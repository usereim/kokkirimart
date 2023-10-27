<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="final_total_order_price" value="0" />
<!-- 총 할인금액 -->
<c:set var="total_discount_price" value="0" />
<!-- 최종결제금액 -->
<c:set var="final_totalQuantity" value="0" />
<!--배송비  -->
<%-- <c:set var="delivery_fee" value="3500" /> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- jQuery 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- jQuery UI 라이브러리 -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap"
	rel="stylesheet">
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- Custom CSS -->
<link href="${contextPath}/resources/css/order/orderEachGoods.css"
	rel="stylesheet" type="text/css">
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- jQuery UI -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- Bootstrap JS -->
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- 주소검색 api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- 포트원 결제 -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
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
      document.getElementById('detailAddress').value = data.detailAddress;

      // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
      if(data.autoRoadAddress) {
        //예상되는 도로명 주소에 조합형 주소를 추가한다.
        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
        document.getElementById('roadAddress').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

      } else if(data.autodetailAddress) {
          var expJibunAddr = data.autodetailAddress;
          document.getElementById('detailAddress').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
      } 
      window.close();
    }
  }).open();
}

$(function() {
    //input을 datepicker로 선언
    $("input[id='datepicker']").datepicker({
        dateFormat: 'yy-mm-dd' //달력 날짜 형태
        ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
        ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
        ,changeYear: true //option값 년 선택 가능
        ,changeMonth: true //option값  월 선택 가능                
        ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
        ,buttonImage: "${contextPath}/resources/images/order/calendar.png" //버튼 이미지 경로
        ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
        ,buttonText: "선택" //버튼 호버 텍스트              
        ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
        ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
        ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
        ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
    });                    
    
    //초기값을 오늘 날짜로 설정해줘야 합니다.
    $('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
});
</script>
<title>Insert title here</title>
<style>
.detail_table {
	display: flex;
	flex-direction: column;
	align-items: left;
	margin-top: 20px;
	margin-left: 30px;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 400;
	width: 90%;
	border-collapse: separate;
}

.detail_table table {
	margin-top: 10px;
	margin-bottom: 40px;
	text-align: left;
	border-collapse: separate; /* 'collapse'에서 'separate'로 변경 */
	width: 100%;
}

.detail_table table {
	width: 100%;
}

.detail_table td {
	text-align: left;
}

#hp1 {
	font-family: 'Noto Sans KR', sans-serif;
	outline: 0;
	height: 40px;
	border: 1px solid #E8E8E8;
	margin: 5px 5px 5px 0;
	padding: 10px;
	box-sizing: border-box;
	font-size: 14px;
}

.payment_table {
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 15px;
	margin-top: 30px;
	margin-left: 30px;
	font-weight: 400;
}

.payment_table td {
	padding: 5px;
}
/* 첫 번째 열의 넓이 조정 */
.payment_table td:first-child {
	width: 100px; /* 원하는 넓이로 조정하세요 */
}

.detail_table td:first-child {
	width: 100px; /* 원하는 넓이로 조정하세요 */
}

.title {
	font-family: 'Noto Sans KR', sans-serif;
	text-align: center;
	margin-top: 30px;
	font-size: 30px;
	font-weight: 700;
}

.delivery_table {
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 15px;
	margin-top: 30px;
	margin-left: 15px;
	font-weight: 400;
}

.fixed_join {
	margin-right: 20px;
}

