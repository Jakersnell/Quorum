<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
	<jsp:include page="navbar.jsp" />
	
	
	<!--Carousel-->
	<div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="..." class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="..." class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="..." class="d-block w-100" alt="...">
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
	
	

	<h1>School Details</h1>

	<c:choose>
		<!-- Display School details -->
		<c:when test="${not empty school}">
			<div>
				<h2>${school.name}Details</h2>
				<p>School ID: ${school.id}</p>
				<p>Name: ${school.name}</p>
				<p>Description: ${school.description}</p>
				<p>Founded In: ${school.foundedIn}</p>
				<p>Created On: ${school.createdOn}</p>
				<p>Last Updated: ${school.lastUpdate}</p>
				<p>
					Image: <img src="${school.imageUrl}" alt="School Image">
				</p>
			</div>
		</c:when>

		<!-- Display Courses details -->
		<c:if test="${not empty courses}">
			<h2>Courses</h2>
			<ul>
				<c:forEach items="${courses}" var="course">
					<li>${course.title}-${course.description}</li>
					<!-- Other course details -->
				</c:forEach>
			</ul>
		</c:if>

		<!-- Display Professors details -->
		<c:if test="${not empty professors}">
			<h3>Professors</h3>
			<ul>
				<c:forEach items="${professors}" var="professor">
					<li>${professor.name}-${professor.department}</li>
					<!-- Other professor details -->
				</c:forEach>
			</ul>
		</c:if>

		<c:otherwise>
			<p>School details not available.</p>
		</c:otherwise>
	</c:choose>

	<jsp:include page="footer.jsp" />
</body>
</html>