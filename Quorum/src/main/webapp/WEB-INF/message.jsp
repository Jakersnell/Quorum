<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
<jsp:include page="navbar.jsp" />

<h1> To: <c:out value="${user.firstName}"></c:out></h1>
<form action="message.do" method="POST">
	<label for="message">Message</label>
	<input type="text" name="message" id="message" placeholder="say something..." required>
	<input type="hidden" name="senderID" id="senderID" value="${loggedUser.id}">
	<input type="hidden" name="receiverID" id="receiverID" value="${user.id}">
	<input type="submit" value="send">
</form>

<jsp:include page="footer.jsp" />
</body>
</html>