#tr_pay_card {
	display: flex;
}
</style>
</head>
<body>
	<div class="order-container">
		<div class="title">주문/결제</div>
		<!-- 최상단 주문자 정보 -->
		<div class="orderer_info">
			<H1>주문자 정보</H1>
			<table class="order_cus">
				<tr class="dot_line">
					<td style="vertical-align: middle;"><span class="required">*</span>이름</td>
					<td>
						<div class="input-container">
							<input type="text" value="${orderer.member_name}" size="15"
								readonly />
						</div>
					</td>
				</tr>
				<tr class="dot_line">
					<td style="vertical-align: middle;"><span class="required"
						readonly>*</span>전화번호</td>
					<td>
						<div class="input-container">
							<input type="text"
								value="${orderer.tel1}-${orderer.tel2}-${orderer.tel3}"
								size="15" readonly />
						</div>
					</td>
				</tr>
				<tr class="dot_line">
					<td style="vertical-align: middle;"><span class="required"
						readonly>*</span>이메일</td>
					<td>
						<div class="input-container">
							<input type="text" value="${orderer.email1}" readonly />
						</div>
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join" style="vertical-align: top;"><span
						class="required">*</span>주소</td>
					<td>
						<div class="input-container">
							<input type="text" id="zipcode1" name="zipcode" size="5"
								value="${orderer.zipcode }" style="width: 80px !important;"
								readonly>
						</div>
						<div class="input-container">
							<input type="text" id="roadAddress1" name="roadAddress" size="50"
								value="${orderer.roadAddress }" readonly />
						</div>
						<div class="input-container">
							<input type="text" id="detailAddress1" name="detailAddress"
								size="50" value="${orderer.detailAddress }" readonly />
						</div> <input type="hidden" id="h_zipcode" name="h_zipcode"
						value="${orderer.zipcode }" /> <input type="hidden"
						id="h_roadAddress" name="h_roadAddress"
						value="${orderer.roadAddress }" /> <input type="hidden"
						id="h_detailAddress" name="h_detailAddress"
						value="${orderer.detailAddress }" />
					</td>
				</tr>
			</table>
		</div>

		<!-- 주문정보 -->
		<form name="form_order">
			<div class="container-fluid"
				style="min-height: calc(100vh - 136px); max-width: 900px; margin: 0 auto;">
				<!-- 그룹 태그로 role과 aria-multiselectable를 설정한다. -->
				<div class="panel-group" id="accordion" role="tablist"
					aria-multiselectable="true">

					<!-- 하나의 item입니다. data-parent 설청과 href 설정만 제대로 하면 문제없이 작동합니다. -->
					<div class="panel panel-default">
						<div class="panel-heading" role="tab">
							<a role="button" data-toggle="collapse" data-parent="#accordion"
								href="#collapse1" aria-expanded="true">주문내역</a>
						</div>
						<div id="collapse1" class="panel-collapse collapse in"
							role="tabpanel" aria-expanded="true">
							<div class="panel-body" style="padding-left: 35px;">
								<H1 style="margin-left: 5px;">주문상품</H1>
								<table class="list_view">
									<tr
										style="font-size: 15px; text-align: center; background: #1D1D1D; color: white;">
										<th colspan="2" class="fixed" style="text-align: center;">주문상품명</th>
										<th style="text-align: center;">수량</th>
										<th style="text-align: center;">주문금액</th>
										<!-- <th style="text-align: center;">배송비</th> -->
										<th style="text-align: center;">주문금액<br>합계
										</th>
									</tr>
									<c:forEach var="item" items="${myOrderList}">
										<tr
											style="font-size: 15px; text-align: center; font-weight: 400;">
											<td class="goods_image"><a
												href="${contextPath}/goods/goodsDetail.do?product_id=${item.product_id}">
													<img width="75" alt=""
													src="${contextPath}/thumbnails.do?product_id=${item.product_id}&fileName=${item.fileName}">
													<input type="hidden" id="h_product_id" name="h_product_id"
													value="${item.product_id}" /> <input type="hidden"
													id="h_goods_fileName" name="h_goods_fileName"
													value="${item.fileName}" />
											</a></td>
											<td>${item.product_name} <input type="hidden"
												id="h_order_product_name" name="h_order_product_name"
												value="${item.product_name}" />
											</td>
											<td>${item.order_qty}개 <input type="hidden"
												id="h_order_goods_qty" name="h_order_goods_qty"
												value="${item.order_qty}" />
											</td>
											<td><fmt:formatNumber value="${item.order_price}"
													type="number" var="order_price" />
												${order_price}원</td>
											<%-- <td><fmt:formatNumber value="${delivery_fee}"
													type="number" var="delivery_fee2" />${delivery_fee2 }</td>
											<td><fmt:formatNumber
													value="${0.05 * item.order_price}" type="number"
													var="order_price" /> ${order_price}원</td> --%>
											<td><fmt:formatNumber
													value="${item.order_price * item.order_qty}"
													type="number" var="each_pay_account" />
												${each_pay_account}원 <input type="hidden"
												id="h_each_pay_account" name="h_each_pay_account"
												value="${item.order_price * item.order_qty}" />
											</td>
										</tr>
										<c:set var="p_totalQuantity" value="${item.order_qty}" />
										<c:set var="final_totalQuantity"
											value="${final_totalQuantity+p_totalQuantity}" />
										<c:set var="p_totalPrice"
											value="${(item.order_price * item.order_qty)}" />
										<c:set var="final_total_order_price"
											value="${final_total_order_price + p_totalPrice}" />
									</c:forEach>

								</table>
								<p style="text-align: right; margin-right: 55px;">
									<span class="required">*</span>배송비는 한번만 적용됩니다.
								</p>
								<br>
								<script>
				function fn_point() {
					
					var point = retention_point.value;
					var myPoint = $('#myPoint').val();
					console.log("보유포인트: " +myPoint);
					var finalPrice = final_totalPrice.value;
					
					if (point > Number(myPoint)){
						alert("보유 적립금을 초과하였습니다.");
					}else if(Number(point)<0||Number(point)>Number(finalPrice)){
						alert("다시 입력해주세요!.");
					}else{
					console.log(finalPrice);
					del(p_totalSalesPrice);
					del(h_total_sales_price);
					del(h_pay_account);
					del(p_final_totalPrice);
					
					var html = '';
					var html2 = '';
					if(Number(point)==0){
						point=Number(0);
					}
					html += "<p id='p_totalSalesPrice' class='fs-3'>" + point + "원</p>";
					html += "<input id='h_total_sales_price' type='hidden' value='"+point+"' />";
					new_p_totalSalesPrice.innerHTML = html;
					console.log("포인트:" + h_total_sales_price.value);
					var new_finalPrice = document.getElementById("finalPrice");
					html2 += "<p id='p_final_totalPrice' class='fs-3'>"
							+ (finalPrice - point+3500) + "원 </p>";
					html2 += "<input id='h_pay_account' type='hidden' value='"
							+ (finalPrice - point+3500) + "' />";
					new_finalPrice.innerHTML = html2;}

				}
				function del(elementId) {
					var element = document.getElementById(elementId);
					if (element) {
						element.remove();
					}
				}
				</script>

								<H1 style="margin-left: 5px;">최종 결제금액</H1>
								<div class="cart-total" style="width: 100%">
									<table class="cart-total-table">
										<tbody>
											<tr>
												<td>총 상품 수</td>
												<td>
													<p id="p_total_order_goodsqty">${final_totalQuantity}개</p>
													<input id="h_total_order_goods_qty" type="hidden"
													value="${final_totalQuantity}" />
												</td>
											</tr>
											<tr>
												<td>주문금액</td>
												<td><fmt:formatNumber
														value="${final_total_order_price}" type="number"
														var="final_total_order_price2" />
													<p id="final_total_order_price">${final_total_order_price}원</p>
												</td>
												<td><input id="h_totalPrice" type="hidden"
													value="${p_totalPrice}" /> <input id="final_totalPrice"
													type="hidden" value="${final_total_order_price}" /></td>
											</tr>
											<%-- <tr>
												<td>배송비</td>
												<td><fmt:formatNumber value="${delivery_fee}"
														type="number" var="delivery_fee2" />
													<p id="p_totalDelivery">${delivery_fee2}원</p> <input
													id="h_totalDelivery" type="hidden" value="${delivery_fee}" />
												</td>
											</tr> --%>
											<tr>
												<td style="font-weight: 700;"><span class="required">*</span>최종
													결제 금액</td>
												<td id="finalPrice">
													<p id="p_final_totalPrice">${final_total_order_price}원</p>
													<input id="h_pay_account" type="hidden"
													name="pay_account" value="${final_total_order_price}" />
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>

					<!-- 하나의 item입니다.  -->
					<div class="panel panel-default">
						<div class="panel-heading" role="tab">
							<a role="button" data-toggle="collapse" data-parent="#accordion"
								href="#collapse2" aria-expanded="false">배송지</a>
						</div>
						<div id="collapse2" class="panel-collapse collapse"
							role="tabpanel">
							<div class="panel-body" style="padding-left: 35px;">
								<H1 style="margin-left: 5px;">배송지 정보</H1>

								<DIV class="delivery_table">
									<table>
										<tbody>
											<tr class="dot_line">
												<td colspan="2">
													<div class="input-container3" style="margin-bottom: 20px;">
														<input type="radio" name="delivery_place"
															onClick="restore_all()" value="기본배송지" checked>기본배송지
														&nbsp;&nbsp;&nbsp; <input type="radio"
															name="delivery_place" value="새로입력" onClick="reset_all()">새로입력
														&nbsp;&nbsp;&nbsp;
													</div>
												</td>
											</tr>
											<tr class="dot_line">
												<td class="fixed_join" style="margin-right: 5px;">받으실 분</td>
												<td>
													<div class="input-container3">
														<input id="order_name" name="order_name" type="text"
															size="40" value="${orderer.member_name }" />
													</div>
													<div class="input-container3">
														<input type="hidden" id="h_member_name"
															name="h_member_name" value="${orderer.member_name }" />
													</div>
													<div class="input-container3">
														<input type="hidden" id="h_order_name"
															name="h_order_name" value="${orderer.member_name }" />
													</div>
												</td>
											</tr>
											<tr class="dot_line">
												<td class="fixed_join">휴대폰번호</td>
												<td style="vertical-align: top;">
													<div class="input-container3"
														style="display: inline-block; box-sizing: border-box;">
														<select id="hp1" name="hp1"
															style="width: 220px; text-align: center;">
															<option>없음</option>
															<option value="010" selected>010</option>
															<option value="011">011</option>
															<option value="016">016</option>
															<option value="017">017</option>
															<option value="018">018</option>
															<option value="019">019</option>
														</select> - <input
															style="display: inline-block; width: 225px; text-align: center;"
															type="text" id="hp2" name="hp2" value="${orderer.tel2 }">
														- <input
															style="display: inline-block; width: 225px; text-align: center;"
															type="text" id="hp3" name="hp3" value="${orderer.tel3 }">
														<input type="hidden" id="h_hp1" name="h_hp1"
															value="${orderer.tel1 }" /> <input type="hidden"
															id="h_hp2" name="h_hp2" value="${orderer.tel2 }" /> <input
															type="hidden" id="h_hp3" name="h_hp3"
															value="${orderer.tel3 }" />
														<c:set var="orderer_hp"
															value="${orderer.tel1}-${orderer.tel2}-${orderer.tel3 }" />
													</div>
												</td>
											</tr>

											<tr class="dot_line">
												<td class="fixed_join">주소</td>
												<td>
													<div class="input-container3" style="margin-bottom: 5px;">
														<input type="text" id="zipcode" name="zipcode" size="5"
															value="${orderer.zipcode }" style="width: 100px;">
														<button type="button"
															style="background: #1D1D1D; color: white; height: 35px;"
															onclick="execDaumPostcode();">주소 검색</button>
													</div>
													<div class="input-container3" style="margin-bottom: 5px;">
														<input type="text" id="roadAddress" name="roadAddress"
															size="50" value="${orderer.roadAddress }" />
													</div>
													<div class="input-container3" style="margin-bottom: 5px;">
														<input type="text" id="detailAddress" name="detailAddress"
															size="50" value="${orderer.detailAddress }" />
													</div> <input type="hidden" id="h_zipcode" name="h_zipcode"
													value="${orderer.zipcode }" /> <input type="hidden"
													id="h_roadAddress" name="h_roadAddress"
													value="${orderer.roadAddress }" /> <input type="hidden"
													id="h_detailAddress" name="h_detailAddress"
													value="${orderer.detailAddress }" />
												</td>
											</tr>
											<tr class="dot_line">
												<td class="fixed_join">배송 메시지</td>
												<td>
													<div class="input-container3" style="margin-bottom: 5px;">
														<input id="order_message" name="order_message"
															type="text" size="50"
															placeholder="택배 기사님께 전달할 메시지를 남겨주세요." />
													</div>
												</td>
											</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading" role="tab">
							<a role="button" data-toggle="collapse" data-parent="#accordion"
								href="#collapse3" aria-expanded="false"> 결제수단 </a>
						</div>
						<div id="collapse3" class="panel-collapse collapse"
							role="tabpanel">
							<div class="panel-body" style="padding-left: 35px;">
								<H1 style="margin-left: 5px;">결제 방법 선택</H1>
								<div class="payment_table">
									<table style="width: 500px;">

										<tr>
											<td style="width: 33.33%;"><input type="radio"
												id="pay_method" name="pay_method" value="신용카드"
												onClick="fn_pay_card()" checked>신용카드</td>
											<td style="width: 33.33%;"><input type="radio"
												id="pay_method" name="pay_method" value="휴대폰결제"
												onClick="fn_pay_phone()">휴대폰 결제</td>
											<td style="width: 33.33%;"><input type="radio"
												id="pay_method" name="pay_method" value="카카오페이">카카오페이
											</td>

										</tr>

									</table>
									<div id="tr_pay_card"
										style="display: flex; box-sizing: border-box; margin-top: 20px;">

										카드 선택 <select id="card_com_name" name="card_com_name"
											style="margin-left: 5px; margin-right: 15px;">

											<option value="삼성" selected>삼성</option>
											<option value="하나SK">하나SK</option>
											<option value="현대">현대</option>
											<option value="KB">KB</option>
											<option value="신한">신한</option>
											<option value="롯데">롯데</option>
											<option value="BC">BC</option>
											<option value="시티">시티</option>
											<option value="NH농협">NH농협</option>
										</select> 할부 기간 <select id="pay_monthly" name="pay_monthly"
											style="margin-left: 5px;">
											<option value="일시불" selected>일시불</option>
											<option value="2개월">2개월</option>
											<option value="3개월">3개월</option>
											<option value="4개월">4개월</option>
											<option value="5개월">5개월</option>
											<option value="6개월">6개월</option>
										</select>

									</div>
									<div id="tr_pay_phone"
										style="visibility: hidden; display: flex; box-sizing: border-box;">
										결제 휴대폰 번호 입력 <input type="text" size="5" value=""
											id="pay_tel1" name="pay_tel1"
											style="margin-left: 5px; margin-right: 5px;" />- <input
											type="text" size="5" value="" id="pay_tel2" name="pay_tel2"
											style="margin-left: 5px; margin-right: 5px;" />- <input
											type="text" size="5" value="" id="pay_tel3" name="pay_tel3"
											style="margin-left: 5px; margin-right: 5px;" />
									</div>

								</div>
							</div>
						</div>
					</div>
				</div>
				<div style="text-align: right;">
					<a href="javascript:fn_process_pay_order();"> <input
						type="button" class="btn btn-secondary" value="최종 결제하기"
						style="background: #1D1D1D; color: white; height: 35px; margin-right: 5px; font-weight: 500;" />
					</a> <a href="${contextPath}/main/main.do"> <input type="button"
						class="btn btn-secondary" value="쇼핑 계속하기"
						style="background: #E8E8E8; color: black; height: 35px; font-weight: 500;" />
					</a>
				</div>
			</div>
			<!-- tab end div -->
		</form>
		<!-- end form -->
	</div>


	<div id="layer" style="visibility: hidden">
		<!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
		<div id="popup_order_detail">
			<!-- 팝업창 닫기 버튼 -->
			<a href="javascript:"
				onClick="javascript:imagePopup('close', '.layer01');"> <img
				src="${contextPath}/resources/image/close.png" id="close" />
			</a> <br />
			<div class="detail_table2">
				<h1>주문 확인</h1>
				<table>
					<tbody align=left>
						<tr>
							<td width=200px>주문상품번호:</td>
							<td>
								<p id="p_order_product_id">주문번호</p>
							</td>
						</tr>
						<tr>
							<td width=200px>주문상품명:</td>
						</tr>
						<tr>
							<td width=200px>주문상품개수:</td>
							<td>
								<p id="p_total_order_goods_qty">주문 상품개수</p>
							</td>
						</tr>
						<tr>
							<td width=200px>주문금액합계:</td>
							<td>
								<p id="p_total_order_pay_account">주문금액합계</p>
							</td>
						</tr>
						<tr>
							<td width=200px>주문자:</td>
							<td>
								<p id="p_member_name">주문자 이름</p>
							</td>
						</tr>
						<tr>
							<td width=200px>받는사람:</td>
							<td>
								<p id="p_order_name">받는사람이름</p>
							</td>
						</tr>
						<tr>
							<td width=200px>받는사람 휴대전화:</td>
							<td>
								<p id="p_receiver_hp_num"></p>
							</td>
						</tr>
						<tr>
							<td width=200px>배송주소:</td>
							<td align=left>
								<p id="p_delivery_address">배송주소</p>
							</td>
						</tr>
						<tr>
							<td width=200px>배송메시지:</td>
							<td align=left>
								<p id="p_order_message">배송메시지</p>
							</td>
						</tr>

						<tr>
							<td width=200px>결제방법:</td>
							<td align=left>
								<p id="p_pay_method">결제방법</p>
							</td>
						</tr>
				</table>

				<input name="btn_process_pay_order" type="button"
					onClick="fn_process_pay_order()" value="최종 결제하기"
					style="margin-top: 15px; color: white; background: black;">



			</div>
		</div>
	</div>
	<div class="clear"></div>
	<br>



	<script type="text/javascript">
