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
	<script src="../resources/javascript/custom.js"></script>

	<!-- Swiper 설정 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.3/css/swiper.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.3/css/swiper.min.css">
	 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.3/js/swiper.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.3/js/swiper.min.js"></script>
	<!-- Swiper 설정 끝 -->

    <style>
	    .swiper-container {
	        width: 100%;
	        height: 500px;
	        padding-top: 50px;
	        padding-bottom: 50px;
	    }
	    .swiper-slide {
	        background-position: center;
	        background-size: cover;
	    }


    	body{
    		padding-top: 0px;
    	}
    	header{
    		background: url(../resources/images/posting.jpeg) no-repeat center;
    	}
    	
    	.swiper-posting1, .swiper-posting2, .swiper-posting3,
    	.swiper-posting4, .swiper-posting5, .swiper-posting6,
    	.swiper-posting7, .swiper-posting8, .swiper-posting9,
    	.swiper-posting10{
    		position: absolute;
    		margin: 0;
    		padding: 0;
    	}
    	.swiper-posting1 > *, .swiper-posting2 > *, .swiper-posting3 > *,
    	.swiper-posting4 > *, .swiper-posting5 > *, .swiper-posting6 > *,
    	.swiper-posting7 > *, .swiper-posting8 > *, .swiper-posting9 > *,
    	.swiper-posting10 > *{
    		position: absolute;
    		margin: 0;
    		padding: 0;
    		top: 0;
    		left: 0;
    	}
    	.swiper-posting1, .swiper-posting5, .swiper-posting6, .swiper-posting9{
			top: 0;
			left: 0;
    	}
    	.swiper-posting1{
    		height: 100%;
    		width: 40%;
    	}
    	.swiper-posting2{
    		height: 60%;
    		width: 60%;
    		top: 0;
    		left: 40%;
    	}
    	.swiper-posting3, .swiper-posting4{
    		height: 40%;
    		width: 30%;
    		top: 60%;
    	}
    	.swiper-posting3{
    		left: 40%;
    	}
    	.swiper-posting4{
    		left: 70%;
    	}
    	.swiper-posting5, .posting-img-box, .posting-content{
    		height: 100%;
    		width: 100%;
    	}
    	.swiper-posting6{
    		height: 100%;
    		width: 50%;
    	}
    	.swiper-posting7, .swiper-posting8{
    		height: 50%;
    		width: 50%;
    		left: 50%;
    	}
    	.swiper-posting7{
    		top: 0;
    	}
    	.swiper-posting8{
    		top:50%;
    	}
    	.swiper-posting9, .swiper-posting10{
    		height: 100%;
    		width: 50%;
    	}
    	.swiper-posting10{
    		top: 0;
    		left: 50%;
    	}
    	.posting-img-box{
    		overflow: hidden;
    	}
    	
    </style>
	
	<script type="text/javascript">
		var condition;
		ToolbarOpacHeight(500);
		$(function(){
			condition = $('input[name="condition"]').val();
			
			$('a.booklog:contains("더보기")').on('click', function(){
				$(self.location).attr("href","../booklog/getBooklogList?condition="+condition);
			});
			$('a.posting:contains("더보기")').on('click', function(){
				$(self.location).attr("href","../booklog/getPostingList?condition="+condition);
			});
			
			$('div.div-booklog').on('click', function(){
				var booklogNo = $(this).find('input[name="booklogNo"]').val();
				$(self.location).attr("href","../booklog/getBooklog?booklogNo="+booklogNo);
			});
			$('div.div-posting .posting-img, div.div-posting h3').on('click', function(){
				var postingNo = $(this).find('input[name="postingNo"]').val();
				$(self.location).attr("href","../booklog/getPosting?postingNo="+postingNo+"&condition="+condition);
			});
			$('a.posting-user').on('click', function(){
				var user = $(this).find('input[name="user.email"]').val();
				$(self.location).attr("href","../booklog/getBooklog?user.email="+user);
			});

		
			//이미지 불러오기 실패시 기본 이미지 출력
			$('img.posting-img').on('error', function(){
				$(this).attr('src', '../resources/images/posting_noimage.jpeg');
			});

			var p1 = $('.swiper-posting1').clone(true);
			var p2 = $('.swiper-posting2').clone(true);
			var p3 = $('.swiper-posting3').clone(true);
			var p4 = $('.swiper-posting4').clone(true);
			var p5 = $('.swiper-posting5').clone(true);
			var p6 = $('.swiper-posting6').clone(true);
			var p7 = $('.swiper-posting7').clone(true);
			var p8 = $('.swiper-posting8').clone(true);
			var p9 = $('.swiper-posting9').clone(true);
			var p10 = $('.swiper-posting10').clone(true);
			$('.posting-slide1').append(p1.show()).append(p2.show()).append(p3.show()).append(p4.show());
			$('.posting-slide2').append(p5.show());
			$('.posting-slide3').append(p6.show()).append(p7.show()).append(p8.show());
			$('.posting-slide4').append(p9.show()).append(p10.show());

			
			$('.booklog-img').css('height', $('.booklog-img').find('div').find('img').css('width'));
			
			for(var i=0; i<$('.div-booklog').length; i++){
				var booklogUser = $($('.div-booklog')[i]).find('input[name="booklogUser"]').val();
				$.ajax({
					url: 'rest/getCounts/'+booklogUser.split('@')[0]+'/'+booklogUser.split('.')[0].split('@')[1]+'/'+booklogUser.split('.')[1]+'/'+i,
					method: 'get',
					dataType: 'json',
					success: function(data){
						$($($('.div-booklog')[data.index]).find('.content-count')[0]).html(data.counts.cc>999? '999+':data.counts.wc).find('.loading-img').hide();
						$($($('.div-booklog')[data.index]).find('.content-count')[1]).html(data.counts.pc>999? '999+':data.counts.pc).find('.loading-img').hide();
						$($($('.div-booklog')[data.index]).find('.content-count')[2]).html(data.counts.bc>999? '999+':data.counts.bc).find('.loading-img').hide();
						$($('.div-booklog')[data.index]).find('i.glyphicon-bookmark').addClass(data.bookmark == 'true'? 'bookmarked':'nobookmarked');
					}
				});
			}
		});

		
		$(function(){
	        var swiper = new Swiper('.swiper-container', {
	            spaceBetween: 5,
	            pagination: {
	            	el: '.swiper-pagination',
	            	clickable: true
	            },
	            loop: false,
	            slidesPerView: 'auto',
	            freeMode: true,
	        });
	        
	        var postingSwiper = new Swiper('.posting-swiper-container', {
	        	spaceBetween: 0,
	        	pagination:{
	        		el: '.swiper-pagination',
	        		clickable: true,
	        	},
	        	slidesPerView: 1,
	        });
	    })
	    

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

		<c:set var="i" value="0"/>
		<c:forEach items="${postingList}" var="posting">
			<c:set var="i" value="${i+1}"/>
			<div class="swiper-posting${i}" style="display: none;">
				<div class="posting-content">
					<div class="div-posting">
						<h3>${posting.postingTitle}</h3>
					</div>
				</div>
				<div class="posting-img-box">
					<img class="img-object-fit posting-img" src="../resources/upload_files/images/${posting.postingFileList[0].fileName}">
				</div>
			</div>
		</c:forEach>

		<div class="posting-swiper-container swiper-container">
			<div class="swiper-wrapper">
				<div class="swiper-slide posting-slide1"></div>
				<div class="swiper-slide posting-slide2"></div>
				<div class="swiper-slide posting-slide3"></div>
				<div class="swiper-slide posting-slide4"></div>
			</div>
	        <div class="swiper-pagination swiper-pagination-black"></div>
		</div>

		인기포스팅 <a class="btn posting" href="javascript:void(0);">더보기</a>
		<c:forEach items="${postingList}" var="posting">
		<div class="row div-posting booklog-background">
			<div class="row hidden-xs">
				<div class="col-sm-4 text-center posting-img" style="padding-right: 0;">
					<input type="hidden" name="postingNo" value="${posting.postingNo}"/>
					<img class="img-object-fit posting-img" src="../resources/upload_files/images/${posting.postingFileList[0].fileName}" alt="Image Not Found" height="200px">
				</div>
				<div class="col-sm-8" style="height: 200px; padding: 0 50px 10px 20px;">
					<h3><input type="hidden" name="postingNo" value="${posting.postingNo}"/><strong>${posting.postingTitle}</strong></h3>
					<a class="posting-user" href="javascript:void(0);">
						<input type="hidden" name="user.email" value="${posting.user.email}">
						by.${posting.user.nickname}
					</a>
					<span class="posting-content">${posting.postingContent}</span>
					<div class="row" style="position: absolute; bottom: 0; margin: 10px 0;">
						<c:forEach items="${posting.postingTagList}" var="tag">
							<span class="tag">#${tag.tagName}</span>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="row hidden-sm hidden-md hidden-lg">
				<div class="col-xs-12 posting-img">
					<div class="col-xs-10 col-xs-offset-1" style="position: absolute; top: 0; left: 0; height: 200px;">
						<h4><strong>${posting.postingTitle}</strong></h4>
						<a class="posting-user" href="javascript:void(0);">
							<input type="hidden" name="user.email" value="${posting.user.email}">
							by.${posting.user.nickname}
						</a>
						<span class="posting-content">${posting.postingContent}</span>
						<div class="row" style="position: absolute; bottom: 0; margin: 10px 0;">
							<c:forEach items="${posting.postingTagList}" var="tag">
								<span class="tag">#${tag.tagName}</span>
							</c:forEach>
						</div>
					</div>
					<input type="hidden" name="postingNo" value="${posting.postingNo}"/>
					<img class="img-object-fit posting-img" src="../resources/upload_files/images/${posting.postingFileList[0].fileName}" alt="Image Not Found">
				</div>
			</div>
		</div>
		</c:forEach>



		인기북로그 <a class="btn booklog" href="javascript:void(0);">더보기</a>

	    <div class="swiper-container">
	        <div class="swiper-wrapper">
	        	<c:set var="i" value="0"/>
	        	<c:forEach items="${booklogList}" var="booklog">
	        		<c:set var="i" value="i+1"/>
	        		<div class="swiper-slide">
						<div class="row booklog-profile div-booklog" style="width: 250px;">
							<input type="hidden" name="booklogNo" value="${booklog.booklogNo}">
							<input type="hidden" name="booklogUser" value="${booklog.user.email}">
							<div class="col-sm-12">
								<div class="row text-center booklog-img">
									<div class="col-xs-offset-1 col-xs-10 booklog-img">
										<img class="img-responsive img-circle center-block img-object-fit" src="../resources/upload_files/images/${booklog.booklogImage}">
									</div>
								</div>
						
								<!-- 북로그이미지, 소개글, 이름 -->
								<div class="row text-center booklog-name">
									<p><em>${booklog.booklogName}</em></p>
								</div>
								<div class="row text-center booklog-intro booklog-background">
									<p>${booklog.booklogIntro}</p>
								</div>
								<div class="row text-center booklog-content-num">
									<div class="col-xs-4 text-center">
										<span class="content-icon"><i class="glyphicon glyphicon-pencil"></i></span><br/>
										<span class="content-count"><img class="loading-img" src="../resources/images/loading.gif" style="height: 25px;"></span>
									</div>
									<div class="vertical-line"></div>
									<div class="col-xs-4 text-center">
										<span class="content-icon"><i class="glyphicon glyphicon-grain"></i></span><br/>
										<span class="content-count"><img class="loading-img" src="../resources/images/loading.gif" style="height: 25px;"></span>
									</div>
									<div class="vertical-line"></div>
									<div class="col-xs-4 text-center">
										<span class="content-icon"><i class="glyphicon glyphicon-bookmark"></i></span><br/>
										<span class="content-count"><img class="loading-img" src="../resources/images/loading.gif" style="height: 25px;"></span>
									</div>
								</div>
							</div>
		
						</div>
					</div>
	        	</c:forEach>
	        </div>
	        <!-- Add Pagination -->
	        <div class="swiper-pagination swiper-pagination-black"></div>
	    </div>
	    
	    
		

	    
	</div>
	
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
	
</body>
</html>