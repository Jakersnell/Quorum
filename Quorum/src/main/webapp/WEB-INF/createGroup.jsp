<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
	<jsp:include page="navbar.jsp" />
	<div class="container wrapper">
	<main>

			<div class="row">
				<div class="col-3"></div>
				<div class="col-6 ">
					<div class="spacer"></div>
					<div class="card shadow p-3 mb-5 rounded" id="logincard">
						<div class="card-header text-center" id="createGroupHeader">
							<strong>Create A Group</strong>
						</div>
						<div class="card-body" id="logincard">
							<form action="createGroup.do" method="POST">
								<div class="row mb-3">
									<input class="form-control login-form rounded bg-white"
										type="text" name="name" placeholder="your groups name"
										required>
								</div>
								<div class="row mb-3">
									<textarea class="form-control login-form rounded bg-white" id="groupDescription" rows="2"
										name="description" placeholder="Describe what your group is"></textarea>
								</div>
								<div class="row mb-3">
									<button class="btn form-control login-form rounded-pill"
										id="loginbtn" type="submit">Submit</button>
								</div>
							</form>
						</div>
					</div>
					<div class="spacer"></div>
				</div>
				<div class="col-3"></div>
			</div>
			<div class="spacer"></div>
		</main>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>
