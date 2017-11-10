<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, width=device-width">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<script src="../resources/javascript/toolbar_opac.js"></script>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >

  	<link rel="stylesheet" href="../resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/css/custom.css">
	
	<style>
		body{
    		padding-top:0px;
    	}
    	header{
    		background:url(../resources/images/community.jpeg) no-repeat center;
    	}
	
   		.room_item{
   			height: 355px;
   			width: 250px;
   			border: solid 2px #62BFAD;
   			display: inline-block;
   			box-shadow: 3px 3px 3px #62BFAD;
   			margin: 10px;
   		}
   		
   		.room_item .room-image{
   			/*
   			height: 45%;
   			*/
   			overflow: hidden;
   			height: 150px;
   		}
   		.room_item .room-image img{
   			/*
   			*/
   			height: 150px;
   			width:250px;
   			object-fit: cover;
   			background-color: #F9F7E8;
   			
   		}
   		
   		.room_item .content{
   			background-color: #F9F7E8;
			/*
   			height: 55%;
   			*/
   			height: 200px;
   			overflow: hidden;
   			text-overflow:ellipsis;
   			width: 100%;
   		}
   		.room_item .content div {
   			text-overflow:ellipsis;
   			width: 100%;
   			margin: 0;
   			
   		}
   		.room_item .content .content-titlee{
   			height: 25px;		
   			background-color: 	#62BFAD;
   			font-weight: bold;
   			overflow: hidden;
   			
   		}
   		.room_item .content .content-content{
   			height: 90px;
   			overflow: hidden;
   			
   		}
   		.room_item .content .content-user{
   			height: 25px;
   		}
   		.room_item .content .content-tag{
   			height: 25px;
   		}
   		
   	/*============ 게시판 CSS==================*/
   		.board_item{
   			height: 145px;
   			border: solid 2px #62BFAD;
   			margin-top: 10px;
   			/*
   			border-radius: 10px;
   			*/
   			box-shadow: 3px 3px 3px #62BFAD;
   		}
		.board_item .board-title{
			/*
			border-radius: 9px 9px 0px 0px;
			*/
			background-color: #62BFAD;
		}   		
   		.board_item img{
   			
   			width: 100%;
   			height: 115px;
   			/*
   			max-height: 100%;
   			*/
   			object-fit: cover;
   		}
   		.board_item p{
   			text-overflow:ellipsis;
   			width: 100%;
   			margin: 0;
   		}
   		
   		.board_item .content{
   			height:116px;
   			/*
   			border-radius: 0px 0px 10px 0px;
   			*/
   			background-color: #F9F7E8;
   		}
   	
    </style>
    
    <script type="text/javascript">
    var condition;
	ToolbarOpacHeight(500);
    //채팅방 상세보기 이벤트
    $(function(){
    	$(".room_item").on("click",function(){
    		//alert($("input",this).val())
    		self.location=$("input",this).val();
    	});
    });
    
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
	<header class="parallax"></header>
	
		
	<div class="container">
		<div class="row">
			<!-- 생성버튼 -->
			<div class="col-md-6 text-left">
			<div>
			<a class="btn btn-default" href="addChatRoom">채팅방 생성</a><a class="btn btn-default" href="addBoard">게시글 작성</a>
			</div>
			<br>
			<a class="btn addChatRoomModal" data-toggle="modal" data-target="#addChatRoom">채팅방 생성</a>
			<a class="btn addBoardModal" data-toggle="modal" data-target="#addBoard">게시판 생성</a>
			
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
		<!--   ==================방송=========================     -->
		<h1>CAST</h1>
		<hr/>
		<div class="row text-center">
			<c:forEach items="${castList}" var="room">
					<!--  
			<div class="col-md-3 col-sm-4 col-xs-6">
			-->
				<div class="room_item">
					<input type="hidden" value="getCast?roomId=${room.roomId}">
					<div class="room-image text-center">
						<c:if test="${empty room.image }">
							<img src="../resources/images/noimage.png">
						</c:if>
						<c:if test="${!empty room.image }">
							<img src="${room.image}">
						</c:if>
					</div>
					<div class="content">
						<div class="content-titlee text-center">${room.title}</div>
						<div class="content-nickname">${room.host.nickname}</div>
						<div class="content-content">${room.content}</div>
						<div class="content-user">인원:${ room.currentUser }/${ room.maxUser }</div>
						<div class="content-tag">
						<c:forEach items="${room.tagList}" var="tag">
							<span>#${tag.tagName}</span>
						</c:forEach>
						</div>
					</div>
				 </div>			
			<!-- 
			</div>
			 -->	
			</c:forEach>
		</div>
					
		<br/>
			<!--   ==================채팅방=========================     -->
		<h1>CAMCHAT</h1>
		<hr/>
		<div class="row text-center">
		<c:forEach items="${camChatList}" var="room">
			<!--  
			<div class="col-md-3 col-sm-4 col-xs-6">
			-->
				<div class="room_item">
					<input type="hidden" value="getCamChat?roomId=${room.roomId}">
					<div class="room-image text-center">
						<c:if test="${empty room.image }">
							<img src="../resources/images/noimage.png">
						</c:if>
						<c:if test="${!empty room.image }">
							<img src="${room.image}">
						</c:if>
					</div>
					<div class="content">
						<div class="content-titlee text-center">${room.title}</div>
						<div class="content-nickname">${room.host.nickname}</div>
						<div class="content-content">${room.content}</div>
						<div class="content-user">인원:${ room.currentUser }/${ room.maxUser }</div>
						<div class="content-tag">
						<c:forEach items="${room.tagList}" var="tag">
							<span>#${tag.tagName}</span>
						</c:forEach>
						</div>
					</div>
				 </div>			
			<!-- 
			</div>
			 -->	
		</c:forEach>
		</div>	
		
		
		<br/>
		<h1>BOARD</h1>
		<h5 class="btn" id="moreBoard">더 보기</h5>
		<hr/>
			<div>
				<c:forEach items="${ boardList }" var="board">
				<div class="board_item row">
					<div class="board-title col-xs-12 text-left">${board.boardTitle }</div>
					<div class="col-md-2 col-sm-3 col-xs-4 text-center">
						<c:if test="${empty board.thumbnailUrl}">
							<img src="../resources/images/noimage.png">
						</c:if>
						<c:if test="${!empty board.thumbnailUrl}">
							<img src="${board.thumbnailUrl}" onerror="this.src='../resources/images/noimage.png'">
						</c:if>
					</div>
					<div class="content col-md-10 col-sm-9 col-xs-8">
						<input type="hidden" value="${board.boardNo}" class="boardNo">
					
						<!-- 제목이었는데 제거
						<p>${board.boardTitle }</p>
						 -->
						<div class="text-right"><small>${board.boardRegDate}</small></div>
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
	
	<div class="modal fade" id="addChatRoom" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title" id="exampleModalLabel">채팅방 생성</h4>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	       	<jsp:include page="addChatRoomViewModal.jsp"></jsp:include>
	      </div>
	      <div class="modal-footer">
	        <button class="submit addChatRoom btn prime-btn">생성</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	<div class="modal fade" id="addBoard" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title" id="exampleModalLabel">게시글 생성</h4>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	       	<jsp:include page="addBoardViewModal.jsp"></jsp:include>
	      </div>
	      <div class="modal-footer">
	        <button class="submit addBoard btn prime-btn">생성</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	
</body>
</html>