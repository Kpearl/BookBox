<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
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
    </script>
		

</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	
<div class="container">	
	
	<h3>진행펀딩목록</h3>
    <!-- Swiper -->
    	<div class="swiper-container" id= list>
        	<div class="swiper-wrapper">
			        <div class="swiper-slide">
            				<div class="item">
					<img alt="Image" src="../resources/images/test3.jpg">
					<h1><a href="#">Funding title</a></h1>
					<p><a href="#">Funding content</a></p>
					<p>Graph</p>
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
   	<a href="#" class="btn btn-success" name="more">펀딩 더보기</a>
   </div>
   
   <h3>픽션</h3>
   
   <div class="swiper-container" id= list>
        	<div class="swiper-wrapper">
			        <div class="swiper-slide">
            				<div class="item">
					<img alt="Image" src="../resources/images/test1.jpg">
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
   		<a href="#" class="btn btn-success" name="more">더보기</a>
  	 </div>    		
            		
   <h3>논픽션</h3>
   
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
   		<a href="#" class="btn btn-success" name="more">더보기</a>
  	 </div> 

</div>

	
	
   
</body>
</html>