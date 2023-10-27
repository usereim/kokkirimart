<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<head>
<style>


@import url(https://fonts.googleapis.com/css?family=Roboto:300);



 


#member_id, #member_name, #member_email, #member_pw, #mem_pw_confirm{
	width: 200px;
}
#member_birth_y, #member_birth_m, #member_birth_d, #member_hp1, #member_hp2, #member_hp3{
	width: 120px;
}
#checkIdButton,
#sendEmailButton {
	display: inline-block;
	vertical-align: middle;
	margin-left: 5px;
	margin-top: 0px;
	width: 130px;
	background: #4285f4;

#emailConfirm {
	margin-top: 10px;
	width: 200px;
}

.form-group.address-container {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  margin-bottom: 10px;
}

/* Adjust width of the address containers as needed */
.address-container {
  width: 100%; /* This will make the address fields occupy the full width of the form */
}

/* Optional: Adjust spacing between address fields */
.address-container input {
  margin-bottom: 5px;
}

  .required {
    color: #DB0000; /* 원하는 색상으로 변경하세요 */
  }
 
.centered-button {
  display: block;
  width: 100px; /* 원하는 너비를 설정하세요 */
  margin: 0;
  text-align: center;
  align-items: right;
}
.joinButton{
margin-top: 20px;
margin-left: 500pax;
}

#emailConfirm {
  display: flex;
  align-items: center;
}

#verifyBtn button{
width: 70px;
  height: 40px;
}


</style>
<link href="${contextPath}/resources/css/member/memberForm.css" rel="stylesheet" type="text/css">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
 
<title>회원가입</title>
</head>
<body>
<div class="memberForm-page">
  <div class="memberForm-text">
   	회원가입
  </div>
  <div class="form">
    <form id="memberForm" class="member-form" action="${contextPath}/member/addMember.do" method="post">
	
	<div class="form-group" style="margin-bottom: 0px;">
	  <div class="label-group">
	    <label for="member_id"><span class="required" >*</span>아이디</label>
	  </div>
	  <input type="text" placeholder="아이디" id="member_id" name="member_id" />
	  
	  <button type="button" id="checkIdButton">중복 체크</button>
	</div>

	<font id="checkId" size="2" style="margin-right: 100px;"></font>
	
	<div class="form-group">
	  <div class="label-group">
	    <label for="mem_pw"><span class="required" >*</span>비밀번호</label>
	  </div>
	  <input type="password" placeholder="비밀번호" id="member_pw" name="member_pw" style="margin-right: 5px;">
	<%--  <input type="password" placeholder="비밀번호 확인" id="mem_pw_confirm" name="mem_pw_confirm" /> --%>
	</div>	
	<%--  <span id="pwMismatchMessage" style="color: red;margin-left: 90px;"></span> --%>
	  <!-- 일치하지 않을 때 메시지를 표시할 위치 -->
	
      <div class="form-group">
        <div class="label-group">
          <label for="member_name"><span class="required" >*</span>이름</label>
        </div>
        <input type="text" placeholder="이름" id="member_name" name="member_name" />
      </div>

      <div class="form-group">
        <div class="label-group">
          <label for="mem_birth"><span class="required" >*</span>생년월일</label>
        </div>
        <div class="input-group">
          <input type="text" id="member_birth_y" name="member_birth_y" placeholder="년" maxlength="4">
          <input type="text" id="member_birth_m" name="member_birth_m" placeholder="월" maxlength="2">
          <input type="text" id="member_birth_d" name="member_birth_d" placeholder="일" maxlength="2">
        </div>
      </div>

      <div class="form-group">
        <div class="label-group">
          <label for="mem_tel"><span class="required" >*</span>연락처</label>
        </div>
        <div class="input-group">
          <select id="hp1" name="hp1">
			<option>없음</option>
			<option value="010" selected>010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="018">018</option>
			<option value="019">019</option>
		  </select> 

         <!--  <input type="text" id="mem_tel1" name="mem_tel1" placeholder="통신사" maxlength="3"> -->
          <input type="text" id="hp2" name="hp2" maxlength="4" 
          style="width: 122px;">
          <input type="text" id="hp3" name="hp3" maxlength="4" 
          style="width: 122px;">
        </div>
      </div>
      
       <div class="form-group" style="display: flex;align-items: center;">
        <div class="label-group">
          <label for="email1"><span class="required" >*</span>이메일</label>
        </div>
        <input type="text" placeholder="이메일" id="email1" name="email1" style="width:88%"/> @ <input type="text" placeholder="elephants.com" id="email2" name="email2" style="width:88%"/>
         
	<%-- 기존 이메일 입력 코드 가져옴 --%>
         <select name="email2" onChange=""	title="직접입력">
									<option value="non">직접입력</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="naver.com">naver.com</option>
									<option value="yahoo.co.kr">yahoo.co.kr</option>
									<option value="hotmail.com">hotmail.com</option>
									<option value="paran.com">paran.com</option>
									<option value="nate.com">nate.com</option>
									<option value="google.com">google.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="empal.com">empal.com</option>
									<option value="korea.com">korea.com</option>
									<option value="freechal.com">freechal.com</option>
							</select>


        <%-- <button type="button" id="sendMail" style="margin-left: 5px;">메일 인증</button> --%>

      </div>