function init(){
  	var form_order=document.form_order;

  	var h_hp1=form_order.h_hp1;
  	var hp1=h_hp1.value;
  	var select_hp1=form_order.hp1;
  	select_hp1.value=hp1;
  }    

function fn_pay_phone(){
	
	
	var e_card=document.getElementById("tr_pay_card");
	var e_phone=document.getElementById("tr_pay_phone");
	e_card.style.visibility="hidden";
	e_phone.style.visibility="visible";
}

function fn_pay_card(){
	var e_card=document.getElementById("tr_pay_card");
	var e_phone=document.getElementById("tr_pay_phone");
	e_card.style.visibility="visible";
	e_phone.style.visibility="hidden";
}

function imagePopup(type) {
	if (type == 'open') {
		// 팝업창을 연다.
		jQuery('#layer').attr('style', 'visibility:visible');

		// 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
		jQuery('#layer').height(jQuery(document).height());
	}

	else if (type == 'close') {

		// 팝업창을 닫는다.
		jQuery('#layer').attr('style', 'visibility:hidden');
	}
}

var product_id="";
var goods_fileName="";

var order_qty;
var each_pay_account;
var total_order_goods_qty;
var member_name;
var order_name;
var hp1;
var hp2;
var hp3;
var receiver_hp_num;
var delivery_address;
var order_message;
var delivery_method;
var pay_method;
var card_com_name;
var pay_monthly;
var pay_orderer_hp_num;



