<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

	<!-- 참조 : kakao login -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	
	<!-- 참조 : google login -->
	<meta name="google-signin-client_id" content="427136160435-92p0s5pu0e988v74q17q7smnevk92hns.apps.googleusercontent.com"/>
	<script src="https://apis.google.com/js/platform.js" async defer></script>
	
	<!-- google login custom button -->
	<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
	
	<!-- 참조 : naver login -->	
  	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
	
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
 			//로그인 버튼 이미지 변경을 위한 스크립트
		 function loginWithKakao() {
	 		
		   Kakao.init('4f67f74235560f00f4a1567103ae4b88');
		   // 로그인 창을 띄웁니다.
		   Kakao.Auth.login({
		     success: function(authObj) {
		       alert(JSON.stringify(authObj));
		       $("#outerToken").val(authObj.access_token);
			      $("#outerAccount").val(2);
				  $("form").attr("method","POST").attr("action","../user/login").submit();
		     },
		     fail: function(err) {
		       alert(JSON.stringify(err));
		     }
		   });
		 };
		//============= kakao 로그인  =============
		$(function(){
		
			  //<![CDATA[
		    // 사용할 앱의 JavaScript 키를 설정해 주세요.
/* 		    Kakao.init('4f67f74235560f00f4a1567103ae4b88');
		    // 카카오 로그인 버튼을 생성합니다.
		    Kakao.Auth.createLoginButton({
		      container: '#kakao-login-btn',
		      success: function(authObj) {
		        alert(JSON.stringify(authObj));
		        $("#outerToken").val(authObj.access_token);
		        $("#outerAccount").val(2);
				$("form").attr("method","POST").attr("action","../user/login").submit();
		      },
		      fail: function(err) {
		         alert(JSON.stringify(err));
		      }
		    });
 */			  //]]>

		})
		
/* 		//============= 구글 로그인  =============
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
			  $("form").attr("method","POST").attr("action","../user/login").submit();
	  
			}
 */		//===========구글 로그인 커스텀 버튼======================
		
			function onSuccess(googleUser) {
	 			if(false){
					 var profile = googleUser.getBasicProfile();  
					 var id_token = googleUser.getAuthResponse().id_token;
					  console.log("ID Token: " + id_token);
					  $('#outerToken').val(id_token);
					  $('#email').val(profile.getEmail());
					  $('#outerAccount').val(3);
					  $("form").attr("method","POST").attr("action","../user/login").submit();
	 			}
    		}
		    function onFailure(error) {
		      console.log(error);
		    }
		    function renderButton() {
		      gapi.signin2.render('my-signin2', {
		        'scope': 'profile email',
		        'width': 205,
		        'height': 49,
		        'longtitle': true,
		        'theme': 'light',
		        'onsuccess': onSuccess,
		        'onfailure': onFailure
		      });
		    }
			

		//============= "로그인"  Event 연결 =============
		$( function() {
			
			$("#email").focus();
			
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a.user-login").on("click" , function() {
				var email=$("input[name='email']").val();
				var pw=$("input[name='password']").val();
				
				if(email == null || email.length <1) {
					alert('이메일을 입력하지 않으셨습니다.');
					$("#email").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('패스워드를 입력하지 않으셨습니다.');
					$("#password").focus();
					return;
				}
				$("form").attr("method","POST").attr("action","../user/login").submit();
			});
		});	
		
		
		//============= 회원원가입화면이동 =============
		$( function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a.user-sign-in").on("click" , function() {
				self.location = "../user/addUser"
			});
		});
		
		//============= 비밀번호 찾기 화면이동 =============
		$( function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a.user-find-password").on("click" , function() {
				
				var popURL = "../user/findPassword";
				var popOption ="width = 800, height = 320, resizable = yes, scrollbars= no, status= no;"
				
				window.open(popURL,"비밀번호 찾기",popOption);
				
			});
		});		
		
		
	</script>		

</head>


<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<div class="container login">
		<div class="row">
			<div class="col-md-offset-3 col-md-6">
				<form class="form-horizontal">
					<h1>Login</h1>
					<hr>
					<div class="form-group">
						<label for="email" class="col-sm-6 col-md-4 control-label">Your email :</label>
						<div class="col-sm-6 col-md-8">
							<input type="text" class="form-control" id="email" name="email" placeholder="email@bookbox.com" value="${user.email}">
						</div>
					</div>
					
					<div class="form-group">
						<label for="password" class="col-sm-6 col-md-4 control-label">And your password</label>
						<div class="col-sm-6 col-md-8">
							<input type="password" class="form-control" id="password" name="password" placeholder="password">
						</div>
					</div>
					<c:if test="${!empty msg}">
						<p>${msg}<p/>
					</c:if>
					
					<input type="hidden" name="outerToken" id="outerToken"> 
					<input type="hidden" name="outerAccount" id="outerAccount" value="0">
					
					<br/>
					<div class="row">
						<div class="btn-group btn-group-justified" role="group">
							<a class="btn user-login" role="button">Login</a>
							<a class="btn user-sign-in" role="button">Sign in</a>
							<a class="btn user-find-password" role="button">Find Password</a>
						</div>
					</div>
					
					<br/>
<!-- 					kakao 아이디로로그인 버튼 노출 영역
					<a id="kakao-login-btn"></a>
					<a href="http://developers.kakao.com/logout"></a>
-->
					<div class="form-group">
						<!-- kakao 커스텀 버튼 -->
						<a id="custom-login-btn" href="javascript:loginWithKakao()">
							<img src="../resources/images/kakao_login_btn/login/en/kakao_account_login_btn_medium_narrow.png" />
						</a>
		  				<!-- google 로그인 커스텀 -->
		  				<div id="my-signin2"></div>
					</div>
<!-- 					google 아이디로로그인 버튼 노출 영역
	  				<div class="g-signin2" data-onsuccess="onSignIn"></div>
					
					<!-- <a class="btn btn-default">NAVER LOGIN</a> -->
				</form>
			</div>
		</div>
	</div>
</body>
</html>