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
  	$("div.homebtn").on("click" , function() {
 		$(self.location).attr("href","${param.uri}");
	}); 

//============= 네비게이션 open/close =============

	$('.openbtn').on('mouseup', function(){
		$('.side-nav').css('width', '230px');
		$(document).on('mousedown', function(event){
			var target = event.target.className;
			if(target.indexOf('bookbox-nav-menu') == -1 || target.indexOf('openbtn') > -1){
				$('.side-nav').css('width', '0');
				$(this).off('mousedown');
			}
		})
	});
	
	$('.findbtn').on('mouseup', function(){
		$('div.bookbox-search.search-form-group').css('width', '217px');
		$('select.search-form').css('width', '72px');
		$('input.search-form').css('width', '138px');
		$(this).on('mousedown', function(){
			searchCheck();
		});
		$(document).on('mousedown', function(event){
			var target = event.target.className;
			if(target.indexOf('bookbox-search') == -1){
				$('input.search-form').css('width', '0');
				$('select.search-form').css('width', '0');
				$('div.bookbox-search.search-form-group').css('width', '0');
				$(this).off('mousedown');
				$('.findbtn').off('mousedown');
			}
		});
	});

//============= 상단 컨텐츠 Navigation =============
	$('.content-title').on('click', function(){
		var content = $(this).find('input:hidden');
		var contentName = $(content).attr('name');
		if(contentName == 'booklogNo'){
			$(self.location).attr('href', '${param.uri}booklog/getBooklog?booklogNo='+$(content).val());
		}else if(contentName == 'user.email'){
			$(self.location).attr('href', '${param.uri}booklog/getBooklog?user.email='+$(content).val());
		}else if(contentName == 'creationNo'){
			$(self.location).attr('href', '${param.uri}creation/getWritingList?creationNo='+$(content).val());
		}
	});


	
// JJ : Search Button View
//============= 검색버튼 Event  처리 =============
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

<div class="bookbox-navigation">
	<div class="navbtn-group">
		<div class="navbtn text-center">
			<span class="openbtn"><img class="bookbox-nav-menu" src="https://icongr.am/octicons/three-bars.svg?size=32&color=727272"></span>
		</div>
		<div class="homebtn text-center">
		    <span class="nav-home"><img class="bookbox-nav-menu" src="https://icongr.am/octicons/book.svg?size=40&color=727272"></span>
		    <span class="bookbox-brand hidden-xs hidden-sm">BOOKBOX</span>
		</div>
	</div>
	<div class="content-title hidden-xs">
	<c:if test="${!empty posting}">
		<input type="hidden" name="user.email" value="${posting.user.email}">
		<img src="${param.uri}resources/upload_files/images/${posting.user.booklogImage}" class="img-circle" alt="No Image">
		<span>${posting.user.nickname}</span>
	</c:if>
	<c:if test="${!empty booklog}">
		<input type="hidden" name="booklogNo" value="${booklog.booklogNo}">
		<img src="${param.uri}resources/upload_files/images/${booklog.booklogImage}" class="img-circle" alt="No Image">
		<span>${booklog.user.nickname}</span>
	</c:if>
	<c:if test="${!empty creation}">
		<input type="hidden" name="creationNo" value="${creation.creationNo}">
		<img src="${param.uri}resources/upload_files/images/${creation.creationFileName}" class="img-circle" alt="No Image">
		<span>${creation.creationTitle}</span>
	</c:if>
	<c:if test="${!empty funding}">
		<input type="hidden" name="creationNo" value="${funding.creation.creationNo}">
		<img src="${param.uri}resources/upload_files/images/${funding.creation.creationFileName}" class="img-circle" alt="No Image">
		<span>${funding.creation.creationTitle}</span>
	</c:if>
	</div>
	<div class="search-group">
		<div class="bookbox-search search-form-group">
			<select id="keyField" class="bookbox-search search-form">
				<option value="unifiedsearch" class="bookbox-search">통합검색</option>
				<option value="book" class="bookbox-search">도서</option>
				<option value="creation" class="bookbox-search">창작공간</option>
				<option value="community" class="bookbox-search">소모임</option>
				<option value="posting" class="bookbox-search">포스팅</option>
				<option value="tag" class="bookbox-search">태그</option>
			</select>
			<input type="text" class="bookbox-search search-form nav-search-keyword" id="keyWord" placeholder="검색어 입력">
		</div>
		<div class="bookbox-search searchbtn text-center">
			<span class="findbtn"><img class="bookbox-search" src="https://icongr.am/octicons/search.svg?size=26&color=727272"></span>
		</div>
	</div>
</div>

<div class="bookbox-nav-menu side-nav">
	<div class="bookbox-nav-menu side-nav-menu">
	<c:if test="${!empty sessionScope.user}">
		<li class="dropdown nav-default bookbox-nav-menu"><a class="dropdown-toggle bookbox-nav-menu" data-toggle="dropdown" aria-expanded="false" href="javascript:void(0)">${sessionScope.user.nickname} <span class="caret bookbox-nav-menu"></span></a>
			<ul class="dropdown-menu bookbox-nav-menu" role="menu">
				<li role="presentation"><a class="nav-booklog-my bookbox-nav-menu" href="javascript:void(0)">내 북로그보기</a></li>
				<li role="presentation"><a class="nav-subscribe bookbox-nav-menu" href="javascript:void(0)">구독한글보기</a></li>
				<li role="presentation"><a class="nav-booklike bookbox-nav-menu" href="javascript:void(0)">좋아요책목록보기</a></li>
				<li role="presentation"><a class="nav-bookmark bookbox-nav-menu" href="javascript:void(0)">책갈피목록보기</a></li>
			<c:if test="${sessionScope.user.role == 'admin'}">
				<li role="presentation"><a class="nav-userlist bookbox-nav-menu" href="javascript:void(0)">회원목록조회</a></li>
			</c:if>
				<li role="presentation"><a class="nav-userinfo bookbox-nav-menu" href="javascript:void(0)">내 정보조회</a></li>
			</ul>
		</li>
	</c:if>
	<c:choose>
		<c:when test="${empty sessionScope.user}">
			<a class="nav-login bookbox-nav-menu" href="javascript:void(0)">로그인 </a>
			<a class="nav-signin bookbox-nav-menu" href="javascript:void(0)">회원가입 </a>
		</c:when>
		<c:otherwise>
			<a class="nav-logout bookbox-nav-menu" href="javascript:void(0)">로그아웃</a>
		</c:otherwise>
	</c:choose>
	
		<hr/>
	
		<a class="nav-creation bookbox-nav-menu" href="javascript:void(0)">창작공간 </a>
		<a class="nav-community bookbox-nav-menu" href="javascript:void(0)">소모임 </a>
		<a class="nav-booklog bookbox-nav-menu" href="javascript:void(0)">북로그</a>
		<a class="nav-notice bookbox-nav-menu" href="javascript:void(0)">공지사항</a>
	</div>
</div>
