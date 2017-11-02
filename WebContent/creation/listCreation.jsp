<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<!-- 기본설정 -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/css/custom.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- 기본설정 끝 -->

	<!-- 평점 별 css -->
	<link rel="stylesheet" href="../resources/css/star.css">
	
	<style>
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
    
   $(function() {
  //============= 창작글리스트 조회 Navigation Event  처리 =============	
	  $("a.creationTitle").on("click" , function() {
   		$(self.location).attr("href","../creation/getWritingList?creationNo="+$(this).attr("id"));
   	
   	}); 
           
   //============= 검색 Event  처리 =============	
	  $("a.creationSearch").on("click" , function() {
   		$(self.location).attr("href","../creation/getCreationList?condition="+$("select[name='condition']").val()+"&keyword="+$("input[name='keyword']").val());
   	
   	}); 
   
 //============= 창작글쓰기 Navigation Event  처리 =============	
	  $("a.addWriting").on("click" , function() {
		  $(self.location).attr("href","../creation/addWriting");
   	
   	}); 
    
   //============= 펀딩등록하기 Navigation Event  처리 =============	
	  $("a.addfunding").on("click" , function() {
		  $(self.location).attr("href","../creation/addFunding");
   	
   	}); 
   
	//이미지 불러오기 실패시 기본 이미지 출력
	$('img.creation-img').on('error', function(){
		console.log("에러");
		$(this).attr('src', '../resources/images/creation_noimage.jpg');
	});
	
	$('.creation-row:nth-child(2n)').find('.col-md-5').addClass('col-md-push-7');
	$('.creation-row:nth-child(2n)').find('.col-md-7').addClass('col-md-pull-5');

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
				<c:if test="${!empty sessionScope.user }">
					<a class="btn btn-default addWriting">창작글 쓰기</a>
					<a class="btn btn-default addfunding">펀딩등록하기</a>
				</c:if>
			</div>
			<!-- 생성버튼 끝 -->
		 	
		 	<form class="form-inline text-right col-md-6" action="getCommunityMain" method="get">
			  <div class="form-group">
			    <div class="input-group">
			      <div class="input-group-addon">
			      	<select class="form-control" name="condition">
			      		<option value="3" ${ ! empty search.condition && search.condition==3 ? "selected" : "" }></option>
			      		<option value="0" ${ ! empty search.condition && search.condition==0 ? "selected" : "" }>제목</option>
			      		<option value="1" ${ ! empty search.condition && search.condition==1 ? "selected" : "" }>작가</option>
			      		<option value="2" ${ ! empty search.condition && search.condition==2 ? "selected" : "" }>태그</option>
			      	</select>
			      </div>
			      <input type="text" class="form-control" name="keyword" id="keyword" placeholder="검색어">
			  	 	<div class="input-group-addon">
			  			<a class="btn creationSearch">검색</a> 
			  			<!-- <button type="submit" class="btn" name="creationSearch">검색</button> -->
					</div>
			    </div>
			  </div>
			</form>
			
		</div>
      	  
	<h3>창작리스트</h3>

	<div class="row">
		<c:forEach var="creation" items="${creationList}" >
		<div class="row creation-row">
			<%-- <input type ="text" name="creationNo" value="${creation.creationNo }"/> --%>
			<div class="col-md-5">
				<img class="img-responsive creation-img" src="../resources/upload_files/images/${creation.creationFileName}" alt="Image">
				<!-- <img class="img-responsive creation-img" src="../resources/images/creation_noimage.jpg" alt="Image"> -->
				<p>펀딩여부</p>
			</div>
			<div class="col-md-7">
				<p><a  class="creationTitle" id="${creation.creationNo }">${creation.creationTitle }</a></p>
				<p>${creation.creationAuthor.nickname }</p>
					<c:forEach var="tag" items="${creation.tagList }">	
						<span>#${tag.tagName }</span>
					</c:forEach>
						
				<!-- 별점 -->
				<div id="starWrap" class="star5<%-- ${book.grade.average} --%>">
					<ul>
						<li class="s1"></li>
						<li class="s2"></li>
						<li class="s3"></li>
						<li class="s4"></li>
						<li class="s5"></li>
					</ul>
				</div>
				<!-- 별점끝 -->	
			</div>
		</div>        
		</c:forEach>
	</div>
		
        	
</div>

</body>
</html>