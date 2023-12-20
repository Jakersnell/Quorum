<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>

<head>
<jsp:include page="head.jsp" />
</head>

<body>
	<jsp:include page="navbar.jsp" />
	<div class="wrapper container">
		<div class="sm-spacer"></div>
		<div id="accordion">
			<div class="row">
				<div class="col-1"></div>
				<div class="col-2">
					<div class="search-div profile-container">
						<c:if test="${!userResults.isEmpty()}">
							<div class="card result-btn">
								<button class="btn card-header search-selector-btn"
									data-toggle="collapse" data-target="#collapseOne"
									aria-expanded="true" aria-controls="collapseOne">
									<i class="fa-solid fa-user"></i> Users
								</button>
							</div>
						</c:if>
						<c:if test="${!groupResults.isEmpty()}">
							<div class="search-selector-spacer"></div>
							<div class="card result-btn">
								<button class="btn collapsed card-header search-selector-btn"
									data-toggle="collapse" data-target="#collapseThree"
									aria-expanded="false" aria-controls="collapseThree">
									<i class="fa-solid fa-user-group"></i> Groups
								</button>
							</div>
						</c:if>
						<c:if test="${!postResults.isEmpty()}">
							<div class="search-selector-spacer"></div>
							<div class="card result-btn">
								<button class="btn collapsed card-header search-selector-btn"
									data-toggle="collapse" data-target="#collapseFour"
									aria-expanded="false" aria-controls="collapseFour">
									<i class="fa-regular fa-newspaper"></i> Posts
								</button>
							</div>
						</c:if>
						<c:if test="${!professorResults.isEmpty()}">
							<div class="search-selector-spacer"></div>
							<div class="card result-btn">
								<button class="btn collapsed card-header search-selector-btn"
									data-toggle="collapse" data-target="#collapseFive"
									aria-expanded="false" aria-controls="collapseFive">
									<i class="fa-solid fa-chalkboard-user"></i> Professors
								</button>
							</div>
						</c:if>
						<c:if test="${!schoolResults.isEmpty()}">
							<div class="search-selector-spacer"></div>
							<div class="card result-btn">
								<button class="btn collapsed card-header search-selector-btn"
									data-toggle="collapse" data-target="#collapseTwo"
									aria-expanded="false" aria-controls="collapseTwo">
									<i class="fa-solid fa-school"></i> Schools
								</button>
							</div>
						</c:if>
					</div>
				</div>
				<div class="col-8 display-container profile-container">
					<div class="search-div">
						<div class="result-header">
							<h3>Search Results For: "${query}"</h3>
						</div>
						<hr>
						<div id="collapseOne" class="collapse show"
							data-parent="#accordion">
							<h4>Users</h4>
							<div class="card-body scrollable-card stylized-scroll" data-bs-spy="scroll"
								data-bs-smooth-scroll="true" data-bs-target="#collapseOne"
								tabindex="0">
								<c:forEach var="resultUser" items="${userResults}">
									<a class="wrapper-link"
										href="userProfile.do?userID=${resultUser.id}">
										<div class="card-body result-card">
											<div class="row">
												<div class="col-2">${resultUser.firstName}
													${resultUser.lastName}</div>
												<div class="col-2"></div>
												<div class="col-2">${resultUser.username}</div>
												<div class="col-2">${resultUser.school.name}</div>
												<c:if test="${loggedUser.role == 'admin'}">
													<div class="col-2">
														Active: ${resultUser.enabled}
													</div>
													<c:choose>
													<c:when test="${resultUser.enabled}">
														<div class="col-2">
															<a href="deactivate.do?userID=${resultUser.id}&query=${query}"><button class="btn btn-danger">Deactivate</button></a>
														</div>
													</c:when>
													<c:otherwise>
														<div class="col-2">
															<a href="activate.do?userID=${resultUser.id}&query=${query}"><button class="btn btn-info">Activate</button></a>
														</div>
													</c:otherwise>
													</c:choose>
												</c:if>
											</div>
										</div>
									</a>
								</c:forEach>
							</div>
						</div>
						<div id="collapseTwo" class="collapse" data-parent="#accordion">
							<h4>Schools</h4>
							<div class="card-body scrollable-card stylized-scroll" data-bs-spy="scroll"
								data-bs-smooth-scroll="true" data-bs-target="#collapseOne"
								tabindex="0">
								<c:forEach var="resultSchool" items="${schoolResults}">
									<a class="wrapper-link"
										href="school.do?schoolID=${resultSchool.id}">
										<div class="card-body result-card">
											<div class="row">
												<div class="col-4">${resultSchool.name}</div>
												<div class="col-8">
													<p class="card-text result-card-description">${resultSchool.description}
													</p>
												</div>
											</div>
										</div>
									</a>
								</c:forEach>
							</div>
						</div>
						<div id="collapseThree" class="collapse" data-parent="#accordion">
							<h4>Groups</h4>
							<div class="card-body scrollable-card stylized-scroll" data-bs-spy="scroll"
								data-bs-smooth-scroll="true" data-bs-target="#collapseOne"
								tabindex="0">
								<c:forEach var="group" items="${groupResults}">
									<a class="wrapper-link" href="group.do?groupID=${group.id}">
										<div class="card-body result-card">
											<div class="row">
												<div class="col-6">
													<h6>${group.name}</h6>
												</div>
												<div class="col-6">
													<h6>${group.description}</h6>
												</div>
											</div>
										</div>
									</a>
								</c:forEach>
							</div>
						</div>

						<div id="collapseFour" class="collapse" data-parent="#accordion">
							<h4>Posts</h4>
							<div class="card-body scrollable-card stylized-scroll" data-bs-spy="scroll"
								data-bs-smooth-scroll="true" data-bs-target="#collapseOne"
								tabindex="0">
								<c:forEach var="resultPost" items="${postResults}">
									<a class="wrapper-link"
										href="post.do?postID=${resultPost.id}">
										<div class="card-body result-card">
											<div class="row">
												<div class="col-6">
													<h6>@${resultPost.user.username}</h6>
												</div>
												<div class="col-6">
													<h6>${resultPost.socialGroup.name}</h6>
												</div>
											</div>
											<div class="row">

												<h5 class="card-title">${resultPost.title}</h5>
											</div>
										</div>
									</a>
								</c:forEach>
							</div>
						</div>
						<div id="collapseFive" class="collapse" data-parent="#accordion">
							<h4>Proffesors</h4>
							<div class="card-body">
								<div class="card-body scrollable-card stylized-scroll" data-bs-spy="scroll"
									data-bs-smooth-scroll="true" data-bs-target="#collapseOne"
									tabindex="0">
									<c:forEach var="professor" items="${professorResults}">
										<a class="wrapper-link"
											href="professorview.do?professorId=${professor.id}">
											<div class="card-body result-card">
												<div class="row">
													<div class="col-6">
														<h6>${professor.firstName}&nbsp;${professor.lastName}</h6>
													</div>
													<div class="col-6">
														<h6>${professor.school.name}</h6>
													</div>
												</div>
											</div>
										</a>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-1"></div>
			</div>

		</div>
		<div class="xs-spacer"></div>
	</div>
	<jsp:include page="footer.jsp" />
</body>

</html>