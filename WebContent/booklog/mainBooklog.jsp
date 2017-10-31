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
		var condition;
		$(function(){
			condition = $('input[name="condition"]').val();
			$('a.booklog:contains("더보기")').on('click', function(){
				$(self.location).attr("href","../booklog/getBooklogList?condition="+condition);
			});
			$('a.posting:contains("더보기")').on('click', function(){
				$(self.location).attr("href","../booklog/getPostingList?condition="+condition);
			});
			
			$('div.div-booklog').on('click', function(){
				var booklogNo = $(this).find('input[type="hidden"]').val();
				$(self.location).attr("href","../booklog/getBooklog?booklogNo="+booklogNo);
			});
			$('div.div-posting').on('click', function(){
				var postingNo = $(this).find('input[type="hidden"]').val();
				$(self.location).attr("href","../booklog/getPosting?postingNo="+postingNo+"&condition="+condition);
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
	
	<div class="container">
		<input type="hidden" name="condition" value="${search.condition}">
		인기북로그 <a class="btn btn-default booklog" href="#">더보기</a>
	    <div class="swiper-container">
	        <div class="swiper-wrapper">
<!-- 	        	<div class="swiper-slide">
		        	<div class="col-sm-6 col-md-4">
						<div class="thumbnail alert alert-warning">
							<img src="../resources/upload_files/images/empty.GIF" class="img-responsive" data-holder-rendered="true" style="height: 200px; width: 100%; display: block;">
							<div class="caption">
								<input type="hidden" name="prodNo" value="">
								<h3>product.prodName</h3>
								<p><div class="btn-group" role="group">
								<a href="#" class="btn btn-primary" role="button">aa
								</a>
								</div>
							</div>
						</div>
					</div>
	        	</div> -->
	        	<c:set var="i" value="0"/>
	        	<c:forEach items="${booklogList}" var="booklog">
	        		<c:set var="i" value="i+1"/>
		            <%-- <div class="swiper-slide" style="background-image:url(http://lorempixel.com/600/600/nature/${i})"> --%>
					<div class="swiper-slide div-booklog" style="background-image:url(http://cfile9.uf.tistory.com/image/2261AA46582D467B3C3609)">
						<input type="hidden" name="booklogNo" value="${booklog.booklogNo}">
						북로그명 : ${booklog.booklogName}<br/>
						북로그소개 : ${booklog.booklogIntro}<br/>
						주인장 : ${booklog.user.nickname}
		            </div>
	        	</c:forEach>
	        </div>
	        <!-- Add Pagination -->
	        <div class="swiper-pagination"></div>
	    </div>
		

		인기포스팅 <a class="btn btn-default posting" href="#">더보기</a>
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