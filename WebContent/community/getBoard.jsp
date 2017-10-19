<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0; maximum-scale=1.0; width=device-width;">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
<title>Insert title here</title>

<script type="text/javascript">
	$(function(){
		
		$("#recommend").on("click",function(){
			var boardNo=$("#boardNo").val();
			var param="targetNo="+boardNo+"&category=board&pref=up";
			sendRecommend(param);
		});
		
		$("#report").on("click",function(){
			var boardNo=$("#boardNo").val();
			var param="targetNo="+boardNo+"&category=board";
			sendReport(param);
		});
		
		$("#addCommentArea").on("click",function(){
			
			appendCommentArea(this);
			
		});
		
	});
	
	
	function sendRecommend(param){
		
		$.ajax({
			url: "rest/addRecommend",
			method: "POST",
			data: param,
			success:function(data,status){
				alert("success")	
			}
		});
		
	}
//////////////////////	
	function sendReport(param){
		$.ajax({
			url: "rest/addReport",
			method: "POST",
			data: param,
			success:function(data,status){
				alert("success")	
			}
		});
	}
///////////////////
	function appendCommentArea(obj){
		
		var inputObj=$("<div><textarea></textarea><a class='btn'>등록</div>");
		alert(inputObj.html());
		
		
		inputObj.find("a").on("click",function(){
			alert("test");
		});
		$(".inputarea").append(inputObj);
		
	}
</script>

</head>
<body>
	<div class="container">
		
		<div class="board">
			<input type="text" value="${board.boardNo}" id="boardNo" readonly="readonly"/>
			<div class="title">
				제목:	${board.boardTitle}
			</div>
			<!-- 추천 신고 -->
			<a class="btn recommend" id="recommend">추천</a> <span id="recommedCount">${board.recommend}</span>
			<a class="btn recommend" id="unRecommend">비추천</a>
			<a class="btn report" id="report">신고</a>
			
			<div class="content">
				내용:
				<br/>
				${board.boardContent}
			</div>
			
			<a class="btn" id=addCommentArea>답변달기</a>
			<div class="inputarea">
			</div>
			
		</div>
		


		<div class="commentList">
		
		</div>
				
	</div>
	
	
	
	
</body>
















</html>