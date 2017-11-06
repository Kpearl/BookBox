<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

$(function() {
//============= 창작공간 Navigation Event  처리 =============	
	$("a.nav-creation").on("click" , function() {
		$(self.location).attr("href","${param.uri}creation/getCreationMain");
	}); 

//============= 소모임 Navigation Event  처리 =============	
 	$("a.nav-community").on("click" , function() {
		$(self.location).attr("href","${param.uri}community/getCommunityMain");
	}); 	

//============= 북로그 Navigation Event  처리 =============	
 	$("a.nav-booklog").on("click" , function() {
		$(self.location).attr("href","${param.uri}booklog/getBooklogMain?condition=main");
	}); 	
 
//============= 공지사항 Navigation Event  처리 =============	
 	$("a.nav-notice").on("click" , function() {
		$(self.location).attr("href","${param.uri}booklog/getBooklog?booklogNo=11");
	}); 	

//============= 회원가입 Event  처리 =============	
 	$("a.nav-signin").on("click" , function() {
		$(self.location).attr("href","${param.uri}user/addUser");
	}); 
 
//============= 로그인 Event  처리 =============	
 	$("a.nav-login").on("click" , function() {
		$(self.location).attr("href","${param.uri}user/login");
	}); 
 
//============= 로그아웃 Event  처리 =============	
	$("a.nav-logout").on("click" , function() {
		$(self.location).attr("href","${param.uri}user/logout");
		//self.location = "/user/logout"
	}); 
		
//============= 내정보조회 Event  처리 =============	
  	$("a.nav-userinfo").on("click" , function() {
 		$(self.location).attr("href","${param.uri}user/getUser?email=${sessionScope.user.email}");
	}); 

//============= 내북로그보기 Event  처리 =============	
  	$("a.nav-booklog-my").on("click" , function() {
 		$(self.location).attr("href","${param.uri}booklog/getBooklog?user.email=${sessionScope.user.email}");
	}); 
  
//============= 구독한 글보기 Event  처리 =============	
  	$("a.nav-subscribe").on("click" , function() {
 		$(self.location).attr("href","${param.uri}creation/getCreation?email=${sessionScope.user.email}&subscribe");
	}); 
  
//============= 좋아요 책목록 보기 Event  처리 =============	
  	$("a.nav-booklike").on("click" , function() {
 		$(self.location).attr("href","${param.uri}booklog/getBookLikeList?email=${sessionScope.user.email}");
	}); 

//============= 책갈피 목록보기 Event  처리 =============	
  	$("a.nav-bookmark").on("click" , function() {
 		$(self.location).attr("href","${param.uri}booklog/getBooklogList?condition=bookmark&keyword=${sessionScope.user.email}");
	}); 
  
//============= 회원목록조회 Event  처리 =============	
  	$("a.nav-userlist").on("click" , function() {
 		$(self.location).attr("href","${param.uri}user/getUserList");
	}); 
  
//============= 홈버튼 Event  처리 =============	
  	$("a.nav-home").on("click" , function() {
 		$(self.location).attr("href","${param.uri}");
	}); 

//============= 네비게이션 open/close =============
	$('.openbtn').on('mouseup', function(){
		$(".sidenav").css('width', "250px");
		$('.navbtn').addClass('sr-only');
		$(document).on('mousedown', function(event){
			var target = event.target.className;
			if(target.indexOf('bookbox-nav') == -1){
				$('.sidenav').css('width', '0');
				$('.navbtn').removeClass('sr-only');
				$(this).off('mousedown');
			}
		})
	});
	
	$('.findbtn').on('mouseup', function(){
		$('.searchnav').css('transform', 'translate(-300px, 0)');
		$('.searchbtn').addClass('sr-only');
		$(document).on('mousedown', function(event){
			var target = event.target.className;
			if(target.indexOf('bookbox-search') == -1){
				$('.searchnav').css('transform', 'translate(0, 0)');
				$('.searchbtn').removeClass('sr-only');
				$(this).off('mousedown');
			}
		});
	});

// JJ : Search Button View
//============= 검색버튼 Event  처리 =============
	$("button.nav-search").on("click" , function() {
		searchCheck();
	});
	
	$('a.navigation-search').on('click', function(){
		if($('li.nav-search.sr-only').length == 1){
			$('li.nav-search.sr-only').removeClass('sr-only');
			$('li.nav-default').addClass('sr-only');
		}else{
			$('li.nav-default.sr-only').removeClass('sr-only');
			$('li.nav-search').addClass('sr-only');
		}
	});
	
	//검색창 Enter 키 이벤트 설정
	$('input.nav-search-keyword').on('keydown', function(event){
		if(event.which == 13){
			event.preventDefault();
			searchCheck();
		}
	});
	
});
	  
//JJ : Search Exception & Navigation
//============= Search Option Event 처리 =============	
  
