<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
<jsp:include page="navbar.jsp" />

<h1>${school.name} Details</h1>

	<!-- Display School details -->
	<p>Name: ${school.name}</p>
	<p>Description: ${school.description}</p>
	<p>Founded In: ${school.foundedIn}</p>
	<p>Created On: ${school.createdOn}</p>
	<p>Last Updated: ${school.lastUpdate}</p>
	<p>Image: ${school.imageUrl}</p>
	
	<!-- Display Courses details -->
	<!-- Display Professors details -->

<jsp:include page="footer.jsp" />
</body>
</html>