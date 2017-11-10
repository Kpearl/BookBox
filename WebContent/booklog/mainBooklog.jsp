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
	<script src="../resources/javascript/toolbar_opac.js"></script>

	<!-- Swiper 설정 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.3/css/swiper.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.3/css/swiper.min.css">
	 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.3/js/swiper.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.3/js/swiper.min.js"></script>
	<!-- Swiper 설정 끝 -->

    <style>
	    .swiper-container {
	        width: 100%;
	        height: 400px;
	        padding-top: 50px;
	        padding-bottom: 50px;
	    }
	    .swiper-slide {
	        background-position: center;
	        background-size: cover;
	        width: 300px;
	        height: 300px;
	    }


    	body{
    		padding-top:0px;
    	}
    	header{
    		background:url(../resources/images/posting.jpeg) no-repeat center;
    	}

    </style>
	
	<script type="text/javascript">
		var condition;
		ToolbarOpacHeight(500);
//		setToolbarOpac(false);
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

		
			//이미지 불러오기 실패시 기본 이미지 출력
			$('img.posting-img').on('error', function(){
				$(this).attr('src', '../resources/images/posting_noimage.jpeg');
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
	    
/*    		$(window).scroll(function(){
			if($(window).scrollTop() <= 500){
				max = 500;
				$('header').css('opacity', (max - $(window).scrollTop())/max);
			}
		}); */


	</script>
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>
	<!-- 여기부터 코딩 -->
	
	<div class="container">
		<input type="hidden" name="condition" value="${search.condition}">
		인기북로그 <a class="btn booklog" href="#">더보기</a>
	    <div class="swiper-container">
	        <div class="swiper-wrapper">
	        	<c:set var="i" value="0"/>
	        	<c:forEach items="${booklogList}" var="booklog">
	        		<c:set var="i" value="i+1"/>
					<div class="swiper-slide div-booklog" style="background-image:url('../resources/upload_files/images/${booklog.booklogImage}')">
						<input type="hidden" name="booklogNo" value="${booklog.booklogNo}">
						북로그명 : ${booklog.booklogName}<br/>
						북로그소개 : ${booklog.booklogIntro}<br/>
						주인장 : ${booklog.user.nickname}
		            </div>
	        	</c:forEach>
	        </div>
	        <!-- Add Pagination -->
	        <div class="swiper-pagination swiper-pagination-black"></div>
	    </div>
	    
	    
		

		인기포스팅 <a class="btn posting" href="#">더보기</a>
		<c:forEach items="${postingList}" var="posting">
		<div class="row div-posting booklog-border booklog-background">
			<input type="hidden" name="postingNo" value="${posting.postingNo}"/>
			<div class="row hidden-xs">
				<div class="col-sm-4 text-center posting-img booklog-border-thin" style="padding-right: 0;">
					<img class="img-thumbnail img-object-fit posting-img" src="../resources/upload_files/images/${posting.postingFileList[0].fileName}" alt="Image Not Found" height="200px">
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
					<img class="img-thumbnail img-object-fit posting-img" src="../resources/upload_files/images/${posting.postingFileList[0].fileName}" alt="Image Not Found">
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