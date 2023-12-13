<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="jakarta.tags.core" %>
		<!DOCTYPE html>
		<html>

		<head>
			<jsp:include page="head.jsp" />
		</head>

		<body>
			<jsp:include page="navbar.jsp" />
			<div class="sm-spacer"></div>
			<div class="container">
				<div class="row">
					<div class="col-1"></div>
					<div class="col-10" id="accordion">

						<div class="row">

							<div class="col-md-3">
								<div class="card">
									<div class="card-header">
										<button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne"
											aria-expanded="true" aria-controls="collapseOne">Users</button>
									</div>
								</div>
							</div>

							<div class="col-md-3">
								<div class="card">
									<div class="card-header">
										<button class="btn btn-link collapsed" data-toggle="collapse"
											data-target="#collapseTwo" aria-expanded="false"
											aria-controls="collapseTwo">Posts</button>
									</div>
								</div>
							</div>

							<div class="col-md-3">
								<div class="card">
									<div class="card-header">
										<button class="btn btn-link collapsed" data-toggle="collapse"
											data-target="#collapseThree" aria-expanded="false"
											aria-controls="collapseThree">Groups</button>
									</div>
								</div>
							</div>

							<div class="col-md-3">
								<div class="card">
									<div class="card-header">
										<button class="btn btn-link collapsed" data-toggle="collapse"
											data-target="#collapseFour" aria-expanded="false"
											aria-controls="collapseFour">Schools</button>
									</div>
								</div>
							</div>

						</div>
						<div class="row p-2">
							<div id="collapseOne" class="collapse show" data-parent="#accordion">
								<div class="card-body">Content of Div 1</div>
							</div>
							<div id="collapseTwo" class="collapse" data-parent="#accordion">
								<div class="card-body">Content of Div 2</div>
							</div>
							<div id="collapseThree" class="collapse" data-parent="#accordion">
								<div class="card-body">Content of Div 3</div>
							</div>
							<div id="collapseFour" class="collapse" data-parent="#accordion">
								<div class="card-body">Content of Div 4</div>
							</div>
						</div>
						<div class="col-1"></div>
					</div>
				</div>
			</div>
			<jsp:include page="footer.jsp" />
		</body>

		</html>