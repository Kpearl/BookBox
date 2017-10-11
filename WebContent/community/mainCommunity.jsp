<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
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
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" />
	
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
		
		<h1>CAST</h1>
		<hr/>
		<div class="row">
			<div class="col-md-3">
				<div class="room_item">
					<img src="http://cfile9.uf.tistory.com/image/2261AA46582D467B3C3609">
					<div class="content">
						<p>주제:보노보노</p>
						<p>닉네임:보노보노</p>
						<p>소개글:보노보노보노보보노보노보노보노보보노노보노보노보노보노보노보노보노</p>
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
		<hr/>
			<div>
				<div class="board_item">
					<div class="content">
						<img src="http://cfile9.uf.tistory.com/image/2261AA46582D467B3C3609">
						<p>주제:보노보노</p>
						<p>닉네임:보노보노</p>
						<p>소개글:보노보노보노보보노보노보노보노보보노노보노보노보노보노보노보노보노</p>
						<p>댓글수 123 신고수 0</p>
						<p>#보노보노</p>
					</div>
				</div>
			</div>		
	
	
	</div>
	
</body>
</html>