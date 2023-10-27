<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<style>
.container-fluid {
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 700;
}

.navbar.navbar-inverse {
	padding: 8px;
	padding-left: 160px;
	padding-right: 160px;
	background: white;
	border: none;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 500;
	font-size: 16px; /* 변경된 값 */
}

.nav.navbar-nav {
	margin-top: 38px; /* 변경된 값 */
	margin-left: 32px; /* 변경된 값 */
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 500;
	display:block;
	font-size :16px; /* 변경된 값 */
}

.nav.navbar-nav.navbar-right {
    font-size :13px; /* 변경된 값 */
    font-family :'Noto Sans KR',sans-serif ;
    font-weight :400 ; 
    display:block ;
    margin-top :38px ; /* 변경된 값 */
}

ul.nav.navbar-nav li a {
	color:black ;
	padding :8px ; /* 변경된 값 */
}

ul.nav.navbar-nav li a:hover{
	color:#000000 ;
}

.hidden{
	display:none ;
}
 
 .navbar .dropdown-menu .dropdown-toggle{
     z-index :9999 ;
 }
 .logged-out{ 
 margin-top :20 px ; /* 변경된 값 */
 }
</style>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- 폰트:나눔산스 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700;800&family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
</head>

<body>
	<nav class="navbar navbar-inverse navbar-fixed" style="font-family: 'Noto Sans KR', sans-serif;" >
	
		<div class="container-fluid">
			<div class="navbar-header">
				<a href="${contextPath}/main/main.do"><img src="${contextPath}/resources/images/logo/logo.jpg" width="100px"></a>
			</div>
			<ul class="nav navbar-nav" style="color:black; font-weight: 700;">
				<li><a href="${contextPath}/notice/listArticles.do">쇼핑하기</a></li>
				<li><a href="${contextPath}/notice/listArticles.do">배송안내</a></li>
				<li><a href="${contextPath}/notice/listArticles.do">공지사항</a></li>
				<li><a href="${contextPath}/notice/listArticles.do">고객센터</a></li>
			</ul>
			
	
		<ul class="nav navbar-nav navbar-right" style="vertical-align: middle;margin">		
			 <c:choose>
		           <c:when test="${isLogOn == true and not empty memberInfo }">
		             <div style="margin-top: 1.5px;font-size: 14px;text-align: right;margin-right: 13px;">${memberInfo.member_id} 님 </div>
		          </c:when>
		       </c:choose>
		    <li class="logged-out"><a href="${contextPath}/member/memberForm.do"><img width=20 src="${contextPath}/resources/images/nav/join.png"> 회원가입</a></li>
		    <li class="logged-out"><a href="${contextPath}/member/loginForm.do" id="loginBtn"><img width=20 src="${contextPath}/resources/images/nav/login.png"> 로그인</a></li>
		    <li class="user-logged-in hidden" ><a href="${contextPath}/cart/myCartList.do"><img width=20 src="${contextPath}/resources/images/nav/cart.png"> 장바구니</a></li>		    
		    <li class="dropdown user-logged-in hidden" >
            <a class="dropdown-toggle" data-toggle="dropdown" href="#" >
                <img width=20 src="${contextPath}/resources/images/nav/mypage.png"> 마이페이지<span class="caret"></span>
            </a>
	            <ul class="dropdown-menu" style="min-width: 105px;">
	                <li style="width:130px;"><a href="${contextPath}/mypage/listMyOrderHistory.do">마이페이지</a>
<%-- 잠시 주석처리함
	                <li><a href="${contextPath}/mypage/myWriteList.do">내가 남긴 글</a></li>
	                <li><a href="${contextPath}/mypage/listMyOrderHistory.do">주문 내역</a></li>
	                <li><a href="${contextPath}/mypage/deleteMemForm.do">회원 탈퇴</a></li>
--%>
	            </ul>
            </li>

