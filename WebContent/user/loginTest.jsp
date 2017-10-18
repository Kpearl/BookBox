<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>



<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	

	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
    	 body >  div.container{ 
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		//============= naver 로그인  =============
/* 		window.onload = function(){
			var naver_id = new naver_id_login("PZ8jTocq281e6hfxXuIC", "http://127.0.0.1:8080/user/login");
		  	var state = naver_id.getUniqState();
		  	naver_id.setButton("white", 3,45);
		  	naver_id.setDomain("http://127.0.0.1:8080/user/login");
		  	naver_id.setState(state);
		  	naver_id.setPopup(); 
		  	naver_id.init_naver_id_login();
		  	
			naver_id.get_naver_userprofile("naverSignInCallback()");

		}
	
		function naverSignInCallback(){
			
			plusCheck();
		}
 */		
		//============= kakao 로그인  =============
		$(function(){
		
			  //<![CDATA[
		    // 사용할 앱의 JavaScript 키를 설정해 주세요.
		    Kakao.init('4f67f74235560f00f4a1567103ae4b88');
		    // 카카오 로그인 버튼을 생성합니다.
		    Kakao.Auth.createLoginButton({
		      container: '#kakao-login-btn',
		      success: function(authObj) {
		        alert(JSON.stringify(authObj));
		        $("#outerToken").val(authObj.access_token);
		        $("#outerAccount").val(2);
				$("form").attr("method","POST").attr("action","login").submit();
		      },
		      fail: function(err) {
		         alert(JSON.stringify(err));
		      }
		    });
		  //]]>
			
		})
		
		//============= 구글 로그인  =============
 		 function onSignIn(googleUser) {
			  var profile = googleUser.getBasicProfile();
			  console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
			  console.log('Name: ' + profile.getName());
			  console.log('Image URL: ' + profile.getImageUrl());
			  console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
			  
			  
			  var id_token = googleUser.getAuthResponse().id_token;
			  console.log("ID Token: " + id_token);
			  $('#outerToken').val(id_token);
			  $('#email').val(profile.getEmail());
			  $('#outerAccount').val(3);
			  $("form").attr("method","POST").attr("action","login").submit();
	  
			}

		//============= "로그인"  Event 연결 =============
		$( function() {
			
			$("#email").focus();
			
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("button").on("click" , function() {
				var email=$("input[name='email']").val();
				var pw=$("input[name='password']").val();
				
				if(email == null || email.length <1) {
					alert('ID 를 입력하지 않으셨습니다.');
					$("#email").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('패스워드를 입력하지 않으셨습니다.');
					$("#password").focus();
					return;
				}
				$("form").attr("method","POST").attr("action","login").submit();
			});
		});	
		
		
		//============= 회원원가입화면이동 =============
		$( function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#']").on("click" , function() {
				self.location = "addUser"
			});
		});
		
		
	</script>		
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
   	<!-- ToolBar End /////////////////////////////////////-->	
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		<!--  row Start /////////////////////////////////////-->
		<div class="row">
		
			<div class="col-md-6">
					<img src="/images/logo-spring.png" class="img-rounded" width="100%" />
			</div>
	   	 	
	 	 	<div class="col-md-6">
	 	 	
		 	 	<br/><br/>
				
				<div class="jumbotron">	 	 	
		 	 		<h1 class="text-center">로 &nbsp;&nbsp;그 &nbsp;&nbsp;인</h1>

			        <form class="form-horizontal">
		  
					  <div class="form-group">
					    <label for="userId" class="col-sm-4 control-label">이 메 일</label>
					    <div class="col-sm-6">
					      <input type="text" class="form-control" name="email" id="email"  placeholder="emailID" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="password" class="col-sm-4 control-label">패 스 워 드</label>
					    <div class="col-sm-6">
					      <input type="password" class="form-control" name="password" id="password" placeholder="패스워드" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <div class="col-sm-offset-4 col-sm-6 text-center">
					      <button type="button" class="btn btn-primary"  >로 &nbsp;그 &nbsp;인</button>
					      <a class="btn btn-primary btn" href="#" role="button">회 &nbsp;원 &nbsp;가 &nbsp;입</a>
					    </div>
					  </div>
					  
					  <!--outerToken & outerAccount  -->
					  <input type="hidden" name="outerToken" id="outerToken"> 
					  <input type="hidden" name="outerAccount" id="outerAccount">
					  
					  
					  
		<!-- 네이버아이디로로그인 버튼 노출 영역 -->
  		<div id="naver_id_login"></div>
  			
  	<!-- <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
  	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script> -->

<!-- 	<script type="text/javascript">
	var naver_id_login = new naver_id_login("PZ8jTocq281e6hfxXuIC", "http://127.0.0.1:8080/user/login");
  	var state = naver_id_login.getUniqState();
  	naver_id_login.setButton("white", 2,40);
  	naver_id_login.setDomain("http://127.0.0.1:8080/user/login");
  	naver_id_login.setState(state);
  	/* naver_id_login.setPopup(); */
  	naver_id_login.init_naver_id_login();
	</script> -->
	 
	<!-- kakao 아이디로로그인 버튼 노출 영역 -->
	<a id="kakao-login-btn"></a>
	<a href="http://developers.kakao.com/logout"></a>

  
  	<!-- google 아이디로로그인 버튼 노출 영역 -->
  	<div class="g-signin2" data-onsuccess="onSignIn"></div>
  
			
					</form>
			   	 </div>
			   	 
			   	 
			
			</div>
			
			
  	 	</div>
  	 	<!--  row Start /////////////////////////////////////-->
  	 	
  	 	 
  </div>

  

</body>

</html>