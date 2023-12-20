<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />

<body>
	<jsp:include page="navbar.jsp" />
	<div class="container wrapper">

		<h1>Courses List</h1>

		<table class="table table-striped table-bordered">
			<thead class="thead-dark">
				<tr>
					<th>Course ID</th>
					<th>Title</th>
					<th>Start Date</th>
					<th>End Date</th>
					<th>Professor</th>
					<th>Days</th>
					<th>Enroll</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="course" items="${courses}">
					<tr>
						<td>${course.id}</td>
						<td>${course.title}</td>
						<td>${course.dateStart}</td>
						<td>${course.dateEnd}</td>
						<td>${course.professor.firstName} ${course.professor.lastName}</td>
						<td>${course.daysOfWeek}</td>
						
						<td>
							<c:choose>
                                <c:when test="${!user.courses.contains(course)}">
                                    <form action="addCourse.do" method="post">
                                        <input type="hidden" name="courseID" value="${course.id}" />
                                        <input type="hidden" name="studentID" value="${user.id}" />
                                        <button type="submit" class="btn btn-info">Enroll</button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <form action="unenrollCourse.do" method="post">
                                        <input type="hidden" name="courseID" value="${course.id}" />
                                        <input type="hidden" name="studentID" value="${user.id}" />
                                        <button type="submit" class="btn btn-info">Remove</button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>





	</div>
	<jsp:include page="footer.jsp" />
</body>

</html>