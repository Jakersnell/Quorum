<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
<jsp:include page="navbar.jsp" />

<div class="container wrapper">
	<div class="row">
		<div class="col"></div>
		<div class="col-6 text-center"><h2>Active Messages</h2></div>
		<div class="col"></div>
	</div>
	
	<div class="row">
		<div class="col"></div>
		<div class="col-6">
			<table class="table">
				<thead>
				    <tr>
				      <th scope="col">First</th>
				      <th scope="col">Last</th>
				    </tr>
				</thead>
				<tbody>
				  <c:forEach items="${messagees}" var="m">
					  <tr>
					      <th scope="row"><a href="message.do?userID=${m.id}"><c:out value="${m.firstName}"></c:out></a></th>
					      <td><c:out value="${m.lastName}"></c:out></td>
					  </tr>
				  </c:forEach>
				</tbody>
			</table>
		</div>
		<div class="col"></div>
	</div>
</div>
	


<jsp:include page="footer.jsp" />
</body>
</html>