<%-- 이메일 인증 필드
      <div id="emailConfirm" class="hide" style="width:100%">
        <input type="text" id="emailCode" name="emailCode" placeholder="인증번호 입력" style="margin-left: 90px;">
        <button type="button" id="verifyBtn" style="margin-left: 5px; width:100px;">인증 확인</button>
      </div>
--%>      
      
		<div class="form-group" style="width:100px; vertical-align: middle">
			<div class="label-group">
				<label for="mem_addr"><span class="required" >*</span>주소</label>
			</div>
			<div class="input-group">
				<input type="text" id="zipcode" name="zipcode" placeholder="우편번호" style="width:100px; ">
			</div>
			<a href="javascript:execDaumPostcode()">
			<button type="button" id="addressSearch" style="margin-left: 5px;background: #4285f4;">주소검색</button>
			</a>
		</div>		
	

		<div class="form-group">
			<div class="label-group">
				<label for="mem_addr"></label>
			</div>
			<div class="input-group">
				<input type="text" id="roadAddress" name="roadAddress" placeholder="도로명주소"><br>
			</div>
		</div>
		
		<div class="form-group">
			<div class="label-group">
				<label for="mem_addr"></label>
			</div>
				<div class="input-group">
					<input type="text" id="detailAddress" name="detailAddress"  placeholder="나머지 주소"><br>
				</div>
		</div>
<%--		
  	   <div class="form-group">
		 <div class="label-group">
		  	<label for="mem_addr"></label>
		 </div>
		<div class="input-group"> 
			<input type="text" name="namujiAddress" placeholder="나머지 주소" style="width:100%">
		</div>
	  </div>

  --%>
  
        <div class="form-group">
        <div class="label-group">
          <label for="mem_birth"><span class="required" >*</span>이메일 수신 여부</label>
        </div>
        <div class="input-group">
			<input type="checkbox" name="emailsts_yn" value="Y" checked="" style="
    width: 80px;
">
        </div>
      </div>

      <div>
      	<button type="submit" id="centered-button" style="width:200px;height:50px;margin-top:20px;margin-bottom:40px;margin-left: 300px;background: #4285f4;">회원가입</button>	
      </div>
    </form>
  </div>
</div>

<script>
	/* 아이디 중복 체크 */
