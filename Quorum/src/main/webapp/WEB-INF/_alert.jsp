<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<script type="text/javascript">
	function closeMsg() {
		document.getElementById("msgAlert").style.display = "none";
	}
</script>
<c:if test="${not empty msg}">
	<div id="msgAlert">
		<button onClick="closeMsg()" class="msg-close-btn">X</button>
		<p class="alert-contents">${msg}</p>
	</div>
</c:if>
