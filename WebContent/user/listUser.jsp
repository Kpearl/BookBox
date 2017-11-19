<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	
	<script src="../resources/javascript/toolbar_opac.js"></script>
	<script src="../resources/javascript/custom.js"></script>

<style type="text/css">
		body{
	    	padding-top:0px;
	    }
	    
	    header{
	    	background:url(../resources/images/user_title.jpg) no-repeat center;
	    }
	    
	    .list-header{
	    	margin:  20px 0 10px 0;
	    	font-weight: bold;
	    	border-bottom: 1px solid #444;  
	    }
	    .userlist-title{
	    	background-color: #444;
			color: floralwhite;		
			font-size: 35px;
			text-align: center;
	    }

</style>
<script type="text/javascript">
	var condition;
	ToolbarOpacHeight(500);
</script>
	
</head>

<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>
	<!-- 여기부터 코딩 -->
	
	<div class="container">
		<div class="userlist-title">
			USER LIST
		</div>
		<div class="list-header">
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
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
	
	
</body>
</html>