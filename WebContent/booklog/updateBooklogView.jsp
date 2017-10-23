<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, width=device-width">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<link rel="stylesheet" href="../resources/css/style.css">
	<link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">

	<script type="text/javascript">
	
		$(function(){
			$('a:contains("표지 저장")').on('click',function(){
				$('form.booklog-update').attr('method','post').attr('action','../booklog/updateBooklog').attr('enctype','multipart/form-data').submit();
			});
		});
	
	</script>

</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<!-- 여기부터 코딩 -->
	<div class="container signup">
		<h1>Update your Booklog</h1>
		<hr>
		<form class="booklog-update">
			<input type="hidden" name="user.email" value="${booklog.user.email}">
			<input type="hidden" name="booklogNo" value="${booklog.booklogNo}">
			<label>
				<h2>BooklogName :</h2>
				<input class="long" type="text" name="booklogName" value="${booklog.booklogName}">
			</label>
			
			<label>
				<h2>BooklogIntro :</h2>
				<input class="long" type="text" name="booklogIntro" value="${booklog.booklogIntro }">
			</label>
	
			<label>
				<h2>BooklogImage :</h2>
				<input class="long" type="file" name="file">
			</label>
			<a href="#" class="btn btn-default">표지 저장</a>
		</form>
	</div>	
</body>
</html>