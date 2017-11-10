<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<!-- 기본설정 -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="./resources/css/custom.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- 기본설정 끝 -->
	
	<!-- 툴바 투명해지는 스크립트 -->
	<script src="./resources/javascript/toolbar_opac.js"></script>
	
	<!-- 스와이퍼 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.5/css/swiper.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.5/css/swiper.min.css">
	 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.5/js/swiper.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.5/js/swiper.min.js"></script>
	
	<style>
		body{
			padding-top: 0;
		}
		header{
			background-image: url('./resources/images/main_img.jpg');
			min-height: 100%;
		}
		#main-search{
			height: 150px;
			padding: 40px;
		}
		#main-search .input-group *{
			margin: 0;
		}
		#main-search input{
			border: 1px solid #ccc;
			padding: 0 7px;
			background-color: rgba(255, 255, 255, 0.8);
		}
		#main-search input:focus{
			border: 1px solid #66afe9;
			box-shadow: 0 0.5px 0.5px 0.1px #66afe9;
		}
		#main-search > .bookbox-relative > div{
			background-color: rgba(224, 151, 88, 0.89);
			padding: 30px 5px;
		}
		#main-recommend-book{
			position: relative;
			margin-top: 10px;
			margin-bottom: 60px;
		}
		.max-height{
			height: 100%;
			background-color: rgba(248, 255, 115, 0.25);
		}
		.half-height{
			height: 45%;
			margin: 0 15px;
		}
		.first-level, .second-level{
			margin: 0;
			padding: 2px;
			overflow: hidden;
		}
		.second-level{
			/* background-color: rgba(248, 255, 115, 0.5); */
		}
		.book-img{
			z-index: 0;
			width: 100%;
			height: 100%;
			object-fit: cover;
			opacity: 0.75;
			-webkit-transition: 0.1s;
			   -moz-transition: 0.1s;
					transition: 0.1s;
		}
		.book-content:hover{
			opacity: 0.3;
			-webkit-transition: 0.5s;
			   -moz-transition: 0.5s;
					transition: 0.5s;
/* 			-webkit-transform: translate(-50%, -50%) scale(1.07);
			   -moz-transform: translate(-50%, -50%) scale(1.07);
					transform: translate(-50%, -50%) scale(1.07); */
		}
		.category{
			min-height: 100%;
		}
		.category .list{
			position: relative;
		}
		.category-creation{
			background-image: url('./resources/images/creation.jpg');
			height: 400px;
		}
		.category-community{
			background-image: url('./resources/images/community.jpeg');
			height: 400px;
		}
		.category-booklog{
			background-image: url('./resources/images/posting.jpeg');
			height: 400px;
		}
		.font-large{
			font-size: 24px!important;
		}
		.font-small{
			font-size: 16px!important;
		}
		.theme-black{
			color: #fff!important;
			background-color: #000!important;
		}
		.theme-white{
			color: #fff!important;
		}
		.padding-large{
			padding: 12px 30px!important;
		}
		.wide{
			letter-spacing: 15px;
		}
		.narrow{
			letter-spacing: 5px;
		}
	</style>
	
	<script>
		//Toolbar 투명도 설정
		ToolbarOpacHeight($(window).height());
		//Window Resize시 Toolbar 투명도, BookContainer 높이, Parallax background-position 재설정
		$(window).resize(function(){
			ToolbarOpacHeight($(window).height());
			$('#main-recommend-book').css('height', $('#main-recommend-book').width() * 2 / 3);
		});
		
		
		$(function(){
			//툴바 검색창 숨김
			$('.bookbox-navigation .search-group').hide();
			//메인배너 클릭시 스크롤이동 이벤트
			$('#main-bookbox').on('click', function(){
				var offset = $('#main-search').offset();
				$('html, body').animate({scrollTop : offset.top - 52}, 1300);
			});
			
			//검색창 드롭다운버튼 이벤트
			$('#main-search li a').on('click', function(){
				$('button.selected-menu').attr('aria-expanded', $(this).attr('class'))
										.html($(this).html());
			});
			//검색버튼 이벤트
			$('button.main-search-btn').on('click', function(){
				fncSearch();
			});
			//검색입력창 EnterKey 이벤트
			$('#main-search input').on('keydown', function(event){
				console.log(event.which);
				if(event.which == 13){
					event.preventDefault();
					fncSearch();
				}
			});
			
			$('#main-recommend-book').css('height', $('#main-recommend-book').width() * 2 / 3);

			//스와이퍼 초기화
 			var bookSwiper = new Swiper('.book-swiper-container', {
				speed: 600,
				spaceBetween: 50,
				effect: 'slide',
				autoplay: {
					delay: 5000,
				},
				pagination:{
					el: '.swiper-pagination',
					type: 'bullets',
					clickable: true,
				},
			});
			
			var categorySwiper = new Swiper('.category-swiper-container', {
				speed: 600,
				parallax: true
			});
			
			//추천도서 rest
			$.ajax({
				url: "./unifiedsearch/rest/recommendBook",
				success: function(data){
					if(data.userRecommendList == null){
						$('#userRecommend').remove();
						bookSwiper.update();
					};
					for(var i=0; i<4; i++){
						var bestSellerContainer = $('#bestSeller .book-content')[i];
						var bestSellerThumbnail = data.bestsellerList[i].thumbnail;
						var newBookContainer = $('#newBook .book-content')[i];
						var newBookThumbnail = data.newBookList[i].thumbnail;
						
						$(bestSellerContainer).find('input[name="isbn"]').val(data.bestsellerList[i].isbn);
						$(bestSellerContainer).find('.book-img').attr('src', 'http://t1.daumcdn.net/book/KOR' + data.bestsellerList[i].isbn)
																.attr('onerror', 'this.src="' + bestSellerThumbnail + '"');
						$(bestSellerContainer).find('.book-title').html(data.bestsellerList[i].title);
						$(bestSellerContainer).find('.book-author').html(function(){
																		var author = '';
																   		for(x in data.bestsellerList[i].authors){
																   			author += data.bestsellerList[i].authors[x] + ', ';
																   		}
																   		author = author.substring(0, author.lastIndexOf(','));
																   		return author;
																	});

						$(newBookContainer).find('input[name="isbn"]').val(data.newBookList[i].isbn);
						$(newBookContainer).find('.book-img').attr('src', 'http://t1.daumcdn.net/book/KOR' + data.newBookList[i].isbn)
																.attr('onerror', 'this.src="' + newBookThumbnail + '"');
						$(newBookContainer).find('.book-title').html(data.newBookList[i].title);
						$(newBookContainer).find('.book-author').html(function(){
																		var author = '';
																   		for(x in data.newBookList[i].authors){
																   			author += data.newBookList[i].authors[x] + ', ';
																   		}
																   		author = author.substring(0, author.lastIndexOf(','));
																   		return author;
																	});
						
						if(data.userRecommendList != null){
							var userRecommendContainer = $('#userRecommend .book-content')[i];
							var userRecommendThumbnail = data.userRecommendList[i].thumbnail;
							$(userRecommendContainer).find('input[name="isbn"]').val(data.userRecommendList[i].isbn);
							$(userRecommendContainer).find('.book-img').attr('src', 'http://t1.daumcdn.net/book/KOR' + data.userRecommendList[i].isbn)
																	.attr('onerror', 'this.src="' + userRecommendThumbnail + '"');
							$(userRecommendContainer).find('.book-title').html(data.userRecommendList[i].title);
							$(userRecommendContainer).find('.book-author').html(function(){
																			var author = '';
																	   		for(x in data.userRecommendList[i].authors){
																	   			author += data.userRecommendList[i].authors[x] + ', ';
																	   		}
																	   		author = author.substring(0, author.lastIndexOf(','));
																	   		return author;
																		});
						}
					}
					
					$('.book-content').on('click', function(){
						var isbn = $(this).find('input[name="isbn"]').val();
						if(isbn != 0){
							$(self.location).attr("href","./unifiedsearch/getBook?isbn="+isbn);
						}
					}).css('cursor', function(){
						var isbn = $(this).find('input[name="isbn"]').val();
						if(isbn != 0){
							return 'pointer';
						}else{
							return 'not-allowed';
						}
					});
/*  					$('.book-img').on('error', function(){
						$(this).attr('src', './resources/images/noimage.png');
					}); */
				}
			});
			
			
		});
		
		//검색처리
		function fncSearch(){
			var keyword = $('#main-search input').val().trim();
			
			if(keyword == '') {  
				alert('검색어를 입력하세요');
			} else {
				var option_value = $('button.selected-menu').attr('aria-expanded');
				 
				switch (option_value){	  
					case "unifiedsearch" : $(self.location).attr("href","${param.uri}unifiedsearch/getUnifiedsearchList?category=10&keyword="+keyword); break; 
					case "book" : $(self.location).attr("href","${param.uri}unifiedsearch/getBookList?keyword="+keyword); break;
					case "creation" : $(self.location).attr("href","${param.uri}unifiedsearch/getUnifiedsearchList?category=1&keyword="+keyword); break;
					case "community" : $(self.location).attr("href","${param.uri}unifiedsearch/getUnifiedsearchList?category=6&keyword="+keyword); break;
					case "posting" : $(self.location).attr("href","${param.uri}unifiedsearch/getUnifiedsearchList?category=5&keyword="+keyword); break; 
					case "tag" : $(self.location).attr("href","${param.uri}unifiedsearch/getUnifiedsearchList?category=11&keyword="+keyword); break; 
				}
			}
		}
	</script>
