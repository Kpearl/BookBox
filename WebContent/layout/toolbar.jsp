<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="shortcut icon" href="${param.uri}resources/images/icon.png">
<link rel="icon" href="${param.uri}resources/images/icon.png">

<title>BookBox</title>

<script type="text/javascript">

//============= 창작공간 Navigation Event  처리 =============	
$(function() {
	$("a.nav-creation").on("click" , function() {
		$(self.location).attr("href","${param.uri}creation/getCreationMain");
		//self.location = "/user/logout"
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
		$(self.location).attr("href","${param.uri}booklog/getBooklog?user.email=admin");
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
  	$("a.navigation-home").on("click" , function() {
 		$(self.location).attr("href","${param.uri}index.jsp");
	}); 

// JJ : Search Button View
//============= 검색버튼 Event  처리 =============
	$("a.navigation-search").on("click" , function() {
		$(this).fadeOut(100);
		$(this).fadeIn(function() { 
			$(this).replaceWith('<select id="keyField">' +
								'<option value="unifiedsearch">통합검색</option>' +
								'<option value="book">도서</option>' +
								'<option value="creation">창작공간</option>' +
								'<option value="community">소모임</option>' +
								'<option value="posting">포스팅</option></select>' + 
								'<input type="text" placeholder="검색어 입력" id="keyWord">' +
								'<button class="icon-large icon-search" onclick="searhCheck();"></button>'); 
		});
	});
	
});
	  
//JJ : Search Exception & Navigation
//============= Search Option Event 처리 =============	
  
function searhCheck(){
	var keyword = document.getElementById("keyWord").value;
	
	if(keyword == '') {  
		alert('검색어를 입력하세요');
	} else {
		var select = document.getElementById("keyField");
		var option_value = select.options[select.selectedIndex].value;
		 
		switch (option_value){	  
			case "unifiedsearch" : $(self.location).attr("href","${param.uri}unifiedsearch/getUnifiedsearchList?keyword="+keyword); break; 
			case "book" : $(self.location).attr("href","${param.uri}unifiedsearch/getBookList?keyword="+keyword); break;
			case "creation" : $(self.location).attr("href","${param.uri}unifiedsearch/getCreationList?keyword="+keyword); break;
			case "community" : $(self.location).attr("href","${param.uri}unifiedsearch/getCommunityList?keyword="+keyword); break;
			case "posting" : $(self.location).attr("href","${param.uri}unifiedsearch/getPostingList?keyword="+keyword); break; 
		}
	}
}
</script>

<section class="blank">
	<nav class="navigation">
		<ul>
			<li>
				<a href="#" class="focus navigation-home">
					<i class="icon-large icon-home"></i>
				</a>
			</li>
			<li><a class="nav-creation" href="#">창작공간</a></li>
			<li><a class="nav-community" href="#">소모임</a></li>
			<li><a class="nav-booklog" href="#">북로그</a></li>
			<li><a class="nav-notice" href="#">공지사항</a></li>
			<li class="lefty">
				<a class="navigation-settings navigation-search"> 
					<i class="icon-large icon-search"></i>
				</a>
			</li>

			<c:if test="${!empty sessionScope.user}">
				<li class="lefty dropdown">
					<a href="#" id="drop3" data-toggle="dropdown"> 
						<i class="icon-large icon-th-list"></i>
					</a>
					<ul class="dropdown-menu" aria-labelledby="drop3">
						<li><a class="nav-booklog-my" href="#">내 북로그보기</a></li>
						<li><a class="nav-subscribe" href="#">구독한글보기</a></li>
						<li><a class="nav-booklike" href="#">좋아요책목록보기</a></li>
						<li><a class="nav-bookmark" href="#">책갈피목록보기</a></li>
						<c:if test="${sessionScope.user.role == 'admin'}">
							<li><a class="nav-userlist" href="#">회원목록조회</a></li>
						</c:if>
						<li><a class="nav-userinfo" href="#">내 정보조회</a></li>
					</ul>
				</li>
			</c:if>
	
			<c:choose>
				<c:when test="${empty sessionScope.user}">
					<li class="lefty"><a class="nav-signin" href="#">회원가입</a></li>
					<li class="lefty"><a class="nav-login" href="#">로그인</a></li>
				</c:when>
				<c:otherwise>	
					<li class="lefty"><a class="nav-logout" href="#">로그아웃</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
		
		
		<br class="clear">
	</nav>
</section>

