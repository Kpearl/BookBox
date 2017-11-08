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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.3/css/swiper.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.3/css/swiper.min.css">
	 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.3/js/swiper.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.3/js/swiper.min.js"></script>
	
	<style>
		body{
			padding-top: 0;
		}
		header{
			background-image: url('./resources/images/test2.jpeg');
			min-height: 100%;
		    opacity: 0.75;
		}
		#main-search{
			height: 800px;
			padding: 40px;
		}
		#main-search .input-group *{
			margin: 0;
		}
		#main-search input{
			border: 1px solid #ccc;
			padding: 0 7px;
		}
		#main-search input:focus{
			border: 1px solid #66afe9;
			box-shadow: 0 0.5px 0.5px 0.1px #66afe9;
		}
		.category{
			min-height: 100%;
		}
		.category .list{
			position: relative;
		}
		.category-creation{
			background-image: url('./resources/images/creation.jpeg');
			height: 400px;
		    opacity: 0.75;
		}
		.category-community{
			background-image: url('./resources/images/community.jpeg');
			height: 400px;
		    opacity: 0.75;
		}
		.category-booklog{
			background-image: url('./resources/images/posting.jpeg');
			height: 400px;
		    opacity: 0.75;
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
			letter-spacing: 10px;
		}
	</style>
	
	<script>
		//Toolbar 투명도 설정
		ToolbarOpacHeight($(window).height());
		//Window Resize시 Toolbar 투명도, Parallax background-position 재설정
		$(window).resize(function(){
			ToolbarOpacHeight($(window).height());
			$('.category-community').css('background-position-x', $(window).width());
			$('.category-booklog').css('background-position-x', $(window).width() * 2);
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
			
			//Parallax 배경 위치 조절
			$('.category-community').css('background-position-x', $(window).width());
			$('.category-booklog').css('background-position-x', $(window).width() * 2);

			//스와이퍼 초기화
			var swiper = new Swiper('.swiper-container', {
				speed: 400
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
					case "none" : alert('분류를 선택해주세요..'); break;
				}
			}
		}
	</script>
</head>
<body>

	<jsp:include page="./layout/toolbar.jsp"/>
	<header class="parallax">
		<div id="main-bookbox" class="display-middle" style="cursor: pointer; white-space: nowrap; display:block;">
			<span class="font-large theme-black padding-large wide">BOOKBOX<small class="hidden-xs hidden-sm"> Book Community</small></span><br/>
			<p class="font-large theme-black wide text-center"><small class="hidden-xs hidden-sm"><em class="text-muted font-small">- 책으로 소통하는 공간</em></small></p>
		</div>
	</header>
	
	<div id="main-search" class="container bookbox-relative">
		<div class="row bookbox-relative">
			<div class="col-sm-offset-3 col-sm-6">
				<div class="input-group">
					<div class="input-group-btn">
						<button type="button" class="btn btn-default selected-menu" aria-expanded="none" style="width: 80px;">선택</button>
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><span class="caret"></span></button>
						<ul class="dropdown-menu" role="menu">
							<li><a href="javascript:void(0);" class="unifiedsearch">통합검색</a>
							<li><a href="javascript:void(0);" class="bookr">도서</a>
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
	
	<div class="category swiper-container">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<div class="list list-first">
					<div class="category-creation parallax">
						<div class="display-middle">
							<span class="font-large theme-white padding-large wide">CREATION</span>
						</div>
					</div>
					<div class="container">
						얍얍1
					</div>
				</div>
			</div>
			<div class="swiper-slide">
				<div class="list list-second">
					<div class="category-community parallax">
						<div class="display-middle">
							<span class="font-large theme-white padding-large wide">COMMUNITY</span>
						</div>
					</div>
					<div class="container">
						얍얍2
					</div>
				</div>
			</div>
			<div class="swiper-slide">
				<div class="list list-third">
					<div class="category-booklog parallax">
						<div class="display-middle">
							<span class="font-large theme-white padding-large wide">BOOKLOG</span>
						</div>
					</div>
					<div class="container">
						얍얍3
					</div>
				</div>
			</div>
		</div>
	</div>

	<footer class="container-fluid">
		<jsp:include page="./layout/tailbar.jsp"/>
	</footer>
	
</body>
</html>