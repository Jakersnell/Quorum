<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
	<jsp:include page="navbar.jsp" />
	
	<c:if test="${empty loggedUser}">
		<h1>Welcome To Quorum!</h1>
	</c:if>
<br>
	<c:if test="${not empty loggedUser}">
		<h1>Hello, <c:out value="${loggedUser.firstName}">!</c:out></h1>
	</c:if>


	 <jsp:include page="footer.jsp" />
</body>
</html>