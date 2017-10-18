<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="shortcut icon" href="${param.uri}resources/images/icon.png">
<link rel="icon" href="${param.uri}resources/images/icon.png">

<title>BookBox</title>

<script type="text/javascript">

//============= 창작공간 Navigation Event  처리 =============	
$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	$("a:contains('창작공간')").on("click" , function() {
		$(self.location).attr("href","${param.uri}creation/getCreationMain");
		//self.location = "/user/logout"
	}); 
});


//============= 소모임 Navigation Event  처리 =============	
$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
 	$("a:contains('소모임')").on("click" , function() {
		$(self.location).attr("href","${param.uri}community/getCommunityMain");
			}); 	
 });

//============= 북로그 Navigation Event  처리 =============	
$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
 	$("a:contains('북로그')").on("click" , function() {
		$(self.location).attr("href","${param.uri}booklog/getBooklogMain");
			}); 	
 });
 
//============= 공지사항 Navigation Event  처리 =============	
$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
 	$("a:contains('공지사항')").on("click" , function() {
		$(self.location).attr("href","${param.uri}booklog/getBooklog?email=admin");
			}); 	
 });

//============= 회원가입 Event  처리 =============	
$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
 	$("a:contains('회원가입')").on("click" , function() {
		$(self.location).attr("href","addUser");
		}); 
 });
 
//============= 로그인 Event  처리 =============	
$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
 	$("a:contains('로그인')").on("click" , function() {
		$(self.location).attr("href","login");
		}); 
 });
 
//============= 로그아웃 Event  처리 =============	
 $(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
 	$("a:contains('로그아웃')").on("click" , function() {
		$(self.location).attr("href","logout");
		//self.location = "/user/logout"
	}); 
 });
		
		
//============= 내정보조회 Event  처리 =============	
 $(function() {
 	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
  	$("a:contains('내 정보조회')").on("click" , function() {
 		$(self.location).attr("href","${param.uri}user/getUser?email=${sessionScope.user.email}");
 		}); 
  });


//============= 내북로그보기 Event  처리 =============	
 $(function() {
 	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
  	$("a:contains('내 북로그보기')").on("click" , function() {
 		$(self.location).attr("href","${param.uri}booklog/getBooklog?email=${sessionScope.user.email}");
 		}); 
  });
  
//============= 구독한 글보기 Event  처리 =============	
 $(function() {
 	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
  	$("a:contains('구독한 글보기')").on("click" , function() {
 		$(self.location).attr("href","${param.uri}creation/getCreation?email=${sessionScope.user.email}&subscribe");
 		}); 
  });
  
//============= 좋아요 책목록 보기 Event  처리 =============	
 $(function() {
 	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
  	$("a:contains('좋아요 책목록 보기')").on("click" , function() {
 		$(self.location).attr("href","${param.uri}booklog/getBookLikeList?email=${sessionScope.user.email}");
 		}); 
  });

//============= 책갈피 목록보기 Event  처리 =============	
 $(function() {
 	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
  	$("a:contains('책갈피 목록보기')").on("click" , function() {
 		$(self.location).attr("href","${param.uri}booklog/getBooklogList?email=${sessionScope.user.email}");
 		}); 
  });
  
//============= 회원목록조회 Event  처리 =============	
 $(function() {
 	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
  	$("a:contains('회원목록조회')").on("click" , function() {
 		$(self.location).attr("href","getUserList");
 		}); 
  });
  
//============= 홈버튼 Event  처리 =============	
 $(function() {
 	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
  	$("a.navigation-home").on("click" , function() {
 		$(self.location).attr("href","${param.uri}index.jsp");
 		}); 
  });



</script>


<section class="blank">
	<nav class="navigation">
		<ul>
			<li>
				<a href="#" class="focus navigation-home">
					<i class="icon-large icon-home"></i>
				</a>
			</li>
			<li><a href="#">창작공간</a></li>
			<li><a href="#">소모임</a></li>
			<li><a href="#">북로그</a></li>
			<li><a href="#">공지사항</a></li>
			<li class="lefty">
				<a href="#" class="navigation-settings"> 
			<i class="icon-large icon-search"></i>
				</a>
			</li>

			<li class="lefty dropdown"><a href="#" id="drop3"
				data-toggle="dropdown"> <i class="icon-large icon-th-list"></i>
			</a>

				<ul class="dropdown-menu" aria-labelledby="drop3">
					<li><a href="#">내 북로그보기</a></li>
					<li><a href="#">구독한글보기</a></li>
					<li><a href="#">좋아요책목록보기</a></li>
					<li><a href="#">책갈피목록보기</a></li>
				
				<c:if test="${sessionScope.user.role == 'admin'}">
					<li><a href="#">회원목록조회</a></li>
				</c:if>
				
					<li><a href="#">내 정보조회</a></li>
				</ul></li>
	
			<c:choose>
				<c:when test="${sessionScope.user == null }">
			<li class="lefty"><a href="#">회원가입</a></li>
					<li class="lefty"><a href="#">로그인</a></li>
				</c:when>
				<c:otherwise>	
					<li class="lefty"><a href="#">로그아웃</a></li>
				</c:otherwise>
			</c:choose>
			</ul>
		
		
		<br class="clear">
	</nav>
</section>

