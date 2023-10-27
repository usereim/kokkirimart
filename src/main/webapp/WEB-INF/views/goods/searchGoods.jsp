<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	//치환 변수 선언합니다.
pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<head>
<title>검색 도서 목록 페이지</title>
</head>
<body>
	<div class="clear"></div>
	<div id="sorting">
		<ul>
			<li><a class="active" href="#">인기 상품</a></li>
			<li><a href="#">최신 출간</a></li>
			<li><a style="border: currentColor; border-image: none;"
				href="#">최근 등록</a></li>
		</ul>
	</div>
	<table id="list_view">
		<tbody>
			<c:choose>
				<c:when test="${ empty goodsList }">
					<p>검색한 상품이 존재하지 않습니다. 검색내용을 확인해 주세요</p>
				</c:when>
				<c:otherwise>
					<c:forEach var="item" items="${goodsList }">
						<tr>
							<td class="goods_image"><a
								href="${contextPath}/goods/goodsDetail.do?product_id=${item.product_id}">
									<img width="75" alt=""
									src="${contextPath}/thumbnails.do?goods_id=${item.product_id}&fileName=${item.product_fileName}">
							</a></td>
							<td class="goods_description">
								<h2>
									<a
										href="${contextPath}/goods/goodsDetail.do?product_id=${item.product_id }">${item.product_name }</a>
								</h2>
							</td>
							<td class="price"><span>${item.product_price }원</span><br>
								<strong> <fmt:formatNumber
										value="${item.product_price*0.9}" type="number"
										var="discounted_price" /> ${item.product_sale_price}원
							</strong><br>(10% 할인)</td>
							<td><input type="checkbox" value=""></td>
							<td class="buy_btns">
								<UL>
									<li><a href="#">장바구니</a></li>
									<li><a href="#">구매하기</a></li>
									<li><a href="#">비교하기</a></li>
								</UL>
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
	<div class="clear"></div>
	<div id="page_wrap">
		<ul id="page_control">
			<li><a class="no_border" href="#">Prev</a></li>
			<c:set var="page_num" value="0" />
			<c:forEach var="count" begin="1" end="10" step="1">
				<c:choose>
					<c:when test="${count==1 }">
						<li><a class="page_contrl_active" href="#">${count+page_num*10 }</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="#">${count+page_num*10 }</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<li><a class="no_border" href="#">Next</a></li>
		</ul>
	</div>