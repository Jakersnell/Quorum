<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />

<body>
	<jsp:include page="navbar.jsp" />

	<div class="container">

		<div class="row">
			<div class="col-4"></div>
			<div class="col-4 ">
				<div class="spacer"></div>
				<div class="card shadow p-3 mb-5 rounded" id="logincard">
					<div class="card-body" id="logincard">
						<div class="text-center">
						Your account was deactivated. <a href="reactivate.do?userID=${userID}" id="signuplink">Reactive?</a>						
						</div>
					</div>
				</div>
				<div class="spacer"></div>
			</div>
			<div class="col-4"></div>
		</div>
	</div>
	<div class="spacer"></div>
	<jsp:include page="footer.jsp" />
</body>


</html>