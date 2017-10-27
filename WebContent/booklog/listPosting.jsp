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

	<script type="text/javascript">
		$(function(){
			$('a.posting-add:contains("포스팅 등록")').on('click',function(){
				$(self.location).attr('href','../booklog/addPosting');
			})

			$('div.div-posting').on('click', function(){
				var postingNo = $(this).find('input[type="hidden"]').val();
				var condition = $('input[name="condition"]').val();
				var keyword = $('input[name="keyword"]').val();
				$(self.location).attr("href","../booklog/getPosting?postingNo="+postingNo+"&condition="+condition+"&keyword="+keyword);
			});
		});
	</script>

</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<!-- 여기부터 코딩 -->

	<div class="container">
		<input type="hidden" name="condition" value="${search.condition}">
		<input type="hidden" name="keyword" value="${search.keyword}">
		<a class="btn btn-default posting-add" href="#">포스팅 등록</a><br/>
		<div class="activity" style="width:100%;">
			<c:forEach items="${postingList}" var="posting">
			<div class="activity-list-update div-posting">
				<input type="hidden" name="postingNo" value="${posting.postingNo}"/>
				<img src="http://cfile9.uf.tistory.com/image/2261AA46582D467B3C3609" alt="Image" width="100px" height="80px">
				<p><strong>${posting.postingTitle}</strong><a href="#"> by.${posting.user.nickname}</a>.</p>
				<div class="clear"></div>
			</div>
			</c:forEach>
		</div>
	</div>

</body>
</html>