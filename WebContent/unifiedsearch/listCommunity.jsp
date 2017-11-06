<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<!-- 기본설정 -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/css/custom.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- 기본설정 끝 -->

<style>
body{
	padding-top:0px;
}
header{
	background:url(../resources/images/community.jpeg) no-repeat center;
}
.parallax { 
    background-attachment: fixed;
    background-size: cover;
}
</style>
</head>

<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>


	<div class="container">
		<h1>검색 결과 총 ${total} 건</h1>
		
		<c:forEach items="${result}" var="result">
     	   <div class="row">
    	        <div class="col-md-12"></div>
    	       	 <div class="col-lg-10 col-md-offset-1">
      	       	   <h2>(${result.category}) ${result.title}</h2>
      	       	   <p class="author"><strong>${result.nick_name}</strong> <span class="text-muted"></span></p>
      	      </div>
       	     <div class="col-md-push-0 col-xs-3 col-xs-offset-1 col-xs-push-0"><img class="img-thumbnail" src="../resources/images/unifiedsearch.jpg"></div>
       	     	<div class="col-xs-7">
               	 <p class="lead author">
               	 	<strong><c:forEach items="${result.tag}" var="tag">${tag} /</c:forEach></strong>
               	 </p>
               	 <p>${result.content}</p>
            	</div>
        	</div>
        </c:forEach>
    </div>
</body>	
</html>