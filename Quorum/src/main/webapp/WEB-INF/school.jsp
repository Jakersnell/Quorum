<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
<jsp:include page="navbar.jsp" />

<h1>School Details</h1>

	<!-- Display School details -->
    <c:choose>
        <c:when test="${not empty school}">
            <div>
                <h2>${school.name} Details</h2>
                <p>School ID: ${school.id}</p>
                <p>Name: ${school.name}</p>
                <p>Description: ${school.description}</p>
                <p>Founded In: ${school.foundedIn}</p>
                <p>Created On: ${school.createdOn}</p>
                <p>Last Updated: ${school.lastUpdate}</p>
                <p>Image: <img src="${school.imageUrl}" alt="School Image"></p>
            </div>
        </c:when>
        <c:otherwise>
            <p>School details not available.</p>
        </c:otherwise>
    </c:choose>
	
	<!-- Display Courses details -->
	<!-- Display Professors details -->

<jsp:include page="footer.jsp" />
</body>
</html>