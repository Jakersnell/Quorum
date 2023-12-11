<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<nav>
    <ul>
        <li><a href="home.do">Home</a></li>
        <c:choose>
            <c:when test="${not empty loggedUser}">
                <li><a href="account.do">Account</a></li>
                <li><a href="logout.do">Logout</a></li>
            </c:when>
            <c:otherwise>
                <li><a href="login.do">Login</a></li>
            </c:otherwise>
        </c:choose>
    </ul>
</nav>