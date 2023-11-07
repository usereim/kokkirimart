package com.bookshop01.notice.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop01.notice.service.ArticleService;
import com.bookshop01.notice.vo.ArticleVO;
import com.bookshop01.notice.vo.ImageVO;
import com.bookshop01.member.vo.MemberVO;

@Controller("articleController")
public class ArticleControllerImpl implements ArticleController {
	private static final String ARTICLE_IMAGE_REPO = "C:\\board\\article_image1";
	@Autowired
	private ArticleService articleService;
	@Autowired
	private ArticleVO articleVO;

	//게시물을 불러오는 메서드 + 페이지 넘버링을 매기는 메서드
	@Override
	@RequestMapping(value = "/notice/listArticles.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView listArticles(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 페이징을 위해 request로 값을 가져옴
		String _section=request.getParameter("section");
		String _pageNum=request.getParameter("pageNum");
		
		//String으로 지정된 값을 parseInt를 이용해 int로 변경
		int section = Integer.parseInt(((_section==null)? "1":_section) );
		int pageNum = Integer.parseInt(((_pageNum==null)? "1":_pageNum));
		
		// 페이징 맵을 만들어 section과 pageNum값을 넣음
		Map pagingMap=new HashMap();
		pagingMap.put("section", section);
		pagingMap.put("pageNum", pageNum);
		
		// 페이징 맵으로 리스트를 불러오는 SQL을 동작시킴
		Map articlesMap = articleService.listArticles(pagingMap);

		// 가져온 값을 articlesMap에 넣음
		articlesMap.put("section", section);
		articlesMap.put("pageNum", pageNum);
		
		String viewName = (String) request.getAttribute("viewName");
		
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("articlesMap", articlesMap);
		return mav;

	}

	// 게시글을 클릭할 때(읽을때) 작동하는 메서드
	@RequestMapping(value = "/notice/viewArticle.do", method = RequestMethod.GET)
	public ModelAndView viewArticle(@RequestParam("notice_No") int notice_No, 
												@RequestParam(value="removeCompleted", required=false) String removeCompleted,
												HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO)session.getAttribute("memberInfo");
		
		// memberVO가 비어있지 않은 경우 id를 가져오도록 함
		String id = null;
		if(memberVO != null) {
			id = memberVO.getMember_id();
		}
		
		// viewMap에 글 번호와 작성자 id를 추가
		Map viewMap = new HashMap();
		viewMap.put("notice_No", notice_No);
		viewMap.put("member_Id", id);
		
//		Map articleMap = boardService.viewArticle(NOTICE_NO);
		Map articleMap = articleService.viewArticle(viewMap);
		articleMap.put("removeCompleted", removeCompleted );
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		mav.addObject("notice_No", notice_No); //게시글 번호 추가
		mav.addObject("articleMap", articleMap); // articleMap에 viewMap으로 SQL을 작동시킨 결과 값 추가
		return mav;
	}


	// 게시글 삭제 메서드
	@Override
	@RequestMapping(value = "/notice/removeArticle.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity removeArticle(@RequestParam("notice_No") int notice_No, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			//게시글 삭제 SQL을 게시글 번호(notice_No)로 작동.
			articleService.removeArticle(notice_No);
			//File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + notice_No);
			//FileUtils.deleteDirectory(destDir);

			message = "<script>";
			message += " alert('게시글이 삭제되었습니다.');";
			message += " location.href='" + request.getContextPath() + "/notice/listArticles.do';";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);

		} catch (Exception e) {
			message = "<script>";
			message += " alert('게시글이 삭제되지 않았습니다. 오류가 발생하였습니다.');";
			message += " location.href='" + request.getContextPath() + "/notice/listArticles.do';";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}

	// 게시글 추가 메서드
	@Override
	@RequestMapping(value = "/notice/addNewArticle.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity addNewArticle(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		String imageFileName = null;

		Map articleMap = new HashMap();
		Enumeration enu = multipartRequest.getParameterNames();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = multipartRequest.getParameter(name);
			articleMap.put(name, value);
		}

		// 세션을 이용해 id를 가져옴.
		HttpSession session = multipartRequest.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		String member_Id = memberVO.getMember_id();

		// id값을 articleMap에 넣음
		articleMap.put("member_Id", member_Id);
		
