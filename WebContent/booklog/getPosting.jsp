<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

<script type="text/javascript">
	var condition;
	var keyword;
	$(function(){
		condition = $('input[name="condition"]').val();
		keyword = $('input[name="keyword"]').val();
		$('a.posting-list:contains("포스팅 목록")').on('click',function(){
			$(self.location).attr('href','../booklog/getPostingList?condition='+condition+'&keyword='+keyword);
		});
		$('a.posting-update:contains("수정하기")').on('click',function(){
			$(self.location).attr('href','../booklog/updatePosting?postingNo='+$('input[name="postingNo"]').val());
		});
	});
</script>
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<!-- 여기부터 코딩 -->
	<div class="container-fluid text-center">
		<input type="hidden" name="postingNo" value="${posting.postingNo}">
		<img src="http://cfile9.uf.tistory.com/image/2261AA46582D467B3C3609" alt="Image">
		<!-- <img src="http://localhost:8080/BookBox/resources/upload_files/images/${posting.postingFileList[0]}" alt="Image"> -->
		<br/><mark>${posting.postingTitle}</mark>, <em>by ${posting.user.nickname}</em>, 조회수 : ${posting.viewCount}
	</div>
	
	<div class="container">
		${posting.postingContent} <br/><br/>
		<c:forEach items="${posting.postingTagList}" var="tag" >
			#${tag.tagName} 
		</c:forEach>
	</div>
	<div class="container">
		<input type="hidden" name="condition" value="${search.condition}">
		<input type="hidden" name="keyword" value="${search.keyword}">
		<div class="col-md-3 text-center">
			<c:if test="${sessionScope.user.email == posting.user.email}">
				<a class="posting-update" href="#">수정하기</a>
			</c:if>
			<br/><br/><a href="#">이전 포스팅</a>
		</div>
		<div class="col-md-6">
		
		</div>
		<div class="col-md-3 text-center">
			<a class="posting-list" href="#">포스팅 목록</a>
			<br/><br/><a href="#">다음 포스팅</a>
		</div>
	</div>
	
	
</body>
</html>