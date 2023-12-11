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
        <table>
        <form action="signup.do" method="POST">
            <tr>
                <th>
                    <label for="username">Username</label>
                </th>
                <td>
                    <input type="text" name="username" id="username" placeholder="username" required>
                </td>
            </tr>   
            <tr>
                <th>
                    <label for="password">Password</label>
                </th>
                <td>
                    <input type="password" name="password" id="password" placeholder="password" required>
                </td>
            </tr>   
            <tr>
                <th>
                    <label for="firstName">First Name</label>
                </th>
                <td>
                    <input type="text" name="firstName" id="firstName" placeholder="First Name" required>
                </td>
            </tr>   
            <tr>
                <th>
                    <label for="lastName">Last Name</label>
                </th>
                <td>
                    <input type="text" name="lastName" id="lastName" placeholder="Last Name" required>
                </td>
            </tr>   
            <tr>
                <td>
                    <input type="submit" value="submit">
                </td>

            </tr>
        </form>
    </table>
    </main>
    <jsp:include page="footer.jsp" />
</body>
</html>
