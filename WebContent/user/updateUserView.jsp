<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1.0; maximum-scale=1.0; width=device-width;">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
<link rel="stylesheet" href="../resources/css/style.css">
<link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<div class="container login">
		<form>
			<h1>Update User</h1>
			<hr>
			<label>
				<h2>Your NickName :</h2>
				<input class="long" type="text">
			</label>

			<label>
				<h2>And your password</h2>
				<input class="long" type="password">
			</label>
			
			<label>
				<h2>And your password Check</h2>
				<input class="long" type="password">
			</label>

			<label>
				<h2>And your gender</h2>
				남자<input class="long" type="radio">
				여자<input class="long" type="radio">
			</label>
			
			<label>
				<h2>And your birthday</h2>
				<input class="long" type="date">
			</label>
			
			<label>
			<button class="button-submit">정보 수정</button>
			</label>
		</form>
	</div>
</body>
</html>