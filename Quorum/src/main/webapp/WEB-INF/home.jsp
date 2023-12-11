<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>QUORUM</title>
	</head>
<body>
	<jsp:include page="navbar.jsp" />
<h1>Welcome To Quorum!</h1>
<br>
	<c:if test="${not empty loggedUser}">
		Hello, <c:out value="${loggedUser.firstName}">!</c:out>
	</c:if>


	 <jsp:include page="footer.jsp" />
</body>
</html>