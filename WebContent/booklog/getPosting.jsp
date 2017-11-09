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
	
	<style>
    	body{
    		padding-top:0px;
    	}
    	header{
    		background:url(../resources/upload_files/images/${empty mainFile? '../../images/posting_noimage.jpeg':mainFile.fileName}) no-repeat center;
    	}
	</style>

	<script type="text/javascript">
		var condition;
		var keyword;
		ToolbarOpacHeight(500);
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
	<header class="parallax"></header>
	
	<!-- 여기부터 코딩 -->
	<div class="container text-center">
		<input type="hidden" name="postingNo" value="${posting.postingNo}">
		<p><mark>${posting.postingTitle}</mark>, <em>by ${posting.user.nickname}</em>, 조회수 : ${posting.viewCount}</p>
		<p>${posting.postingRegDate}</p>
	</div>
	
	<div class="container" style="overflow: auto;">
		${posting.postingContent} <br/><br/>
		<c:forEach items="${posting.postingTagList}" var="tag" >
			<span class="tag"># ${tag.tagName}</span> 
		</c:forEach>
	</div>
	<div class="container">
		<input type="hidden" name="condition" value="${search.condition}">
		<input type="hidden" name="keyword" value="${search.keyword}">
		<div class="col-xs-4 col-md-3 text-center">
			<c:if test="${sessionScope.user.email == posting.user.email}">
				<a class="posting-update" href="#">수정하기</a>
			</c:if>
			<br/><br/><a href="#">이전 포스팅</a>
		</div>
		<div class="col-xs-offset-4 col-xs-4 col-md-offset-6 col-md-3 text-center">
			<a class="posting-list" href="#">포스팅 목록</a>
			<br/><br/><a href="#">다음 포스팅</a>
		</div>
	</div>
	
	
</body>
</html>