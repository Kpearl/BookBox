<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, width=device-width">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<link rel="stylesheet" href="../resources/css/style.css">
	<link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">

	<!-- CKEditor 추가 -->
	<!-- <script src="../resources/javascript/ckeditor/ckeditor.js"></script> -->
		<!-- CDN Version -->
	<script src="https://cdn.ckeditor.com/4.7.3/standard/ckeditor.js"></script>
	<!-- CKEditor -->
	
	
	<script type="text/javascript">
		var tagHtml;
		$(function(){
			tagHtml = '<input type="text" name="tag"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>';
			$('a:contains("등록하기")').on('click',function(){
				var data = CKEDITOR.instances.postingContent.getData();
				$('textarea').val(data);
				alert($('textarea').val());
				$('form').attr('method','post').attr('action','../booklog/addPosting').attr('enctype','multipart/form-data').submit();
			});
			
			$('a:contains("추가하기")').on('click',function(){
				$('.tag-list').append(tagHtml);
			});
		});
	
		$(function(){
			CKEDITOR.replace('postingContent');
		});
	</script>
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<!-- 여기부터 코딩 -->
	
	<div class="container">
		<form>
			<div class="form-group">
				<label>포스팅 제목</label>
				<input type="text" name="postingTitle">
			</div>
			<div class="form-group">
				<textarea name="postingContent" id="postingContent" rows="10" cols="80"></textarea>
			</div>
			
			<div class="form-group tag-list">
				<label>태그</label>
				<a href="#" class="btn">추가하기</a>
				<input type="text" name="tag">
			</div>
			<a href="#" class="btn">등록하기</a>
		</form>
	</div>
	
	
</body>
</html>