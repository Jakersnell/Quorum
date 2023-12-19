<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />

<body>
	<jsp:include page="navbar.jsp" />
	<div class="container mt-3 wrapper pt-2">
		<div class="group-header">
			<div class="row text-center">
				<h2 class="group-name">${group.name}</h2>
			</div>
		</div>
		<div class="row mt-3">
			<div class="col-3 group-side">
				<div class="container row mt-1">
					<h3 class="content-header">
						<strong>Members</strong>
					</h3>
				</div>
				<hr>
				<div class="scroll-container mt-3 group-description">
					<c:forEach var="member" items="${members}">
						<a href="userProfile.do?userID=${member.id}">
							<div class="row container">
								<h4 class="card-title username">@${member.username}</h4>
							</div>
						</a>
						<hr>
						<div class="xs-spacer"></div>
					</c:forEach>
				</div>
			</div>
			<div class="col-6 group-main container">
				<c:choose>
					<c:when test="${userIsMember}">
						<jsp:include page="makePostForm.jsp"></jsp:include>
						<c:if test="${!feed.isEmpty()}">
							<div class="row text-center container">
								<h2 class="content-header">Posts in ${group.name}</h2>
							</div>
						</c:if>
						<jsp:include page="_feed.jsp" />
					</c:when>
					<c:otherwise>
						<div class="row mt-1 mb-1 text-center">
							<h4>You are not in this group yet!</h4>
						</div>
						<div class="row">
							<div class="col-4"></div>
							<div class="col-4">
								<form action="joinGroup.do" method="post">
									<input class="form-control" type="hidden" name="groupID"
										value="${group.id}" />
									<button class="btn btn-secondary form-control">Join
										Group</button>
								</form>
							</div>
							<div class="col-4"></div>
						</div>
						<div class="group-default-image">
							<img alt="default image of social group"
								src="https://img.freepik.com/free-vector/yellow-pencil-students-pupils-3d-illustration-cartoon-drawing-writing-tool-school-college-university-3d-style-white-background-education-stationery-concept_778687-1675.jpg?w=1060&t=st=1702769966~exp=1702770566~hmac=83e234143b5220cd942ab41a051adeedffdc43890dbcd55cd04d4c4aa561147a">
						</div>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="col-3 group-side">
				<div class="row text-center row">
					<h3>
						<strong>About this group</strong>
				</div>
				<div class="group-description">
					<div class="row text-center mt-3">
						<p class="group-description">${group.description}</p>
					</div>
					<div class="row text-center mt-3">
						<a href="userProfile.do?userID=${group.owner.id}"
							class="group-description nav-link">Created by
							${group.owner.firstName} ${group.owner.lastName}</a>
					</div>
					<div class="row text-center mt-3">
						<p class="group-description">Created On ${group.createdOn}</p>
					</div>
					<c:if test="${userIsMember && (group.owner != loggedUser)}">
						<div class="row mb-3">
							<div class="col-3"></div>
							<div class="col-6">
								<form action="leaveGroup.do" method="post">
									<input class="form-control" type="hidden" name="groupID"
										value="${group.id}" />
									<button class="btn btn-secondary form-control">Leave
										Group</button>
								</form>
							</div>
							<div class="col-3"></div>
						</div>
					</c:if>
					<c:if test="${userHasEditAuth}">
						<div class="row mb-3">
							<div class="col-3"></div>
							<div class="col-6">
								<form action="deleteGroup.do" method="post">
									<input class="form-control" type="hidden" name="groupID"
										value="${group.id}" />
									<button class="btn btn-danger form-control">Delete
										Group</button>
								</form>
							</div>
							<div class="col-3"></div>
						</div>
					</c:if>
				</div>
				<div class="row">
					<div class="col-3"></div>
					<div class="col-6">
						<c:if test="${userHasEditAuth}">
							<button type="button" class="btn btn-secondary form-control"
								data-bs-toggle="modal" data-bs-target="#editGroupModal">
								Edit this group</button>

							<div class="modal fade" id="editGroupModal" tabindex="-1"
								aria-labelledby="editGroupModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<form action="updateGroup.do" method="post">
											<div class="modal-body">
												<input id="groupNameInput"
													class="form-control login-form rounded bg-white"
													type="hidden" name="id" value="${group.id}" required>
												<div class="row mb-3">
													<label for="groupNameInput">Group Name</label> <input
														id="groupNameInput"
														class="form-control login-form rounded bg-white"
														type="text" name="name" value="${group.name}" required>
												</div>
												<div class="row mb-3">
													<label for="groupDescInput">Group Description</label>
													<textarea id="groupDescInput"
														class="form-control login-form rounded bg-white"
														id="groupDescription" rows="2" name="description">${group.description}</textarea>
												</div>

											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">Close</button>
												<button type="submit" class="btn btn-primary">Save
													changes</button>
											</div>
										</form>
									</div>
								</div>
							</div>
						</c:if>
					</div>
					<div class="col-3"></div>
				</div>
			</div>
		</div>

	</div>
	<jsp:include page="footer.jsp" />
</body>

</html>