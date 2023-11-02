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

<style>
.line {
	text-align: left; /* 하유리: 왼쪽 정렬(23.08.01.) */
	/* margin-bottom: 30px; */ /* 하유리: 하단 여백 추가(23.08.01.) */
	margin-top: 30px; /* 하유리: 상단 여백 추가(23.08.02.) */
}

/* 입력된 댓글_id */
.line-userId {
	flex-grow: 1;
	text-align: left; /* 하유리: 좌측 정렬(23.08.01.) */
	font-weight: 700; /* 하유리: 폰트 굵기 지정(23.08.01.) */
	vertical-align: 9.3px; /* 하유리: 아이콘-id 세로 중앙정렬(23.08.02.) */
	margin-left: 0px; /* 하유리: 좌측 여백 지정(23.08.02.) */
	color: #000; /* 하유리: 폰트 색상 지정(23.08.02.) */
}

/* 입력된 댓글_내용 */
.line-title {
	width: 800px; /* 하유리: 댓글 너비 지정(23.08.01.) */
	/* font-weight: bold; */ /* 하유리: 주석 처리(23.08.01.) */
	/* margin-right: 10px; */ /* 하유리: 주석 처리(23.08.01.) */
	padding: 7px 0; /* 하유리: 상하 여백만 주도록 변경(23.08.01.) */
	/* background-color: #128853; */ /* 하유리: 배경색 주석 처리(23.08.01.) */
	color: #333; /* 하유리: 폰트 색상 변경(23.08.01.) */
	margin-left: 0px; /* 하유리: 좌측 여백 지정(23.08.02.) */
	margin-top: -10px; /* 하유리: 아이디-댓글 내용 사이 여백 지정(23.08.02.) */
}

/* '대댓글' 버튼 */
.line-comment {
	font-size: 13px; /* 하유리: 폰트 크기 지정(23.08.02.) */
	color: #828c94; /* 하유리: 폰트 색상 지정(23.08.02.) */
	font-weight: 400; /* 하유리: 폰트 굵기 지정(23.08.02.) */
	/* 하유리: 굵기 변경(23.08.02.) */
	display: inline; /* 하유리: 인라인요소로 지정(23.08.02.) */
	border: none; /* 하유리: 버튼 테두리 제거(23.08.02.) */
	background-color: #fff; /* 하유리: 배경 지정(23.08.02.) */
	margin-left: 10px; /* 하유리: 좌측으로 이동(23.08.02.) */
}

button:focus {
	outline: none;
	-webkit-tap-hignlight-color: transparent;
	/* 하유리: 버튼 클릭 시 테두리 안 생기게(23.08.02.) */
}

/* 댓글작성 폼 */
#commentForm2 {
	margin-top: 50px;
	float: left;
	margin-left: 139px; /* 하유리: 좌측 여백 지정(23.08.01.) */
	margin-bottom: 100px; /* 하유리: 하단 여백 지정(23.08.01.) */
	border-top: 7px solid #eeeeee;
	/* 하유리: 글쓰기 테이블 - 댓글 작성폼 사이의 구분선(23.08.01.) */
	padding-top: 50px; /* 하유리: 구분선 - 댓글 작성폼 사이의 여백(23.08.01.) */
	width: 832px; /* 하유리: 너비 지정(23.08.01.) */
}

/* 댓글작성폼 상단 '댓글' 텍스트' */
#commentForm2 p {
	text-align: left; /* 하유리: 좌측 정렬(23.08.01.) */
	font-size: 20px; /* 하유리: 폰트 크기 지정(23.08.01.) */
	font-weight: 700; /* 하유리: 폰트 굵기 지정(23.08.01.) */
	letter-spacing: -1px; /* 하유리: 자간 지정(23.08.01.) */
}

/* 댓글 입력 부분 */
.comment_input {
	height: 61px; /* 하유리: 높이(23.08.01.) */
	border-radius: 10px; /* 하유리: 테두리 가장자리 둥글게 지정(23.08.01.) */
	display: flex; /* 하유리: 요소 일정간격으로 배열(23.08.01.) */
	justify-content: space-between;
	align-items: center; /* 하유리: 세로 중앙 배열(23.08.01.) */
	margin-bottom: 10px; /* 하유리: input 외부에 여백 지정(23.08.01.) */
}

/* 댓글 적는 사람 아이콘 */
#commentForm2 img {
	height: 28px; /* 하유리: 크기 지정(23.08.01.) */
}

/* 댓글_id, 내용 입력 input */
.comment_id, .comment_text, .comment_text2, #commentBt, .reply-btn {
	border: 1px solid #e3e3e3; /* 하유리: 테두리 지정(23.08.01.) */
	height: 35px; /* 하유리: 높이 지정(23.08.01.) */
	border-radius: 8px; /* 하유리: 테두리 가장자리 둥글게 지정(23.08.01.) */
	font-weight: 300; /* 하유리: 폰트 크기 지정(23.08.01.) */
	outline: none; /* 하유리: 클릭 시 생기는 테두리 없애기(23.08.01.) */
}

