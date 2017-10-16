<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<link rel="shortcut icon" href="${param.uri}resources/images/icon.png">
<link rel="icon" href="${param.uri}resources/images/icon.png">

<title>BookBox</title>

<section class="blank">
	<nav class="navigation">
		<ul>
			<li><a href="${param.uri}index.jsp" class="focus navigation-home">
			<i class="icon-large icon-home"></i>
			</a></li>
			<li><a href="#">창작공간</a></li>
			<li><a href="#">소모임</a></li>
			<li><a href="#">북로그</a></li>
			<li><a href="#">공지사항</a></li>
			<li class="lefty"><a href="#" class="navigation-settings"> <i
					class="icon-large icon-search"></i>
			</a></li>

			<li class="lefty dropdown"><a href="#" id="drop3"
				data-toggle="dropdown"> <i class="icon-large icon-th-list"></i>
			</a>

				<ul class="dropdown-menu" aria-labelledby="drop3">
					<li><a href="#">내 북로그보기</a></li>
					<li><a href="#">구독한글보기</a></li>
					<li><a href="#">좋아요책목록보기</a></li>
					<li><a href="#">책갈피목록보기</a></li>
					<li><a href="${param.uri}user/adminUserInfoView.jsp">회원목록조회</a></li>
					<li><a href="${param.uri}user/getUser.jsp">내 정보조회</a></li>
				</ul></li>
			<li class="lefty"><a href="${param.uri}user/addUserView.jsp">회원가입</a></li>
			<li class="lefty"><a href="${param.uri}user/login.jsp">로그인</a></li>
			<li class="lefty"><a href="${param.uri}index.jsp">로그아웃</a></li>
		</ul>
		<br class="clear">
	</nav>
</section>
