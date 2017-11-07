<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<!-- 기본설정 -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/custom.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- 기본설정 끝 -->
	
	<style>
		body{
			padding-top: 0;
		}
		header{
			background-image: url('./resources/images/test2.jpeg');
			min-height: 100%;
		    opacity: 0.75;
		}
		.category{
			min-height: 100%;
		}
		.category .list{
			position: relative;
		}
		.category-creation{
			background-image: url('./resources/images/creation.jpeg');
			height: 400px;
		    opacity: 0.75;
		}
		.category-community{
			background-image: url('./resources/images/community.jpeg');
			height: 400px;
		    opacity: 0.75;
		}
		.category-booklog{
			background-image: url('./resources/images/posting.jpeg');
			height: 400px;
		    opacity: 0.75;
		}
		.parallax{
		    background-attachment: fixed;
		    background-position: center;
		    background-repeat: no-repeat;
		    background-size: cover;
		}
		.display-middle{
			position: absolute;
			top: 50%;
			left: 50%;
			-webkit-transform: translate(-50%, -50%);
			   -moz-transform: translate(-50%, -50%);
					transform: translate(-50%, -50%);
		}
		.font-large{
			font-size: 24px!important;
		}
		.font-small{
			font-size: 16px!important;
		}
		.theme-black{
			color: #fff!important;
			background-color: #000!important;
		}
		.theme-white{
			color: #fff!important;
		}
		.padding-large{
			padding: 12px 30px!important;
		}
		.wide{
			letter-spacing: 10px;
		}
	</style>
	
	<script>
		var winHeight = $(window).height();
		
		$(window).scroll(function(){
			if($(window).scrollTop() <= winHeight - 50){
				$('header').css('opacity', (winHeight - $(window).scrollTop()) / winHeight * 0.75);
				$('.bookbox-navigation, .side-nav').css('background-color', 'rgba(255, 255, 255, ' + (1 - ((winHeight - $(window).scrollTop()) / winHeight)) + ')')
												.css('-webkit-box-shadow', '0px ' + (5 * ($(window).scrollTop() / winHeight)) + 'px ' + (20 * ($(window).scrollTop() / winHeight)) + 'px 0px')
												.css('-moz-box-shadow', '0px ' + (5 * ($(window).scrollTop() / winHeight)) + 'px ' + (20 * ($(window).scrollTop() / winHeight)) + 'px 0px')
												.css('box-shadow', '0px ' + (5 * ($(window).scrollTop() / winHeight)) + 'px ' + (20 * ($(window).scrollTop() / winHeight)) + 'px 0px');
			}else{
				$('.bookbox-navigation, .side-nav').css('background-color', 'rgba(255, 255, 255, 1)')
												.css('-webkit-box-shadow', '0px 5px 20px 0px')
												.css('-moz-box-shadow', '0px 5px 20px 0px')
												.css('box-shadow', '0px 5px 20px 0px');
			}
		});
		
		$(window).resize(function(){
			winHeight = $(window).height();
		});
		
		$(function(){
			if($(window).scrollTop() < winHeight){
				$('.bookbox-navigation, .side-nav').css('background-color', 'rgba(255, 255, 255, ' + (1 - ((winHeight - $(window).scrollTop()) / winHeight)) + ')')
												.css('-webkit-box-shadow', '0px ' + (5 * ($(window).scrollTop() / winHeight)) + 'px ' + (20 * ($(window).scrollTop() / winHeight)) + 'px 0px')
												.css('-moz-box-shadow', '0px ' + (5 * ($(window).scrollTop() / winHeight)) + 'px ' + (20 * ($(window).scrollTop() / winHeight)) + 'px 0px')
												.css('box-shadow', '0px ' + (5 * ($(window).scrollTop() / winHeight)) + 'px ' + (20 * ($(window).scrollTop() / winHeight)) + 'px 0px');
			}
			
			$('#main-bookbox').on('click', function(){
				var offset = $('#main-search').offset();
				$('html, body').animate({scrollTop : offset.top - 52}, 1500);
			});
		});
	</script>
</head>
<body>

	<jsp:include page="./layout/toolbar.jsp"/>
	<header class="parallax">
		<div id="main-bookbox" class="display-middle" style="cursor: pointer; white-space: nowrap;">
			<span class="font-large theme-black padding-large wide">BOOKBOX <small class="hidden-xs hidden-sm">Book Community <em class="text-muted font-small">책으로 소통하는 공간</em> </small></span>
		</div>
	</header>
	
	<div id="main-search" class="container">
		으어어어어어<hr/>
		으어어어어어<hr/>
		으어어어어어<hr/>
		으어어어어어<hr/>
		으어어어어어<hr/>
		으어어어어어<hr/>
		으어어어어어<hr/>
		으어어어어어<hr/>
		으어어어어어<hr/>
		으어어어어어<hr/>
		으어어어어어<hr/>
		으어어어어어<hr/>
		으어어어어어<hr/>
	</div>
	
	<div class="category">
		<div class="list list-first">
			<div class="category-creation parallax">
				<div class="display-middle">
					<span class="font-large theme-white padding-large wide">CREATION</span>
				</div>
			</div>
			<div class="container">
				얍얍1
			</div>
		</div>
		<div class="list list-second">
			<div class="category-community parallax">
				<div class="display-middle">
					<span class="font-large theme-white padding-large wide">COMMUNITY</span>
				</div>
			</div>
			<div class="container">
				얍얍2
			</div>
		</div>
		<div class="list list-third">
			<div class="category-booklog parallax">
				<div class="display-middle">
					<span class="font-large theme-white padding-large wide">BOOKLOG</span>
				</div>
			</div>
			<div class="container">
				얍얍3
			</div>
		</div>
	</div>

	<footer class="container-fluid">
		<jsp:include page="./layout/tailbar.jsp"/>
	</footer>
	
</body>
</html>