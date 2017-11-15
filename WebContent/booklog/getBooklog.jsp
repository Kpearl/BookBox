<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

	<!-- Swiper 설정 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.5/css/swiper.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.5/css/swiper.min.css">
	 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.5/js/swiper.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.5/js/swiper.min.js"></script>
	<!-- Swiper 설정 끝 -->

	<!-- Chart.js 설정 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.bundle.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.js"></script>
	<!-- Chart.js 설정 끝 -->
	
	<script src="../resources/javascript/custom.js"></script>
	
    <style>
    	.booklog-btn{
    		cursor: pointer;
			padding: 8px;
			background: #3D3D3D;
			color: #F9F7F7;
			font-weight: bold;
    	}
    	.swiper-posting-box{
    		position: relative;
    		width: 100%;
    		height: 500px;
    		background: rgba(114, 114, 114, 0.3);
    		margin: 0;
    		padding: 0;
    	}
	    .swiper-container {
	        width: 100%;
	        height: 400px;
	        margin-left: auto;
	        margin-right: auto;
	    }
	    .swiper-slide {
	        background-position: center;
	        background-size: cover;
	    }
	    .gallery-top{
	    	height: 80%;
	    	width: 100%;
	    }
	    .gallery-thumbs{
	    	height: 20%;
	    	box-sizing: border-box;
	    	padding: 10px 0;
	    }
	    .gallery-thumbs .swiper-slide{
	    	width: 25%;
	    	height: 100%;
	    	opacity: 0.4;
	    }
	    .gallery-thumbs .swiper-slide-active{
	    	opacity: 1;
	    }
	    
	    div.div-posting img{
	    	opacity: 0.8;
	    }
	    
	    div.div-posting{
	    	margin: 0;
	    	height: 15%;
	    	padding: 0 40px;
	    }
	    .posting-preview{
	    	position: absolute;
	    	width: 100%;
	    	height: 100%;
	    }
	    .posting-preview-content{
	    	height: 15%;
	    	width: 100%;
	    	position: absolute;
	    	bottom: 0;
	    	background-color: rgba(219, 226, 239, 0.6);
	    	-webkit-transition: 0.3s;
	    	   -moz-transition: 0.3s;
	    			transition: 0.3s;
	    }
	    .posting-preview-content:hover{
	    	height: 40%;
	    	-webkit-transition: 0.3s;
	    	   -moz-transition: 0.3s;
	    			transition: 0.3s;
	    }
	    
	    ul.timeline{
	    	position: relative;
	    	margin: 0 0 30px 0;
	    	padding: 0;
	    	list-style: none;
	    }
	    ul.timeline:before{
	    	content: '';
	    	position: absolute;
	    	top: 0;
	    	bottom: 0;
	    	width: 4px;
	    	background: #ddd;
	    	left: 21px;
	    	margin: 0;
	    	border-radius: 2px;
	    }
	    ul.timeline > li{
	    	position: relative;
	    	margin-bottom: 15px;
	    }
	    ul.timeline > li:after{
	    	clear: both;
	    }
	    ul.timeline > li:before, ul.timeline > li:after{
	    	content: '';
	    	display: table;
	    }
	    ul.timeline > li > .glyphicon{
	    	width: 30px;
	    	height: 30px;
	    	font-size: 15px;
	    	line-height: 30px;
	    	position: absolute;
	    	border-radius: 50%;
	    	text-align: center;
	    	left: 8px;
	    	top: 0;
	    	color: #fff;
	    }
	    ul.timeline > li > .timeline-item{
	    	border-radius: 3px;
	    	margin-top: 0;
	    	color: #444;
	    	margin-left: 45px;
	    	margin-right: 15px;
	    	padding: 0;
	    	position: relative;
	    	-webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
	    			box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
	    }
	    ul.timeline > li > .timeline-item > .time{
	    	color: #999;
	    	float: right;
	    	padding: 10px;
	    	font-size: 12px;
	    }
	    ul.timeline > li > .timeline-item > .timeline-body{
	    	padding: 10px;
	    	cursor: pointer;
	    }
	    .log-booklog-background{
	    	background-color: #0073b7 !important;
	    }
	    .log-creation-background{
	    	background-color: #00c0ef !important;
	    }
	    .log-community-background{
	    	background-color: #f39c12 !important;
	    }
	    .log-book-background{
	    	background-color: #d81b60 !important;
	    }
	    .log-more-background{
	    	background-color: #d2d6de !important;
	    }
    </style>

