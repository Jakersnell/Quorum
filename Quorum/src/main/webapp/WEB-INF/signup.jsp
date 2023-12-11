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
            <select name="school" id="school">
                <option value="1">Metropolitan Tech</option>
                <option value="2">Harborview Arts College</option>
                <option value="3">Rivertown College</option>
                <option value="4">Crestview Business School</option>
                <option value="5">Avalon Liberal Arts</option>
            </select>
            <input type="submit" value="submit">
        </form>
    </table>
    </main>
    <jsp:include page="footer.jsp" />
</body>
</html>
