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
	
	<style>
   		.room_item{
   			height: 350px;
   			border: solid 1px;
   		}
   		.room_item .content{
   			background-color: #444;
   		}
   		.room_item img{
   			height: 150px;
   		}
   		.room_item p{
   			text-overflow:ellipsis;
   			width: 100%;
   			margin: 0;
   		}
   		
   	   	.board_item img{
   			height: 120px;
   			
   		}
   		.board_item p{
   			text-overflow:ellipsis;
   			width: 100%;
   			margin: 0;
   		}
   		.board_item .content{
   			padding: 10px;
   			height:120px;
   			background-color: #444;
   		}
    </style>
    <script type="text/javascript">
    	$(function(){
    		$(".board_item").on("click",function(){
    			self.location="getBoard?boardNo="+$(this).find(".boardNo").val();
    			
    		});
    		
    	})
    </script>
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	
	<div class="container">
		<form class="form-inline text-right">
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">
		      	<select class="form-control">
		      		<option>옵션</option>
		      	</select>
		      </div>
		      <input type="text" class="form-control" id="keyword" placeholder="검색어">
		  	 	<div class="input-group-addon">
		  			<button type="submit" class="btn">검색</button>
				</div>
		    </div>
		  </div>
		</form>
		
		<a class="btn btn-default" href="#">인기</a>
		<a class="btn btn-default" href="#">최신</a>
		<a class="btn btn-default" href="#">댓글순</a>
				
		<br/>
		<h1>BOARD</h1>
		<hr/>
			<div>
				<c:forEach items="${ boardList }" var="board">
					<div class="board_item row">
					<div class="col-md-2 text-center">
						<c:if test="${empty board.thumbnailUrl}">
							<img src="http://cfile9.uf.tistory.com/image/2261AA46582D467B3C3609">
						</c:if>
						<c:if test="${!empty board.thumbnailUrl}">
							<img src="${board.thumbnailUrl}">
						</c:if>
					</div>
					<div class="content col-md-10">
						<input type="hidden" value="${board.boardNo}" class="boardNo">
					
						
						<p>${board.boardTitle }</p>
						<p>${board.writer.nickname }</p>
						<!-- 
						<p>${board.boardContent }</p>
						 -->
						<p>댓글수 0 신고수 ${board.report }</p>
						
						<p>
						<c:forEach items="${board.tagList}" var="tag" >
							#${tag.tagName}
						</c:forEach>
						</p>
					</div>
				</div>
				</c:forEach>
			</div>		
	
	
	</div>
	
</body>
</html>