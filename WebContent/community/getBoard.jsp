<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, width=device-width">
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >

<!-- 
 -->
	<link rel="stylesheet" href="../resources/css/style.css">
	<link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">

	
<title>Insert title here</title>

<style type="text/css">
.container img{
	max-width: none;
}
</style>

<script type="text/javascript">

//게시글 추천,신고 버튼 이벤트 초기화
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
		
		//게시글의 답변 버튼 이벤트
		commentEventInit($(".board"));
		
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
//////////////////////	신고 추가 부분
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
	
	//댓글 로딩
	$(function(){
		
		var boardNo=$("input[name=boardNo]").val();
		
		$.ajax({
			url: "rest/getCommentList/"+boardNo,
			method: "GET",
			dataType:"json",
			crossDomain:true,
			success:function(data){
				//alert("getCommentList success");
				//alert(data.length);
				//alert(JSON.stringify(data));
				
			var commentListDiv=$(".commentList");
	
			appendComment(commentListDiv,data);
				
			
			}
	 	});//ajax 끝 
	});
	//댓글 로딩 끝
	
	//대댓글 재귀함수
	function appendComment(parentObj,commentList){
		
		var appendPoint=parentObj.find(".media-body");
		
		//레벨 0댓글일 경우 comment 부분에 추가
		if(!appendPoint.length){
			appendPoint=$(".commentList");
		}
		
		
		for(var i=0; i<commentList.length; i++){
			//alert(commentList[i].content);
				var comment=commentList[i];
				
				var commentObj=$("<div class='media'>"+
									"<input name='commentNo' value='"+comment.commentNo+"'>"+ //히든처리할거
									"<input name='level' value='"+comment.level+"'>"+ //히든처리할거
									"<div class='media-left'>"+
										"<img src='../resources/images/comment.png' class='media-object' style='width:20px'>"+
									"</div>"+
									"<div class='media-body'>"+
										"<h4 class='media-heading'>"+ comment.writer.nickname +"<small><i>"+comment.regDate+"</i></small></h4>"+
										"<p>"+comment.content+"</p>"+
										"<a class='btn' id='addCommentArea'>답변</a>"+
										"<div class='inputarea'>"+
										"</div>"+
									"</div>"+
								"</div>"	);
			
			commentEventInit(commentObj);
			
			appendPoint.append(commentObj);
			
			if(commentList[i].comment!=null){
				appendComment(commentObj,commentList[i].comment);
			}
			
		}
		
	}
	//대댓글 재귀함수 끝
	
	//대댓글 이벤트 초기화 함수
	function commentEventInit(commentObj){
		//alert(commentObj.html());
		
		//댓글 입력창 , 댓글달기 이벤트 추가 부분
		commentObj.find("#addCommentArea").on("click",function(){
			
			if(commentObj.find(".inputarea").html()!=''){
				return;
			}
			
			var inputObj=$("<div><textarea></textarea><a class='btn'>등록</div>");
			
			inputObj.find("a").on("click",function(){
				
				var boardNo=$("input[name=boardNo]").val();
				var content=inputObj.find("textarea").val();
				var level = commentObj.find("input[name='level']").val();
				var commentNo=commentObj.find("input[name='commentNo']").val();
				
				if(level==undefined){
					level=-1;
					commentNo=0;
				}
				
				alert(boardNo+","+content+","+level+","+commentNo);
				/*
			 	$.ajax({
					url: "rest/addComment",
					method: "POST",
					crossDomain:true,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					data :JSON.stringify({
						"boardNo": boardNo,
						"content" : content,
						"level" : "0"
					}),
					success:function(){
						alert("addComment success")	
					}
			 	});*///ajax 끝 
				//commentObj.find(".inputarea").html(""); 등록후 입력창 없애기 , 댓글영역을 리로드할 예정 필요없을지도
			});//등록 클릭이벤트 끝
			
			commentObj.find(".inputarea").eq(0).append(inputObj);
			
		});//댓글 입력창 , 댓글달기 이벤트 추가 부분
		
	}//이벤트 초기화끝
</script>

</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<div class="container">
		
		<div class="board">
			히든예정<input type="text" value="${board.boardNo}" name="boardNo" readonly="readonly"/>
			
				
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
			<div class="inputarea"></div><!-- 여기 무조건 붙어있어야함 -->
			
		</div>

	<!-- 댓글 부분 -->
		<div class="commentList">
				댓글부분
		
		
		</div><!-- 댓글부분 끝 -->
	
				
				
	</div>
	
	
	
	
	
</body>
















</html>