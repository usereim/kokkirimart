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

	@Override
	@RequestMapping(value = "/notice/listArticles.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView listArticles(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String _section=request.getParameter("section");
		String _pageNum=request.getParameter("pageNum");
		int section = Integer.parseInt(((_section==null)? "1":_section) );
		int pageNum = Integer.parseInt(((_pageNum==null)? "1":_pageNum));
		Map pagingMap=new HashMap();
		pagingMap.put("section", section);
		pagingMap.put("pageNum", pageNum);
		Map articlesMap = articleService.listArticles(pagingMap);

		articlesMap.put("section", section);
		articlesMap.put("pageNum", pageNum);
		
		String viewName = (String) request.getAttribute("viewName");
		
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("articlesMap", articlesMap);
		return mav;

	}


	@RequestMapping(value = "/notice/viewArticle.do", method = RequestMethod.GET)
	public ModelAndView viewArticle(@RequestParam("notice_No") int notice_No, 
												@RequestParam(value="removeCompleted", required=false) String removeCompleted,
												HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO)session.getAttribute("memberInfo");
		
		String id = null;
		if(memberVO != null) {
			id = memberVO.getMember_id();
		}
		
		Map viewMap = new HashMap();
		viewMap.put("notice_No", notice_No);
		viewMap.put("member_Id", id);
		
//		Map articleMap = boardService.viewArticle(NOTICE_NO);
		Map articleMap = articleService.viewArticle(viewMap);
		articleMap.put("removeCompleted", removeCompleted );
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		mav.addObject("notice_No", notice_No); //게시글 번호 추가
		mav.addObject("articleMap", articleMap);
		return mav;
	}


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
			System.out.println("------寃뚯떆湲� �궘�젣------");
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
			message += " alert('�옉�뾽以� �삤瑜섍� 諛쒖깮�뻽�뒿�땲�떎.�떎�떆 �떆�룄�빐 二쇱꽭�슂.');";
			message += " location.href='" + request.getContextPath() + "/notice/listArticles.do';";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}

	// �떎以� �씠誘몄� 湲� 異붽��븯湲�
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

		HttpSession session = multipartRequest.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		String member_Id = memberVO.getMember_id();

		articleMap.put("member_Id", member_Id);
		
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
			message += " alert('�삤瑜섍� 諛쒖깮�뻽�뒿�땲�떎. �떎�떆 �떆�룄�빐 二쇱꽭�슂');');";
			message += " location.href='" + multipartRequest.getContextPath() + "/notice/articleForm.do'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}
	
	
	// �떎以� �떟湲� 異붽��븯湲�
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

		// 濡쒓렇�씤 �떆 �꽭�뀡�뿉 ���옣�맂 �쉶�썝 �젙蹂댁뿉�꽌 湲��벖�씠 �븘�씠�뵒瑜� �뼸�뼱���꽌 Map�뿉 ���옣�빀�땲�떎.
		HttpSession session = multipartRequest.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		String id = memberVO.getMember_id();
		articleMap.put("id", id);
		
		//�꽭�뀡�뿉 ���옣�븳 遺�紐④�怨� 湲�洹몃９踰덊샇瑜� 媛�吏�怨� �삩�떎.
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
			message += " alert('�떟湲��쓣 異붽��뻽�뒿�땲�떎.');";
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
			message += " alert('�삤瑜섍� 諛쒖깮�뻽�뒿�땲�떎. �떎�떆 �떆�룄�빐 二쇱꽭�슂');');";
			message += " location.href='" + multipartRequest.getContextPath() + "/article/articleForm.do'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}

	

	// �떎以� �씠誘몄� �닔�젙 湲곕뒫
	@RequestMapping(value = "/notice/modArticle.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity modArticle(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		Map<String, Object> articleMap = new HashMap<String, Object>();
		Enumeration enu = multipartRequest.getParameterNames();
		while (enu.hasMoreElements()) {
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

		List<String> fileList = uploadModImageFile(multipartRequest); //�닔�젙�븳 �씠誘몄� �뙆�씪�쓣 �뾽濡쒕뱶�븳�떎.

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
			if (fileList != null && fileList.size() != 0) { // �닔�젙�븳 �뙆�씪�뱾�쓣 李⑤���濡� �뾽濡쒕뱶�븳�떎.
				for (int i = 0; i < fileList.size(); i++) {
					String fileName = fileList.get(i);
					if (i  < pre_img_num ) {
						if (fileName != null) {
							File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + fileName);
							File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + notice_No);
							FileUtils.moveFileToDirectory(srcFile, destDir, true);

							String[] oldName = (String[]) articleMap.get("oldFileName");
							String oldFileName = oldName[i];

							File oldFile = new File(ARTICLE_IMAGE_REPO + "\\" + notice_No + "\\" + oldFileName);
							oldFile.delete();
						}
					}else {
						if (fileName != null) {
							File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + fileName);
							File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + notice_No);
							FileUtils.moveFileToDirectory(srcFile, destDir, true);
						}
					}
				}
			}

			message = "<script>";
			message += " alert('湲��쓣 �닔�젙�뻽�뒿�땲�떎.');";
			message += " location.href='" + multipartRequest.getContextPath() + "/notice/viewArticle.do?notice_No="
					+ notice_No + "';";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		} catch (Exception e) {

			if (fileList != null && fileList.size() != 0) { // �삤瑜� 諛쒖깮 �떆 temp �뤃�뜑�뿉 �뾽濡쒕뱶�맂 �씠誘몄� �뙆�씪�뱾�쓣 �궘�젣�븳�떎.
				for (int i = 0; i < fileList.size(); i++) {
					File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + fileList.get(i));
					srcFile.delete();
				}

				e.printStackTrace();
			}

			message = "<script>";
			message += " alert('�삤瑜섍� 諛쒖깮�뻽�뒿�땲�떎.�떎�떆 �닔�젙�빐二쇱꽭�슂');";
			message += " location.href='" + multipartRequest.getContextPath() + "/notice/viewArticle.do?notice_No="
					+ notice_No + "';";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		}
		return resEnt;
	}

	// �닔�젙�븯湲곗뿉�꽌 �씠誘몄� �궘�젣 湲곕뒫
	@RequestMapping(value = "/notice/removeModImage.do", method = RequestMethod.POST)
	@ResponseBody
	public void removeModImage(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();

		try {
			String image_No = (String) request.getParameter("image_No");
			String imageFileName = (String) request.getParameter("imageFileName");
			String notice_No = (String) request.getParameter("notice_No");
			
			System.out.println("image_No = " + image_No);
			System.out.println("notice_No = " + notice_No);

			ImageVO imageVO = new ImageVO();
			imageVO.setNotice_No(Integer.parseInt(notice_No));
			imageVO.setImage_No(Integer.parseInt(image_No));
			articleService.removeModImage(imageVO);
			
			File oldFile = new File(ARTICLE_IMAGE_REPO + "\\" + notice_No + "\\" + imageFileName);
			oldFile.delete();
			
			writer.print("success");
		} catch (Exception e) {
			writer.print("failed");
		}

	}

	
