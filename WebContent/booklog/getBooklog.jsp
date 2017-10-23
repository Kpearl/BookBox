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

	<!-- Swiper 설정 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/css/swiper.css">
	 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.jquery.js"></script>
	<!-- Swiper 설정 끝 -->
	
    <style>
	    .swiper-container {
	        width: 100%;
	        padding-top: 50px;
	        padding-bottom: 50px;
	    }
	    .swiper-slide {
	        background-position: center;
	        background-size: cover;
	        width: 300px;
	        height: 300px;
	    }
    </style>

<script type="text/javascript">
	var booklogUser;
	$(function(){
		booklogUser = $('input[name="user.email"]').val()
		$('a:contains("포스팅 더 보기")').on('click',function(){
			$(self.location).attr('href','../booklog/getPostingList?condition='+booklogUser);
		});
		$('a:contains("표지편집")').on('click', function(){
			$(self.location).attr('href','../booklog/updateBooklog?user.email='+booklogUser);
		});
		$('div.div-posting').on('click', function(){
			var postingNo = $(this).find('input[type="hidden"]').val();
			$(self.location).attr("href","../booklog/getPosting?postingNo="+postingNo+"&condition=booklog&keyword="+booklogUser);
		});
	});

	$(function(){
        var swiper = new Swiper('.swiper-container', {
            spaceBetween: 30,
            centeredSlides: true,
            pagination: {
            	el: '.swiper-pagination',
            	clickable: true
            },
            loop: false
        });
    })
	
</script>
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<!-- 여기부터 코딩 -->
	<input type="hidden" name="user.email" value="${booklog.user.email}">
	<input type="hidden" name="booklogNo" value="${booklog.booklogNo}">
	<div class="container-fluid text-center">
		<img src="http://cfile9.uf.tistory.com/image/2261AA46582D467B3C3609" alt="Image">
		<!-- <img src="http://localhost:8080/BookBox/resources/uploadFiles/images/${booklog.booklogImage}" alt="Image"> -->
		<br/><mark>${booklog.booklogIntro}</mark>, <em>${booklog.booklogName}</em>
		<div class="col-md-9-offset col-md-3">
			<a class="btn btn-defalut" href="#">
				<c:if test="${sessionScope.user.email != null}">
					${sessionScope.user.email == booklog.user.email ? '표지편집' : '책갈피 등록'}
				</c:if>
			</a>
		</div>
	</div>

	<div class="container">
	    <div class="swiper-container">
	        <div class="swiper-wrapper">
	        	<c:set var="i" value="0"/>
	        	<c:forEach items="${booklog.postingList}" var="posting">
					<c:set var="text" value="${posting.postingContent }"/>
					<c:set var="len" value="${fn:length(text)}"/>
					<c:set var="len" value="${len > 10 ? 10 : len }"/>
					<div class="swiper-slide div-posting" style="background-image:url(http://cfile9.uf.tistory.com/image/2261AA46582D467B3C3609)">
						<input type="hidden" name="postingNo" value="${posting.postingNo}"/>
						포스팅명 : ${posting.postingTitle}<br/>
						포스팅내용 : ${fn:substring(text,0,len-1)}${len==10 ? '...':'' }<br/>
		            </div>
	        	</c:forEach>
	        </div>
	        <!-- Add Pagination -->
	        <div class="swiper-pagination"></div>
	    </div>
	</div>
	
	<div class="container">
		${posting.postingContent} <br/><br/>
		<c:forEach items="${posting.postingTagList}" var="tag" >
			#${tag.tagName} 
		</c:forEach>
	</div>
	<div class="container">
		<input type="hidden" name="condition" value="${search.condition}">
		<div class="col-md-3 text-center">
			<br/><br/><a href="#">이전 포스팅</a>
		</div>
		<div class="col-md-6">
		
		</div>
		<div class="col-md-3 text-center">
			<a href="#">포스팅 목록</a>
			<br/><br/><a href="#">다음 포스팅</a>
		</div>
	</div>
	
	
</body>
</html>