function fn_process_pay_order(){
	product_id="";
	product_name="";
	goods_fileName="";
	
	var frm=document.form_order;
	var h_product_id=frm.h_product_id;
	var h_goods_fileName=frm.h_goods_fileName;
	var h_order_goods_qty=document.getElementById("h_order_goods_qty");
	var h_total_order_goods_qty=document.getElementById("h_total_order_goods_qty");
	var h_total_sales_price=document.getElementById("h_total_sales_price");
	var h_pay_account=document.getElementById("h_pay_account");
	var h_member_name=document.getElementById("h_member_name");
	var i_order_name=document.getElementById("order_name");
	var i_pay_account=document.getElementById("p_final_totalPrice");

	if(h_product_id.length <2 ||h_product_id.length==null){
		product_id+=h_product_id.value;
	}else{
		for(var i=0; i<h_product_id.length;i++){
			product_id+=h_product_id[i].value+"<br>";
			
		}	
	}
	
	
	
	if(h_goods_fileName.length <2 ||h_goods_fileName.length==null){
		goods_fileName+=h_goods_fileName.value;
	}else{
		for(var i=0; i<h_goods_fileName.length;i++){
			goods_fileName+=h_goods_fileName[i].value+"<br>";
			
		}	
	}
	
	console.log(h_pay_account);
	total_order_pay_account=h_pay_account.value;

	total_order_goods_qty=h_total_order_goods_qty.value;
	

		

	
	var r_pay_method  =  frm.pay_method;
	
	for(var i=0; i<r_pay_method.length;i++){
	  if(r_pay_method[i].checked==true){
		  pay_method=r_pay_method[i].value
		  if(pay_method=="신용카드"){
			var i_card_com_name=document.getElementById("card_com_name");
			var i_pay_monthly=document.getElementById("pay_monthly");
			card_com_name=i_card_com_name.value;
			pay_monthly=i_pay_monthly.value;
			pay_method+="<Br>"+
				 		"카드사:"+card_com_name+"<br>"+
				 		"할부개월수:"+pay_monthly;
			pay_orderer_hp_num="해당없음";
			
		  }else if(pay_method=="휴대폰결제"){
			var i_pay_tel1=document.getElementById("pay_tel1");
			var i_pay_tel2=document.getElementById("pay_tel2");
			var i_pay_tel3=document.getElementById("pay_tel3");
			pay_orderer_hp_num=i_pay_tel1.value+"-"+
						   	    i_pay_tel2.value+"-"+
							    i_pay_tel3.value;
			pay_method+="<Br>"+"결제휴대폰번호:"+pay_orderer_hp_num;
			card_com_name="해당없음";
			pay_monthly="해당없음";
		  } //end if
		 break;
	  }// end for
	}
	
	var i_hp1=document.getElementById("hp1");
	var i_hp2=document.getElementById("hp2");
	var i_hp3=document.getElementById("hp3");
	var i_zipcode=document.getElementById("zipcode");
	var i_roadAddress=document.getElementById("roadAddress");
	var i_detailAddress=document.getElementById("detailAddress");
	var i_order_message=document.getElementById("order_message");
	var i_pay_method=document.getElementById("pay_method");
	var i_pay_account=document.getElementById("p_final_totalPrice");

//	alert("총주문 금액:"+total_order_pay_account);
	order_goods_qty=h_order_goods_qty.value;
	//order_total_price=h_order_total_price.value;
	
	
	member_name=h_member_name.value;	
	order_name=i_order_name.value;	
	hp1=i_hp1.value;	
	hp2=i_hp2.value;	
	hp3=i_hp3.value;	
	//pay_account = final_total_order_price.value;
	//alert("두번째 토탈 프라이스:"+pay_account);	
	receiver_hp_num=hp1+"-"+hp2+"-"+hp3;	
	delivery_address=i_zipcode.value+"<br>"+
					 i_roadAddress.value+"<br>"+
					 "["+i_detailAddress.value+"]<br>";
	order_message = i_order_message.value;

	//alert("최종 결제하기");

    // 새로운 form을 생성합니다.
    var formObj = document.createElement("form");

    // 필요한 input 요소들을 생성하고 값을 설정합니다.
    var s_order_name = document.createElement("input");
    var s_receiver_hp1 = document.createElement("input");
    var s_receiver_hp2 = document.createElement("input");
    var s_receiver_hp3 = document.createElement("input");
    var s_delivery_address = document.createElement("input");
    var s_order_message = document.createElement("input");
    var s_pay_method = document.createElement("input");
    var s_card_com_name = document.createElement("input");
    var s_pay_monthly = document.createElement("input");
    var s_pay_orderer_hp_num = document.createElement("input");
    var s_pay_account = document.createElement("input");

    // 각 input 요소에 name 속성과 값을 설정합니다.
    s_order_name.name = "order_name";
    s_receiver_hp1.name = "hp1";
    s_receiver_hp2.name = "hp2";
    s_receiver_hp3.name = "hp3";
    s_delivery_address.name = "order_delivery_address";
    s_order_message.name = "order_message";
    s_pay_method.name = "pay_method";
    s_card_com_name.name = "card_com_name";
    s_pay_monthly.name = "pay_monthly";
    s_pay_orderer_hp_num.name = "pay_orderer_hp_num";
    s_pay_account.name = "pay_account"; 
 

    // 값을 설정합니다.
    s_order_name.value = order_name;
    s_receiver_hp1.value = hp1;
    s_receiver_hp2.value = hp2;
    s_receiver_hp3.value = hp3;
    s_delivery_address.value = delivery_address;
    s_order_message.value = order_message;
    s_pay_method.value = pay_method;
    s_card_com_name.value = card_com_name;
    s_pay_monthly.value = pay_monthly;
    s_pay_orderer_hp_num.value = pay_orderer_hp_num; 
    s_pay_account.value = total_order_pay_account;
   
    
    // form에 input 요소들을 추가합니다.
    formObj.appendChild(s_order_name);
    formObj.appendChild(s_receiver_hp1);
    formObj.appendChild(s_receiver_hp2);
    formObj.appendChild(s_receiver_hp3);
    formObj.appendChild(s_delivery_address);
    formObj.appendChild(s_order_message);
    formObj.appendChild(s_pay_method);
    formObj.appendChild(s_card_com_name);
    formObj.appendChild(s_pay_monthly);
    formObj.appendChild(s_pay_orderer_hp_num);
    formObj.appendChild(s_pay_account);


    // form을 body에 추가하고 submit합니다.
    document.body.appendChild(formObj);
    formObj.method = "post";
    formObj.action = "${contextPath}/order/payToOrderGoods.do";
    formObj.submit();

    
}


