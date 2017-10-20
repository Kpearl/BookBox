<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1.0; maximum-scale=1.0; width=device-width;">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../resources/css/style.css">
<link
	href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css"
	rel="stylesheet">
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp">
		<jsp:param value="../" name="uri" />
	</jsp:include>
	<section class="blank items">
		<table border="1">
			<tr>
				<td>
					<div id="${book.isbn}">
						<img alt="" src="${book.thumbnail}">
						<h2>${book.title}</h2>
						<button>좋아요</button><br><br>
						${book.authors} | ${book.translators} |${book.datetime} | ${book.publisher} | ${book.price}원
						<br><br>
						사이트내 좋아요 개수 : ${book.like.totalLike}<br><br>
						사이트내 평균 평점 : ${book.grade.average}<br><br>
						 도서 소개 : ${book.contents}<br><br>
						 <a href="${book.url}">판매 페이지로 이동</a><br><br>
						 <c:forEach items="${book.replyList}" var="reply">
							 email : ${reply.user.nickname} | ${reply.content}
						 </c:forEach>
						<hr>
					</div>
				</td>
			</tr>
		</table>
	</section>
</body>
</html>