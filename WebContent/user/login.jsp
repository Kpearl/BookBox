<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1.0; maximum-scale=1.0; width=device-width;">
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<!-- 참조 : kakao login -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	
	<!-- 참조 : google login -->
	<meta name="google-signin-client_id" 
	content="427136160435-92p0s5pu0e988v74q17q7smnevk92hns.apps.googleusercontent.com"/>
	<script src="https://apis.google.com/js/platform.js" async defer></script>
	
	<!-- 참조 : naver login -->	
  	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<link rel="stylesheet" href="../resources/css/style.css">
<link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">


</head>

<script type="text/javascript">

/**
 *@brief 로그인 
 */
$( function() {
	
	$("#email").focus();
	
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	$("button").on("click" , function() {
		var email=$("input[name='email']").val();
		var password=$("input[name='password']").val();
		
		if(email == null || email.length <1) {
			alert('emailID 를 입력하지 않으셨습니다.');
			$("#email").focus();
			return;
		}
		
		if(password == null || password.length <1) {
			alert('패스워드를 입력하지 않으셨습니다.');
			$("#password").focus();
			return;
		}
		
		$("form").attr("method","POST").attr("action","/user/login").submit();
	});
});	


</script>


<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<div class="container login">
		<form>
			<h1>Login</h1>
			<hr>
			<label>
				<h2>Your email :</h2>
				<input type="text" id="email" name="email">
			</label>

			<label>
				<h2>And your password</h2>
				<input  type="password" id="password" name="password">
			</label>

			<label>
			<button type="button" class="button-submit" href="#">Login</button>
			</label>
			
			<label>
			<button class="button-submit">Join</button>
			</label>
			
			<!-- kakao 아이디로로그인 버튼 노출 영역 -->
			<label>
			<a id="kakao-login-btn"></a>
			<a href="http://developers.kakao.com/logout"></a>
			</label>
			
			<!-- google 아이디로로그인 버튼 노출 영역 -->
			<label>
  				<div class="g-signin2" data-onsuccess="onSignIn"></div>
			</label>
			
			<label>
			<button class="button-submit">NAVER LOGIN</button>
			</label>
		</form>
	</div>
</body>
</html>