<%-- 카카오 로그인 및 회원관리 주석처리
            <li class="dropdown kakao-user-logged-in hidden" >
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                <span class="glyphicon glyphicon-user"></span> 마이페이지 <span class="caret"></span>
            </a>
	            <ul class="dropdown-menu">
	                <li><a href="${contextPath}/mypage/modifyMemForm.do">카카오-개인정보수정</a></li>
	                <li><a href="#">문의 내역</a></li>
	                <li><a href="${contextPath}/mypage/listMyOrderHistory.do">카카오-주문 내역</a></li>
	                <li><a href="#">리뷰 확인</a></li>
	                <li><a href="${contextPath}/mypage/deleteMemForm.do">카카오-회원 탈퇴</a></li>
	            </ul>
            </li>


            <li class="user-logged-in hidden"><a href="${contextPath}/member/logout.do" id="logoutBtn"><img width=20 src="${contextPath}/resources/images/nav/logout.png"> 로그아웃</a></li>            
		    <li class="kakao-user-logged-in hidden"><a href="${contextPath}/social/kakao_logout.do" id="logoutBtn"><img width=20 src="${contextPath}/resources/images/nav/logout.png"> 로그아웃</a></li>
--%>
			<li class="user-logged-in hidden"><a href="${contextPath}/member/logout.do" id="logoutBtn"><img width=20 src="${contextPath}/resources/images/nav/logout.png"> 로그아웃</a></li>		    
            
            <li class="dropdown admin-logged-in hidden" >
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                <span class="glyphicon glyphicon-user"></span> 관리자 페이지 <span class="caret"></span>
            </a>
	            <ul class="dropdown-menu">
	                <li><a href="${contextPath}/admin/goods/adminGoodsMain.do">관리자 페이지</a></li>
	                <li><a href="${contextPath}/admin/member/adminMemberMain.do">회원 관리</a></li>
	                <li><a href="${contextPath}/admin/order/adminOrderMain.do">주문 관리</a></li>

	       
	            </ul>
            </li>
		    <li class="admin-logged-in hidden"><a href="${contextPath}/member/logout.do" id="logoutBtn"> 로그아웃</a></li>
		    
		</ul>
	</div>
</nav>

<!-- 헤더 스크립트 -->
	<script>
	$(document).ready(function() {
	    var isLogOn = false;
	    var isAdmin = false;
	    var isKakao = false;
	    
	    function toggleForm() {
	        if (isAdmin) {
	            $('.admin-logged-in').removeClass('hidden');
	            $('.user-logged-in, .logged-out').addClass('hidden');
	        } else if (isLogOn) {
	            $('.user-logged-in').removeClass('hidden');
	            $('.admin-logged-in, .logged-out').addClass('hidden');
	        } else if (isKakao) {
	            $('.kakao-user-logged-in').removeClass('hidden');
	            $('.admin-logged-in, .logged-out').addClass('hidden');
	        } else {
	            $('.logged-out').removeClass('hidden');
	            $('.user-logged-in, .admin-logged-in').addClass('hidden');
	        }
	    }
	
	    // 로그인 상태 변경 시 폼 변경
	    toggleForm();
	
	    var isLogOnValue = '<c:out value="${sessionScope.isLogOn}" />';
	    if (isLogOnValue === 'true') {
	        isLogOn = true;
	    }
	    toggleForm();
	    
	    var isAdminValue = '<c:out value="${sessionScope.isAdmin}" />';
	    if (isAdminValue === 'true') {
	        isAdmin = true;
	    }
	    toggleForm();
	    
        var kakaoTokenValue = '<c:out value="${sessionScope.kakaoToken}" />';
        if (kakaoTokenValue === 'true') {
            isKakao = true; // kakaoToken이 존재하면 카카오 로그인으로 판별
        }
        toggleForm();
	
	    $('#loginBtn').click(function() {
	        isLogOn = true;
	        isAdmin = true;
	        isKakao = true;
	        toggleForm();
	    });
	
	    $('#logoutBtn').click(function() {
	        isLogOn = false;
	        isAdmin = false;
	        isKakao = false;
	        toggleForm();
	    	});
		});
	
		//카카오로그아웃  
		function kakaoLogout() {
		    if (Kakao.Auth.getAccessToken()) {
		      Kakao.API.request({
		        url: '/v1/user/unlink',
		        success: function (response) {
		        	console.log(response)
		        },
		        fail: function (error) {
		          console.log(error)
		        },
		      })
		      Kakao.Auth.setAccessToken(undefined)
		    }
		  }  
		
	</script>
</body>
</html>