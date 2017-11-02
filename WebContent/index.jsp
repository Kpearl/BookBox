<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
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
    	body{
    		padding-top:0px;
    	}
    	header{
    		background:url(resources/images/test2.jpg) no-repeat center;
    	}
    	.parallax { 
		    background-attachment: fixed;
		    background-size: cover;
		}
    </style>


</head>

<body>
    <header class="parallax">
    	<jsp:include page="layout/toolbar.jsp"/>
    </header>
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
                <div class="row">
                    <div class="col-md-6">
                        <div class="thumbnail"><img alt="Image" src="resources/images/book1.jpg">
                            <div class="caption">
                                <h3>BestSeller</h3>
                                <p>Author : amugae</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="thumbnail"><img alt="Image" src="resources/images/book2.jpg">
                            <div class="caption">
                                <h3>BestSeller</h3>
                                <p>Author : amugae</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="thumbnail"><img alt="Image" src="resources/images/book3.jpg">
                            <div class="caption">
                                <h3>BestSeller</h3>
                                <p>Author : amugae</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="thumbnail"><img alt="Image" src="resources/images/book4.jpg">
                            <div class="caption">
                                <h3>BestSeller</h3>
                                <p>Author : amugae</p>
                            </div>
                        </div>
                    </div>
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

</html>