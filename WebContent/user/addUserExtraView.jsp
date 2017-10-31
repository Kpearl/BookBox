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

//============= "가입"  Event 연결 =============
$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	$( "button:contains('Sign Up')" ).bind("click" , function() {
		
		fncAddUser();
	});
});

//=============fncAddUser()=================
	function fncAddUser() {

			var nickname=$("input[name='nickname']").val();
			var name=$("input[name='gender']").val();
			var name=$("input[name='birth']").val();
			var name=$("input[name='active']").val(1);
			
						
			if(nickname == "" || nickname.length <1){
				alert("닉네임은 반드시 입력하셔야 합니다.");
				return;
			}
			if(gender == ""){
				alert("성별은  반드시 체크하셔야 합니다.");
				return;
			}
			if(birth == ""){
				alert("생일은 반드시 입력하셔야 합니다.");
				return;
			}
						
			$("form").attr("method" , "POST").attr("action" , "addUser").submit();
			
		}

//=============생일 날짜입력==================
	$( function() {
	    $("#birth").datepicker({ 
	    	dateFormat:"yy-mm-dd",
	    	showOn: "button",
	    	buttonImageOnly : true,
	    	buttonImage: "https://icongr.am/octicons/calendar.svg?size=25",
	    	buttonText : "Select date"});
	  } );	

</script>

</head>

<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
		<div class="container signup">
		
		<form>
			<h1>Sign up for BookBox</h1>
			<hr>
			<label>
				<h2>Your email:</h2>
				<input id="email" name="email"  class="long" type="text" value="${user.email}" readonly>
			</label>

			<label>
				<h2>Your nickName:</h2>
				<input id="nickname" name="nickname" class="long" type="text">
			</label>

			<label>
				<h2>Choose your gender</h2>
				<input class="long" type="radio" id="gender" name="gender" value="남"> 남
				<input class="long" type="radio" id="gender" name="gender" value="여"> 여		
			</label>
			
			<label>
				<h2>Choose your birthday</h2>
				<input class="long" type="text" id="birth" name="birth" >
			</label>
			
			<input type ="hidden" id="outerAccount" name="outerAccount" value="${user.outerAccount }">
			<input type ="hidden" id="outerToken" name="outerToken" value="${user.outerToken }">
			<input type ="hidden" id="active" name="active" >
			
			<button type="button" class="btn btn-default">Sign Up</button>

		</form>
	</div>	
</body>
</html>