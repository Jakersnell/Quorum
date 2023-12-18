<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
<jsp:include page="navbar.jsp" />

<div class="container wrapper">
<div class="row">
	<div class="col"></div>
	<div class="col-6">
	  		<div class="card">
	  		  <div class="card-header bg-white">
			  	<h4><c:out value="${user.firstName}"></c:out></h4>
			  </div>
			  <div class="card-body">
				  <c:forEach items="${messages}" var="m">
				  	<div class="row">
					  	<c:choose>
					  		<c:when test="${m.sender.id == loggedUser.id }">
								  	<div class="col"></div>
								  	<div class="col">
										<div class="card text-end rounded" id="sender">
										  <div class="card-body">
							    			<c:out value="${m.contents}"/>
										  </div>
										</div>
									</div>
					  		</c:when>
					  		<c:otherwise>
								  	<div class="col">
									<div class="card rounded" id="receiver">
									  <div class="card-body">
						    			<c:out value="${m.contents}"/>
									  </div>
									</div>
									</div>
								  	<div class="col"></div>
					  		</c:otherwise>
					  	</c:choose>
				  	</div>
				   </c:forEach>
  				</div>
							<form class="row g-3" action="message.do" method="POST">
								<div class="col"></div>
								<div class="col-md-6 text-end">
									<div class="form-floating mb-3">
										<input type="text" name="message" class="form-control rounded" id="floatingInput" placeholder="say something..." required>
										<label for="floatingInput">To <c:out value="${user.firstName}"></c:out></label>
									</div>
									<input type="hidden" name="senderID" id="senderID" value="${loggedUser.id}">
									<input type="hidden" name="receiverID" id="receiverID" value="${user.id}">
								</div>
								<div class="col-md-3">
									<button type="submit" class="btn btn-primary">Send</button>
								<div class="col"></div>
								</div>
							</form>
						<div class="col"></div>
					</div>
  				
			</div>
			<div class="col"></div>
		</div>
	</div>

<!-- Message Box -->

<jsp:include page="footer.jsp" />
</body>
</html>