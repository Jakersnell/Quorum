<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />

<body>
	<jsp:include page="navbar.jsp" />
	<h2>Log In</h2>

	<form action="login.do" method="post">
		<input type="text" name="userName"> <input type="password"
			name="password" /> <input type="submit" value="Log In">
	</form>

	<jsp:include page="footer.jsp" />
</body>


</html>