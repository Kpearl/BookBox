<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1.0; maximum-scale=1.0; width=device-width;">
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
   			height: 150px;
   			float: left;
   		}
   		.board_item p{
   			text-overflow:ellipsis;
   			width: 100%;
   			margin: 0;
   		}
   		.board_item .content{
   			background-color: #444;
   		}
    </style>
    
    <script type="text/javascript">
    	
    $(function(){
    	//게시판 상세보기 이벤트	
    	$(".board_item").on("click",function(){
    		//alert($(this).html());
    		var boardNo=$(this).find(".boardNo").val();                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
    		self.location="getBoard?boardNo="+boardNo;
    	})
    	
    	$("#moreBoard").on("click",function(){
    		self.location="getBoardList";
    	})
    });
    
    
    </script>
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" />
	
	<div class="container">
		<div class="row">
			<!-- 생성버튼 -->
			<div class="col-md-6 text-left">
			<a class="btn">채팅방 생성</a><a class="btn" href="addBoard">게시글 작성</a>
			</div>
			<!-- 생성버튼 끝 -->
		 	<form class="form-inline text-right col-md-6" action="getCommunityMain" method="get">
			  <div class="form-group">
			    <div class="input-group">
			      <div class="input-group-addon">
			      	<select class="form-control">
			      		<option>옵션</option>
			      	</select>
			      </div>
			      <input type="text" class="form-control" name="keyword" id="keyword" placeholder="검색어">
			  	 	<div class="input-group-addon">
			  			<button type="submit" class="btn">검색</button>
					</div>
			    </div>
			  </div>
			</form>
			
		</div>
		
		<h1>CAST</h1>
		<hr/>
		<div class="row">
			<div class="col-md-3">
				<div class="room_item">
					<img src="http://cfile9.uf.tistory.com/image/2261AA46582D467B3C3609">
					<div class="content">
						<p>주제:보노보노</p>
						<p>닉네임:보노보노</p>
						<p>소개글:보노보노보노보보노보노보노보노보보노</p>
						<p>인원:0/100</p>
						<p>#보노보노</p>
					</div>
				</div>
			</div>
		</div>
					
		<br/>
		<h1>CAMCHAT</h1>
		<hr/>
		<div class="row">
			<div class="col-md-3">
				<div class="room_item">
					<img src="http://cfile9.uf.tistory.com/image/2261AA46582D467B3C3609">
					<div class="content">
						<p>주제:보노보노</p>
						<p>닉네임:보노보노</p>
						<p>소개글:보노보노보노보보노보노보노보노보보노노보노보노보노보노보노보노보노</p>
						<p>인원:1/10</p>
						<p>#보노보노</p>
					</div>
				</div>
			</div>
		</div>
		
		<br/>
		<h1>BOARD</h1>
		<h5 class="btn" id="moreBoard">더 보기</h5>
		<hr/>
			<div>
				<div class="board_item row">
					<div class="content">
						<img src="http://cfile9.uf.tistory.com/image/2261AA46582D467B3C3609">
						<p>주제:보노보노</p>
						<p>닉네임:보노보노</p>
						<p>소개글:보노보노보노보보노보노보노보노보보노노보노보노보노보노보노보노보노</p>
						<p>댓글수 123 신고수 0</p>
						<p>#보노보노</p>
					</div>
				</div>
				
				<c:forEach items="${ boardList }" var="board">
				<div class="board_item row">
					<div class="content">
						<input type="hidden" value="${board.boardNo}" class="boardNo">
						<img src="http://cfile9.uf.tistory.com/image/2261AA46582D467B3C3609">
						<p>${board.boardTitle }</p>
						<p>${board.writer.nickname }</p>
						<p>${board.boardContent }</p>
						<p>댓글수 0 신고수 ${board.report }</p>
						<p>#보노보노</p>
					</div>
				</div>
				</c:forEach>
			</div>		
	
	</div>
	
</body>
</html>