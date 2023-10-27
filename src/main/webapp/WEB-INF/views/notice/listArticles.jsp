<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="articlesList"  value="${articlesMap.articlesList}"  />
<c:set var="section"  value="${articlesMap.section}"  />
<c:set var="pageNum"  value="${articlesMap.pageNum}"  />
<c:set var="totArticles"  value="${articlesMap.totArticles}"  />
<%
	// 특정 아이디를 변수에 저장 (예: "admin"이 특정 아이디라고 가정)
String admin = "admin";
%>



<!DOCTYPE html>
<html>
<style>
    .custom-color th { /* 게시판 리스트 색상 */
        background: #C0C0C0;
    }
</style>
<head>
<meta charset="UTF-8">
<link href="${contextPath}/resources/css/noticeList.css"
	rel="stylesheet" type="text/css">
<!-- 폰트:나눔산스 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700;800&family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
s
<title>Insert title here</title>
</head>
<body>

	<!-- Tab links -->
	<div class="tab">
		<button class="tablinks" onclick="openNotice(event, 'Notice')">공지사항</button>
		<button id="faqTabButton" class="tablinks"
			onclick="openNotice(event, 'FAQ')">FAQ</button>
	</div>

	<!-- Tab content -->

	<div id="Notice" class="tabcontent container1" style="display: block;">
		<!-- <h3>공지사항</h3> -->


		<div id="Notice_page">
			<div class="table-responsive">
				<table class="table table-striped table-sm table-hover">

					<colgroup>
						<col style="width: 10%;" />
						<col style="width: auto;" />
						<col style="width: 15%;" />
						<col style="width: 10%;" />
						<col style="width: 10%;" />
					</colgroup>
					<thead>
						<tr class="custom-color">
							<th scope="col" class="center tw fg">번호</th>
							<th scope="col" class="center tw fg">제목</th>
							<th scope="col" class="center tw fg">작성일</th>
							<th scope="col" class="center tw fg">작성자</th>
							<th scope="col" class="center tw fg">조회수</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach  var="article" items="${articlesList }" varStatus="articleNum" >
							<tr>
								<td class="center fgl"
									style="font-weight: 500; font-size: 16px;">${articleNum.count}</td>
								<td class="left fgl"><a
									href="${contextPath}/notice/viewArticle.do?notice_No=${article.notice_No}">${article.notice_Title}</a>
								</td>

								<td class="center fgl"><fmt:formatDate value="${article.notice_Date}" pattern="yy-MM-dd" /></td>
								<td class="center fgl">${article.member_Id}</td>
								<td class="center fgl">${article.notice_Count}</td>
							</tr>
						</c:forEach>
					</tbody>


				</table>
				<!--글쓰기 버튼  -->
				<c:if test="${isLogOn == true && memberInfo.member_id=='admin' }">
					<div class="writeButton">
						<button type="button" class="btn btn-sm btn-primary greylist"
							id="btnWriteForm" style="background-color:#4285f4">
							<a class="atw" href="${contextPath}/notice/articleForm.do">글쓰기</a>
						</button>
					</div>
				</c:if>

			</div>

			<!-- 코끼리마트 페이징 -->
			<div class="cls2">
				<c:if test="${not empty totArticles}">
					<c:choose>
						<c:when test="${totArticles >100 }">
							<!-- 글 개수가 100 초과인경우 -->
							<c:forEach var="page" begin="1" end="10" step="1">
								<c:if test="${section >1 && page==1 }">
									<a class="no-uline"
										href="${contextPath }/notice/listArticles.do?section=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp;
										pre </a>
								</c:if>
								<a class="no-uline"
									href="${contextPath }/notice/listArticles.do?section=${section}&pageNum=${page}">${(section-1)*10 +page }
								</a>
								<c:if test="${page ==10 }">
									<a class="no-uline"
										href="${contextPath }/notice/listArticles.do?section=${section+1}&pageNum=${section*10+1}">&nbsp;
										next</a>
								</c:if>
							</c:forEach>
						</c:when>
						<c:when test="${totArticles ==100 }">
							<!--등록된 글 개수가 100개인경우  -->
							<c:forEach var="page" begin="1" end="10" step="1">
								<a class="no-uline" href="#">${page } </a>
							</c:forEach>
						</c:when>

						<c:when test="${totArticles< 100 }">
							<!--등록된 글 개수가 100개 미만인 경우  -->
							<c:forEach var="page" begin="1" end="${totArticles/10 +1}"
								step="1">
								<c:choose>
									<c:when test="${page==pageNum }">
										<a class="sel-page"
											href="${contextPath }/notice/listArticles.do?section=${section}&pageNum=${page}">${page }
										</a>
									</c:when>
									<c:otherwise>
										<a class="no-uline"
											href="${contextPath }/notice/listArticles.do?section=${section}&pageNum=${page}">${page }
										</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:when>
					</c:choose>
				</c:if>
			</div>



		</div>

	</div>


	<!-- FAQ -->

	<div id="FAQ" class="tabcontent container1">

		<div id="Notice_FAQ_page">
			<div class="table-responsive">
				<table class="table table-striped table-sm">

					<colgroup>
						<col style="width: 10%;" />
						<col style="width: auto;" />
						<col style="width: 15%;" />
						<col style="width: 10%;" />
						<col style="width: 10%;" />
					</colgroup>
					<thead>
						<tr>
							<th class="center tw fg">번호</th>
							<th class="center tw fg">제목</th>
							<th class="center tw fg">작성일</th>
							<th class="center tw fg">작성자</th>
							<th class="center tw fg">조회수</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach  var="article" items="${articlesList }" varStatus="articleNum" >
							<tr>
								<td class="center fgl"
									style="font-weight: 500; font-size: 16px;">${articleNum.count}</td>
									<td>
								<a class='cls1' href="${contextPath}/notice/viewArticle.do?notice_No=${article.notice_No}">${article.notice_Title}</a>
									</td>

								<td class="center fgl"><fmt:formatDate
										value="${article.notice_Date}" /></td>
								<td class="center fgl">${article.member_Id}</td>
								<td class="center fgl">${article.notice_Count}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>


				<!--글쓰기 버튼  -->
				<c:if test="${isLogOn == true && memberInfo.member_id=='admin' }">
					<div class="writeButton">
						<button type="button" class="btn btn-sm btn-primary greylist"
							id="btnWriteForm">
							<a class="atw" href="${contextPath}/notice/articleForm.do">글쓰기</a>
						</button>
					</div>
				</c:if>

			</div>






		</div>
	</div>








	<script>
		function openNotice(evt, noticeName) {
			// Declare all variables
			var i, tabcontent, tablinks;

			// Get all elements with class="tabcontent" and hide them
			tabcontent = document.getElementsByClassName("tabcontent");
			for (i = 0; i < tabcontent.length; i++) {
				tabcontent[i].style.display = "none";
			}

			// Get all elements with class="tablinks" and remove the class "active"
			tablinks = document.getElementsByClassName("tablinks");
			for (i = 0; i < tablinks.length; i++) {
				tablinks[i].className = tablinks[i].className.replace(
						" active", "");
			}

			// Show the current tab, and add an "active" class to the button that opened the tab
			document.getElementById(noticeName).style.display = "block";
			evt.currentTarget.className += " active";

			// AJAX로 데이터 가져오기
			if (noticeName === "Notice") {
				loadNoticeList();
			} else if (noticeName === "FAQ") {
				loadFaqList();
			}
		}
	</script>

</body>
</html>