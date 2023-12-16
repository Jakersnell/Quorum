<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />

<body>
	<jsp:include page="navbar.jsp" />
	<div class="container mt-3 wrapper">
		<div class="row">
			<div class="col-4"></div>
			<div class="col-4">
				<div class="row text-center">
					<h2 class="group-name">${group.name}</h2>
				</div>
				<div class="row text-center mt-3">
					<p class="group-description">${group.name}</p>
				</div>
				<div class="row text-center mt-3">
					<a href="userProfile.do?userID=${group.owner.id}"
						class="group-description nav-link">Created by
						${group.owner.firstName} ${group.owner.lastName}</a>
				</div>
				<div class="row text-center mt-3">
					<p class="group-description">Created On ${group.createdOn}</p>
				</div>
			</div>
			<div class="col-1"></div>
			<div class="col-2">
				<c:if test="${userHasEditAuth}">
					<a href="editGroup.do?groupID=${group.id}"
						class="btn btn-secondary form-control">edit</a>
				</c:if>
			</div>
			<div class="col-1"></div>
		</div>
		<c:choose>
			<c:when test="${userIsMember}">
				<div class="container row mb-2">
					<div class="col-4"></div>
					<div class="col-4">
						<form action="leaveGroup.do" method="post">
							<input class="form-control" type="hidden" name="groupID"
								value="${group.id}" />
							<button class="btn btn-secondary form-control">Leave Group</button>
						</form>
					</div>
					<div class="col-4"></div>
				</div>
				<div class="row">
					<div class="col-1"></div>
					<div class="col-3">
						<div class="container row">
							<h2 class="content-header">Members</h2>
						</div>
						<div class="scroll-container">
							<c:forEach var="member" items="${members}">
								<a href="userProfile.do?userID=${member.id}">
									<div class="row container">
										<h3 class="card-title">${member.username}</h3>
									</div>
								</a>
								<hr>
								<div class="xs-spacer"></div>
							</c:forEach>
						</div>
					</div>
					<div class="col-6">
						<div class="row text-center container">
							<h2 class="content-header">Make A Post</h2>
						</div>
						<jsp:include page="makePostForm.jsp"></jsp:include>
						<div class="row text-center container">
							<h2 class="content-header">posts in ${group.name}</h2>
						</div>
						<hr>
						<jsp:include page="_feed.jsp" />
			</c:when>
			<c:otherwise>
				<div class="container row">
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
			</c:otherwise>
		</c:choose>
	</div>
	<jsp:include page="footer.jsp" />
</body>

</html>