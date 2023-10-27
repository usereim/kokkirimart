<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="removeCompleted" value="${articleMap.removeCompleted}" />
<c:set var="imageFileList" value="${articleMap.imageFileList}" />
<c:set var="article" value="${articleMap.article}" />
<input type="hidden" id="i_notice_no" value="${article.notice_No}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${contextPath}/resources/css/noticeRead.css"
	rel="stylesheet" type="text/css">



<script type="text/javascript">


function saveChanges() {
	    var titleTextarea = document.getElementById('i_title');
	    var contentTextarea = document.getElementById('i_content');
	    var noticeNoInput = document.getElementById('i_notice_no');

	    var updatedTitle = titleTextarea.value;
	    var updatedContent = contentTextarea.value;
	    var noticeNo = noticeNoInput.value;

	    $.ajax({
	        url: '${contextPath}/notice/saveChanges.do',
	        type: 'POST',
	        contentType: 'application/json',
	        data: JSON.stringify({"notice_Title": updatedTitle, "notice_Content": updatedContent, "notice_No": noticeNo}),
	        success: function(response) {
	            alert(response);
	        },
	        error: function(error) {
	            console.log(error);
	            alert("Error occurred while saving changes");
	        }
	     });
	}

function backToList(form){
    if (form) {
        form.action="${contextPath}/notice/listArticles.do";
        form.submit();
    } else {
        console.error("연결된 form을 찾을 수 없습니다.");
    }
}

	 function fn_remove_article(url,notice_No){
		 var form = document.createElement("form");
		 form.setAttribute("method", "post");
		 form.setAttribute("action", url);
	     var notice_NoInput = document.createElement("input");
	     notice_NoInput.setAttribute("type","hidden");
	     notice_NoInput.setAttribute("name","notice_No");
	     notice_NoInput.setAttribute("value", notice_No);
		 
	     form.appendChild(notice_NoInput);
	     document.body.appendChild(form);
	     form.submit();
	 
	 }
	 
	 function fn_modify_article(obj){
		 obj.action="${contextPath}/notice/modArticle.do";
		 obj.submit();
	 }
	 
     function enableEditing() {
  	    var textarea = document.getElementById('i_content');
  	    var titleInput = document.getElementById('i_title');
  	    textarea.disabled = false;
  	    titleInput.disabled = false;
  	}
 	 
 		function fn_enable( ){
 			 document.getElementById("i_title").disabled=false;
 			 document.getElementById("i_content").disabled=false;
 			 document.getElementById("tr_btn_modify").style.display="block";
 			 document.getElementById("tr_btn").style.display="none";
 			 $(".tr_modEnable").css('visibility', 'visible');
 		 }
	 
	 </script>

<title>게시물 조회</title>
</head>
<body>

	<h1 style="font-size: 30px; margin-bottom: 80px;">공지사항</h1>
	<div role="main" class="container">
		<div class="row row1">
			<table class="table" style="width: 800px; margin-left: 140px;">
				<tr>
					<th viwidth=15% class="text-center fg lb fw"
						style="background-color: #C0C0C0;">작성자</th>
					<td width=35% class="fgl" style="text-align: center;">
						${article.member_Id }</td>
					<th width=15% class="text-center lb fg fw"
						style="background-color: #C0C0C0;">조회수</th>
					<td width=35% class="fgl bbu" style="text-align: center;">${article.notice_Count }</td>
				</tr>
				<tr>
					<th width=15% class="text-center lb fg fw"
						style="background-color: #C0C0C0;">제목</th>
					<td colspan="2" class="fgl"><textarea id='i_title'
							style='white-space: pre-wrap; border: none; background-color: white; width: 100%; height: 200px;'
							disabled>${article.notice_Title}</textarea></td>
				</tr>
				<tr>
					<th width=15% class="text-center lb fg fw"
						style="vertical-align: middle; background-color: #C0C0C0;">내용</th>
					<td colspan="4" class="text-left fg" valign="top" height="200">
						<textarea id='i_content'
							style='white-space: pre-wrap; border: none; background-color: white; width: 100%; height: 200px;'
							disabled>${article.notice_Content}</textarea>
					</td>
				</tr>

				<c:forEach var="imageFileName" items="${imageFileList}">
					<tr>
						<th width=15% class="text-center lb fg fw"
							style="vertical-align: middle; background-color: #C0C0C0;">첨부 파일</th>
						<td class="result-images"><img alt=""
							src="${contextPath}/downloadNoticeImage?fileName=${imageFileName.image_Name}&notice_No=${notice_No}">
						</td>
					</tr>
				</c:forEach>
				<tr>



					<td colspan="4" class="text-right">

						<div class="button-container">
							<c:if test="${isLogOn == true && memberInfo.member_id=='admin' }">
								<a class="atw" onClick="enableEditing()">
									<button type="button" class="bbtn btn-sm btn-primary greylist"
										style="background-color: #4285f4;">수정</button>
								</a>
								<a class="atw" onClick="saveChanges()">
									<button type="button" class="bbtn btn-sm btn-primary greylist"
										style="background-color: #4285f4;">완료</button>
								</a>
								<a class="atw"
									onClick="fn_remove_article('${contextPath}/notice/removeArticle.do', ${article.notice_No})">
									<button type="button" class="btn btn-sm btn-primary greylist"
										style="background-color: #4285f4;">삭제</button>
								</a>
							</c:if>
							<form id="frmArticle">
								<!-- Form contents -->
								<button type="button" class="btn btn-sm btn-primary greylist"
									style="background-color: #4285f4;"
									onclick="backToList(this.form);">목록</button>
							</form>

						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>



</body>
</html>