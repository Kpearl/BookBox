<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1.0; maximum-scale=1.0; width=device-width;">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	 <link rel="stylesheet" href="/resources/demos/style.css">
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<link rel="stylesheet" href="../resources/css/style.css">
<link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">

<script type="text/javascript">

	var emailJSONData;
	var nicknameJSONData;

//============= "가입"  Event 연결 =============
$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	$( "button:contains('Sign Up')" ).bind("click" , function() {
		
		fncAddUser();
	});
});

//=============fncAddUser()=================
	function fncAddUser() {
			
			
			var email=$("input[name='email']").val();
			var nickname=$("input[name='nickname']").val();
			var password=$("input[name='password']").val();
			var checkPassword=$("input[name='checkPassword']").val();
			var name=$("input[name='gender']").val();
			var name=$("input[name='birth']").val();
			
			var name=$("input[name='outerAccount']").val(0);
			var name=$("input[name='active']").val(0);
						
			if(email == "" || email.length <1){
				alert("아이디는 반드시 입력하셔야 합니다.");
				return;
			}
			if(nickname == "" || nickname.length <1){
				alert("닉네임은 반드시 입력하셔야 합니다.");
				return;
			}
			if(password == "" || password.length <1){
				alert("패스워드는  반드시 입력하셔야 합니다.");
				return;
			}
			if(checkPassword == "" || checkPassword.length <1){
				alert("패스워드 확인은  반드시 입력하셔야 합니다.");
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
			
			if( password != checkPassword ) {				
				alert("비밀번호 확인이 일치하지 않습니다.");
				$("input:[name='checkPassword']").focus();
				return;
			}
			
			if( emailJSONData == false ) {				
				alert("사용불가능한 이메일입니다.");
				return;
			}

			if( nicknameJSONData == false ) {				
				alert("사용불가능한 닉네임입니다.");
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
	  
//============emailID 중복체크================
			$(function() {

				$('#email').keyup(
						function() {
							var email=$("input[name='email']").val().trim();
							//alert("입력된 값은 "+email);

							/////////ajax 적용/////////
							$.ajax({
								url : "rest/checkEmailValidation/",
								method : "post",
		 						data : JSON.stringify({
									email : email
								}),
								dataType : "json",
								headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
								},
								success : function(JSONData, status) {

									//Debug...
									//alert(status);
									//Debug...
									//alert("JSONData : \n"+JSONData);
									//alert( "JSON.stringify(JSONData) : \n"+JSONData );
									
										emailJSONData =JSONData;
																			
										if (JSONData == true) {
										
											var displayValue = "<p>'" +email+ "'은 사용가능한 아이디입니다.<br/></p>";
										} else {
											var displayValue = "<p>'"+email+ "'은 사용불가능한 아이디입니다. <br/></p>";
										}
										
										if(email == "") {	
												var displayValue ="";
									}

									//Debug...									
									//alert(displayValue);
									$("p").remove();
									$("#checkEmail").html(displayValue);
								}
							})
						})
				})

//============nickname 중복체크================
				$(function() {

				$('#nickname').keyup(
						function() {
							var nickname=$("input[name='nickname']").val().trim();
							//alert("입력된 값은 "+email);

							/////////ajax 적용/////////
							$.ajax({
								url : "rest/checkNicknameValidation/",
								method : "post",
		 						data : JSON.stringify({
									nickname : nickname
								}),
								dataType : "json",
								headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
								},
								success : function(JSONData, status) {

									//Debug...
									//alert(status);
									//Debug...
									//alert("JSONData : \n"+JSONData);
									//alert( "JSON.stringify(JSONData) : \n"+JSONData );
									
									nicknameJSONData = JSONData;
									
										if (JSONData == true) {
										
											var displayValue = "<p>'"+nickname+ "'은 사용가능한 닉네임입니다.<br/></p>";
										} else {
											var displayValue = "<p>'"
																				+nickname+ "'은 사용불가능한 닉네임입니다. <br/></p>";
										}
										
										if(nickname == "") {	
												var displayValue ="";
									}

									//Debug...									
									//alert(displayValue);
									$("p").remove();
									$("#checkNickname").html(displayValue);
								}
							})
						})
				})


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
				<input id="email" name="email"  class="long" type="text">
			</label>
			
			<span id="checkEmail">
			
			</span>
					
			<label>
				<h2>Your nickName:</h2>
				<input id="nickname" name="nickname" class="long" type="text">
			</label>

			<span id="checkNickname">
			
			</span>

			<label>
				<h2>Choose your password</h2>
				<input id="password" name="password" class="long" type="password">
			</label>

			<label>
				<h2>Repeat your password</h2>
				<input id="chekPassword" name="checkPassword" class="long" type="password">
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
			
				<input class="long" type="hidden" id="outerAccount" name="outerAccount">
				<input class="long" type="hidden" id="active" name="active">

			<button type="button" class="btn btn-default">Sign Up</button>

		</form>
	</div>	
</body>
</html>