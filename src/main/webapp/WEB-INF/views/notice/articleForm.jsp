<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="articlesList" value="${articlesMap.articlesList}" />
<c:set var="section" value="${articlesMap.section}" />
<c:set var="pageNum" value="${articlesMap.pageNum}" />
<c:set var="totArticles" value="${articlesMap.totArticles}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>게시물 작성</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link href="${contextPath}/resources/css/noticeRead.css"
	rel="stylesheet" type="text/css">


<style type="text/css">
@charset "UTF-8";

.th {
	
}

.table {
	width: 800px;
	margin-left: 150px;
}

.row1 {
	margin: 0px;
	width: 1100px;
	text-align: left;
}

#asas {
	text-align: center;
	justify-content: center;
}

.hh1 {
	text-align: center;
	margin-top: 50px;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 700;
	font-size: 35px;
	margin-bottom: 20px;
}

.bbu {
	border-bottom: 1px solid #ddd;
}

.greylist {
	width: 100px;
	height: 50px;
	font-weight: 900;
	color: white;
	text-align: center;
	background: black;
	border-radius: 5px;
}

.greylist:hover {
	background-color: #6CC148;
	border: solid 2px white;
	color: white;
}

.greylist a {
	text-decoration-line: none;
	text-decoration: none;
	color: white;
}

.atw {
	text-decoration-line: none;
	text-decoration: none;
	color: white;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 500;
	display: block;
	font-size: 20px;
	width: 80px;
	height: 40px;
}

.writeButton {
	float: right;
}

.fg {
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 400;
	font-size: 20px;
	font-weight: bold;
}

.fgl {
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 400;
	font-size: 20px;
	padding: 5px;
	margin: 0;
}

.fw {
	color: white;
}

.lb {
	background-color: #292929;
}

.rightbtn {
	float: right;
}

.bordered-input {
	border: 1px solid #ccc;
	margin-left: 5px;
}

.text-center {
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 500;
	font-size: 15px;
}

::-webkit-input-placeholder { /* Chrome, Safari, Opera */
	font-size: 15px;
}
</style>
<script>
	var cnt = 1;
	function fn_addFile() {
		$("#d_file")
				.append("<br>" + "<input type='file' name='file"+cnt+"' />");
		cnt++;
	}
</script>
</head>
<body>

<%-- [11/7] Style 수정 : 이경민 --%>

	<h1 class="hh1">공지글 작성</h1>
	<form method="post" name="articleForm" id="form" role="form"
		action="${contextPath}/notice/addNewArticle.do"
		enctype="multipart/form-data">
		<div role="main" class="container" style="padding-bottom: 100px">
			<div class="row row1">
				<table class="table">
					<tr>
						<th width=20% class="text-center fg lb fw"
							style="background-color: #C0C0C0;">작성자</th>
						<td width=85% class="text-left fgl"><input
							style="width: 300px;" type="text" name="notice_member_Id"
							class="bordered-input" value="admin" disabled />
					</tr>
					<tr>
						<th width=20% class="text-center fg lb fw"
							style="background-color: #C0C0C0;">제목</th>
						<td width=80% class="text-left fgl"><input
							style="width: 300px;" type="text" name="notice_Title"
							class="bordered-input" placeholder="제목을 입력해 주세요" /></td>
					</tr>
					<tr>
						<th width="20%" class="text-center fg lb fw"
							style="vertical-align: middle; background-color: #C0C0C0;">내용</th>
						<td colspan="4" class="text-left fg" valign="top" height="200"
							style="padding-left: 13px;"><textarea cols="80" rows="8"
								name="notice_Content" placeholder="내용을 입력해 주세요"
								class="bordered-input"
								style="width: 300px; height: 300px; padding: 0; margin: 0;"></textarea>
						</td>
					</tr>
					<tr>
						<th width="20%" class="text-center fg lb fw"
							style="vertical-align: middle; background-color: #C0C0C0;">이미지<br>파일<br>첨부</th>
						<td><input type="file" name="imageFileName"
							onchange="readURL(this);" /></td>
						<td align="left"><input type="button" value="파일 추가"
							onClick="fn_addFile()" /></td>
						<td><img id="preview" src="#" width=200 height=200 /></td>
					</tr>
					<tr>
						<td colspan="4"><div id="d_file"></div></td>
					</tr>

					<tr>
						<td td colspan="4" class="text-right">
							<div>
								<input type="submit" class="btn btn-sm btn-primary greylist atw"
									style="float: right; background-color: #4285f4;" value="작성">
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</form>

</body>
</html>
