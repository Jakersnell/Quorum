<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:forEach var="post" items="${feed}" varStatus="status">
	<div
		class="shadow p-1 mb-5 rounded container post-list home-post-color-${status.index % 4}">
		<div class="row">
			<div class="col-6">
				<h6>
					<a class="post-link" href="userProfile.do?userID=${post.user.id}">@${post.user.username}</a>
				</h6>
				<small>${post.lastUpdate}</small>
			</div>
			<div class="col-3">
				<h6>
					<a class="post-link"
						href="group.do?groupID=${post.socialGroup.id}">${post.socialGroup.name}</a>
				</h6>
			</div>
			<div class="col-3">
				<c:if test="${loggedUser.id == post.user.id}">
					<a class="btn post-edit-btn" href="editPost.do?postID=${post.id}<c:if test="${not empty fromUrl}">&fromUrl=${fromUrl}</c:if>">Edit</a>
				</c:if>
			</div>
		</div>
		<div class="row">
			<h3 class="card-title">${post.title}</h3>
		</div>
		<div class="row">
			<p>${post.contents}</p>
		</div>
	</div>
	<c:if test="${!status.last}">
		<div class="xs-spacer"></div>
	</c:if>
</c:forEach>