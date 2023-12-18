<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />

<body>
	<jsp:include page="navbar.jsp" />
	<div class="container wrapper">
		<h5>${professor.firstName}${professor.lastName}</h5>
		<h1>Average Rating ${professor.averageRating}</h1>

		<c:forEach var="rating" items="${ratings}">
			<h5>${rating.content}</h5>
			<p>Rating: ${rating.rating}</p>
		</c:forEach>
		
		
		<form action="professorview.do" method="POST">
		<div class="mb-3">
			<select class="form-select" aria-label="Rating" name="rating" required>
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="3">4</option>
				<option value="3">5</option>
			</select>
		</div>
		<div class="mb-3">
			<label for="content" class="form-label">Comment</label>
			<textarea class="form-control" id="content" name="content"
				rows="3" required></textarea>
		</div>
			<input type="hidden" name="userID" id="userID" value="${loggedUser.id}">
			<input type="hidden" name="profID" id="profID" value="${professor.id}">
		<c:choose>
			<c:when test="${rated}">
				<button type="submit" class="btn btn-primary" disabled>Submit</button>
			</c:when>
			<c:otherwise>
				<button type="submit" class="btn btn-primary">Submit</button>
			</c:otherwise>
		</c:choose>
		
	</form>

	</div>
	<jsp:include page="footer.jsp" />
</body>

</html>