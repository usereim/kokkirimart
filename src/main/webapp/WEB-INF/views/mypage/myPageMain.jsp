<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<c:if test="${message=='cancel_order'}">
	<script>
		window.onload = function() {
			init();
		}

		function init() {
			alert("주문을 취소했습니다.");
		}
	</script>
</c:if>
<script>
	function fn_cancel_order(order_id) {
		var answer = confirm("주문을 취소하시겠습니까?");
		if (answer == true) {
			var formObj = document.createElement("form");
			var i_order_id = document.createElement("input");

			i_order_id.name = "order_id";
			i_order_id.value = order_id;

			formObj.appendChild(i_order_id);
			document.body.appendChild(formObj);
			formObj.method = "post";
			formObj.action = "${contextPath}/mypage/cancelMyOrder.do";
			formObj.submit();
		}
	}

	function fn_sangdam(order_id, member_id, product_name) { // product_name 추가
	    var answer = confirm("제품 상담을 신청하시겠습니까 ?");
	    if (answer == true) {
	        var formObj = document.createElement("form");

	        var i_order_id = document.createElement("input");
	        i_order_id.name = "order_id";
	        i_order_id.value = order_id;

	        var i_member_id = document.createElement("input");
	        i_member_id.name = "member_id";
	        i_member_id.value = member_id; // 수정

	        var i_product_name = document.createElement("input");
	        i_product_name.name = "product_name";
	        i_product_name.value = product_name;

			formObj.appendChild(i_order_id); // 수정
			formObj.appendChild(i_member_id); // 수정
			formObj.appendChild(i_product_name);

			document.body.appendChild(formObj);
			formObj.method="post";
			formObj.action="${contextPath}/mypage/consultation.do";
			alert("컨트롤러 호출");
			formObj.submit();	
	    }
	}
</script>
</head>
<body>
	<h1>
		최근주문내역 <A href="#"> <IMG
			src="${contextPath}/resources/image/btn_more_see.jpg">
		</A>
	</h1>
	<table class="list_view">
		<tbody align=center>
			<tr style="background: #33ff00">
				<td>주문번호</td>
				<td>주문일자</td>
				<td>주문상품</td>
				<td>상담하기</td>
				<td>주문취소</td>
			</tr>
			<c:choose>
				<c:when test="${ empty myOrderList  }">
					<tr>
						<td colspan=5 class="fixed"><strong>주문한 상품이 없습니다.</strong></td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="item" items="${myOrderList }" varStatus="i">
						<c:choose>
							<c:when test="${ pre_order_id != item.order_id}">
								<c:choose>
									<c:when test="${item.delivery_state=='delivery_prepared' }">
										<tr bgcolor="lightgreen">
									</c:when>
									<c:when test="${item.delivery_state=='finished_delivering' }">
										<tr bgcolor="lightgray">
									</c:when>
									<c:otherwise>
										<tr bgcolor="orange">
									</c:otherwise>
								</c:choose>
								<tr>
									<td><a
										href="${contextPath}/mypage/myOrderDetail.do?order_id=${item.order_id }"><span>${item.order_id }</span>
									</a></td>
									<td><span>${item.order_date }</span></td>
									<td align="left"><strong> <c:forEach var="item2"
												items="${myOrderList}" varStatus="j">
												<c:if test="${item.order_id ==item2.order_id}">
													<a
														href="${contextPath}/goods/goodsDetail.do?product_id=${item2.product_id }">${item2.product_name }/${item.order_qty }개</a>
													<br>
												</c:if>
											</c:forEach>
									</strong></td>
									<td><input type="button"
										onClick="fn_sangdam('${item.order_id}')" value="상담하기" /></td>
									<td><c:choose>
											<c:when test="${item.delivery_state=='delivery_prepared'}">
												<input type="button"
													onClick="fn_cancel_order('${item.order_id}')" value="주문취소" />
											</c:when>
											<c:otherwise>
												<input type="button"
													onClick="fn_cancel_order('${item.order_id}')" value="주문취소"
													disabled />
											</c:otherwise>
										</c:choose></td>
								</tr>
								<c:set var="pre_order_id" value="${item.order_id}" />
							</c:when>
						</c:choose>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>

	<br>
	<br>
	<br>
	<h1>
		계좌내역 <a href="#"> <img
			src="${contextPath}/resources/image/btn_more_see.jpg" />
		</a>
	</h1>
	<table border=0 width=100% cellpadding=10 cellspacing=10>
		<tr>
			<td>예치금 &nbsp;&nbsp; <strong>10000원</strong>
			</td>
			<td>쇼핑머니 &nbsp;&nbsp; <strong>9000원</strong>
			</td>
		</tr>
		<tr>
			<td>쿠폰 &nbsp;&nbsp; <strong>6000원</strong>
			</td>
			<td>포인트 &nbsp;&nbsp; <strong>2000원</strong>
			</td>
		</tr>
		<tr>
			<td>상품권 &nbsp;&nbsp; <strong>4000원</strong>
			</td>
			<td>디지털머니 &nbsp;&nbsp; <strong>9000원</strong>
			</td>
		</tr>
	</table>

	<br>
	<br>
	<br>
	<h1>
		나의 정보 <a href="#"> <img
			src="${contextPath}/resources/image/btn_more_see.jpg" />
		</a>
	</h1>
	<table border=0 width=100% cellpadding=10 cellspacing=10>
		<tr>
			<td>이메일:</td>
			<td><strong>${memberInfo.email1 }@${memberInfo.email2 }</strong>
			</td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><strong>${memberInfo.hp1 }-${memberInfo.hp2}-${memberInfo.hp3 }</strong>
			</td>
		</tr>
		<tr>
			<td>주소</td>
			<td>도로명: &nbsp;&nbsp; <strong>${memberInfo.roadAddress }</strong>
				<br>
			</td>
		</tr>
	</table>
</body>
</html>