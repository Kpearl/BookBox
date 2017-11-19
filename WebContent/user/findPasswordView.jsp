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

	<script src="../resources/javascript/toolbar_opac.js"></script>
	<script src="../resources/javascript/custom.js"></script>
	
<style type="text/css">
		body{
	    	padding-top:0px;
	    }
	    
	    header{
	    	background:url(../resources/images/user_title.jpg) no-repeat center;
	    }
	    .find-password{
			background-color: #444;
			color: floralwhite;		
			font-size: 35px;
			text-align: center;
		}
		
		.btn-custom{
			border-radius: 5px;
			border: 1px solid #444;
			padding: 10px;
			color: #444;
		}
</style>	
<script type="text/javascript">
	var condition;
	ToolbarOpacHeight(500);
//============= 비밀번호찾기 Event=============
$( function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	$("a:contains('임시비밀번호 발송')").on("click" , function() {
		
		var email=$("input[name='email']").val().trim();
		var birth=$("input[name='birth']").val().trim();
		
		if(email == "" || email.length <1){
			alert("이메일은 반드시 입력하셔야 합니다.");
			return;
		}
		if(birth == "" || birth.length <1){
			alert("생년월일은  반드시 입력하셔야 합니다.");
			return;
		}
		
			/////////ajax 적용/////////
			$.ajax({
				url : "rest/findPassword/",
				method : "post",
					data : JSON.stringify({
					email : email,
					birth : birth
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
															
						if (JSONData == true) {
							alert("임시비밀번호가 발송되었습니다.");	
						}else{
							alert("입력하신 정보와 일치하는 계정이 없습니다.");
						}
				
				window.close();
				}
			})
	
	});
});

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
		<header class="parallax"></header>
	<div class="container signup">
		<form class="form-horizontal">	
			<div class="find-password">
				Find your password
			</div>	
				<hr>
				<div class="form-group">
					<label class="col-sm-6 col-xs-3 control-label">
						Email
					</label>
						<input class="long" type="text" name="email" id="email">
				</div>
				<div class="form-group">
					<label class="col-sm-6 col-xs-3 control-label">
						Birthday
					</label>
						<input class="long" type="text" name="birth" id="birth">
				</div>
				<div class="text-center">
				<br/><br/><br/>
				<a class="btn-custom">임시비밀번호 발송</a>
				</div>
			</form>	
		
	</div>	
		<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
		</footer>
</body>
</html>