package com.bookshop01.member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop01.common.base.BaseController;
import com.bookshop01.member.DTO.KakaoDTO;
import com.bookshop01.member.service.MemberService;
import com.bookshop01.member.vo.MemberVO;

@Controller("memberController")
@RequestMapping(value = "/member")
public class MemberControllerImpl extends BaseController implements MemberController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private MemberVO memberVO;

	@Override
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public ModelAndView login(@RequestParam Map<String, String> loginMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		memberVO = memberService.login(loginMap);
		if (memberVO != null && memberVO.getMember_id() != null) {
			
			HttpSession session = request.getSession();
			session.setAttribute("memberInfo", memberVO);
			session.setAttribute("isLogOn", true);
			
			//관리자 계정(admin)인 경우 isAdmin 값 부여. 10-17
			 if (memberVO.getMember_id().equals("admin")) {
		            session.setAttribute("isAdmin", true);
		        } else {
		            session.setAttribute("isAdmin", false);
		        }
			session = request.getSession(true);	
			
			String action = (String) session.getAttribute("action");
			if (action != null && action.equals("/order/orderEachGoods.do")) {
				mav.setViewName("forward:" + action);
			} else {
				mav.setViewName("redirect:/main/main.do");
			}

		} else {
			String message = "占쏙옙占싱듸옙  占쏙옙橘占싫ｏ옙占� 틀占쏙옙占싹댐옙. 占쌕쏙옙 占싸깍옙占쏙옙占쏙옙占쌍쇽옙占쏙옙";
			mav.addObject("message", message);
			mav.setViewName("/member/loginForm");
		}
		return mav;
	}

	@Override
	@RequestMapping(value = "/logout.do", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		//HttpSession session = request.getSession();
		HttpSession session = request.getSession(false);
		
		if (session != null) {
	        session.invalidate(); // 세션 무효화

	        // 새로운 세션 생성
	        session = request.getSession(true);
	        session.setAttribute("isLogOn", false);
	        System.out.println(memberVO.getMember_id()+ " 로그아웃 완료");
	    }
		
		session.setAttribute("isLogOn", false);
		session.removeAttribute("memberInfo");
		mav.setViewName("redirect:/main/main.do");
		return mav;
	}

	@Override
	@RequestMapping(value = "/addMember.do", method = RequestMethod.POST)
	public ResponseEntity addMember(@ModelAttribute("memberVO") MemberVO _memberVO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			memberService.addMember(_memberVO);
			message = "<script>";
			message += " alert('회占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占싣쏙옙占싹댐옙.占싸깍옙占쏙옙창占쏙옙占쏙옙 占싱듸옙占쌌니댐옙.');";
			message += " location.href='" + request.getContextPath() + "/member/loginForm.do';";
			message += " </script>";

		} catch (Exception e) {
			message = "<script>";
			message += " alert('占쌜억옙 占쏙옙 占쏙옙占쏙옙占쏙옙 占쌩삼옙占쌩쏙옙占싹댐옙. 占쌕쏙옙 占시듸옙占쏙옙 占쌍쇽옙占쏙옙');";
			message += " location.href='" + request.getContextPath() + "/member/memberForm.do';";
			message += " </script>";
			e.printStackTrace();
		}
		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}

	@Override
	@RequestMapping(value = "/overlapped.do", method = RequestMethod.POST)
	public ResponseEntity overlapped(@RequestParam("id") String id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ResponseEntity resEntity = null;
		String result = memberService.overlapped(id);
		resEntity = new ResponseEntity(result, HttpStatus.OK);
		return resEntity;
	}

	@Override
	@RequestMapping(value = "/kakaoLogin.do", method = RequestMethod.GET)
	public ModelAndView kakaoLogin(@RequestParam(value = "code", required = false) String code, HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		System.out.println("#########" + code);
		String access_Token = memberService.getAccessToken(code);
		KakaoDTO userInfo = memberService.getUserInfo(access_Token);
		System.out.println("###access_Token#### : " + access_Token);
		System.out.println("###nickname#### : " + userInfo.getK_name());
		System.out.println("###email#### : " + userInfo.getK_email());
		String[] email = userInfo.getK_email().split("@");
		memberVO.setMember_id(userInfo.getK_email());
		memberVO.setMember_name(userInfo.getK_name());
		memberVO.setEmail1(email[0]);
		memberVO.setEmail2(email[1]);
		HttpSession session = request.getSession();
		session = request.getSession();
		session.setAttribute("memberInfo", memberVO);
		session.setAttribute("isLogOn", true);
		
		mav.setViewName("redirect:/main/main.do");
		return mav;
	}
}