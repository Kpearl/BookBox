<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1.0, maximum-scale=1.0, width=device-width">
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

<script>
	function getBook(isbn) {
		$(self.location).attr("href","../unifiedsearch/getBook?isbn="+isbn);
	}
</script>
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp">
		<jsp:param value="../" name="uri" />
	</jsp:include>
	<section class="blank items">
		<table border="1">
			<tr>
				<td><c:forEach items="${bookList}" var="book">
					<div onclick="getBook(${book.isbn});" id="${book.isbn}">
							<img alt="" src="${book.thumbnail}">
							<h2>${book.title}</h2>
							<c:forEach items="${book.authors}" var="str">
		   			   	 	${str} 
   						</c:forEach>
							|
							<c:forEach items="${book.translators}" var="str">
   				   	 	${str}
   			   			</c:forEach>
							| ${book.publisher} | ${book.datetime}<br>
								${book.grade.average} | ${book.like.totalLike} | ${book.price}원<br>
							<hr>
						</div>
				</c:forEach></td>
			</tr>
		</table>
	</section>
</body>
</html>