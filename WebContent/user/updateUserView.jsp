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
	    
	    .list-header{
	    	margin:  20px 0 10px 0;
	    	font-weight: bold;
	    	border-bottom: 1px solid #444;  
	    }
	    .userupdate-title{
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
	
	$( function() {
	    $("#birth").datepicker({ 
	    	dateFormat:"yy-mm-dd",
	    	showOn: "button",
	    	changeMonth: true,
	    	changeYear: true,
	    	defaultDate: '-20y',
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
	<div class="container login">
		<form class="form-horizontal">
			<div class="userupdate-title">
				Update User
			</div>
			<hr>
			<div class="form-group">
				<label class="col-sm-6 col-xs-3 control-label">
					NickName
				</label>
					<input class="long" type="text">
			 </div>
			<div class="form-group">
				<label class="col-sm-6 col-xs-3 control-label">
					Password
				</label>
					<input class="long" type="password">
			</div>
			<div class="form-group">
				<label class="col-sm-6 col-xs-3 control-label">
					Password Check
				</label>
				<input class="long" type="password">
			</div>
			<div class="form-group">
				<label class="col-sm-6 col-xs-3 control-label">
					Gender
				</label>
					남자<input class="long" type="radio">
					여자<input class="long" type="radio">
			</div>
			<div class="form-group">
				<label class="col-sm-6 col-xs-3 control-label">
				Birthday
				</label>
				<input class="long" type="text" id="birth" name="birth" readonly>
			</div>
			<div class="text-center">
				<label>
					<a class="button-submit btn-custom">정보 수정</a>
				</label>
			</div>
		</form>
	</div>
	
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
</body>
</html>