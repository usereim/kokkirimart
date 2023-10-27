<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta   charset="utf-8">
<title>Insert title here</title>
</head>
<body>

  <h1>Consultation Page</h1>
    
    <p>Member ID: ${member_Id}</p>
    <p>Product Name: ${product_Name}</p>
    <p>Order ID: ${order_Id}</p>
</body>
</html>