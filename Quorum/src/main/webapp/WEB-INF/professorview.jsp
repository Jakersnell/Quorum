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
		
		<c:choose>
			<c:when test="${rating.user.id == loggedUser.id}">
			
				<div class="card">
					<div class="card-header">
						Your rating
					</div>
					<div class="card-body">
						<h5>${rating.content}</h5>
						<p>Rating: ${rating.rating}</p>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<h5>${rating.content}</h5>
				<p>Rating: ${rating.rating}</p>
			</c:otherwise>
		</c:choose>
		</c:forEach>
		
		<div class="card">
			<div class="card-header">
				<h4>Enter your rating for Professor <c:out value="${professor.lastName}">:</c:out></h4>
			</div>
			<div class="card-body">
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
						<p>You have already submitted a rating.<p>
						
					</c:when>
					<c:otherwise>
						<button type="submit" class="btn btn-primary">Submit</button>
					</c:otherwise>
				</c:choose>
				</form>
			</div>
		</div>

	</div>
	<jsp:include page="footer.jsp" />
</body>

</html>