//	@RequestMapping(value = "/board/*Form.do", method = {RequestMethod.GET , RequestMethod.POST})
//	private ModelAndView form(@RequestParam(value="parentNO", required=false) String parentNO,
//			                            HttpServletRequest request, HttpServletResponse response) throws Exception {
//		String viewName = (String) request.getAttribute("viewName");
//		
//		if(viewName.equals("/board/replyForm")) {
//			HttpSession session = request.getSession();
//			if(parentNO != null) {
//				session.setAttribute("parentNO", parentNO);  //誘몃━ 濡쒓렇�씤 �썑, �떟湲� �벐湲� �겢由� �떆 遺�紐④�踰덊샇瑜� �꽭�뀡�뿉 ���옣
//			}
//		}
	
	
	@RequestMapping(value = "/notice/articleForm.do", method = {RequestMethod.GET , RequestMethod.POST})
	private ModelAndView articleForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();

		mav.setViewName(viewName);
		return mav;
	}
	
	
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
	


	// �깉 湲� �벐湲� �떆 �떎以� �씠誘몄� �뾽濡쒕뱶�븯湲�
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
					if (!file.exists()) { // 寃쎈줈�긽�뿉 �뙆�씪�씠 議댁옱�븯吏� �븡�쓣 寃쎌슦
						file.getParentFile().mkdirs(); // 寃쎈줈�뿉 �빐�떦�븯�뒗 �뵒�젆�넗由щ뱾�쓣 �깮�꽦
						mFile.transferTo(new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + originalFileName)); // �엫�떆濡�
																													// ���옣�맂
																													// multipartFile�쓣
																													// �떎�젣
																													// �뙆�씪濡�
																													// �쟾�넚
					}
				}
			}

		}
		return fileList;
	}

	// �닔�젙 �떆 �떎以� �씠誘몄� �뾽濡쒕뱶�븯湲�
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
					if (!file.exists()) { // 寃쎈줈�긽�뿉 �뙆�씪�씠 議댁옱�븯吏� �븡�쓣 寃쎌슦
						file.getParentFile().mkdirs(); // 寃쎈줈�뿉 �빐�떦�븯�뒗 �뵒�젆�넗由щ뱾�쓣 �깮�꽦
						mFile.transferTo(new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + originalFileName)); // �엫�떆濡�
					}
				}
			} else {
				fileList.add(null);
			}

		}
		return fileList;
	}
	
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






