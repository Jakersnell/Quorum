<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
<jsp:include page="navbar.jsp" />

<div class="container">
	  <c:forEach items="${messages}" var="m">
	  	<div class="row">
	  	<div class="col"></div>
		  	<c:choose>
		  		<c:when test="${m.sender.id == loggedUser.id }">
					  	<div class="col-3"></div>
					  	<div class="col-3">
							<div class="card text-end" id="sender">
							  <div class="card-body">
				    			<c:out value="${m.contents}"/>
							  </div>
							</div>
						</div>
		  		</c:when>
		  		<c:otherwise>
					  	<div class="col-3">
						<div class="card" id="receiver">
						  <div class="card-body">
			    			<c:out value="${m.contents}"/>
						  </div>
						</div>
						</div>
					  	<div class="col-3"></div>
		  		</c:otherwise>
		  	</c:choose>
	  	<div class="col"></div>
	  	</div>
	   </c:forEach>
	</div>













<!-- Message Box -->
<div class="container">
	<div class="row">
		<div class="col"></div>
		<div class="col-6 text-end">
			<form action="message.do" method="POST">
				<div class="form-floating mb-3">
					<input type="text" name="message" class="form-control" id="floatingInput" placeholder="say something..." required>
					<label for="floatingInput">To <c:out value="${user.firstName}"></c:out></label>
				</div>
				<input type="hidden" name="senderID" id="senderID" value="${loggedUser.id}">
				<input type="hidden" name="receiverID" id="receiverID" value="${user.id}">
				
				<input type="submit" value="send">
				
			</form>
			</div>
		<div class="col"></div>
	</div>
</div>

<jsp:include page="footer.jsp" />
</body>
</html>