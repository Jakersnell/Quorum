<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />

<body>
	<jsp:include page="navbar.jsp" />

	<div class="container mt-5">
		<div class="row">

			<%-- Left Column: User Info, Friends, Followers, School, Clubs --%>
			<div class="col-md-5">

				<%-- User Image, Name, and Bio in one vertical column --%>
				<div class="col-md-4">
					<img src="<c:out value='${user.profileImageUrl}'/>"
						alt="Profile Picture" class="img-thumbnail mb-3">
					<h2>
						<c:out value="${user.firstName} ${user.lastName}" />
					</h2>

					<%-- If User Edit Profile --%>

					<div class="d-flex justify-content-start mb-3">
						<c:if test="${loggedUser.id == user.id}">
							<a class="btn btn-info" role="button"
								href="editProfile.do?userID=${user.id}">Edit Profile</a>
						</c:if>

						<c:if test="${loggedUser.id != user.id}">
							<a class="btn btn-info" role="button"
								href="message.do?userID=${user.id}">Message</a>
						</c:if>

						<%-- If Friend Unfollow and Message, Otherwise Follow --%>
						<c:if test="${!userEditAuth}">
							<c:choose>
								<c:when test="${userIsFollowingUser}">

									<form action="removeFollowing.do" method="post">

										<input type="hidden" name="userID" id="userID"
											value="${loggedUser.id}" /> <input type="hidden"
											name="removeID" id="removeID" value="${user.id}" /> <input
											type="hidden" name="fromProfile" id="fromProfile"
											value="true" />

										<button type="submit" class="btn btn-secondary">Unfollow</button>

									</form>

								</c:when>


								<c:otherwise>
									<form action="addFollowing.do" method="post">
										<input type="hidden" name="userID" id="userID"
											value="${loggedUser.id}" /> <input type="hidden"
											name="followID" id="followID" value="${user.id}" />


										<button type="submit" class="btn btn-secondary">Follow</button>
									</form>
								</c:otherwise>


							</c:choose>
						</c:if>
					</div>
					<p>
						<c:out value="${user.biography}" />
					</p>
				</div>

				<div class="container mt-5">
					<div class="row mb-4">
						<%-- Friends/Following Section --%>
						<div class="col-md-6">
							<h3>
								<a href="getFollow.do?userID=${user.id}">FOLLOWING</a>
							</h3>
							<div class="d-flex flex-row flex-wrap">
								<c:forEach items="${user.following}" var="friend" begin="0"
									end="3">
									<a href="userProfile.do?userID=${friend.id}" class="p-2"> <img
										src="${user.profileImageUrl}" alt="${friend.username} Image"
										class="rounded-circle" style="width: 75px; height: 75px;">
									</a>
								</c:forEach>
							</div>

							<%-- Followers Section --%>
							<div class="row">
									<h3>
										<a href="getFollow.do?userID=${user.id}">FOLLOWERS</a>
									</h3>
									<div class="d-flex flex-row flex-wrap">
										<c:forEach items="${user.followers}" var="follower" begin="0"
											end="3">
											<a href="userProfile.do?userID=${follower.id}" class="p-2">
												<img src="${follower.profileImageUrl}"
												alt="${follower.username} Image" class="rounded-circle"
												style="width: 75px; height: 75px;">
											</a>
										</c:forEach>
									</div>
							</div>
						</div>
					</div>

					<%-- School and Clubs Section --%>
					<div class="col-md-12">
						<h4>
							SCHOOL: <a href="school.do?schoolID=${user.school.id}"><c:out
									value="${user.school.name}" /></a>
						</h4>
						<h4>CLUBS</h4>
						<div>
							<c:forEach items="${user.groups}" var="group">
								<p>
									<a href="group.do?groupID=${group.id}"><c:out
											value="${group.name}" /></a>
								</p>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>


			<%-- Right Column: User Posts Feed --%>
			<div class="col-md-7">
				<h3>POSTS</h3>
				<jsp:include page="makePostForm.jsp" />
				<jsp:include page="_feed.jsp" />
			</div>
		</div>
	</div>
	</div>

	<jsp:include page="footer.jsp" />
</body>
</html>
