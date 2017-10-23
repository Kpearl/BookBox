<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, width=device-width">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<link rel="stylesheet" href="../resources/css/style.css">
	<link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
	
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>

	<div class="container">
		<div class="activity" style="width:100%;">
			<c:forEach items="${booklogList}" var="booklog">
			<c:set var="text" value="${booklog.booklogIntro }"/>
			<div class="activity-list-update div-posting">
				<input type="hidden" name="booklogNo" value="${booklog.booklogNo}"/>
				<img src="http://cfile9.uf.tistory.com/image/2261AA46582D467B3C3609" alt="Image" width="100px" height="80px">
				<p><strong>${booklog.booklogName}</strong>//${booklog.booklogIntro}<a href="#"> by.${booklog.user.nickname}</a>.</p>
				<div class="clear"></div>
			</div>
			</c:forEach>
		</div>
	</div>

</body>
</html>