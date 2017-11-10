<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<!-- 기본설정 -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/css/custom.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- 기본설정 끝 -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

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
				BooklogName :
				<input class="long" type="text" name="booklogName" value="${booklog.booklogName}">
			</label>
			
			<label>
				BooklogIntro :
				<input class="long" type="text" name="booklogIntro" value="${booklog.booklogIntro }">
			</label>
	
			<label>
				BooklogImage :
				<input class="long" type="file" name="file">
			</label>
			<a href="javascript:void(0);" class="btn btn-default">표지 저장</a>
		</form>
	</div>	
	
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
	
</body>
</html>