<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<!-- 기본설정 -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/css/custom.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- 기본설정 끝 -->

<script type="text/javascript">

</script>
</head>

<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>

	<section class="container">
		<h1>total : ${total}</h1>
		
		<c:forEach items="${result}" var="result">
			title : ${result.title}<br>
			content : ${result.content}<br>
			nick_name : ${result.nick_name}<br>
			tag : 
			<c:forEach items="${result.tag}" var="tag">
				${tag} /  
			</c:forEach>
			<br>=========================================<br><br>
		</c:forEach>
	</section>
	
</body>
</html>