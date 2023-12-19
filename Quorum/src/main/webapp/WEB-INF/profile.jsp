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
				<div class="profile-container">
					<img src="<c:out value='${user.profileImageUrl}'/>"
						alt="Profile Picture" class="img-thumbnail mb-3">
					<h2>
						<c:out value="${user.firstName} ${user.lastName}" />
					</h2>

					<%-- If User Edit Profile --%>

					<div class="d-flex justify-content-start mb-3">
						<c:if test="${loggedUser.id == user.id}">
							<a class="shadow btn" id="editbtn" role="button"
								href="editProfile.do?userID=${user.id}">Edit Profile</a>
						</c:if>

						<c:if test="${loggedUser.id != user.id}">
							<a class="shadow btn" id="editbtn" role="button"
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

										<button type="submit" class="shadow btn" id="editbtn2">Unfollow</button>

									</form>

								</c:when>


								<c:otherwise>
									<form action="addFollowing.do" method="post">
										<input type="hidden" name="userID" id="userID"
											value="${loggedUser.id}" /> <input type="hidden"
											name="followID" id="followID" value="${user.id}" />


										<button type="submit" class="shadow btn" id="editbtn2">Follow</button>
									</form>
								</c:otherwise>


							</c:choose>
						</c:if>
					</div>
					<p>
						<c:out value="${user.biography}" />
					</p>

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
								<c:if
									test="${user.following == null || user.following.isEmpty()}">
									<small><strong>not following anyone</strong></small>
								</c:if>
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
									<c:if
										test="${user.followers == null || user.followers.isEmpty()}">
										<small><strong>has no followers</strong></small>
									</c:if>
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

					<%-- Courses Section --%>
					<h4>COURSES</h4>
					<div>
						<c:if test="${empty courses}">
							<p>No courses found.</p>
						</c:if>
						<c:forEach items="${courses}" var="course">
							<div class="mb-2">
								<strong><c:out value="${course.title}" /></strong><br> <span>Time:
									<c:out value="${course.dateStart}" /> - <c:out
										value="${course.dateEnd}" />
								</span><br> <span>Professor: <c:out
										value="${course.professor.firstName} ${course.professor.lastName}" /></span>
							</div>
						</c:forEach>
					</div>

				</div>
			</div>


			<%-- Right Column: User Posts Feed --%>
			<div class="col-md-7">
				<div class="profile-container stylized-scroll">
					<h3>POSTS</h3>
					<hr>
					<jsp:include page="makePostForm.jsp" />
					<c:choose>
						<c:when test="${feed != null && !feed.isEmpty()}"><jsp:include
								page="_feed.jsp" /></c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${user.equals(loggedUser)}">
									<h5>You haven't made any posts yet.</h5>
								</c:when>
								<c:otherwise>
									<h5>This user hasn't made any posts yet.</h5>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>

				</div>
			</div>
		</div>
	</div>
	<div class="spacer"></div>
	<jsp:include page="footer.jsp" />
</body>
</html>
