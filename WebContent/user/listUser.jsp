<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1.0; maximum-scale=1.0; width=device-width;">
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
	<!-- 여기부터 코딩 -->
	
	<div class="container">

		<div class="row">
			<div class="col-md-4">
				Email
			</div>
			<div class="col-md-3">
				Nickname
			</div>
			<div class="col-md-1">
				Gender
			</div>
			<div class="col-md-3">
				Birth
			</div>
			<div class="col-md-1">
				Account
			</div>
		</div>
		
		<c:forEach items="${userList}" var="user">
			<div class="row">
				<div class="col-md-4">
					${user.email}
				</div>
				<div class="col-md-3">
					${user.nickname}
				</div>
				<div class="col-md-1">
					${user.gender}
				</div>
				<div class="col-md-3">
					${user.birth}
				</div>
				<div class="col-md-1">
					<c:if test="user.account == 0">
						내부계정
					</c:if>
					<c:if test="user.account == 1">
						네이버
					</c:if>
					<c:if test="user.account == 2">
						카카오
					</c:if>
					<c:if test="user.account == 3">
						구글
					</c:if>
				</div>
			</div>
		</c:forEach>
		
	</div>
	
	
	
</body>
</html>