//배송지 주소 새로입력
function reset_all() {

	var e_order_name = document.getElementById("order_name");
    var e_hp1 = document.getElementById("hp1");
    var e_hp2 = document.getElementById("hp2");
    var e_hp3 = document.getElementById("hp3");
    var e_zipcode = document.getElementById("zipcode");
    var e_roadAddress = document.getElementById("roadAddress");
    var e_detailAddress = document.getElementById("detailAddress");
    
    e_order_name.value = "";
    e_hp1.value = 0;
    e_hp2.value = "";
    e_hp3.value = "";
    e_zipcode.value = "";
    e_roadAddress.value = "";
    e_detailAddress.value = "";
	
}

//기본배송지 복구
function restore_all() {	
	var h_order_name = document.getElementById("h_order_name");
    var h_hp1 = document.getElementById("h_hp1");
    var h_hp2 = document.getElementById("h_hp2");
    var h_hp3 = document.getElementById("h_hp3");
    var h_zipcode = document.getElementById("h_zipcode");
    var h_roadAddress = document.getElementById("h_roadAddress");
    var h_detailAddress = document.getElementById("h_detailAddress");

    var e_order_name = document.getElementById("order_name");
    var e_hp1 = document.getElementById("hp1");
    var e_hp2 = document.getElementById("hp2");
    var e_hp3 = document.getElementById("hp3");
    var e_zipcode = document.getElementById("zipcode");
    var e_roadAddress = document.getElementById("roadAddress");
    var e_detailAddress = document.getElementById("detailAddress");
    
    e_order_name.value = h_order_name.value;
    e_hp1.value = h_hp1.value;
    e_hp2.value = h_hp2.value;
    e_hp3.value = h_hp3.value;
    e_zipcode.value = h_zipcode.value;
    e_roadAddress.value = h_roadAddress.value;
    e_detailAddress.value = h_detailAddress.value;
	
}
</script>
</body>
</html>