<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<div class="make-post-form shadow p-1 mb-5 rounded">
	<form action="createPost.do" method="post">

		<div class="title-input">
			<input class="form-control" type="text" name="title"
				id="Your posts title" placeholder="Whats on your mind?" required /><br />
		</div>
		<div class="group-selector">
			<select class="form-select" aria-label="Group Selector"
				name="groupId">
				<option selected>What group is this for?</option>
				<c:forEach var="group" items="${loggedUser.groups}">
					<option value="${group.id}">${group.name}</option>
				</c:forEach>
			</select>
		</div>
		<div class="post-content-input">
			<textarea class="form-control" id="postContents" rows="2"
				name="contents"></textarea>
		</div>
		<button class="btn post-btn" type="submit">Post</button>
	</form>
</div>