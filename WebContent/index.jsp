<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<!-- 기본설정 -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/custom.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- 기본설정 끝 -->
	    
	    <style>
	    body {
	    	padding-top: 0px;
	    }
	    
    	header{
    		background:url(resources/images/test2.jpeg) no-repeat center;
    		background-size: cover;
    		opacity: 0.9;
    	}
    	header .row{
    		margin-top: 0%;
    		padding-top: 200px;
    		padding-left: 27%; 
    	}
    	
    	.carousel-control.right {
    		opacity: 0;
    		background-image: 0;
    	}
    	
    	.carousel-control.left {
    		opacity: 0;
    		background-image: 0;
    	}
    </style>
    
    <script type="text/javascript">
    $(function(){	
   		$.ajax ({
   			url : "unifiedsearch/rest/recommendBook",
   			success:function(data){
   				for(var i=0; i<data.length; i++) {
	   				$("#BestSeller").append("<div class='col-xs-3 col-xs-offset-0'><img class='img-thumbnail' height='170px' width='230px' src='http://t1.daumcdn.net/book/KOR"+data[i].isbn+"' onerror='this.src='../resources/images/noimage.jpg''><div class='caption'><h4 style='color:black;'>"+data[i].title+"</h4><p style='color:black;'><strong><c:forEach items='"+data[i].authors+"' var='str' varStatus='status'> ${str} <c:if test='${!status.last}'> | </c:if></c:forEach></strong> </p></div></div></div>");
   				}
   			}
    	})	
    });
    </script>
</head>

<body>
    <header>
       <div class="row">
            <div class="col-xs-10">
                <h1>BOOKBOX</h1>
                <p class="author"><strong>Book Community</strong> <span class="text-muted"> 책으로 소통하는 공간</span></p>
            </div>
        </div>
    </header>
    
 	<div class="container">
 	<div class="row">
 		<br><br>
 	</div> 	
 	
    <div class="row">
        <div class="col-xs-2 post-title">
        	<img class='img-thumbnail' src="resources/images/creation.png" height='200px' width='200px'>
        </div>
        <div class="col-xs-3 post-title">
            <h1>창작공간</h1>
            <p class="author"><strong>Creation</strong> <span class="text-muted">창작글 | 펀딩</span></p>
        </div>
        <div class="col-xs-7 col-xs-offset-0 post-body">
            <p><br><strong>유저가 창작글을 게시하고, 해당 글의 굿즈, 책등을 출간할 수 있도록 펀딩 서비스 제공</strong></p>
        </div>
    </div>
    
    <div class="row">
        <div class="col-xs-7 col-xs-offset-0 post-body">
            <p><br><strong>자유롭게 게시물을 기록하고 활동 로그를 통하여 취향 통계를 확인 할 수 있는 공간</strong></p>
        </div>
        <div class="col-xs-3 post-title">
            <h1>북로그</h1>
            <p class="author"><strong>Book Log</strong> <span class="text-muted">포스팅 | 로그</span></p>
        </div>
         <div class="col-xs-2 post-title">
        	<img class='img-thumbnail' src="resources/images/posting.png" height='200px' width='200px'>
        </div>
    </div>
    
    <div class="row">
        <div class="col-xs-2 post-title">
        	<img class='img-thumbnail' src="resources/images/community.png" height='200px' width='200px'>
        </div>
        <div class="col-xs-3 post-title">
            <h1>소모임</h1>
            <p class="author"><strong>Community</strong> <span class="text-muted">게시판 | 채팅</span></p>
        </div>
        <div class="col-xs-7 col-xs-offset-0 post-body">
            <p><br><strong>책에 대한 생각을 자유롭게 토론 할 수 있는 커뮤니케이션 공간</strong></p>
        </div>
    </div>
    
    <div class="row">
    	<br><br>
    </div>
        
    <div class="carousel slide" data-ride="carousel" id="carousel-1">
        <div class="carousel-inner" role="listbox">
            <div class="item active"><img src="resources/images/book1.jpg">
               <div class="carousel-caption">
					<div class="row">
						<div id="BestSeller">
						</div>
					</div>
               </div>
             </div>
             <div class="item"><img src="resources/images/book1.jpg">
                 <div class="carousel-caption">
                     <h3>Slide Title</h3>
                     <p>Slide Caption</p>
                 </div>
             </div>
             <div class="item"><img src="resources/images/book1.jpg">
                 <div class="carousel-caption">
                     <h3>Slide Title</h3>
                     <p>Slide Caption</p>
                 </div>
             </div>
          </div>
          <div>
          	<a class="left carousel-control" href="#carousel-1" role="button" data-slide="prev">
          	<i class="glyphicon glyphicon-chevron-left"></i>
          	<span class="sr-only">Previous</span></a>
          	<a class="right carousel-control" href="#carousel-1" role="button" data-slide="next">
          	<i class="glyphicon glyphicon-chevron-right"></i><span class="sr-only">Next</span></a>
          </div>
          
          <ol class="carousel-indicators">
              <li data-target="#carousel-1" data-slide-to="0" class="active"></li>
              <li data-target="#carousel-1" data-slide-to="1"></li>
              <li data-target="#carousel-1" data-slide-to="2"></li>
          </ol>
      </div>
      <div>
      	<br><br>
      </div>
	</div>
 	
 	<footer>
 		<jsp:include page="layout/tailbar.jsp"/>
 	</footer>