function searchCheck(){
	var keyword = document.getElementById("keyWord").value;
	
	if(keyword == '') {  
		alert('검색어를 입력하세요');
	} else {
		var select = document.getElementById("keyField");
		var option_value = select.options[select.selectedIndex].value;
		 
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

<style>
	.sidenav{
		height: 100%;
		width: 0;
		position: fixed;
		z-index: 100;
		top: 0;
		left: 0;
		background-color: rgba(72, 65, 65, 0.65);
		overflow-x: hidden;
		-webkit-border-radius: 0 7px 7px 0;
		   -moz-border-radius: 0 7px 7px 0;
				border-radius: 0 7px 7px 0;
		-webkit-transition: 0.5s;
		   -moz-transition: 0.5s;
				transition: 0.5s;
		-webkit-transform: translate(0, 70px);
		   -moz-transform: translate(0, 70px);
				transform: translate(0, 70px);
	}
	
	.sidenav a{
		padding: 8px 8px 8px 32px;
		text-decoration: none;
		font-size: 16px;
		color: #ffffff;
		display: block;
		-webkit-transition: 0.3s;
		   -moz-transition: 0.3s;
				transition: 0.3s;
	}
	
	.searchnav a{
		text-decoration: none;
		font-size: 16px;
		color: #ffffff;
		display: block;
		-webkit-transition: 0.3s;
		   -moz-transition: 0.3s;
				transition: 0.3s;
	}
	
	.sidenav a:hover, .offcanvas a:focus{
		color: #f1f1f1;
	}
	
	.sidenav .nav-home{
		position: absolute;
		top: 0;
		left: 0;
		font-size: 28px;
		width: 190px;
	}
	
	 .searchnav .input-group{
	 	position: absolute;
	 	top: 50%;
	 	left: 0;
	 	width: 240px;
	 	-webkit-transform: translate(0, -50%);
	 	   -moz-transform: translate(0, -50%);
			 	transform: translate(0, -50%);
	 }
	
	.homebtn{
		position: fixed;
		top: 10px;
		z-index: 50;
		left: 0;
		height: 50px;
		width: 60px;
		font-size: 20px;
		-webkit-transition: 0.5s;
		   -moz-transition: 0.5s;
				transition: 0.5s;
		overflow: hidden;
	}
	
	.homebtn a{
		position: absolute;
		top: 50%;
		left: 50%;
		width: 60px;
		text-decoration: none;
		font-size: 28px;
		color: black;
		background-color: rgba(255, 255, 255, 0);
		cursor: pointer;
		-webkit-border-radius: 0 5px 5px 0;
		   -moz-border-radius: 0 5px 5px 0;
				border-radius: 0 5px 5px 0;
		-webkit-transition: 0.3s;
		   -moz-transition: 0.3s;
				transition: 0.3s;
		-webkit-transform: translate(-50%, -50%);
		   -moz-transform: translate(-50%, -50%);
				transform: translate(-50%, -50%);
	}

	.navbtn{
		position: fixed;
		top: 70px;
		z-index: 50;
		left: 0;
		height: 50px;
		width: 40px;
		font-size: 20px;
		-webkit-transition: 0.5s;
		   -moz-transition: 0.5s;
				transition: 0.5s;
	}
	
	.navbtn span{
		position: absolute;
		left: 0;
		padding: 5px;
		width: 60px;
		text-decoration: none;
		font-size: 20px;
		color: white;
		background-color: rgba(206, 163, 121, 0.47);
		cursor: pointer;
		-webkit-border-radius: 0 5px 5px 0;
		   -moz-border-radius: 0 5px 5px 0;
				border-radius: 0 5px 5px 0;
		-webkit-transition: 0.3s;
		   -moz-transition: 0.3s;
				transition: 0.3s;
	}

	.searchnav{
		height: 50px;
		width: 300px;
		position: fixed;
		z-index: 100;
		top: 65px;
		left: 100%;
		background-color: rgba(72, 65, 65, 0.65);
		padding-top: 60px;
		-webkit-border-radius: 7px 0 0 7px;
		   -moz-border-radius: 7px 0 0 7px;
				border-radius: 7px 0 0 7px;
		-webkit-transition: 0.5s;
		   -moz-transition: 0.5s;
				transition: 0.5s;
	}
	
	.searchnav form a{
		padding: 8px 8px 8px 32px;
		text-decoration: none;
		font-size: 16px;
		color: #000000;
		display: block;
		-webkit-transition: 0.3s;
		   -moz-transition: 0.3s;
				transition: 0.3s;
	}
	
	.searchbtn{
		position: fixed;
		top: 70px;
		z-index: 50;
		left: 100%;
		height: 50px;
		width: 40px;
		font-size: 20px;
		-webkit-transition: 0.5s;
		   -moz-transition: 0.5s;
				transition: 0.5s;
	}
	
	.searchbtn span{
		position: absolute;
		left: -60px;
		padding: 5px;
		width: 60px;
		text-decoration: none;
		font-size: 20px;
		color: white;
		background-color: rgba(206, 163, 121, 0.47);
		cursor: pointer;
		-webkit-border-radius: 5px 0 0 5px;
		   -moz-border-radius: 5px 0 0 5px;
				border-radius: 5px 0 0 5px;
		-webkit-transition: 0.3s;
		   -moz-transition: 0.3s;
				transition: 0.3s;
	}
	
	select.search-form{
		position: absolute;
		top: 50%;
		left: 0;
		width: 80px;
		display: inline-block;
		background-color: rgba(72, 65, 65, 0);
		margin-left: 5px;
		color: #ffffff;
		font-size: 14px;
		height: 16px;
		-webkit-box-shadow: none;
				box-shadow: none;
		-webkit-transform: translate(0, -50%);
		   -moz-transform: translate(0, -50%);
				transform: translate(0, -50%);
	}
	
	select.search-form option{
		color: #000000;
	}
	
	input.search-form{
		position: absolute;
		top: 50%;
		left: 80px;
		width: 150px;
		display: inline-block;
		background-color: rgba(72, 65, 65, 0);
		margin-left: 5px;
		font-size: 16px;
		height: 22px;
		color: #ffffff;
		-webkit-transform: translate(0, -50%);
		   -moz-transform: translate(0, -50%);
				transform: translate(0, -50%);
	}
	
	.input-group-btn .nav-search{
		position: absolute;
		top: 50%;
		left: 15px;
		padding: 0;
		-webkit-transform: translate(0, -50%);
		   -moz-transform: translate(0, -50%);
				transform: translate(0, -50%);
	}
	
</style>

<div id="homebtn" class="homebtn text-center">
    <a class="nav-home" href="javascript:void(0)"><i class="glyphicon glyphicon-book"></i></a>
</div>

<div id="sidenav" class="sidenav bookbox-nav">

<c:if test="${!empty sessionScope.user}">
	<li class="dropdown nav-default bookbox-nav"><a class="dropdown-toggle bookbox-nav" data-toggle="dropdown" aria-expanded="false" href="javascript:void(0)">${sessionScope.user.nickname} <span class="caret"></span></a>
		<ul class="dropdown-menu bookbox-nav" role="menu">
			<li role="presentation"><a class="nav-booklog-my bookbox-nav" href="javascript:void(0)">내 북로그보기</a></li>
			<li role="presentation"><a class="nav-subscribe bookbox-nav" href="javascript:void(0)">구독한글보기</a></li>
			<li role="presentation"><a class="nav-booklike bookbox-nav" href="javascript:void(0)">좋아요책목록보기</a></li>
			<li role="presentation"><a class="nav-bookmark bookbox-nav" href="javascript:void(0)">책갈피목록보기</a></li>
		<c:if test="${sessionScope.user.role == 'admin'}">
			<li role="presentation"><a class="nav-userlist bookbox-nav" href="javascript:void(0)">회원목록조회</a></li>
		</c:if>
			<li role="presentation"><a class="nav-userinfo bookbox-nav" href="javascript:void(0)">내 정보조회</a></li>
		</ul>
	</li>
</c:if>
<c:choose>
	<c:when test="${empty sessionScope.user}">
		<a class="nav-login bookbox-nav" href="javascript:void(0)">로그인 </a>
		<a class="nav-signin bookbox-nav" href="javascript:void(0)">회원가입 </a>
	</c:when>
	<c:otherwise>
		<a class="nav-logout bookbox-nav" href="javascript:void(0)">로그아웃</a>
	</c:otherwise>
</c:choose>

	<hr/>

	<a class="nav-creation bookbox-nav" href="javascript:void(0)">창작공간 </a>
	<a class="nav-community bookbox-nav" href="javascript:void(0)">소모임 </a>
	<a class="nav-booklog bookbox-nav" href="javascript:void(0)">북로그</a>
	<a class="nav-notice bookbox-nav" href="javascript:void(0)">공지사항</a>
	        
</div>

<div id="navbtn" class="navbtn text-center bookbox-nav">
	<span class="openbtn bookbox-nav"><img src="https://icongr.am/octicons/three-bars.svg?size=40"></span>
</div>

<div id="searchnav" class="searchnav bookbox-search">
	<div class="input-group bookbox-search">
		<select id="keyField" class="search-form bookbox-search">
			<option value="unifiedsearch" class="bookbox-search">통합검색</option>
			<option value="book" class="bookbox-search">도서</option>
			<option value="creation" class="bookbox-search">창작공간</option>
			<option value="community" class="bookbox-search">소모임</option>
			<option value="posting" class="bookbox-search">포스팅</option>
			<option value="tag" class="bookbox-search">태그</option>
		</select>
		<input type="text" class="search-form nav-search-keyword bookbox-search" id="keyWord" placeholder="검색어 입력">
		<span class="input-group-btn bookbox-search">
			<a href="javascript:void(0)" class="btn nav-search bookbox-search" type="button"><img src="https://icongr.am/octicons/search.svg?size=32&color=ffffff"></a>
		</span>
	</div>
</div>

<div id="searchbtn" class="searchbtn text-center bookbox-search">
	<span class="findbtn bookbox-search"><img src="https://icongr.am/octicons/search.svg?size=40"></span>
</div>

