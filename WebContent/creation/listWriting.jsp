<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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

	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/css/swiper.css">
	 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.jquery.js"></script>
	
	

<style type="text/css">
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
  
  /* ////////////////별점 CSS  //////////// */
/* ////////////마우스오버///////////////// */
#starWrap ul:after {
	content: '';
	display: block;
	clear: both;
}

#starWrap ul li {
	width: 16px;
	height: 15px;
	float: left;
	background: url('../resources/images/bgStarSolo.png') no-repeat;
	cursor: pointer;
}

#starWrap.star1 .s1 {
	background-position: 0 -15px;
}

#starWrap.star2 .s1, #starWrap.star2 .s2 {
	background-position: 0 -15px;
}

#starWrap.star3 .s1, #starWrap.star3 .s2, #starWrap.star3 .s3 {
	background-position: 0 -15px;
}

#starWrap.star4 .s1, #starWrap.star4 .s2, #starWrap.star4 .s3, #starWrap.star4 .s4
	{
	background-position: 0 -15px;
}

#starWrap.star5 .s1, #starWrap.star5 .s2, #starWrap.star5 .s3, #starWrap.star5 .s4,
	#starWrap.star5 .s5 {
	background-position: 0 -15px;
}

/*///////////////// 마우스클릭/////////////////////// */
#starWrapClick ul:after {
	content: '';
	display: block;
	clear: both;
}

#starWrapClick ul li {
	width: 16px;
	height: 15px;
	float: left;
	background: url('../resources/images/bgStarSolo.png') no-repeat;
	cursor: pointer;
}

#starWrapClick.star1 .s1 {
	background-position: 0 -15px;
}

#starWrapClick.star2 .s1, #starWrapClick.star2 .s2 {
	background-position: 0 -15px;
}

#starWrapClick.star3 .s1, #starWrapClick.star3 .s2, #starWrapClick.star3 .s3
	{
	background-position: 0 -15px;
}

#starWrapClick.star4 .s1, #starWrapClick.star4 .s2, #starWrapClick.star4 .s3,
	#starWrapClick.star4 .s4 {
	background-position: 0 -15px;
}

#starWrapClick.star5 .s1, #starWrapClick.star5 .s2, #starWrapClick.star5 .s3,
	#starWrapClick.star5 .s4, #starWrapClick.star5 .s5 {
	background-position: 0 -15px;
}
   
    </style>

	
    <script>

       //============= 창작글 조회 Navigation Event  처리 =============	
   $(function() {
	   $("a.writingTitle").on("click" , function() {
   		$(self.location).attr("href","../creation/getWriting?writingNo="+$(this).attr("id")+"&creationNo="+$("input[name='creationNo']").val());
   	}); 
   }); 
    


    //========================좋아요 추가=======================
    function addLike(targetNo) {
    	var total = document.getElementById('likeSum').innerHTML;
    	
    	$.ajax ({
    		url : "../creation/rest/addLike",
    		method : "POST",
    		data : {"targetNo" : targetNo},
    		success:function(){
    			$("#addLike").replaceWith("<button id='deleteLike' onclick='deleteLike(${targetNo});'>좋아요취소</button>");
    			$("#likeSum").replaceWith("<span id='likeSum'>" + (Number(total)+1) + "</span>");
    		 } 
    	});
    	
    	alert("좋아요를 등록하셨습니다.");
    }

    //=========================좋아요 취소=================================
    function deleteLike(targetNo) {
    	var total = document.getElementById('likeSum').innerHTML;
    	
    	$.ajax ({
    		url : "../creation/rest/deleteLike",
    		method : "POST",
    		data : {"targetNo" : targetNo},
    		success:function(){
    			$("#deleteLike").replaceWith("<button id='addLike' onclick='addLike(${targetNo});'>좋아요</button>");
    		 	$("#likeSum").replaceWith("<span id='likeSum'>" + (Number(total)-1) + "</span>");
    		} 
    	});
    	alert("좋아요를 취소하셨습니다.");
    }


    
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


    <!-- 말머리 -->
	<section class="blank items">
	<h2>${creation.creationHead }</h2>
		<div class="row">
			<div class="col-md-12 text-right">
				<a type="button" class="btn btn-addWriting">창작글쓰기</a>
			</div>
		</div>
	<br>
	
	<div class="row">
	  		<div class="col-md-4">
	  			<div>
					펀딩진행중 여부
				</div>
				<input type ="hidden" name="creationNo" value="${creation.creationNo }"/>
	    		<img src="../resources/images/${creation.creationFileName }" width="320px" height="200px">
	  		</div>
				<div class="col-md-2">
					  <p>${creation.creationTitle }</p> 
					  <p>${creation.creationAuthor.nickname }</p> 
					  <c:forEach var="tag" items="${creation.tagList}">	  
					  	<p>#${tag.tagName }</p>	
					  </c:forEach>
					  <p>${creation.creationIntro }</p>
	  			</div>
		</div>
		
		<br>
	
		<div>
			<button>펀딩보러가기</button>
			<button>구독</button>
			<c:choose>
				<c:when test="${sessionScope.email == null}">
				</c:when>
		
				<c:when test="${like.doLike == false}">
					<button id="addLike" onclick="addLike(${targetNo});">좋아요</button>
				</c:when>

				<c:when test="${like.doLike == true}">
					<button id="deleteLike" onclick="deleteLike(${targetNo});">좋아요 취소</button>
				</c:when>
			</c:choose>
		</div>
	
	<br>
		<div>
			<button>이전글</button>
			<button>다음글</button>
			<button>목록</button>
		</div>

	<br>
		<div>사이트내 좋아요 개수 : <span  id="likeSum">${like.totalLike}</span></div><br>
		<div>사이트내 평균 평점 : <span id="gradeAvg">${grade.average}</span></div><br>

	</section>
		
		<div class="row">
        
		<div class="activity" style="width:100%; ">
			<c:forEach var = "writing" items="${creation.writingList }">
				<div class="activity-list-update div-posting">
				
					<input type ="text" calss="writingNo" name="writingNo" value="${writing.writingNo }" readonly>
					<img src="../resources/images/${creation.creationFileName }" alt="Image" width="100px" height="80px">
					<p><a href ="#" class="writingTitle" id="${writing.writingNo}">${writing.writingTitle }</a></p>
					<p>${writing.writingAuthor.nickname }</p>
					
					<p>${writing.regDate }</p>
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