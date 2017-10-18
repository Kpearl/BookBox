<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1.0; maximum-scale=1.0; width=device-width;">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	 <!-- <link rel="stylesheet" href="../resources/demos/style.css"> -->
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<link rel="stylesheet" href="../resources/css/style.css">
<link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">

<script type="text/javascript">

//============= "가입"  Event 연결 =============
$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	$( "button:contains('정보수정')" ).bind("click" , function() {
		//$(self.location).attr("href","updateUser");
		self.location = "updateUser"
		
	});
});


</script>

</head>

<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
		<div class="container signup">
		
		<form>
			<h1>GetUser for BookBox</h1>
			<hr>
			<label>
				<h2>Your email:</h2>
				<input id="email" name="email"  class="long" type="text" value="${user.email }" readonly>
			</label>
			
			<span id="checkEmail">
			
			</span>
					
			<label>
				<h2>Your nickname:</h2>
				<input id="nickname" name="nickname" class="long" type="text" value="${user.nickname }" readonly>
			</label>

			<span id="checkNickname">
			
			</span>

			<label>
				<h2>Choose your gender</h2>
				<input class="long" type="radio" id="gender" name="gender" value="남" 
				${user.gender == '남' ? 'checked' : '' }> 남
				<input class="long" type="radio" id="gender" name="gender" value="여"
				${user.gender == '여' ? 'checked' : '' }> 여		
			</label>
			
			<label>
				<h2>Choose your birthday</h2>
				<input class="long" type="text" id="birth" name="birth" value="${user.birth }" readonly>
			</label>
			
				<input class="long" type="hidden" id="outerAccount" name="outerAccount" value=${user.outerAccount }>
				<input class="long" type="hidden" id="active" name="active" value=${user.active }>

			<button type="button" class="btn btn-default">정보수정</button>

		</form>
	</div>	
</body>
</html>