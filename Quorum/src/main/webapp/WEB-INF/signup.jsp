<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
<jsp:include page="navbar.jsp" />
    <main>
        <h1>Sign Up</h1>
        <br>
        <form action="signup.do" method="POST">
            <label for="username">Username</label>
            <input type="text" name="username" id="username" placeholder="username" required>
            <label for="password">Password</label>
            <input type="password" name="password" id="password" placeholder="password" required>
            <label for="firstName">First Name</label>
            <input type="text" name="firstName" id="firstName" placeholder="First Name" required>
            <label for="lastName">Last Name</label>
            <input type="text" name="lastName" id="lastName" placeholder="Last Name" required>
            <label for="school">School</label>
            <select name="schoolID" id="schoolID" required>
                <c:forEach items="${school}" var = "s">
                    <option value="${s.id}">${s.name}</option>
                </c:forEach>
            </select>
            <input type="submit" value="submit">
        </form>
    </main>
    <jsp:include page="footer.jsp" />
</body>
</html>
