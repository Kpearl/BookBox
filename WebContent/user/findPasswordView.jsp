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
	<jsp:include page="../layout/toolbar.jsp" />
	<div class="container signup">
		<form>
			<h1>Find your password</h1>
			<hr>
			<label>
				<h2>email :</h2>
				<input class="long" type="text">
			</label>
			
			<label>
				<h2>birthday :</h2>
				<input class="long" type="password">
			</label>
			<button class="button-submit">임시비밀번호 발송</button>
		</form>
	</div>	
</body>
</html>