</body>
    
    <!-- 
    <div class="container">
        <div class="carousel slide" data-ride="carousel" id="carousel-1">
            <div class="carousel-inner" role="listbox">
                <div class="item active"><img src="http://placeholdit.imgix.net/~text?txtsize=42&amp;txt=Carousel+Image&amp;w=1400&amp;h=600" alt="Slide Image">
                    <div class="carousel-caption">
                        <h3>Slide Title</h3>
                        <p>Slide Caption</p>
                    </div>
                </div>
                <div class="item"><img src="http://placeholdit.imgix.net/~text?txtsize=42&amp;txt=Carousel+Image&amp;w=1400&amp;h=600" alt="Slide Image">
                    <div class="carousel-caption">
                        <h3>Slide Title</h3>
                        <p>Slide Caption</p>
                    </div>
                </div>
                <div class="item"><img src="http://placeholdit.imgix.net/~text?txtsize=42&amp;txt=Carousel+Image&amp;w=1400&amp;h=600" alt="Slide Image">
                    <div class="carousel-caption">
                        <h3>Slide Title</h3>
                        <p>Slide Caption</p>
                    </div>
                </div>
                <div class="item"><img src="http://placeholdit.imgix.net/~text?txtsize=42&amp;txt=Carousel+Image&amp;w=1400&amp;h=600" alt="Slide Image">
                    <div class="carousel-caption">
                        <h3>Slide Title</h3>
                        <p>Slide Caption</p>
                    </div>
                </div>
            </div>
            <div><a class="left carousel-control" href="#carousel-1" role="button" data-slide="prev"><i class="glyphicon glyphicon-chevron-left"></i><span class="sr-only">Previous</span></a><a class="right carousel-control" href="#carousel-1" role="button"
                data-slide="next"><i class="glyphicon glyphicon-chevron-right"></i><span class="sr-only">Next</span></a></div>
            <ol class="carousel-indicators">
                <li data-target="#carousel-1" data-slide-to="0" class="active"></li>
                <li data-target="#carousel-1" data-slide-to="1"></li>
                <li data-target="#carousel-1" data-slide-to="2"></li>
                <li data-target="#carousel-1" data-slide-to="3"></li>
            </ol>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-lg-offset-0 col-md-6 col-md-offset-4">
                <div class="row" id="BestSeller">
                </div>
            </div>
            <div class="col-md-6">
                <div class="media">
                    <div class="media-left">
                        <a><img class="img-responsive" src="resources/images/test.jpg"></a>
                    </div>
                    <div class="media-body">
                        <h4>Media Heading</h4>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis maximus nisl ac diam feugiat, non vestibulum libero posuere. Vivamus pharetra leo non nulla egestas, nec malesuada orci finibus. </p>
                    </div>
                </div>
                <div class="media">
                    <div class="media-left">
                        <a><img class="img-responsive" src="resources/images/test.jpg" ></a>
                    </div>
                    <div class="media-body">
                        <h4>Media Heading</h4>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis maximus nisl ac diam feugiat, non vestibulum libero posuere. Vivamus pharetra leo non nulla egestas, nec malesuada orci finibus. </p>
                    </div>
                </div>
                <div class="media">
                    <div class="media-left">
                        <a><img class="img-responsive" src="resources/images/test.jpg" ></a>
                    </div>
                    <div class="media-body">
                        <h4>Media Heading</h4>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis maximus nisl ac diam feugiat, non vestibulum libero posuere. Vivamus pharetra leo non nulla egestas, nec malesuada orci finibus. </p>
                    </div>
                </div>
                <div class="media">
                    <div class="media-left">
                        <a><img class="img-responsive" src="resources/images/test.jpg" ></a>
                    </div>
                    <div class="media-body">
                        <h4>Media Heading</h4>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis maximus nisl ac diam feugiat, non vestibulum libero posuere. Vivamus pharetra leo non nulla egestas, nec malesuada orci finibus. </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
 -->
</html>