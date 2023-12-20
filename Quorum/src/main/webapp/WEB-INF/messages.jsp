<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
	<jsp:include page="navbar.jsp" />

	<div class="container wrapper my-5">
		<div class="row my-5">
			<div class="col"></div>
			<div class="col-6 text-center">
				<h2>Active Messages</h2>
				<hr>
			</div>
			<div class="col"></div>
		</div>
		<div class="row my-5">
			<div class="col"></div>
			<div class="col-6">
				<ul class="list-group">
					<c:forEach items="${messagees}" var="m">
						<li
							class="list-group-item d-flex justify-content-between align-items-center">
							<a href="message.do?userID=${m.id}"><c:out
									value="${m.firstName}"></c:out></a> <span
							class="badge bg-primary rounded-pill">1</span>
						</li>
					</c:forEach>
					<c:if test="${messagees.isEmpty()}">
						<div class="text-center">
							<br> <br> <br>
							<h3>You have no messages.</h3>
						</div>
					</c:if>
				</ul>
			</div>
			<div class="col"></div>
		</div>
	</div>



	<jsp:include page="footer.jsp" />
</body>
</html>