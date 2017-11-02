<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1.0; maximum-scale=1.0; width=device-width;">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >

  	<link rel="stylesheet" href="../resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/css/custom.css">
	
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
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	
	<div class="container">
		<div class="row">
			<!-- 생성버튼 -->
			<div class="col-md-6 text-left">
			<a class="btn" href="addChatRoom">채팅방 생성</a><a class="btn" href="addBoard">게시글 작성</a>
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
		<c:forEach items="${castList}" var="cast">
		<div class="row">
			<div class="col-md-3">
				<div class="room_item">
					<c:if test="${empty cast.image }">
						<img src="http://cfile9.uf.tistory.com/image/2261AA46582D467B3C3609">
					</c:if>
					<c:if test="${empty cast.image }">
						<img src="${cast.image}">
					</c:if>
					<div class="content">
						<p>${cast.title}</p>
						<p>${cast.host.nickname}</p>
						<p>${cast.content}</p>
						<p>인원:0/100</p>
						<p>
						<c:forEach items="cast.tagList" var="tag">
						<span>tag.tagName</span>
						</c:forEach>
						</p>
					</div>
				</div>
			</div>
		</div>
		
		</c:forEach>
		
					
		<br/>
		<h1>CAMCHAT</h1>
		<hr/>
		<c:forEach items="${camChatList}" var="camChat">
		<div class="row">
			<div class="col-md-3">
				<div class="room_item">
					<c:if test="${empty camChat.image }">
						<img src="http://cfile9.uf.tistory.com/image/2261AA46582D467B3C3609">
					</c:if>
					<c:if test="${empty camChat.image }">
						<img src="${cast.image}">
					</c:if>
					<div class="content">
						<p>${camChat.title}</p>
						<p>${camChat.host.nickname}</p>
						<p>${camChat.content}</p>
						<p>인원:0/100</p>
						<p>
						<c:forEach items="camChat.tagList" var="tag">
						<span>tag.tagName</span>
						</c:forEach>
						</p>
					</div>
				</div>
			</div>
		</div>	
		</c:forEach>
		
		
		<br/>
		<h1>BOARD</h1>
		<h5 class="btn" id="moreBoard">더 보기</h5>
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