/* 댓글_id 입력 input */
.comment_id {
	width: 150px; /* 하유리: 너비 지정(23.08.01.) */
	padding: 10px; /* 하유리: input 내부 여백 지정(23.08.01.) */
}

/* 댓글_내용 입력 input */
.comment_text, .comment_text2 {
	width: 530px; /* 하유리: 너비 지정(23.08.01.) */
	padding: 10px; /* 하유리: input 내부 여백 지정(23.08.01.) */
}

.comment_text2 {
	margin: 10px 10px 0 36px;
}

/* 댓글입력 버튼 */
#commentBt, .reply-btn {
	width: 105px; /* 하유리: 너비 지정(23.08.01.) */
	font-weight: 500; /* 하유리: 폰트 굵기 지정(23.08.01.) */
}

/* 입력된 댓글 전체<div> */
#commentList {
	border: 1px solid #e2e2e2; /* 하유리: 테두리 지정(23.08.02.) */
	border-radius: 15px; /* 하유리: 모서리 둥글게 지정(23.08.02.) */
	padding: 0 20px 30px 20px; /* 하유리: 안쪽 여백 지정(23.08.02.) */
}
</style>

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
							style="vertical-align: middle; background-color: #C0C0C0;">첨부
							파일</th>
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
			<div class="comment_wrap">
				<div id="commentForm2">
					<form id="commentForm" method="POST">
						<p>댓글
						<p>
						<div class="comment_input">
							<input class="comment_id" type="text" name="userId" id="userId"
								placeholder="로그인 후 이용 가능" value="${memberInfo.member_id}"
								required readOnly> <input class="comment_text"
								type="text" name="ac_content" id="ac_content"
								placeholder="댓글 내용" required autocomplete="off">
							<button type="submit" id="commentBt">댓글 입력</button>
						</div>
					</form>
					<div id="commentList"></div>
				</div>
			</div>
		</div>
	</div>

	<script>
	// 페이지 호출시 해당 게시글 댓글 내용 출력
	$(document).ready(function () {
		var _notice_no = ${article.notice_No};
		
		$.ajax({
			url: '${contextPath}/comment/listComment.do',
			type: 'POST',
			data: {notice_no :_notice_no},
			dataType: "text",
			success: function (response) {
				var _response = JSON.parse(response);
				var commentList = $('#commentList');
				commentList.empty(); // 기존 목록을 비웁니다.

				for (var i = 0; i < _response.comment.length; i++) {
					var comment = _response.comment[i];
					var newComment = $('<div class="line">');                                                                  				
					var levelSum = 0;
					
					if (comment.parent_No !== 0) {
						levelSum += 40;
						newComment = $('<div class="line">').css('padding-left', levelSum + 'px');
						
					}
					
					newComment.append($('<div class="line-userId">').text(comment.member_Id));                    			
					newComment.append($('<div class="line-title">').text(comment.reply_Content));                              	
					newComment.append($('<button class="line-comment" name="reply" onclick="showCommentForm('+i+')">・ 대댓글</button>'));			

					var ac_commentNoValue = comment.reply_No;
					newComment.append($('<form id="comment_reply_Form_' + i + '" method="POST" style="display:none;"><input type="text" id="reply-NO_' + i + '" value="' + ac_commentNoValue + '" hidden><input type="text" class="comment_text2" id="reply-input_' + i + '" placeholder="대댓글을 입력해주세요" autocomplete="off"><button type="submit" id="commentBt2_' + i + '" class="reply-btn">대댓글 입력</button></form>'));
					console.log('넘버 내용: ' + ac_commentNoValue);
					commentList.append(newComment);
				}
			},
			error: function() {
				alert('비회원 상태입니다.\n로그인 창으로 넘어갑니다.');
				location.href = '${contextPath}/user/loginForm.do';
			}
		});
	});
	
	//대댓글 클릭시 대댓글 입력창 보이기
	function showCommentForm(i) {
		if($('#comment_reply_Form_' + i + '').css('display')=='block') {
			$('#comment_reply_Form_' + i + '').css('display','none');
		} else {
			$('#comment_reply_Form_' + i + '').css('display','block');			
		}
	}
	
	//댓글 작성 코드 11/02
	$('#commentForm').on('submit', function(event) {
		event.preventDefault(); // 폼의 기본 동작인 제출을 막습니다.

		var _notice_no = ${article.notice_No};
		var ac_content = $('#ac_content').val(); // 댓글 내용을 가져옵니다.
		var userId = $('#userId').val();

        console.log('클릭!');

		// 댓글 추가를 위한 AJAX 요청 보내기
		$.ajax({
			url: '${contextPath}/comment/addComment.do', // 실제 댓글을 추가하는 서버 URL로 대체해주세요
			type: 'POST',
			data: {ac_content : ac_content, userId : userId, notice_no :_notice_no},
			dataType: "text",
			success: function (response) {
				var _response = JSON.parse(response);
				var commentList = $('#commentList');
				commentList.empty(); // 기존 목록을 비웁니다.

				for (var i = 0; i < _response.comment.length; i++) {
					var comment = _response.comment[i];
					var newComment = $('<div class="line">');                                                                  				
					var levelSum = 0;
					
					if (comment.parent_No !== 0) {
						levelSum += 40;
						newComment = $('<div class="line">').css('padding-left', levelSum + 'px');
						// newComment.addClass('line-child');
					}
					
					newComment.append($('<div class="line-userId">').text(comment.member_Id));                    			
					newComment.append($('<div class="line-title">').text(comment.reply_Content));                              	
					newComment.append($('<button class="line-comment" name="reply" onclick="showCommentForm('+i+')">・ 대댓글</button>'));			

					var ac_commentNoValue = comment.reply_No;
					newComment.append($('<form id="comment_reply_Form_' + i + '" method="POST" style="display:none;"><input type="text" id="reply-NO_' + i + '" value="' + ac_commentNoValue + '" hidden><input type="text" class="comment_text2" id="reply-input_' + i + '" placeholder="대댓글을 입력해주세요" autocomplete="off"><button type="submit" id="commentBt2_' + i + '" class="reply-btn">대댓글 입력</button></form>'));
					console.log('넘버 내용: ' + ac_commentNoValue);
					commentList.append(newComment);
				}
			},
			error: function() {
				alert('비회원 상태입니다.\n로그인 창으로 넘어갑니다.');
				location.href = '${contextPath}/member/loginForm.do';
			}
		});
	});
	
	// 11/02 대댓글 작성 기능
	$(document).on('click', '[id^="commentBt2_"]', function(event) {
		var _notice_no = ${article.notice_No};
		var userId = $('#userId').val();
		
	    event.preventDefault();
	    var commentIndex = $(this).attr('id').split('_')[1]; // 버튼의 id에서 댓글 인덱스를 추출합니다.
	    var ac_parentNO = $('#reply-NO_' + commentIndex).val(); //부모넘버
	    var ac_content = $('#reply-input_' + commentIndex).val(); //대댓글 내용
	    console.log('댓글 번호: ' + ac_parentNO);
	    console.log('대댓글 내용: ' + ac_content);
	    // 댓글 데이터를 사용하여 원하는 동작을 수행합니다.

	 	// 댓글 추가를 위한 AJAX 요청 보내기
        $.ajax({
            url: '${contextPath}/comment/addCocomment.do', // 실제 댓글을 추가하는 서버 URL로 대체해주세요
            type: 'POST',
            data: {ac_parentNO : ac_parentNO, ac_content : ac_content, userId : userId, notice_no :_notice_no},
            dataType: "text",
            success: function (response) {
				var _response = JSON.parse(response);
				var commentList = $('#commentList');
				commentList.empty(); // 기존 목록을 비웁니다.

				for (var i = 0; i < _response.comment.length; i++) {
					var comment = _response.comment[i];
					var newComment = $('<div class="line">');                                                                  				
					var levelSum = 0;
					
					if (comment.parent_No !== 0) {
						levelSum += 40;
						newComment = $('<div class="line">').css('padding-left', levelSum + 'px');
						// newComment.addClass('line-child');
					}
					
					newComment.append($('<div class="line-userId">').text(comment.member_Id));                    			
					newComment.append($('<div class="line-title">').text(comment.reply_Content));                              	
					newComment.append($('<button class="line-comment" name="reply" onclick="showCommentForm('+i+')">・ 대댓글</button>'));			

					var ac_commentNoValue = comment.reply_No;
					newComment.append($('<form id="comment_reply_Form_' + i + '" method="POST" style="display:none;"><input type="text" id="reply-NO_' + i + '" value="' + ac_commentNoValue + '" hidden><input type="text" class="comment_text2" id="reply-input_' + i + '" placeholder="대댓글을 입력해주세요" autocomplete="off"><button type="submit" id="commentBt2_' + i + '" class="reply-btn">대댓글 입력</button></form>'));
					console.log('넘버 내용: ' + ac_commentNoValue);
					commentList.append(newComment);
				}
			},
            error: function() {
            	alert('비회원 상태입니다.\n로그인 창으로 넘어갑니다.');
                location.href = '${contextPath}/user/loginForm.do';
            }
        });    
	});
	</script>

</body>
</html>