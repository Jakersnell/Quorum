<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />

<body>
	<jsp:include page="navbar.jsp" />
	<div class="container wrapper">
		<div class="row mt-5 pt-20">
			<div class="col-4 mb-5">
				<img src="../img/profheadshot.jpg" class="img-fluid" alt="Professor Headshot"> <br>
			</div>
			<div class="col-6 mb-5 text-center">
				<h2>${professor.firstName} ${professor.lastName}</h2>
				<br>
				<h3>Average Rating: <span id="ratingcolor">${professor.averageRating}</span></h3>
			</div>
			
		</div>
			<div class="mx-2 my-2 text-center">
				<p>Reviews</p>
			</div>
		<div class="card">
				<c:forEach var="rating" items="${ratings}">
					
					<c:choose>
						<c:when test="${rating.user.id == loggedUser.id}">
							
							<div class="card mx-2 my-2">
								
								<div class="card-header bg-success">
									Your rating
								</div>
								<div class="shadow-sm card-body">
									<h5>${rating.content}</h5>
									<p>Rating: <span id="ratingcolor">${rating.rating}</span></p>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<span class="mx-2 my-2">
								<h5>${rating.content}</h5>
								<p>Rating: ${rating.rating}</p>
							</span>
								
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
				
		
		
		<div class="card mt-2 mb-2 pb-5">
			<div class="card-header bg-white">
				<h4>Enter your rating for Professor <c:out value="${professor.lastName}">:</c:out></h4>
			</div>
			<div class="card-body">
				<form action="professorview.do" method="POST">
					<div class="mb-3 mt-1">
						<label for="content" class="form-label">Comment</label>
						<textarea class="form-control" id="content" name="content"
						rows="3" required></textarea>
					</div>
					<input type="hidden" name="userID" id="userID" value="${loggedUser.id}">
					<input type="hidden" name="profID" id="profID" value="${professor.id}">
					<div class="row">
						<div class="col-auto">
							<select class="form-select" aria-label="Rating" name="rating" required>
								<option selected>Rating</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
							</select>
						</div>
						<div class="col-auto">
							<c:choose>
								<c:when test="${rated}">
									<button type="submit" class="btn btn-primary" disabled>Submit</button>
								</div>
								<div class="col-auto">
									<p class="fw-light opacity-75"><em>You have already submitted a rating.</em><p>
								</div>
									
								</c:when>
								<c:otherwise>
									<button type="submit" class="btn btn-primary">Submit</button>
								</div>
									</c:otherwise>
								</c:choose>
					</div>
					</form>
				</div>
			</div>
			
		</div>
	</div>
		<jsp:include page="footer.jsp" />
	</body>
	
	</html>