$(document).ready(function() {
  $("#checkIdButton").on("click", function() {
    var member_id = $("#_member_id").val();
    if (member_id == '') {
      alert("아이디를 입력하세요.");
      return;
    }
    $.ajax({
      type: "post",
      async: false,
      url: "${contextPath}/member/overlapped.do",
      dataType: "json",
      data: {
        member_id: member_id
      },
      success: function(result) {
        if (result == 0) {
          alert("사용할 수 있는 아이디입니다.");
          $("#checkId").text("사용할 수 있는 아이디입니다.").css("color", "green");
          $("#checkIdButton").prop("disabled", true);
          $("#_member_pw").prop("disabled", false);
          $("#_member_name").prop("disabled", false);
          $("#_member_email").prop("disabled", false);
        } else {
          alert("사용할 수 없는 아이디입니다.");
          $("#checkId").text("사용할 수 없는 아이디입니다.").css("color", "red");
        }
        //$("#_member_id").prop("readonly", false); // ID 변경을 막기 위해 주석 처리
        //$("#checkIdButton").prop("disabled", false); // ID 중복 검사 후에도 버튼 비활성화 유지
      },
	      error: function(xhr, status, error) {
	        console.error(error);
	        alert("에러가 발생했습니다.");
	        $("#member_id").prop("readonly", false);
	        $("#checkIdButton").prop("disabled", false);
	      },
	      complete: function(xhr, status) {
	        
	      }
	    });
	  });
	});

	/* 이메일 인증 - 주석처리함 
	$(document).ready(function() {
	  $("#sendMail").click(function() {
	    var mem_email = $("#mem_email").val();
	    $.ajax({
	      type: "POST",
	      url: "${contextPath}/member/emailConfirm.do",
	      data: { mem_email: mem_email },
	      dataType: "text",
	    })
	      .done(function(data) {
	        alert("이메일로 인증번호가 발송되었습니다. 확인해주세요.");
	        console.log("서버에서 받은 인증 코드: " + data);
	        $("#emailCode").data("expectedCode", data);
	        $("#emailConfirm").removeClass("hide");
	      })
	      .fail(function(xhr) {
	        var errorMessage = "서버 요청 중 오류가 발생했습니다.";
	        if (xhr.status === 500) {
	          errorMessage = "서버 내부 오류가 발생했습니다.";
	        } else if (xhr.status === 404) {
	          errorMessage = "서버 URL을 찾을 수 없습니다.";
	        }
	        alert(errorMessage);
	      });
	  });
	
	  $("#verifyBtn").click(function () {
	    var verificationCode = $("#emailCode").val();
	    var expectedCode = $("#emailCode").data("expectedCode");
	
	    if (verificationCode === "") {
	      alert("인증 코드를 입력해주세요.");
	      return;
	    }
	
	    if (verificationCode === expectedCode) {
	      alert("이메일 인증이 완료되었습니다!");
	      isEmailVerified = true;
	    } else {
	      alert("올바른 인증 코드를 입력해주세요.");
	    }
	  });
	});

	이메일 인증 끝 */
	
	//주소 스크립트
	function execDaumPostcode() {
	  new daum.Postcode({
	    oncomplete: function(data) {
	      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	      // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
	      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	      var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
	      var extraRoadAddr = ''; // 도로명 조합형 주소 변수
	
	      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	        extraRoadAddr += data.bname;
	      }
	      // 건물명이 있고, 공동주택일 경우 추가한다.
	      if(data.buildingName !== '' && data.apartment === 'Y'){
	        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	      }
	      // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	      if(extraRoadAddr !== ''){
	        extraRoadAddr = ' (' + extraRoadAddr + ')';
	      }
	      // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
	      if(fullRoadAddr !== ''){
	        fullRoadAddr += extraRoadAddr;
	      }
	
	      // 우편번호와 주소 정보를 해당 필드에 넣는다.
	      document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
	      document.getElementById('roadAddress').value = fullRoadAddr;
	      document.getElementById('jibunAddress').value = data.jibunAddress;
	
	      // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	      if(data.autoRoadAddress) {
	        //예상되는 도로명 주소에 조합형 주소를 추가한다.
	        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	        document.getElementById('roadAddress').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	
	      } else if(data.autoJibunAddress) {
	          var expJibunAddr = data.autoJibunAddress;
	          document.getElementById('jibunAddress').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	      } 
	      window.close();
	    }
	  }).open();
	}
	
	 function validateForm() {
		    // 필수 입력 사항 체크
		    if ($("#member_id").val() === "") {
		      alert("아이디를 입력하세요.");
		      return false;
		    }

		    if ($("#member_pw").val() === "") {
		      alert("비밀번호를 입력하세요.");
		      return false;
		    }

		    if ($("#member_name").val() === "") {
		      alert("이름을 입력하세요.");
		      return false;
		    }
		    
		    if ($("#member_email").val() === "") {
			      alert("메일을 입력하세요.");
			      return false;
			}
		    return true;
	  }
	 
	  /* 폼 제출 시에도 비밀번호 일치 여부 체크
	  $("#memberForm").on("submit", function(e) {
	    // 필수 입력 사항 체크를 통과하지 않으면 폼 제출을 막습니다.
	    if (!validateForm() || !checkPasswordMatch()) {
	      e.preventDefault();
	    }
	  });
		주석처리 끝 */

	  // 폼 안에서 Enter 키를 눌렀을 때 기본 동작을 막습니다.
	  $("#memberForm").on("keypress", function(e) {
	    if (e.keyCode === 13) {
	      e.preventDefault();
	    }
	  });
		/*
	비밀번호 체크 주석처리함  
	  function checkPasswordMatch() {
		  var password = $("#mem_pw").val();
		  var confirmPassword = $("#mem_pw_confirm").val();
		  if (password !== confirmPassword) {
		    $("#pwMismatchMessage").text("비밀번호가 일치하지 않습니다.");
		    return false;
		  } else {
		    $("#pwMismatchMessage").text(""); // 일치하면 메시지 제거
		    return true;
		  }
		}

 	

		// 비밀번호와 비밀번호 확인 입력칸이 변경될 때마다 비교 함수 호출
		$("#mem_pw, #mem_pw_confirm").on("keyup", checkPasswordMatch);

		// 폼 제출 시에도 비밀번호 일치 여부 체크
		$("#memberForm").on("submit", function (e) {
		  if (!checkPasswordMatch()) {
		    e.preventDefault(); // 비밀번호가 일치하지 않으면 폼 제출을 막음
		  }
		});
비밀번호 체크 주석처리 끝 
*/

</script>

</body>
</html>