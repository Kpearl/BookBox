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
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<!-- CKEditor 추가 -->
	<script src="../resources/ckeditor/ckeditor.js"></script>
		<!-- CDN Version -->
	<!-- <script src="https://cdn.ckeditor.com/4.7.3/standard/ckeditor.js"></script> -->
	<!-- CKEditor -->
	
	
	<script type="text/javascript">
		var tagHtml;
		var num;
		var editor;

		$(function(){
			num = 0;
			fncTagAutocomplete();

			$('a.posting-add:contains("등록하기")').on('click',function(){
				var data = CKEDITOR.instances.postingContent.getData();
				$('textarea').val(data);
				$('form').attr('method','post').attr('action','../booklog/addPosting').attr('enctype','multipart/form-data').submit();
			});
			
			$('a.tag-add:contains("추가하기")').on('click',function(){
				num = num + 1;
				tagHtml = '<span id="tag'+num+'">, # <input type="text" name="tag"><span class="glyphicon glyphicon-remove" aria-hidden="true" onClick="javascript:fncRemoveTag('+num+')"></span></span>';
				$('.tag-list').append(tagHtml);
				fncTagAutocomplete();
			});

		});
	
		$(function(){
			editor = CKEDITOR.replace('postingContent', { customConfig : 'config_posting.js'});
			
		});


		function fncTagAutocomplete(){
			$( "input[name='tag']" ).autocomplete({
				source: function( request, response ) {
				    $.ajax( {
				    	url: "rest/tag",
				        method: "post",
				        dataType: "json",
				        data: "tagName="+request.term,
				        success: function( data ) {
			        	  	response(data);
			        	}
					} );
			    }
			});
		}

		function fncRemoveTag(num){
			$('#tag'+num).remove();
		}
		
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
				<a href="#" class="btn tag-add">추가하기</a>
				<span># <input type="text" name="tag" id="tag"></span>
			</div>
			<a href="#" class="btn posting-add">등록하기</a>
		</form>
	</div>
	
	
</body>
</html>