<script type="text/javascript">
	var booklogUser;
	var booklogNo;
	var booklogName;
	var user;
	var logPage = 1;

	$(function(){
		booklogUser = $('input[name="user.email"]').val();
		booklogNo = $('input[name="booklogNo"]').val();
		booklogName = $('input[name="booklogName"]').val();
		user = $('input[name="user"]').val();
		
		$('div.btn-form.posting-list').on('click',function(){
			$(self.location).attr('href','../booklog/getPostingList?condition=booklog&keyword='+booklogUser);
		});
		$('div.div-posting').on('click', function(){
			var postingNo = $(this).find('input[type="hidden"]').val();
			$(self.location).attr("href","../booklog/getPosting?postingNo="+postingNo+"&condition=booklog&keyword="+booklogUser);
		});
		$('div.booklog-btn:contains("표지편집")').on('click', function(){
			$(self.location).attr('href','../booklog/updateBooklog?user.email='+booklogUser);
		});
		$('div.booklog-btn:contains("포스팅등록")').on('click', function(){
			$(self.location).attr('href','../booklog/addPosting');
		});
		if(user != '' && user != null && user != booklogUser){
			$('i.nobookmarked').on('click', function(){
				fncAddBookmark($(this));
			});
			$('i.bookmarked').on('click', function(){
				fncDeleteBookmark($(this));
			});
		}else{
			$('i.nobookmarked').css('cursor', 'auto');
			$('i.bookmarked').css('cursor', 'auto');
		}
		
		$('.booklog-img').css('height', $('.booklog-img').find('div').find('img').css('width'));
		
		fncAddLogCSS();
		
		$('.log-more-background').on('click', function(){
			$('.log-more-background .loading-img').show();
			$.ajax({
				url: 'rest/getLogList/'+booklogUser+'/'+logPage,
				method: 'get',
				dataType: 'json',
				success: function(data){
					var lastLi = $('.timeline > li:last');
					if(data.length > 0){
						for(x in data){
							var logHtml = '<li><i class="log-category"><input type="hidden" name="category" value="'+data[x].categoryNo+'"></i>';
							logHtml += '<div class="timeline-item booklog-background"><span class="time"><i class="glyphicon glyphicon-time"></i>'+data[x].logTimeAgo+'</span>';
							logHtml += '<div class="timeline-body"><input type="hidden" name="link" value="'+data[x].link+'">';
							logHtml += '<span><small>'+data[x].logString+'</small></span></div></div></li>';
							$(lastLi).before(logHtml);
						}
						logPage += 1;
						fncAddLogCSS();
					}else{
						$('.log-more-background').css('cursor', 'not-allowed')
												.off('click')
												.removeClass('glyphicon-option-vertical')
												.addClass('glyphicon-flag');
					}
				},
				complete: function(){
					$('.log-more-background .loading-img').hide();
				}
			});
		});
		
		$.ajax({
			url: 'rest/getCounts/'+booklogUser.split('@')[0]+'/'+booklogUser.split('.')[0].split('@')[1]+'/'+booklogUser.split('.')[1]+'/1',
			method: 'get',
			dataType: 'json',
			success: function(data){
				$($('.content-count')[0]).html(data.counts.cc>999? '999+':data.counts.wc).find('.loading-img').hide();
				$($('.content-count')[1]).html(data.counts.pc>999? '999+':data.counts.pc).find('.loading-img').hide();
				$($('.content-count')[2]).html(data.counts.bc>999? '999+':data.counts.bc).find('.loading-img').hide();
			}
		});
	});
	
	$(window).resize(function(){
		$('.booklog-img').css('height', $('.booklog-img').find('div').find('img').css('width'));
	});

	$(function(){
		/* swiper 설정 */
	<c:if test="${booklog.postingList.size() != 0}">
        var galleryTop = new Swiper('.gallery-top', {
            spaceBetween: 10,
            navigation: {
            	nextEl: '.swiper-button-next',
              	prevEl: '.swiper-button-prev',
            },
            grabCursor: true,
        });
        var galleryThumbs = new Swiper('.gallery-thumbs', {
            spaceBetween: 10,
            centeredSlides: true,
            slidesPerView: 'auto',
            touchRatio: 0.2,
            slideToClickedSlide: true,
        });
        galleryTop.controller.control = galleryThumbs;
        galleryThumbs.controller.control = galleryTop;
	</c:if>
        /* chart 설정 */
		var ctxDaily = $("#dailyChart");
		var dailyChart = new Chart(ctxDaily, {
		    type: 'bar',
		    data: {
		        labels: [fncGetDate(6),
		        			fncGetDate(5),
		        			fncGetDate(4),
		        			fncGetDate(3),
		        			fncGetDate(2),
		        			fncGetDate(1),
		        			fncGetDate(0)],
		        datasets: [{
					label: '# of DailyVisitors',
		            data: [
		            	<c:forEach items="${booklog.visitorsStatistics.daily}" var="daily">
		            		${daily.daycount},
		            	</c:forEach>
				            ],
		            backgroundColor: [
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(54, 162, 235, 0.2)',
		                'rgba(255, 206, 86, 0.2)',
		                'rgba(75, 192, 192, 0.2)',
		                'rgba(153, 102, 255, 0.2)',
		                'rgba(255, 159, 64, 0.2)',
		                'rgba(0, 0, 0, 0.2)'
		            ],
		            borderColor: [
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(54, 162, 235, 0.2)',
		                'rgba(255, 206, 86, 0.2)',
		                'rgba(75, 192, 192, 0.2)',
		                'rgba(153, 102, 255, 0.2)',
		                'rgba(255, 159, 64, 0.2)',
		                'rgba(0, 0, 0, 0.2)'
		            ],
		            borderWidth: 1
		        }]
		    },
		    options: {
		        scales: {
		            yAxes: [{
		                ticks: {
		                    beginAtZero:true
		                    //stepSize:1
		                }
		            }]
		        }
		    }
		});

		var ctxWeekly = $("#weeklyChart");
		var weeklyChart = new Chart(ctxWeekly, {
		    type: 'bar',
		    data: {
		        labels: ['6주 전',
		        			'5주 전',
		        			'4주 전',
		        			'3주 전',
		        			'2주 전',
		        			'1주 전',
		        			'이번주'],
		        datasets: [{
		            label: '# of WeeklyVisitors',
		            data: [
		            	<c:forEach items="${booklog.visitorsStatistics.weekly}" var="weekly">
		            		${weekly.weekcount},
		            	</c:forEach>
							],
		            backgroundColor: [
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(54, 162, 235, 0.2)',
		                'rgba(255, 206, 86, 0.2)',
		                'rgba(75, 192, 192, 0.2)',
		                'rgba(153, 102, 255, 0.2)',
		                'rgba(255, 159, 64, 0.2)',
		                'rgba(0, 0, 0, 0.2)'
		            ],
		            borderColor: [
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(54, 162, 235, 0.2)',
		                'rgba(255, 206, 86, 0.2)',
		                'rgba(75, 192, 192, 0.2)',
		                'rgba(153, 102, 255, 0.2)',
		                'rgba(255, 159, 64, 0.2)',
		                'rgba(0, 0, 0, 0.2)'
		            ],
		            borderWidth: 1
		        }]
		    },
		    options: {
		        scales: {
		            yAxes: [{
		                ticks: {
		                    beginAtZero:true
		                    //stepSize:1
		                }
		            }]
		        }
		    }
		});

		var ctxMonthly = $("#monthlyChart");
		var monthlyChart = new Chart(ctxMonthly, {
		    type: 'bar',
		    data: {
		        labels: ['4달 전',
		        			'3달 전',
		        			'2달 전',
		        			'1달 전',
		        			'이번달'],
		        datasets: [{
		            label: '# of MonthlyVisitors',
		            data: [
		            	<c:forEach items="${booklog.visitorsStatistics.monthly}" var="monthly" begin="2" end="6">
		            		${monthly.monthcount},
		            	</c:forEach>
							],
		            backgroundColor: [
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(54, 162, 235, 0.2)',
		                'rgba(255, 206, 86, 0.2)',
		                'rgba(75, 192, 192, 0.2)',
		                'rgba(153, 102, 255, 0.2)'
		            ],
		            borderColor: [
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(54, 162, 235, 0.2)',
		                'rgba(255, 206, 86, 0.2)',
		                'rgba(75, 192, 192, 0.2)',
		                'rgba(153, 102, 255, 0.2)'
		            ],
		            borderWidth: 1
		        }]
		    },
		    options: {
		        scales: {
		            yAxes: [{
		                ticks: {
		                    beginAtZero:true
		                    //stepSize:1
		                }
		            }]
		        }
		    }
		});
		
		var ctxTag = $('#tagChart');
		var labels = [];
		<c:forEach items="${booklog.visitorsStatistics.tag}" var="tag">
			labels.push('${tag.tagName}');
		</c:forEach>

		var tagChart = new Chart(ctxTag, {
			type: 'bubble',
			data: {
				datasets: [{
					label: 'Tag Dataset',
					data: [
						<c:forEach items="${booklog.visitorsStatistics.tag}" var="tag">
							{x: (Math.random()-0.5), y: (Math.random()-0.5), r: ${tag.per}},
						</c:forEach>
					],
					backgroundColor: 'rgb(255, 99, 132)'
				}]
			},
		    options: {
		        tooltips: {
		        	callbacks: {
 		        		label: function(tooltipItem, data){
		        			return labels[tooltipItem.index]+', '+Math.round(data.datasets[0].data[tooltipItem.index].r)+'%';
		        		} 
		        	}
		        },
		        scales: {
		        	yAxes: [{
		        		ticks: {
			        		suggestedMin: -0.6,
			        		suggestedMax: 0.6,
			        		display: false,
			        		stepSize: 0.3
		        		},
		        		gridLines: {
		        			display: false
		        		}
		        	}],
		        	xAxes: [{
		        		ticks: {
			        		suggestedMin: -0.6,
			        		suggestedMax: 0.6,
			        		display: false,
			        		stepSize: 0.3
		        		},
		        		gridLines: {
		        			display: false
		        		}
		        	}]
		        }
		    }
		});

		
		/* tab 설정 */
		$('#tagTab').tab('show');
		$('#chartTab').tab('show');
    });
	
	function fncAddBookmark(elmA){
		$.ajax({
			url : '../booklog/rest/addBookmark/'+booklogUser+'/'+booklogNo,
			method : 'get',
			dataType : 'json',
			success : function(data){
				if(data){
					var count = $($('.content-count')[2]).html();
					alert("'"+booklogName+"' 북로그를 책갈피에 등록하였습니다.");
					$($('.content-count')[2]).html(Number(count)+1);
					$(elmA).removeClass('nobookmarked').addClass('bookmarked').off('click').on('click', function(){
						fncDeleteBookmark(elmA);
					});
				}else{
					alert("잠시 후 다시 시도해 주세요..");
				}
			}
		});
	}
	
	function fncDeleteBookmark(elmA){
		$.ajax({
			url : '../booklog/rest/deleteBookmark/'+booklogUser+'/'+booklogNo,
			method : 'get',
			dataType : 'json',
			success : function(data){
				if(data){
					var count = $($('.content-count')[2]).html();
					alert("'"+booklogName+"' 북로그를 책갈피에서 삭제하였습니다.");
					$($('.content-count')[2]).html(Number(count)-1);
					$(elmA).removeClass('bookmarked').addClass('nobookmarked').off('click').on('click', function(){
						fncAddBookmark(elmA);
					});
				}else{
					alert("잠시 후 다시 시도해 주세요..");
				}
			}
		});
	}
	
	function fncAddLogCSS(){
		$('.timeline-body').off('click').on('click', function(){
			$(self.location).attr('href', $(this).find('input[name="link"]').val());
		});
		
		$('.log-category').removeClass(function(){
			return $(this).attr('class');
		}).addClass(function(){
			var category = $(this).find('input').val();
			if(category == 1 || category == 2 || category == 3){
				return 'log-category glyphicon glyphicon-pencil log-creation-background';
			}else if(category == 4 || category == 5){
				return 'log-category glyphicon glyphicon-grain log-booklog-background';
			}else if(category == 6 || category == 7 || category == 8){
				return 'log-category glyphicon glyphicon-phone log-community-background';
			}else if(category == 9){
				return 'log-category glyphicon glyphicon-book log-book-background';
			}
		});
	}
    
