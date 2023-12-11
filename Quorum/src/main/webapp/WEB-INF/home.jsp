<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>QUORUM</title>
		
		<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
		crossorigin="anonymous"
	  />
	  <link rel="stylesheet" href="css/style.css">
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