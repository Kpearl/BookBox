<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/css/swiper.css">
	 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.jquery.js"></script>

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
		$(function(){
			$('a:contains("더보기")').on('click', function(){
				$(self.location).attr("href","../booklog/getBooklogList?condition=main");
			})
		});

		
		$(function(){
	        var swiper = new Swiper('.swiper-container', {
	            pagination: '.swiper-pagination',
	            effect: 'coverflow',
	            grabCursor: true,
	            centeredSlides: true,
	            slidesPerView: 'auto',
	            coverflow: {
	                rotate: 50,
	                stretch: 0,
	                depth: 100,
	                modifier: 1,
	                slideShadows : true
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
	
	<div class="container">
		인기북로그보기 <a class="btn btn-default" href="#">더보기</a>
	    <div class="swiper-container">
	        <div class="swiper-wrapper">
	        	<c:set var="i" value="0"/>
	        	<c:forEach items="${booklogList}" var="booklog">
	        		<c:set var="i" value="i+1"/>
		            <%-- <div class="swiper-slide" style="background-image:url(http://lorempixel.com/600/600/nature/${i})"> --%>
					<div class="swiper-slide" style="background-image:url(http://cfile9.uf.tistory.com/image/2261AA46582D467B3C3609)">
						북로그명 : ${booklog.booklogName}<br/>
						북로그소개 : ${booklog.booklogIntro}<br/>
						주인장 : ${booklog.user.nickname}
		            </div>
	        	</c:forEach>
	        </div>
	        <!-- Add Pagination -->
	        <div class="swiper-pagination"></div>
	    </div>
		
<%-- 	    <div class="swiper-container">
	        <div class="swiper-wrapper">
	        	<c:set var="i" value="0"/>
	        	<c:forEach items="${postingList}" var="posting">
	        		<c:set var="i" value="i+1"/>
		            <div class="swiper-slide" style="background-image:url(http://lorempixel.com/600/600/nature/${i})">
					<div class="swiper-slide div-posting" style="background-image:url(http://cfile9.uf.tistory.com/image/2261AA46582D467B3C3609)">
						<input type="hidden" name="postingNo" value="${posting.postingNo}"/>
						포스팅명 : ${posting.postingTitle}<br/>
						포스팅내용 : ${posting.postingContent}<br/>
						작자 : ${posting.user.nickname}
		            </div>
	        	</c:forEach>
	        </div>
	        <!-- Add Pagination -->
	        <div class="swiper-pagination"></div>
	    </div> --%>

   		<div class="activity" style="width:100%;">
			<c:forEach items="${postingList}" var="posting">
			<c:set var="text" value="${posting.postingContent }"/>
			<c:set var="len" value="${fn:length(text)}"/>
			<c:set var="len" value="${len > 10 ? 10 : len }"/>
			<div class="activity-list-update div-posting">
				<input type="hidden" name="postingNo" value="${posting.postingNo}"/>
				<img src="http://cfile9.uf.tistory.com/image/2261AA46582D467B3C3609" alt="Image" width="100px" height="80px">
				<p><strong>${posting.postingTitle}</strong>${fn:substring(text,0,len-1)}${len==10 ? '...':'' }<a href="#"> by.${posting.user.nickname}</a>.</p>
				<div class="clear"></div>
			</div>
			</c:forEach>
		</div>
	    
	</div>
	
</body>
</html>