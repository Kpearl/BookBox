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

	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/css/swiper.css">
	 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.jquery.js"></script>
	
	
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

	
	 <!-- Initialize Swiper -->
    <script>
    
    $(function(){
   
    	var swiper = new Swiper('.swiper-container', {
        	pagination: '.swiper-pagination',
        	slidesPerView: 3,
        	paginationClickable: true,
        	spaceBetween: 30
	    });
    })
    
    //============= 창작공간 Navigation Event  처리 =============	
$(function() {
	$("a:contains('펀딩제목')").on("click" , function() {
		$(self.location).attr("href","../creation/getFunding");
	}); 
});
    
   //============= 펀딩글보기 Navigation Event  처리 =============	
   $(function() {
   	$("a[name='펀딩이미지']").on("click" , function() {
   		$(self.location).attr("href","../creation/getFunding");
   	}); 
 });
   
   //============= 펀딩리스트 더보기 Navigation Event  처리 =============	
   $(function() {
	   $("a[name='fundingMore']").on("click" , function() {
   		$(self.location).attr("href","../creation/getFundingList");
   	}); 
 });  
   
   //============= 픽션 창작리스트 더보기 Navigation Event  처리 =============	
   $(function() {
	   $("a.fictionMore").on("click" , function() {
   		$(self.location).attr("href","../creation/getCreationList?condition=2&keyword=픽션");
   	}); 
 });   
   
   //============= 논픽션 창작리스트 더보기 Navigation Event  처리 =============	
   $(function() {
	   $("a[name='nonfictionMore']").on("click" , function() {
   		$(self.location).attr("href","../creation/getCreationList?condition=2&keyword=논픽션");
   	}); 
 });   
   
   //============= 창작작품 회차리스트 Navigation Event  처리 =============	
   $(function() {
   	$("a:contains('창작작품명')").on("click" , function() {
   		$(self.location).attr("href","../creation/getWritingList?creationNo=");
   	}); 
 });  
   
   //============= 창작글쓰기 Navigation Event  처리 =============	
   $(function() {
	  $("a.addWriting").on("click" , function() {
		  $(self.location).attr("href","../creation/addWriting");
   	
   	}); 
 });   
   
/*    //============= 창작공간 Navigation Event  처리 =============	
   $(function() {
   	$("img[name='creationFile']).on("click" , function() {
   		$(self.location).attr("href","${param.uri}creation/getWritingList");
   	}); 
 });   */
    
    </script>
		

</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	
<div class="container">	
	<div class="row">
			<!-- 글쓰기, 펀딩등록 버튼 -->
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
			      <input type="text" class="form-control" name="keyword" id="keyword" placeholder="검색어" >
			  	 	<div class="input-group-addon">
			  			<a class="btn creationSearch">검색</a> 
			  			<!-- <button type="submit" class="btn" name="creationSearch">검색</button> -->
					</div>
			    </div>
			  </div>
			</form>
			
		</div>


	
	<h2>진행펀딩목록</h2>
    <!-- Swiper -->
    	<div class="swiper-container" id= list>
        	<div class="swiper-wrapper">
			        <div class="swiper-slide">
            				<div class="item">
					<img alt="Image" src="../resources/images/test3.jpg" name="fundingImage" >
					<h1><a href="#">펀딩제목</a></h1>
					<p>펀딩 소개글</p>
					<p>목표금액</p>
					<p>Graph</p>
					<p>남은기간</p>
					<a class="button button-buy" href="#">getFunding navigation</a>
						</div>
            		</div>

            <div class="swiper-slide">
            	
				<div class="item">
					<img alt="Image" src="../resources/images/test4.jpg"/>
					<h1>Funding title</h1>
					<p>Funding content</p>
					<p>Graph</p>
					<a class="button button-buy" href="#">Funding navigation</a>
				</div>
			
			</div>
            <div class="swiper-slide">
            	<div class="item">
					<img alt="Image" src="../resources/images/test2.jpg" />
					<h1>Funding title</h1>
					<p>Funding content</p>
					<p>Graph</p>
					<a class="button button-buy" href="#">Funding navigation</a>
				</div>
            </div>
            
            <div class="swiper-slide">
            	<div class="item">
					<img alt="Image" src="../resources/images/test3.jpg" />
					<h1>Funding title</h1>
					<p>Funding content</p>
					<p>Graph</p>
					<a class="button button-buy" href="#">Funding navigation</a>
				</div>
            </div>
            
            <div class="swiper-slide">
            	<div class="item">
					<img alt="Image" src="../resources/images/test4.jpg"/>
					<h1>Funding title</h1>
					<p>Funding content</p>
					<p>Graph</p>
					<a class="button button-buy" href="#">Funding navigation</a>
				</div>
            </div>
        </div>
        <!-- Add Pagination -->
        <div class="swiper-pagination"></div>
        </div>
        
   <hr>
   <div class="col-sm-offset-10 col-sm-2">
   	<a href="#" class="btn btn-success" name="fundingMore">펀딩 더보기</a>
   </div>
   
   <h2>픽션</h2>
   
   <div class="swiper-container" id= list>
        	<div class="swiper-wrapper">
			        <div class="swiper-slide">
            				<div class="item">
					<img alt="Image" src="../resources/images/test1.jpg" name="creationFile">
					<h1><a href="#">창작작품명</a></h1>
					<p>작성자 닉네임</p>
					
					
						</div>
 	         		</div>
 	         		
 	         		<div class="swiper-slide">창작작품2</div>
 	         		<div class="swiper-slide">창작작품3</div>
            		<div class="swiper-slide">창작작품4</div>
            </div>
              <!-- Add Pagination -->
        <div class="swiper-pagination"></div>
        
  	</div>	
            		
    <hr>    
    <div class="col-sm-offset-10 col-sm-2">
   		<a href="#" class="btn btn-success fictionMore" >더보기</a>
  	 </div>    		
            		
   <h2>논픽션</h2>
   
    <div class="swiper-container" id= list>
        	<div class="swiper-wrapper">
			        <div class="swiper-slide">
            				<div class="item">
					<img alt="Image" src="../resources/images/test2.jpg">
					<h1><a href="#">창작작품명</a></h1>
					<p>작성자 닉네임</p>
					
					
						</div>
 	         		</div>
 	         		
 	         		<div class="swiper-slide">창작작품2</div>
 	         		<div class="swiper-slide">창작작품3</div>
            		<div class="swiper-slide">창작작품4</div>
            </div>
             <!-- Add Pagination -->
        <div class="swiper-pagination"></div>
  	</div>	
  	
  	  <hr>    
    <div class="col-sm-offset-10 col-sm-2">
   		<a href="#" class="btn btn-success" name="nonfictionMore">더보기</a>
  	 </div> 

</div>

	
	
   
</body>
</html>