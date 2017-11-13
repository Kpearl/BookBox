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
		var isListLoading = false;
		
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
			
			//이미지 불러오기 실패시 기본 이미지 출력
			$('img.posting-img').on('error', function(){
				$(this).attr('src', '../resources/images/posting_noimage.jpeg');
			});
			
		});
		
		$(window).scroll(function(){
			console.log($(window).scrollTop());
			if($(document).height() - $(window).height() == 0){
				
			}
		});
		
		function fncGetListAjax(){
			
		};
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

		<c:forEach items="${postingList}" var="posting">
		<div class="row div-posting booklog-background">
			<input type="hidden" name="postingNo" value="${posting.postingNo}"/>
			<div class="row hidden-xs">
				<div class="col-sm-4 text-center posting-img" style="padding-right: 0;">
					<img class="img-object-fit posting-img" src="../resources/upload_files/images/${posting.postingFileList[0].fileName}" alt="Image Not Found" height="200px">
				</div>
				<div class="col-sm-8">
					<h3><strong>${posting.postingTitle}</strong></h3>
					<a class="posting-user" href="#"> by.${posting.user.nickname}</a>
					<span class="posting-content">${posting.postingContent}</span>
					<c:forEach items="${posting.postingTagList}" var="tag">
						<span class="tag"># ${tag.tagName}</span>
					</c:forEach>
				</div>
			</div>
			<div class="row hidden-sm hidden-md hidden-lg">
				<div class="col-xs-12 posting-img">
					<div class="col-xs-10 col-xs-offset-1" style="position: absolute; top: 0; left: 0;">
						<h4><strong>${posting.postingTitle}</strong></h4>
						<a class="posting-user" href="#"> by.${posting.user.nickname}</a>
						<span class="posting-content">${posting.postingContent}</span>
						<c:forEach items="${posting.postingTagList}" var="tag">
							<span class="tag"># ${tag.tagName}</span>
						</c:forEach>
					</div>
					<img class="img-object-fit posting-img" src="../resources/upload_files/images/${posting.postingFileList[0].fileName}" alt="Image Not Found">
				</div>
			</div>
		</div>
		</c:forEach>
	</div>
	
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
	
</body>
</html>