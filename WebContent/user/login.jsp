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

<script type="text/javascript">

/**
 *@brief 로그인 
 */
$( function() {
	
	$("#userId").focus();
	
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	$("button").on("click" , function() {
		var id=$("input:text").val();
		var pw=$("input:password").val();
		
		if(id == null || id.length <1) {
			alert('ID 를 입력하지 않으셨습니다.');
			$("#userId").focus();
			return;
		}
		
		if(pw == null || pw.length <1) {
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
				<input class="long" type="text">
			</label>

			<label>
				<h2>And your password</h2>
				<input class="long" type="password">
			</label>

			<label>
			<button type="button" class="button-submit" href="#">Login</button>
			</label>
			
			<label>
			<button class="button-submit">Join</button>
			</label>
			
			<label>
			<button class="button-submit">NAVER LOGIN</button>
			</label>
			
			<label>
			<button class="button-submit">GOOGLE LOGIN</button>
			</label>
			
			<label>
			<button class="button-submit">KAKAO LOGIN</button>
			</label>
		</form>
	</div>
</body>
</html>