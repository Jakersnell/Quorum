<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:if test="${!user.groups.isEmpty()}">
	<div class="make-post-form shadow pt-3 pb-3 mb-5 rounded"
		align="center">
		<div class="row text-center container">
			<h6 class="content-header">Make A Post</h6>
		</div>
		<form action="createPost.do" method="post">

			<div class="title-input">
				<input class="form-control" type="text" name="title"
					id="Your posts title" placeholder="Title" required /><br />
			</div>
			<div class="post-content-input">
				<textarea class="form-control" id="postContents" rows="2"
					name="contents" placeholder="Whats on your mind?"></textarea>
			</div>

			<c:if test="${not empty fromUrl}">
				<input class="form-control" type="hidden" name="fromUrl"
					value="${fromUrl}" />
			</c:if>

			<c:choose>
				<c:when test="${not empty group}">
					<input class="form-control" type="hidden" name="groupId"
						value="${group.id}" />
				</c:when>
				<c:otherwise>
					<div class="group-selector">
						<select class="form-select" aria-label="Group Selector"
							name="groupId">
							<option selected>What group is this for?</option>
							<c:forEach var="group" items="${loggedUser.groups}">
								<option value="${group.id}">${group.name}</option>
							</c:forEach>
						</select>
					</div>
				</c:otherwise>
			</c:choose>
			<button class="btn rounded-pill my-2" id="loginbtn" type="submit">Post</button>
		</form>
	</div>
</c:if>