</script>


</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<!-- 여기부터 코딩 -->
	<input type="hidden" name="user.email" value="${booklog.user.email}">
	<input type="hidden" name="booklogNo" value="${booklog.booklogNo}">
	<input type="hidden" name="booklogName" value="${booklog.booklogName}">
	<input type="hidden" name="user" value="${sessionScope.user.email}">
	<div class="container">

		<div class="row">

			<div class="col-md-3 col-md-push-9">
			
				<div class="row booklog-profile">
				
					<div class="col-xs-1 col-sm-2 hidden-md hidden-lg"></div>
					<div class="col-xs-10 col-sm-8 col-md-12">
						<div class="row text-center booklog-img">
							<div class="col-xs-offset-1 col-xs-10 booklog-img">
								<img class="img-responsive img-circle center-block img-object-fit" src="../resources/upload_files/images/${booklog.booklogImage}">
							</div>
						</div>
				
						<!-- 북로그이미지, 소개글, 이름 -->
						<div class="row text-center booklog-name">
							<h4><em>${booklog.booklogName}</em></h4>
						</div>
						<div class="row text-center booklog-intro booklog-background">
							<p>${booklog.booklogIntro}</p>
						</div>
						<div class="row text-center booklog-content-num">
							<div class="col-xs-4 text-center">
								<span class="content-icon"><i class="glyphicon glyphicon-pencil"></i></span><br/>
								<span class="content-count"><img class="loading-img" src="../resources/images/loading.gif" style="height: 25px;"></span>
							</div>
							<div class="vertical-line"></div>
							<div class="col-xs-4 text-center">
								<span class="content-icon"><i class="glyphicon glyphicon-grain"></i></span><br/>
								<span class="content-count"><img class="loading-img" src="../resources/images/loading.gif" style="height: 25px;"></span>
							</div>
							<div class="vertical-line"></div>
							<div class="col-xs-4 text-center">
								<span class="content-icon"><i class="glyphicon glyphicon-bookmark ${bookmark? 'bookmarked' : 'nobookmarked'}" style="cursor: pointer;"></i></span><br/>
								<span class="content-count"><img class="loading-img" src="../resources/images/loading.gif" style="height: 25px;"></span>
							</div>
						</div>
					</div>

				</div>
				<c:if test="${sessionScope.user.email == booklog.user.email}">
				<div class="row" style="margin: -10px; margin-bottom: 10px; margin-top: -20px; box-shadow: 3px 1px 2px 0px;">
					<div class="col-xs-6 text-center booklog-btn">
						표지편집
					</div>
					<div class="vertical-line" style="margin-top: 10px; height: 20px;"></div>
					<div class="col-xs-6 text-center booklog-btn">
						포스팅등록
					</div>
				</div>
				</c:if>
				
				<div class="row">
					<div class="col-md-12 hidden-xs hidden-sm">
						<ul class="timeline">
						<c:forEach items="${logList}" var="log">
							<li>
								<i class="log-category"><input type="hidden" name="category" value="${log.categoryNo}"></i>
								<div class="timeline-item booklog-background">
									<span class="time"><i class="glyphicon glyphicon-time"></i> ${log.logTimeAgo}</span>
									<div class="timeline-body">
										<input type="hidden" name="link" value="${log.link}">
										<span><small>${log.logString}</small></span>
									</div>
								</div>
							</li>
						</c:forEach>
							<li>
								<i class="glyphicon glyphicon-option-vertical log-more-background" style="cursor: pointer;"></i>
								<div class="text-center">
									<img class="loading-img" src="../resources/images/loading.gif" style="height: 30px; display:none;">
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>


			<div class="col-md-8 col-md-pull-3">
				<div class="row">
				
					<div class="col-md-12">
					
						<c:if test="${booklog.postingList.size() != 0}">
							<div class="btn-form posting-list">포스팅 더 보기</div>
							<div class="swiper-posting-box">
							    <div class="swiper-container gallery-top">
							        <div class="swiper-wrapper">
						        	<c:set var="i" value="0"/>
						        	<c:forEach items="${booklog.postingList}" var="posting">
						        		<c:set var="i" value="${i+1}"/>
						        		<div class="swiper-slide">
						        			<div class="posting-preview">
							        			<img class="img-object-fit" src="../resources/upload_files/images/${!empty posting.postingFileList? posting.postingFileList[0].fileName : '../../images/posting_noimage.jpeg'}"/>
						        			</div>
						        			<div class="div-posting posting-preview-content booklog-font-color">
												<input type="hidden" name="postingNo" value="${posting.postingNo}"/>
												<h3>${posting.postingTitle}</h3>
												<span class="posting-content">${posting.postingContent}</span>
						        			</div>
						        		</div>
						        	</c:forEach>
							        </div>
							        <!-- Add Arrows -->
							        <div class="swiper-button-next swiper-button-black"></div>
							        <div class="swiper-button-prev swiper-button-black"></div>
							    </div>
	
							    <div class="swiper-container gallery-thumbs">
							        <div class="swiper-wrapper">
						        	<c:set var="i" value="0"/>
						        	<c:forEach items="${booklog.postingList}" var="posting">
						        		<c:set var="i" value="${i+1}"/>
						        		<div class="swiper-slide" style="cursor: pointer; background-image: url(../resources/upload_files/images/${!empty posting.postingFileList? posting.postingFileList[0].fileName : '../../images/posting_noimage.jpeg'})"></div>
						        	</c:forEach>
							        </div>
							    </div>
							</div>
						</c:if>
			        	<c:if test="${booklog.postingList.size() == 0}">
			        		<h3>아직 등록된 포스팅이 없습니다!</h3>
			        	</c:if>
				
						<div class="row">
							<div class="col-sm-6">
								<ul class="nav nav-tabs" role="tablist" id="tagTab">
									<li role="presentation" class="active">
										<a href="#tag" aria-controls="tag" role="tab" data-toggle="tab">
											태그통계
										</a>
									</li>
								</ul>
								<div class="tab-content">
									<div role="tabpanel" class="tab-pane fade in active" id="tag">
										<canvas id="tagChart"></canvas>
									</div>
								</div>
							</div>
							<div class="col-sm-6">
								<ul class="nav nav-tabs" role="tablist" id="chartTab">
									<li role="presentation" class="active">
										<a href="#daily" aria-controls="daily" role="tab" data-toggle="tab">
											일간통계
										</a>
									</li>
									<li role="presentation">
										<a href="#weekly" aria-controls="weekly" role="tab" data-toggle="tab">
											주간통계
										</a>
									</li>
									<li role="presentation">
										<a href="#monthly" aria-controls="monthly" role="tab" data-toggle="tab">
											월간통계
										</a>
									</li>
								</ul>
								<div class="tab-content">
									<div role="tabpanel" class="tab-pane fade in active" id="daily">
										<canvas id="dailyChart"></canvas>
									</div>
									<div role="tabpanel" class="tab-pane fade" id="weekly">
										<canvas id="weeklyChart"></canvas>
									</div>
									<div role="tabpanel" class="tab-pane fade" id="monthly">
										<canvas id="monthlyChart"></canvas>
									</div>
								</div>
							</div>
						</div>
						

					</div>
				</div>
				
			</div>
			
			<div class="col-sm-12 hidden-md hidden-lg">
				<div class="row">
					<div class="col-md-12">
						<ul class="timeline">
						<c:forEach items="${logList}" var="log">
							<li>
								<i class="log-category"><input type="hidden" name="category" value="${log.categoryNo}"></i>
								<div class="timeline-item booklog-background">
									<span class="time"><i class="glyphicon glyphicon-time"></i> ${log.logTimeAgo}</span>
									<div class="timeline-body">
										<input type="hidden" name="link" value="${log.link}">
										<span><small>${log.logString}</small></span>
									</div>
								</div>
							</li>
						</c:forEach>
							<li>
								<i class="glyphicon glyphicon-option-vertical log-more-background" style="cursor: pointer;"></i>
								<div class="text-center">
									<img class="loading-img" src="../resources/images/loading.gif" style="height: 30px; display:none;">
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
			
			
		</div>
		

	</div>
	
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
	
</body>
</html>