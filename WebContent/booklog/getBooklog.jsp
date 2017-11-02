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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.3/css/swiper.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.3/css/swiper.min.css">
	 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.3/js/swiper.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.3/js/swiper.min.js"></script>
	<!-- Swiper 설정 끝 -->

	<!-- Chart.js 설정 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.bundle.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.js"></script>
	<!-- Chart.js 설정 끝 -->
	
	<script src="../resources/javascript/custom.js"></script>
	
    <style>
	    .swiper-container {
	        width: 100%;
	        height: 400px;
	        padding-top: 50px;
	        padding-bottom: 50px;
	    }
	    .swiper-slide {
	        background-position: center;
	        background-size: cover;
	    }
    </style>

<script type="text/javascript">
	var booklogUser;
	var booklogNo;
	var booklogName;

	$(function(){
		booklogUser = $('input[name="user.email"]').val();
		booklogNo = $('input[name="booklogNo"]').val();
		booklogName = $('input[name="booklogName"]').val();
		
		$('a.posting-list').on('click',function(){
			$(self.location).attr('href','../booklog/getPostingList?condition=booklog&keyword='+booklogUser);
		});
		$('div.div-posting').on('click', function(){
			var postingNo = $(this).find('input[type="hidden"]').val();
			$(self.location).attr("href","../booklog/getPosting?postingNo="+postingNo+"&condition=booklog&keyword="+booklogUser);
		});
		$('a.var-btn:contains("표지편집")').on('click', function(){
			$(self.location).attr('href','../booklog/updateBooklog?user.email='+booklogUser);
		});
		$('a.var-btn:contains("책갈피 등록")').on('click', function(){
			fncAddBookmark($(this));
		});
		$('a.var-btn:contains("책갈피 삭제")').on('click', function(){
			fncDeleteBookmark($(this));
		});
	});

	$(function(){
		/* swiper 설정 */
        var swiper = new Swiper('.swiper-container', {
            spaceBetween: 30,
            centeredSlides: true,
            pagination: {
            	el: '.swiper-pagination',
            	clickable: true
            },
            navigation: {
            	nextEl: '.swiper-button-next',
              	prevEl: '.swiper-button-next'
            },
            loop: false
        });
        
        /* chart 설정 */
		var ctxDaily = $("#dailyChart");
		var dailyChart = new Chart(ctxDaily, {
		    type: 'bar',
		    data: {
		        labels: [fncGetDate(6)
		        			, fncGetDate(5)
		        			, fncGetDate(4)
		        			, fncGetDate(3)
		        			, fncGetDate(2)
		        			, fncGetDate(1)
		        			, fncGetDate(0)],
		        datasets: [{
		            label: '# of DailyVisitors',
		            data: [${booklog.visitorsStatistics.daily.get(6.0).daycount}
				            , ${booklog.visitorsStatistics.daily.get(5.0).daycount}
				            , ${booklog.visitorsStatistics.daily.get(4.0).daycount}
				            , ${booklog.visitorsStatistics.daily.get(3.0).daycount}
				            , ${booklog.visitorsStatistics.daily.get(2.0).daycount}
				            , ${booklog.visitorsStatistics.daily.get(1.0).daycount}
				            , ${booklog.visitorsStatistics.daily.get(0.0).daycount}],
		            backgroundColor: [
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(54, 162, 235, 0.2)'
		            ],
		            borderColor: [
		                'rgba(255,99,132,1)',
		                'rgba(54, 162, 235, 1)'
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
		            data: [${booklog.visitorsStatistics.weekly.get(6.0).weekcount},
				            ${booklog.visitorsStatistics.weekly.get(5.0).weekcount},
				            ${booklog.visitorsStatistics.weekly.get(4.0).weekcount},
				            ${booklog.visitorsStatistics.weekly.get(3.0).weekcount},
				            ${booklog.visitorsStatistics.weekly.get(2.0).weekcount},
				            ${booklog.visitorsStatistics.weekly.get(1.0).weekcount},
				            ${booklog.visitorsStatistics.weekly.get(0.0).weekcount}],
		            backgroundColor: [
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(54, 162, 235, 0.2)'
		            ],
		            borderColor: [
		                'rgba(255,99,132,1)',
		                'rgba(54, 162, 235, 1)'
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
		            data: [${booklog.visitorsStatistics.monthly.get(4.0).monthcount},
				    		${booklog.visitorsStatistics.monthly.get(3.0).monthcount},
				            ${booklog.visitorsStatistics.monthly.get(2.0).monthcount},
				            ${booklog.visitorsStatistics.monthly.get(1.0).monthcount},
				            ${booklog.visitorsStatistics.monthly.get(0.0).monthcount}],
		            backgroundColor: [
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(54, 162, 235, 0.2)'
		            ],
		            borderColor: [
		                'rgba(255,99,132,1)',
		                'rgba(54, 162, 235, 1)'
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
		var tagChart = new Chart(ctxTag, {
			type: 'bubble',
			data: {
				datasets: [{
					label: 'Tag Dataset',
					data: [
						{x: 15,y: 15,r: ${booklog.visitorsStatistics.tag.get(0.0).count}},
						{x: 14,y: 15,r: ${booklog.visitorsStatistics.tag.get(1.0).count}},
						{x: 14,y: 14,r: ${booklog.visitorsStatistics.tag.get(2.0).count}},
						{x: 15,y: 14,r: ${booklog.visitorsStatistics.tag.get(3.0).count}},
						{x: 16,y: 14,r: ${booklog.visitorsStatistics.tag.get(4.0).count}},
						{x: 16,y: 15,r: ${booklog.visitorsStatistics.tag.get(5.0).count}},
						{x: 16,y: 16,r: ${booklog.visitorsStatistics.tag.get(6.0).count}},
						{x: 15,y: 16,r: ${booklog.visitorsStatistics.tag.get(7.0).count}},
						{x: 14,y: 16,r: ${booklog.visitorsStatistics.tag.get(8.0).count}},
						{x: 13,y: 15,r: ${booklog.visitorsStatistics.tag.get(9.0).count}}
					],
					backgroundColor: 'rgb(255, 99, 132)'
				}]
			},
		    options: {
		        scales: {
		            yAxes: [{
		                ticks: {
		                    //beginAtZero:true
		                    stepSize:1
		                }
		            }],
		            xAxes: [{
		                ticks: {
		                    //beginAtZero:true
		                    stepSize:1
		                }
		            }]
		        }
		    }
		});

		
		/* tab 설정 */
		$('#chartTab').tab('show');
    });
	
	function fncAddBookmark(elmA){
		$.ajax({
			url : '../booklog/rest/addBookmark/'+booklogUser+'/'+booklogNo,
			method : 'get',
			dataType : 'json',
			success : function(data){
				if(data){
					alert("'"+booklogName+"' 북로그를 책갈피에 등록하였습니다.");
					$(elmA).html('책갈피 삭제').off('click').on('click', function(){
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
					alert("'"+booklogName+"' 북로그를 책갈피에서 삭제하였습니다.");
					$(elmA).html('책갈피 등록').off('click').on('click', function(){
						fncAddBookmark(elmA);
					});
				}else{
					alert("잠시 후 다시 시도해 주세요..");
				}
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
	<div class="container-fluid">
		<div class="row text-center">
			<img class="img-responsive center-block" src="http://cfile9.uf.tistory.com/image/2261AA46582D467B3C3609">
			<!-- <img class="img-responsive center-block" src="../resources/upload_files/images/${booklog.booklogImage}"> -->
			<br/><mark>${booklog.booklogIntro}</mark>, <em>${booklog.booklogName}</em>
			<div class="col-md-offset-9 col-md-3">
				<c:if test="${sessionScope.user.email != null}">
					<a class="btn btn-defalut var-btn" href="#">
						<c:if test="${sessionScope.user.email == booklog.user.email}">
							표지편집
						</c:if>
						<c:if test="${sessionScope.user.email != booklog.user.email}">
							${bookmark == true? '책갈피 삭제' : '책갈피 등록'}
						</c:if>
					</a>
				</c:if>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<a class="btn btn-defalut posting-list" href="#">포스팅 더 보기</a>
		    <div class="swiper-container">
		        <div class="swiper-wrapper">
	        	<c:set var="i" value="0"/>
	        	<c:forEach items="${booklog.postingList}" var="posting">
	        		<div class="swiper-slide div-posting" style="background-image:url(../resources/upload_files/images/${!empty posting.postingFileList? posting.postingFileList[0].fileName : '../../images/noimage.jpeg'})">
						<input type="hidden" name="postingNo" value="${posting.postingNo}"/>
						<p>포스팅명 : ${posting.postingTitle}</p>
	        		</div>
	        	</c:forEach>
		        </div>
		        <!-- Add Pagination -->
		        <div class="swiper-pagination swiper-pagination-black"></div>
		        <!-- Add Arrows -->
		        <div class="swiper-button-next swiper-button-white"></div>
		        <div class="swiper-button-prev swiper-button-white "></div>
		    </div>
		</div>
	
		<div class="row">
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
		
		<div class="row">
			<canvas id="tagChart"></canvas>
		</div>
		
		<div class="row">
			<c:forEach items="${logList}" var="log">
				${log.toString()}<br/>
			</c:forEach>
		</div>

	</div>
	
	
</body>
</html>