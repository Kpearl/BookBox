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
		<c:if test="${!empty sessionScope.user}">
			<a class="btn posting-add" href="#">포스팅 등록</a><br/>
		</c:if>
		<div class="row">
			<c:forEach items="${postingList}" var="posting">
			<div class="activity-list-update div-posting">
				<input type="hidden" name="postingNo" value="${posting.postingNo}"/>
				<img src="../resources/upload_files/images/${empty posting.postingFileList? '../../images/noimage.jpeg':posting.postingFileList[0].fileName}" alt="Image" width="100px" height="80px">
				<p><strong>${posting.postingTitle}</strong><a href="#"> by.${posting.user.nickname}</a>.</p>
			</div>
			</c:forEach>
		</div>
	</div>

</body>
</html>