//		String groupNO = (String)session.getAttribute("groupNO")  ;
//		articleMap.put("groupNO" ,  groupNO);
//		session.removeAttribute("groupNO");

		// 이미지 파일 업로드를 수행
		List<String> fileList = upload(multipartRequest);
		List<ImageVO> imageFileList = new ArrayList<ImageVO>();
		if (fileList != null && fileList.size() != 0) {
			for (String fileName : fileList) {
				ImageVO imageVO = new ImageVO();
				imageVO.setImage_Name(fileName);
				imageFileList.add(imageVO);
			}
			articleMap.put("imageFileList", imageFileList);
		}

		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try { //게시판 번호로 temp에 저장된 이미지 파일을 글 번호 폴더를 만들어 여기에 저장토록 함.
			int notice_No = articleService.addNewArticle(articleMap);
			if (imageFileList != null && imageFileList.size() != 0) {
				for (ImageVO imageVO : imageFileList) {
					imageFileName = imageVO.getImage_Name();
					File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName);
					File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + notice_No);
					// destDir.mkdirs();
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
				}
			}
			
			System.out.println(articleMap);

			message = "<script>";
			message += " alert('게시글을 등록하였습니다.');";
			message += " location.href='" + multipartRequest.getContextPath() + "/notice/viewArticle.do?notice_No=" + articleMap.get("notice_No") + "';" ;
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);

		} catch (Exception e) {
			if (imageFileList != null && imageFileList.size() != 0) {
				for (ImageVO imageVO : imageFileList) {
					imageFileName = imageVO.getImage_Name();
					File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName);
					srcFile.delete();
				}
			}

			message = " <script>";
			message += " alert('오류로 인해 게시글을 추가하지 못하였습니다.');');";
			message += " location.href='" + multipartRequest.getContextPath() + "/notice/articleForm.do'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}
	
	
	// 댓글 기능(정태양)
	@Override
	@RequestMapping(value = "/notice/addReplyArticle.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity addReplyArticle(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		String imageFileName = null;

		Map articleMap = new HashMap();
		Enumeration enu = multipartRequest.getParameterNames();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = multipartRequest.getParameter(name);
			articleMap.put(name, value);
		}

		
		HttpSession session = multipartRequest.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		String id = memberVO.getMember_id();
		articleMap.put("id", id);
		
		
		String parentNO = (String)session.getAttribute("parentNO")  ;
		articleMap.put("parentNO" , (parentNO == null ? 0 : parentNO));
		session.removeAttribute("parentNO");
		
