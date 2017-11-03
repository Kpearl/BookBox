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
  	$("a.navigation-home").on("click" , function() {
 		$(self.location).attr("href","${param.uri}");
	}); 

// JJ : Search Button View
//============= 검색버튼 Event  처리 =============
	$("a.nav-search").on("click" , function() {
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


<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header"><a class="navbar-brand navbar-link navigation-home" href="#"><i class="glyphicon glyphicon-book"></i><span class="text-title">Bookbox </span></a>
            <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navcol-1"><span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
        </div>
        <div class="collapse navbar-collapse" id="navcol-1">
        	<!-- sm용 dropdown menu -->
            <ul class="nav navbar-nav navbar-left hidden-xs hidden-md hidden-lg">
	            <li class="dropdown nav-default"><a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false" href="#">More.. <span class="caret"></span></a>
	                <ul class="dropdown-menu" role="menu">
		                <li role="presentation"><a class="nav-creation" href="#">창작공간 </a></li>
		                <li role="presentation"><a class="nav-community" href="#">소모임 </a></li>
		                <li role="presentation"><a class="nav-booklog" href="#">북로그</a></li>
		                <li role="presentation"><a class="nav-notice" href="#">공지사항</a></li>
	                </ul>
	            </li>
	        </ul>
	        
            <ul class="nav navbar-nav navbar-left hidden-sm">
                <li role="presentation"><a class="nav-creation" href="#">창작공간 </a></li>
                <li role="presentation"><a class="nav-community" href="#">소모임 </a></li>
                <li role="presentation"><a class="nav-booklog" href="#">북로그</a></li>
                <li role="presentation"><a class="nav-notice" href="#">공지사항</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
            <c:choose>
            	<c:when test="${empty sessionScope.user}">
	                <li class="nav-default" role="presentation"><a class="nav-login" href="#">로그인 </a></li>
	                <li class="nav-default" role="presentation"><a class="nav-signin" href="#">회원가입 </a></li>
                </c:when>
                <c:otherwise>
   	                <li class="nav-default" role="presentation"><a class="nav-logout" href="#">로그아웃</a></li>
                </c:otherwise>
            </c:choose>
            <c:if test="${!empty sessionScope.user}">
                <li class="dropdown nav-default"><a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false" href="#">${sessionScope.user.nickname} <span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li role="presentation"><a class="nav-booklog-my" href="#">내 북로그보기</a></li>
                        <li role="presentation"><a class="nav-subscribe" href="#">구독한글보기</a></li>
                        <li role="presentation"><a class="nav-booklike" href="#">좋아요책목록보기</a></li>
                        <li role="presentation"><a class="nav-bookmark" href="#">책갈피목록보기</a></li>
					<c:if test="${sessionScope.user.role == 'admin'}">
                        <li role="presentation"><a class="nav-userlist" href="#">회원목록조회</a></li>
                    </c:if>
                        <li role="presentation"><a class="nav-userinfo" href="#">내 정보조회</a></li>
                    </ul>
                </li>
			</c:if>
				<li class="sr-only nav-search" role="presentation">
					<form class="navbar-form navbar-left" role="search">
						<div class="form-group">
						    <select id="keyField" class="form-control">
						        <option value="unifiedsearch">통합검색</option>
						        <option value="book">도서</option>
						        <option value="creation">창작공간</option>
						        <option value="community">소모임</option>
						        <option value="posting">포스팅</option>
						        <option value="tag">태그</option>
						    </select>
							<input type="text" class="form-control nav-search-keyword" id="keyWord" placeholder="검색어 입력">
						</div>
						<a href="#" class="btn btn-default nav-search">검색</a>
					</form>
				</li>
                <li role="presentation">
                    <a class="navigation-search" href="#"><i class="glyphicon glyphicon-search"></i></a>
                </li>
            </ul>
        </div>
    </div>
</nav>
