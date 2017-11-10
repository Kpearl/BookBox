<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<!-- 기본설정 -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/css/custom.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- 기본설정 끝 -->

	<script type="text/javascript">
		$(function(){
			$('div.div-booklog').on('click', function(){
				var booklogNo = $(this).find('input[type="hidden"]').val();
				$(self.location).attr("href","../booklog/getBooklog?booklogNo="+booklogNo);
			});
		});
	</script>
	
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>

	<div class="container">
		<div class="activity" style="width:100%;">
			<c:forEach items="${booklogList}" var="booklog">
			<c:set var="text" value="${booklog.booklogIntro }"/>
			<div class="activity-list-update div-booklog">
				<input type="hidden" name="booklogNo" value="${booklog.booklogNo}"/>
				<img class="img-circle" src="../resources/upload_files/images/${booklog.booklogImage}" alt="Image" width="100px" height="80px">
				<p><strong>${booklog.booklogName}</strong>//${booklog.booklogIntro}<a href="#"> by.${booklog.user.nickname}</a>.</p>
				<div class="clear"></div>
			</div>
			</c:forEach>
		</div>
	</div>
	
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
	
</body>
</html>