//		String groupNO = (String)session.getAttribute("groupNO")  ;
//		articleMap.put("groupNO" ,  groupNO);
//		session.removeAttribute("groupNO");
		

		List<String> fileList = upload(multipartRequest);
		List<ImageVO> imageFileList = new ArrayList<ImageVO>();
		if (fileList != null && fileList.size() != 0) {
			for (String fileName : fileList) {
				ImageVO imageVO = new ImageVO();
				imageVO.setImage_Name(fileName);
				imageFileList.add(imageVO);
			}
			articleMap.put("imageFileList", imageFileList);
		}

		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			int notice_No = articleService.addReplyArticle(articleMap);
			if (imageFileList != null && imageFileList.size() != 0) {
				for (ImageVO imageVO : imageFileList) {
					imageFileName = imageVO.getImage_Name();
					File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName);
					File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + notice_No);
					// destDir.mkdirs();
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
				}
			}

			message = "<script>";
			message += " alert('댓글 작성 완료.');";
			message += " location.href='" + multipartRequest.getContextPath() + "/article/viewArticle.do?articleNO=" + articleMap.get("articleNO") + "';" ;
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);

		} catch (Exception e) {
			if (imageFileList != null && imageFileList.size() != 0) {
				for (ImageVO imageVO : imageFileList) {
					imageFileName = imageVO.getImage_Name();
					File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName);
					srcFile.delete();
				}
			}

			message = " <script>";
			message += " alert('작성에 오류가 발생하였습니다.');');";
			message += " location.href='" + multipartRequest.getContextPath() + "/article/articleForm.do'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}

	

	// 게시글 수정
	@RequestMapping(value = "/notice/modArticle.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity modArticle(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		Map<String, Object> articleMap = new HashMap<String, Object>();
		Enumeration enu = multipartRequest.getParameterNames();
		while (enu.hasMoreElements()) { //해당 게시글 번호로 이미지 파일이 존재하는지 확인하고 articleMap에 추가
			String name = (String) enu.nextElement();

			if (name.equals("image_No")) {
				String[] values = multipartRequest.getParameterValues(name);
				articleMap.put(name, values);
			} else if (name.equals("oldFileName")) {
				String[] values = multipartRequest.getParameterValues(name);
				articleMap.put(name, values);
			} else {
				String value = multipartRequest.getParameter(name);
				articleMap.put(name, value);
			}

		}

		List<String> fileList = uploadModImageFile(multipartRequest); //수정하려는 이미지 파일을 추가함

		int added_img_num = Integer.parseInt((String) articleMap.get("added_img_num"));
		int pre_img_num = Integer.parseInt((String) articleMap.get("pre_img_num"));
		List<ImageVO> imageFileList = new ArrayList<ImageVO>();
		List<ImageVO> modAddimageFileList = new ArrayList<ImageVO>();

		if (fileList != null && fileList.size() != 0) {
			String[] image_No = (String[]) articleMap.get("image_No");
			for (int i = 0; i < added_img_num; i++) {
				String fileName = fileList.get(i);
				ImageVO imageVO = new ImageVO();
				if (i < pre_img_num) {
					imageVO.setImage_Name(fileName);
					imageVO.setImage_No(Integer.parseInt(image_No[i]));
					imageFileList.add(imageVO);
					articleMap.put("imageFileList", imageFileList);
				} else {
					imageVO.setImage_Name(fileName);
					modAddimageFileList.add(imageVO);
					articleMap.put("modAddimageFileList", modAddimageFileList);
				}
			}
		}


		String notice_No = (String) articleMap.get("notice_No");
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			articleService.modArticle(articleMap);
			if (fileList != null && fileList.size() != 0) { //수정하려는 이미지 파일을 실제 로컬 폴더에 추가함
				for (int i = 0; i < fileList.size(); i++) {
					String fileName = fileList.get(i);
					if (i  < pre_img_num ) {
						if (fileName != null) { //temp 폴더에 있는 파일을 글번호 폴더로 옮김
							File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + fileName);
							File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + notice_No);
							FileUtils.moveFileToDirectory(srcFile, destDir, true);

							String[] oldName = (String[]) articleMap.get("oldFileName");
							String oldFileName = oldName[i];

							//변경 전 이미지 파일을 삭제
							File oldFile = new File(ARTICLE_IMAGE_REPO + "\\" + notice_No + "\\" + oldFileName);
							oldFile.delete();
						}
					}else { //중복되는 파일 이름이 없는 경우에는 옮기기만 수행
						if (fileName != null) {
							File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + fileName);
							File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + notice_No);
							FileUtils.moveFileToDirectory(srcFile, destDir, true);
						}
					}
				}
			}

			message = "<script>";
			message += " alert('수정 완료했습니다.');";
			message += " location.href='" + multipartRequest.getContextPath() + "/notice/viewArticle.do?notice_No="
					+ notice_No + "';";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		} catch (Exception e) {

			if (fileList != null && fileList.size() != 0) {
				for (int i = 0; i < fileList.size(); i++) {
					File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + fileList.get(i));
					srcFile.delete();
				}

				e.printStackTrace();
			}

			message = "<script>";
			message += " alert('오류로 인해 수정에 실패했습니다.');";
			message += " location.href='" + multipartRequest.getContextPath() + "/notice/viewArticle.do?notice_No="
					+ notice_No + "';";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		}
		return resEnt;
	}

	// 이미지 삭제 메서드
	@RequestMapping(value = "/notice/removeModImage.do", method = RequestMethod.POST)
	@ResponseBody
	public void removeModImage(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();

		try { //이미지 정보를 가져옴
			String image_No = (String) request.getParameter("image_No");
			String imageFileName = (String) request.getParameter("imageFileName");
			String notice_No = (String) request.getParameter("notice_No");
			
			System.out.println("image_No = " + image_No);
			System.out.println("notice_No = " + notice_No);

			// ImageVO에 가져온 정보를 담음
			ImageVO imageVO = new ImageVO();
			imageVO.setNotice_No(Integer.parseInt(notice_No));
			imageVO.setImage_No(Integer.parseInt(image_No));
			articleService.removeModImage(imageVO);
			
			// 경로를 확인해 삭제처리
			File oldFile = new File(ARTICLE_IMAGE_REPO + "\\" + notice_No + "\\" + imageFileName);
			oldFile.delete();
			
			writer.print("success");
		} catch (Exception e) {
			writer.print("failed");
		}

	}
	
	// 글쓰기 메서드
	@RequestMapping(value = "/notice/articleForm.do", method = {RequestMethod.GET , RequestMethod.POST})
	private ModelAndView articleForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();

		mav.setViewName(viewName);
		return mav;
	}
	
	// 글 답변 메서드
	@RequestMapping(value = "/notice/replyForm.do", method = {RequestMethod.GET , RequestMethod.POST})
	private ModelAndView replyForm(@RequestParam(value="parentNO", required=false) String parentNO,
												@RequestParam(value="groupNO", required=false) String groupNO,
												HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		if(parentNO != null) {  
			session.setAttribute("parentNO", parentNO);
		}
		
		if(groupNO != null) {
			session.setAttribute("groupNO", groupNO);
		}
		mav.setViewName(viewName);
		return mav;
	}
	


	// 이미지 업로드 메서드
	private List<String> upload(MultipartHttpServletRequest multipartRequest) throws Exception {
		List<String> fileList = new ArrayList<String>();
		Iterator<String> fileNames = multipartRequest.getFileNames();
		while (fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String originalFileName = mFile.getOriginalFilename();
			if (originalFileName != "" && originalFileName != null) {
				fileList.add(originalFileName);
				File file = new File(ARTICLE_IMAGE_REPO + "\\" + fileName);
				if (mFile.getSize() != 0) { // File Null Check
					if (!file.exists()) { 
						file.getParentFile().mkdirs(); 
						mFile.transferTo(new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + originalFileName)); 
					}
				}
			}

		}
		return fileList;
	}

	// 이미지 수정 업로드 메서드
	private List<String> uploadModImageFile(MultipartHttpServletRequest multipartRequest) throws Exception {
		List<String> fileList = new ArrayList<String>();
		Iterator<String> fileNames = multipartRequest.getFileNames();
		while (fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String originalFileName = mFile.getOriginalFilename();
			if (originalFileName != "" && originalFileName != null) {
				fileList.add(originalFileName);
				File file = new File(ARTICLE_IMAGE_REPO + "\\" + fileName);
				if (mFile.getSize() != 0) { // File Null Check
					if (!file.exists()) { 
						file.getParentFile().mkdirs(); 
						mFile.transferTo(new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + originalFileName)); 
					}
				}
			} else {
				fileList.add(null);
			}

		}
		return fileList;
	}
	
	// 게시글 수정 메서드 (오종태)
	@RequestMapping(value = "/notice/saveChanges.do", method = {RequestMethod.GET , RequestMethod.POST})
	public ResponseEntity<String> saveChanges(@RequestBody Map<String, String> requestData) {
        try {
            Map<String, Object> articleMap = new HashMap<String, Object>();
            
            articleMap.put("notice_Title", requestData.get("notice_Title"));
            articleMap.put("notice_No", requestData.get("notice_No"));
            articleMap.put("notice_Content", requestData.get("notice_Content"));
            System.out.println(articleMap.toString()+"------------------====1111111222222222");
            

            articleService.modArticle(articleMap);
            
            return ResponseEntity.ok("글의 정보를 수정하였습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred while saving changes");
        }

	
	}
	
	
}
