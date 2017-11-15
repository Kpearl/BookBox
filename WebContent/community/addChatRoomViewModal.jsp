<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, width=device-width">
<title>Create chatRoom </title>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
    <link rel="stylesheet" href="../resources/css/custom.css">


<script type="text/javascript">
	$(function(){
		
		//태그 자동완성
		$( "#chatroom-tagInput" ).autocomplete({
		      source: function( request, response ) {
		        $.ajax( {
		          url: "rest/getTagNameList",
		          method: "post",
		          dataType: "json",
		          data: "tagName="+request.term,
		          success: function( data ) {
		            //	alert(JSON.stringify(data));
		        	  	response(data);
		          }
		        } );
		      }
		    }
		);
		//태그 자동완성 끝
		
		$( "#chatroom-tagInput" ).on("keyup",function(e){
				if(e.keyCode!=13 || $(this).val()==''){
					return;
				}
				addTag();
		});
		
		//태그 추가 
		$("#chatroom-addTagBtn").on("click",function(){
		//	alert(	$("#tagInput").val());
			addTag();
		});
		
		//submit 버튼 이벤트 등록
		$(".submit.addChatRoom").on("click",function(){
		//	alert("submit");
			$(".chatRoom-form").submit();
		});
		
		
	}); //온로드 끝
	//
	function addTag(){
		
		var tag = $("#chatroom-tagInput").val();
		
		var tagName=$("<span><span class='tag'>"+tag+
						"<input type='hidden' name='tagNames' value='"+tag+"' readonly>"+
						"</span><a class='btn removeBtn'>x</a></span>");
		tagName.find("a.removeBtn").on("click",function(){
			//alert("test");
			tagName.remove();
		});
		
		 $("#chatroom-tagInput").val("");
		//alert(tagName.val());
		$("#chatroom-tagInput").after(tagName);
		
	}
	
</script>
<style type="text/css">
	.ui-autocomplete { z-index:2147483647; }
</style>
</head>


<body>

	<div class="container-fluid">
	
		<form class="chatRoom-form" action="addChatRoom" method="post" enctype="multipart/form-data">
			<div class="input-group">
	 		 <span class="input-group-addon" id="title-addon">방 제목</span>
			 <input type="text" name="title" class="form-control" placeholder="Title" aria-describedby="title-addon"/>
			</div>
			
			<div class="input-group">
	 			<span class="input-group-addon" id="content-addon">방 내용</span>
				<textarea  name="content" class="form-control" placeholder="content" aria-describedby="content-addon"></textarea>
			</div>
			<div class="input-group">
	 		 <span class="input-group-addon" id="title-addon">최대인원</span>
			 <input type="text" name="maxUser" class="form-control" placeholder="maxUser" aria-describedby="title-addon"/>
			</div>
			<div class="input-group">
	 		 <span class="input-group-addon" id="title-addon">이미지</span>
			 <input type="file" name="file" class="form-control" placeholder="이미지" aria-describedby="title-addon"/>
			</div>
			<div class="input-group">
	 		 <span class="input-group-addon" id="type">방종류</span>
			 <select name="type"  class="form-control">
			 	<option value="0">그룹채팅</option>
			 	<option value="1">방송</option>
			 </select>
			</div>
			<div id="tagNames">
				<input type="text"id="chatroom-tagInput"><a class="btn" id="chatroom-addTagBtn">추가</a>
			</div>
			
		</form>
		
			<br/><br/><br/>
	
	</div>
	
</body>
</html>