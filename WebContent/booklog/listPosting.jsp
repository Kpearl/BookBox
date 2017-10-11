<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <c:set var="index" value="L"/> --%>

<c:if test="${param.index == 'C'}">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/css/swiper.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/css/swiper.min.css">
	 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.jquery.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.jquery.min.js"></script>

    <style>
    .swiper-container {
        width: 100%;
        padding-top: 50px;
        padding-bottom: 50px;
    }
    .swiper-slide {
        background-position: center;
        background-size: cover;
        width: 300px;
        height: 300px;
    }
    </style>
    
    
    <script type="text/javascript">
    $(function(){
        var swiper = new Swiper('.swiper-container', {
            pagination: '.swiper-pagination',
            effect: 'coverflow',
            grabCursor: true,
            centeredSlides: true,
            slidesPerView: 'auto',
            coverflow: {
                rotate: 50,
                stretch: 0,
                depth: 100,
                modifier: 1,
                slideShadows : true
            },
        	loop: true
        });
    })
    </script>


    <div class="swiper-container">
        <div class="swiper-wrapper">
            <div class="swiper-slide" style="background-image:url(http://lorempixel.com/600/600/nature/1)"></div>
            <div class="swiper-slide" style="background-image:url(http://lorempixel.com/600/600/nature/2)"></div>
            <div class="swiper-slide" style="background-image:url(http://lorempixel.com/600/600/nature/3)"></div>
            <div class="swiper-slide" style="background-image:url(http://lorempixel.com/600/600/nature/4)"></div>
            <div class="swiper-slide" style="background-image:url(http://lorempixel.com/600/600/nature/5)"></div>
            <div class="swiper-slide" style="background-image:url(http://lorempixel.com/600/600/nature/6)"></div>
            <div class="swiper-slide" style="background-image:url(http://lorempixel.com/600/600/nature/7)"></div>
            <div class="swiper-slide" style="background-image:url(http://lorempixel.com/600/600/nature/8)"></div>
            <div class="swiper-slide" style="background-image:url(http://lorempixel.com/600/600/nature/9)"></div>
            <div class="swiper-slide" style="background-image:url(http://lorempixel.com/600/600/nature/10)"></div>
        </div>
        <!-- Add Pagination -->
        <div class="swiper-pagination"></div>
    </div>

</c:if>


<c:if test="${param.index == 'L'}">
	<div class="container">
		<div class="activity" style="width:100%;">
			<div class="activity-list-update">
				<img src="../resources/images/test.jpg" alt="Image" width="100px" height="80px">
				<p><strong>Posting Title</strong> Posting Context <a href="#">user profile</a>.</p>
				<div class="clear"></div>
			</div>
			<div class="activity-list-update">
				<img src="../resources/images/test.jpg" alt="Image" width="100px" height="80px">
				<p><strong>Posting Title</strong> Posting Context <a href="#">user profile</a>.</p>
				<div class="clear"></div>
			</div>
			<div class="activity-list-update">
				<img src="../resources/images/test.jpg" alt="Image" width="100px" height="80px">
				<p><strong>Posting Title</strong> Posting Context <a href="#">user profile</a>.</p>
				<div class="clear"></div>
			</div>
		</div>
	</div>
</c:if>