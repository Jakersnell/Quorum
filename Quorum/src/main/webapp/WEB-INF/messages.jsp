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
		<div class="col"></div>
		<div class="col-6"><h2>Active Messages</h2></div>
		<div class="col"></div>
	
	
	</div>


	  <c:forEach items="${messagees}" var="m">
	  	<div class="row">
		  	<div class="col"></div>
		  	<div class="col-6"><a href="message.do?userID=${m.id}"><c:out value="${m.firstName}"></c:out></a></div>
		  	<div class="col"></div>
	  	</div>
	   </c:forEach>
	</div>


<jsp:include page="footer.jsp" />
</body>
</html>