</head>
<body>

	<jsp:include page="./layout/toolbar.jsp"/>
	<header class="parallax">
		<div id="main-bookbox" class="display-middle" style="cursor: pointer; white-space: nowrap; display:block;">
			<span class="font-large theme-black padding-large wide"><strong>BOOKBOX</strong><small class="hidden-xs hidden-sm narrow"> Book Community</small></span><br/>
			<p class="font-large theme-black narrow text-center"><small class="hidden-xs hidden-sm"><em class="text-muted font-small">- 책으로 소통하는 공간</em></small></p>
		</div>
	</header>
	
	<div id="main-search" class="container bookbox-relative">
		<div class="row bookbox-relative">
			<div class="col-sm-offset-1 col-sm-10">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-8">
						<div class="input-group">
							<div class="input-group-btn hidden-xs">
								<button type="button" class="btn btn-default selected-menu" aria-expanded="unifiedsearch" style="width: 80px;">통합검색</button>
								<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><span class="caret"></span></button>
								<ul class="dropdown-menu" role="menu" style="min-width: 121px;">
									<li><a href="javascript:void(0);" class="unifiedsearch">통합검색</a>
									<li><a href="javascript:void(0);" class="book">도서</a>
									<li><a href="javascript:void(0);" class="creation">창작공간</a>
									<li><a href="javascript:void(0);" class="community">소모임</a>
									<li><a href="javascript:void(0);" class="posting">포스팅</a>
									<li><a href="javascript:void(0);" class="tag">태그</a>
								</ul>
							</div>
							<input type="text" class="form-control">
							<span class="input-group-btn">
								<button class="btn btn-default main-search-btn" type="button">검색!</button>
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="container">
		<div class="col-md-offset-1 col-md-10">

			<div id="main-recommend-book" class="swiper-container book-swiper-container">
				<div class="swiper-wrapper">
					<div id="userRecommend" class="swiper-slide">
						<h4><em>For U..</em></h4>
						<div class="row half-height">
							<div class="col-sm-6 max-height first-level">
								<div class="row max-height first-level book-content">
									<input type="hidden" name="isbn" value="0">
									<div class="col-sm-6 max-height first-level">
										<img class="book-img" src="./resources/images/noimage.png" alt="No Image Available">
									</div>
									<div class="col-sm-6 max-height second-level">
										<p class="book-title">제목 가져오는 중..</p>
										<p class="book-author">작가 가져오는 중..</p>
									</div>
								</div>
							</div>
							<div class="col-sm-6 max-height first-level">
								<div class="row max-height first-level book-content">
									<input type="hidden" name="isbn" value="0">
									<div class="col-sm-6 max-height first-level">
										<img class="book-img" src="./resources/images/noimage.png" alt="No Image Available">
									</div>
									<div class="col-sm-6 max-height second-level">
										<p class="book-title">제목 가져오는 중..</p>
										<p class="book-author">작가 가져오는 중..</p>
									</div>
								</div>
							</div>
						</div>
						<div class="row half-height">
							<div class="col-sm-6 max-height first-level">
								<div class="row max-height first-level book-content">
									<input type="hidden" name="isbn" value="0">
									<div class="col-sm-6 max-height second-level">
										<p class="book-title">제목 가져오는 중..</p>
										<p class="book-author">작가 가져오는 중..</p>
									</div>
									<div class="col-sm-6 max-height first-level">
										<img class="book-img" src="./resources/images/noimage.png" alt="No Image Available">
									</div>
								</div>
							</div>
							<div class="col-sm-6 max-height first-level">
								<div class="row max-height first-level book-content">
									<input type="hidden" name="isbn" value="0">
									<div class="col-sm-6 max-height second-level">
										<p class="book-title">제목 가져오는 중..</p>
										<p class="book-author">작가 가져오는 중..</p>
									</div>
									<div class="col-sm-6 max-height first-level">
										<img class="book-img" src="./resources/images/noimage.png" alt="No Image Available">
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="bestSeller" class="swiper-slide">
						<h4><em>Best Seller..</em></h4>
						<div class="row half-height">
							<div class="col-sm-6 max-height first-level">
								<div class="row max-height first-level book-content">
									<input type="hidden" name="isbn" value="0">
									<div class="col-sm-6 max-height first-level">
										<img class="book-img" src="./resources/images/noimage.png" alt="No Image Available">
									</div>
									<div class="col-sm-6 max-height second-level">
										<p class="book-title">제목 가져오는 중..</p>
										<p class="book-author">작가 가져오는 중..</p>
									</div>
								</div>
							</div>
							<div class="col-sm-6 max-height first-level">
								<div class="row max-height first-level book-content">
									<input type="hidden" name="isbn" value="0">
									<div class="col-sm-6 max-height first-level">
										<img class="book-img" src="./resources/images/noimage.png" alt="No Image Available">
									</div>
									<div class="col-sm-6 max-height second-level">
										<p class="book-title">제목 가져오는 중..</p>
										<p class="book-author">작가 가져오는 중..</p>
									</div>
								</div>
							</div>
						</div>
						<div class="row half-height">
							<div class="col-sm-6 max-height first-level">
								<div class="row max-height first-level book-content">
									<input type="hidden" name="isbn" value="0">
									<div class="col-sm-6 max-height second-level">
										<p class="book-title">제목 가져오는 중..</p>
										<p class="book-author">작가 가져오는 중..</p>
									</div>
									<div class="col-sm-6 max-height first-level">
										<img class="book-img" src="./resources/images/noimage.png" alt="No Image Available">
									</div>
								</div>
							</div>
							<div class="col-sm-6 max-height first-level">
								<div class="row max-height first-level book-content">
									<input type="hidden" name="isbn" value="0">
									<div class="col-sm-6 max-height second-level">
										<p class="book-title">제목 가져오는 중..</p>
										<p class="book-author">작가 가져오는 중..</p>
									</div>
									<div class="col-sm-6 max-height first-level">
										<img class="book-img" src="./resources/images/noimage.png" alt="No Image Available">
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="newBook" class="swiper-slide">
						<h4><em>Bloger's Select..</em></h4>
						<div class="row half-height">
							<div class="col-sm-6 max-height first-level">
								<div class="row max-height first-level book-content">
									<input type="hidden" name="isbn" value="0">
									<div class="col-sm-6 max-height first-level">
										<img class="book-img" src="./resources/images/noimage.png" alt="No Image Available">
									</div>
									<div class="col-sm-6 max-height second-level">
										<p class="book-title">제목 가져오는 중..</p>
										<p class="book-author">작가 가져오는 중..</p>
									</div>
								</div>
							</div>
							<div class="col-sm-6 max-height first-level">
								<div class="row max-height first-level book-content">
									<input type="hidden" name="isbn" value="0">
									<div class="col-sm-6 max-height first-level">
										<img class="book-img" src="./resources/images/noimage.png" alt="No Image Available">
									</div>
									<div class="col-sm-6 max-height second-level">
										<p class="book-title">제목 가져오는 중..</p>
										<p class="book-author">작가 가져오는 중..</p>
									</div>
								</div>
							</div>
						</div>
						<div class="row half-height">
							<div class="col-sm-6 max-height first-level">
								<div class="row max-height first-level book-content">
									<input type="hidden" name="isbn" value="0">
									<div class="col-sm-6 max-height second-level">
										<p class="book-title">제목 가져오는 중..</p>
										<p class="book-author">작가 가져오는 중..</p>
									</div>
									<div class="col-sm-6 max-height first-level">
										<img class="book-img" src="./resources/images/noimage.png" alt="No Image Available">
									</div>
								</div>
							</div>
							<div class="col-sm-6 max-height first-level">
								<div class="row max-height first-level book-content">
									<input type="hidden" name="isbn" value="0">
									<div class="col-sm-6 max-height second-level">
										<p class="book-title">제목 가져오는 중..</p>
										<p class="book-author">작가 가져오는 중..</p>
									</div>
									<div class="col-sm-6 max-height first-level">
										<img class="book-img" src="./resources/images/noimage.png" alt="No Image Available">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="swiper-pagination"></div>
			</div>
		
		</div>
	</div>
	
	
	
	
	<div class="category">
		<div class="list list-first">
			<div class="category-creation">
				<div class="display-middle">
					<span class="font-large theme-white padding-large wide">CREATION</span>
				</div>
			</div>
			<div class="container">
				얍얍1
			</div>
		</div>
		<div class="list list-second">
			<div class="category-community">
				<div class="display-middle">
					<span class="font-large theme-white padding-large wide">COMMUNITY</span>
				</div>
			</div>
			<div class="container">
				얍얍2
			</div>
		</div>
		<div class="list list-third">
			<div class="category-booklog">
				<div class="display-middle">
					<span class="font-large theme-white padding-large wide">BOOKLOG</span>
				</div>
			</div>
			<div class="container">
				얍얍3
			</div>
		</div>
	</div>

<!-- 	<div class="category category-swiper-container swiper-container">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<div class="category-creation" data-swiper-parallax-y="-100" >
					<div class="display-middle">
						<span class="font-large theme-white padding-large wide">CREATION</span>
					</div>
				</div>
				<div class="container">
					얍얍1
				</div>
			</div>
			<div class="swiper-slide">
				<div class="category-community">
					<div class="display-middle">
						<span class="font-large theme-white padding-large wide">COMMUNITY</span>
					</div>
				</div>
				<div class="container">
					얍얍2
				</div>
			</div>
			<div class="swiper-slide">
				<div class="category-booklog">
					<div class="display-middle">
						<span class="font-large theme-white padding-large wide">BOOKLOG</span>
					</div>
				</div>
				<div class="container">
					얍얍3
				</div>
			</div>
		</div>
	</div> -->


	<footer class="container-fluid">
		<jsp:include page="./layout/tailbar.jsp"/>
	</footer>
	
</body>
</html>