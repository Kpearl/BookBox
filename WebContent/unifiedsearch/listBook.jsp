<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<link rel="stylesheet" href="../resources/css/star.css">
	

<style>
body{
	padding-top:0px;
}
header{
	background:url(../resources/images/bookback.jpeg) no-repeat center;
}
.parallax { 
    background-attachment: fixed;
    background-size: cover;
}
</style>

<script>
function getBook(isbn) {
	$(self.location).attr("href","../unifiedsearch/getBook?isbn="+isbn);
}
</script>
</head>

<body>
	<header class="parallax"></header>

	<jsp:include page="../layout/toolbar.jsp">
		<jsp:param value="../" name="uri" />
	</jsp:include>
    <div class="container">
        <div class="row">

           <c:forEach items="${bookList}" var="book">
	            <div class="col-lg-10 col-md-offset-1">
	            </div>
	            
	            <div class="col-lg-2 col-lg-offset-1 col-lg-push-0 col-md-3 col-md-offset-1 col-md-push-0 col-md-pull-0 col-xs-12 col-xs-offset-0 col-xs-push-0 col-xs-pull-0">
		           	<div class="row"><br><br></div>
	           		<img class="img-thumbnail" src="http://t1.daumcdn.net/book/KOR${book.isbn}" height="240px" width="170px" onerror="this.src='../resources/images/noimage.jpg'">
	                <div id="starWrap" class="star${book.grade.average}">
							<ul>
								<li class="s1"></li>
								<li class="s2"></li>
								<li class="s3"></li>
								<li class="s4"></li>
								<li class="s5"></li>
							</ul>
					</div>
	            </div>
	            
	            <div class="col-lg-7 col-lg-offset-0 col-lg-push-1 col-lg-pull-0 col-md-7 col-md-offset-0 col-md-push-0 post-body" onclick="getBook(${book.isbn});" id="${book.isbn}">
	                <h2>${book.title}</h2>
	                <p class="author"><strong><c:forEach items="${book.authors}" var="str" varStatus="status">
		   			   	 	${str} <c:if test="${!status.last}"> | </c:if>
   						</c:forEach></strong> </p>
	                <p>출판일 : ${book.datetime}</p>
               	 	<p>좋아요 : ${book.like.totalLike}</p>
               	 	<p>가격 : ${book.price}원</p>
               	 	<p><c:forEach items="${book.translators}" var="str" varStatus="status">
               	 			<c:if test="${status.first}"> 번역가 : </c:if>
		   			   	 	${str} <c:if test="${!status.last}"> | </c:if>
   					</c:forEach></p>
	            </div>
	            <div class="col-md-12"></div>
            </c:forEach> 
            <!-- 끝 -->
        </div>
    </div>
</body>
</html>