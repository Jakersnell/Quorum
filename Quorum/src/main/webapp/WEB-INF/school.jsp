<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
	<jsp:include page="navbar.jsp" />


	<div id="carouselExampleAutoplaying" class="carousel slide"
		data-bs-ride="carousel">
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="../img/school-campus.jpg" class="d-block w-100"
					alt="A school campus">
			</div>
			<div class="carousel-item">
				<img src="../img/school-dark-wave.jpg" class="d-block w-100"
					alt="A school campus entrance">
			</div>
			<div class="carousel-item">
				<img src="../img/school-library.jpg" class="d-block w-100"
					alt="A school library">
			</div>
		</div>
		<button class="carousel-control-prev" type="button"
			data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Next</span>
		</button>
	</div>

	<div class="container mt-4">
		<div class="row">
			<div class="col-md-4">
				<img src="../img/school-pink-flowers.jpg" class="img-fluid"
					alt="School Image">
			</div>
			<div class="col-md-8">
				<h2>${school.name}</h2>
				<p>At ${school.name}, they pride themselves on providing a rich
					educational experience that prepares their students for the
					challenges of the future. Founded in ${school.foundedIn},
					${school.name} has established a reputation for excellence in both
					academic and extracurricular pursuits. Nestled in FakeCity USA, the
					campus offers a blend of traditional values and modern innovation,
					creating an environment that is both nurturing and stimulating.
					${school.name} is more than just an institution; it's a community
					where students, teachers, and parents come together to foster a
					lifelong love of learning.</p>
			</div>
		</div>
	</div>

	<div class="container mt-4">
		<h3>Course Information</h3>
		<c:if test="${not empty courses}">
			<ul>
				<c:forEach items="${courses}" var="course">
					<li>${course.title}</li>
				</c:forEach>
			</ul>
		</c:if>
	</div>




	<div class="container mt-4">
		<h3>Professor Information</h3>
		<c:if test="${not empty professors}">
			<div class="row">
				<c:forEach items="${professors}" var="professor" varStatus="status">
					<div class="col-md-4">
						<div class="card mb-3">
							<div class="card-body">
								<img src="../img/profheadshot.jpg" class="img-fluid"
									alt="Professor Headshot">
								<h5 class="card-title">${professor.firstName}
									${professor.lastName}</h5>
								<h5 class="card-title">${professor.ratings}</h5>

							</div>
						</div>
					</div>

					<c:if test="${status.count % 3 == 0}">
			</div>
			<div class="row">
		</c:if>
		</c:forEach>
	</div>
					</c:if>
	</div>



	<br>

	<div class="container mt-4">
		<h3>Professor Information</h3>
		<div class="row">
			<div class="col-md-4">
				<img src="../img/school-pink-flowers.jpg" class="img-fluid"
					alt="Professor Headshot">
				<p>Professor Name</p>
			</div>
		</div>
	</div>





	<h1>School Details</h1>

	<c:choose>
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


			<c:if test="${not empty courses}">
				<h2>Courses</h2>
				<ul>
					<c:forEach items="${courses}" var="course">
						<li>${course.title}</li>
					</c:forEach>
				</ul>
			</c:if>

			<c:if test="${not empty professors}">
				<h3>Professors</h3>
				<ul>
					<c:forEach items="${professors}" var="professor">
						<li>${professor.firstName}</li>
					</c:forEach>
				</ul>
			</c:if>



		</c:when>
		<c:otherwise>
			<p>School details not available.</p>
		</c:otherwise>
	</c:choose>

	<jsp:include page="footer.jsp" />
</body>
</html>