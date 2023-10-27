<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <!-- 추가할부분 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page session="false" %>
<html>
<head>
	<meta charset="UTF-8"> <!-- 추가할부분 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- 추가할부분 -->
	<meta http-equiv="X-UA-Compatible" content="ie=edge"> <!-- 추가할부분 -->
<title>Insert title here</title>
<style>
.container{width: 100%;margin:0 ; padding: 10px; padding-left: 200px; padding-right: 200px; display: flex;
  justify-content: space-between;
  align-items: center;
  font-family: 'Noto Sans KR', sans-serif;
  }
</style>
</head>
<body>

    
    	<div class="container" > 
    	<div class="leftInfo">
    		<img src="${contextPath}/resources/images/logo/logo2.png" width="80px"><br><br>
		    <p>(주)코끼리마트 | 주소: 대전 서구 계룡로 637 (탄방동) 정일빌딩 3층<br>
			개인정보관리책임자: 관리자(privacy@elephants.com)</p>
			
			
			
	
	         <span><a href="${contextPath}/notice/listArticles.do" class="text-reset">공지사항 | </a></span>
	         <span><a href="${contextPath}/notice/listArticles.do" class="text-reset">고객센터</a></span>
	
	         
	         <h6 class="text-uppercase fw-bold mb-4"><p>Copyright 2023. 코끼리마트 All rights reserved.</p></h6>
		</div>
		
		
		<div class="rightInfo">			
	          <h6 class="text-uppercase fw-bold mb-4">대표번호</h6>		       
		        <h3><p>1234-4321</p></h3>
				<p>월-토요일 : 09:00 - 19:00<br>
				점심 : 12:00 - 13:00<br>
				(일요일 및 공휴일 휴무)</p>
				<p>카카오톡: @코끼리마트</p>
				<p>이메일: help@elephants.com</p>   
	   	 </div>
    </div>



</body>
</html>