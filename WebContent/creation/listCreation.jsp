<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
    html, body {
        position: relative;
        height: 100%;
    }
    body {
        background: #eee;
        font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
        font-size: 14px;
        color:#000;
        margin: 0;
        padding: 0;
    }
    .swiper-container {
        width: 100%;
        height: 35%;
    }
    .swiper-slide {
        text-align: center;
        font-size: 18px;
        background: #fff;
        
        /* Center slide text vertically */
        display: -webkit-box;
        display: -ms-flexbox;
        display: -webkit-flex;
        display: flex;
        -webkit-box-pack: center;
        -ms-flex-pack: center;
        -webkit-justify-content: center;
        justify-content: center;
        -webkit-box-align: center;
        -ms-flex-align: center;
        -webkit-align-items: center;
        align-items: center;
    }
    </style>

	

    <script>
    
           //============= 창작글리스트 조회 Navigation Event  처리 =============	
   $(function() {
	  $("a.creationTitle").off('click').on("click" , function() {
   		$(self.location).attr("href","../creation/getWritingList?creationNo="+$(this).attr("id"));
   	
   	}); 
 });  
    
    </script>
		

</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	
<div class="container">
		<div class="row">
			<!-- 글쓰기, 펀딩등록 버튼 -->
			<div class="col-md-6 text-left">
			<a class="btn">창작글 쓰기</a><a class="btn" href="addBoard">펀딩등록하기</a>
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
      	  
	<h3>창작리스트</h3>
	<div class="row">
        
		<div class="activity" style="width:100%; ">
			<c:forEach var="creation" items="${creationList}" >
					<div class="activity-list-update div-creation">
					
					<input type ="text" name="creationNo" value="${creation.creationNo }"/>
					<img src="/images/uploadFiles/${creation.creationFileName }" alt="Image" width="100px" height="80px">
					<p>펀딩여부</p>
					<p><a  class="creationTitle" id="${creation.creationNo }">${creation.creationTitle }</a></p>
					<p>${creation.creationAuthor.nickname }</p>
						<c:forEach var="tag" items="${creation.tagList }">	
							<p>#${tag.tagName }</p>
						</c:forEach>
				
					
					<!-- 별점 -->
						<div id="starWrap" class="star<%-- ${book.grade.average} --%>">
							<ul>
								<li class="s1"></li>
								<li class="s2"></li>
								<li class="s3"></li>
								<li class="s4"></li>
								<li class="s5"></li>
							</ul>
						</div>
					<!-- 별점끝 -->	
					<div class="clear"></div>
				</div>
			</c:forEach>
		</div>        
		
		<hr>
        	
   	</div>
   		
</div>
   

</body>
</html>