<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

	<!-- Swiper 설정 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/css/swiper.css">
	 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.jquery.js"></script>
	<!-- Swiper 설정 끝 -->

	<!-- Chart.js 설정 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.bundle.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.js"></script>
	<!-- Chart.js 설정 끝 -->
	
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
	var booklogUser;
	$(function(){
		booklogUser = $('input[name="user.email"]').val()
		$('a:contains("포스팅 더 보기")').on('click',function(){
			$(self.location).attr('href','../booklog/getPostingList?condition='+booklogUser);
		});
		$('a:contains("표지편집")').on('click', function(){
			$(self.location).attr('href','../booklog/updateBooklog?user.email='+booklogUser);
		});
		$('div.div-posting').on('click', function(){
			var postingNo = $(this).find('input[type="hidden"]').val();
			$(self.location).attr("href","../booklog/getPosting?postingNo="+postingNo+"&condition=booklog&keyword="+booklogUser);
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
		        labels: [fncGetDate(6)
		        			, fncGetDate(5)
		        			, fncGetDate(4)
		        			, fncGetDate(3)
		        			, fncGetDate(2)
		        			, fncGetDate(1)
		        			, fncGetDate(0)],
		        datasets: [{
		            label: '# of WeeklyVisitors',
		            data: [${booklog.visitorsStatistics.weekly.get(6.0).weekcount}
				            , ${booklog.visitorsStatistics.weekly.get(5.0).weekcount}
				            , ${booklog.visitorsStatistics.weekly.get(4.0).weekcount}
				            , ${booklog.visitorsStatistics.weekly.get(3.0).weekcount}
				            , ${booklog.visitorsStatistics.weekly.get(2.0).weekcount}
				            , ${booklog.visitorsStatistics.weekly.get(1.0).weekcount}
				            , ${booklog.visitorsStatistics.weekly.get(0.0).weekcount}],
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

		
		/* tab 설정 */
		$('#chartTab').tab('show');
    })
	
    function fncGetDate(day){
		var nowDate = new Date();
		var date = nowDate.getTime() - (day * 24 * 60 * 60 * 1000);
		nowDate.setTime(date);
		var year = nowDate.getFullYear();
		var month = nowDate.getMonth() + 1;
		var day = nowDate.getDate();
		
		if(month < 10){
			month = '0' + month;
		}
		if(day < 10){
			day = '0' + day;
		}
		
		return year + '-' + month + '-' + day;
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
	<div class="container-fluid text-center">
		<img src="http://cfile9.uf.tistory.com/image/2261AA46582D467B3C3609" alt="Image">
		<!-- <img src="http://localhost:8080/BookBox/resources/uploadFiles/images/${booklog.booklogImage}" alt="Image"> -->
		<br/><mark>${booklog.booklogIntro}</mark>, <em>${booklog.booklogName}</em>
		<div class="col-md-offset-9 col-md-3">
			<a class="btn btn-defalut" href="#">
				<c:if test="${sessionScope.user.email != null}">
					<c:if test="${sessionScope.user.email == booklog.user.email}">
						표지편집
					</c:if>
					<c:if test="${sessionScope.user.email != booklog.user.email}">
						${bookmark == true? '책갈피 삭제' : '책갈피 등록'}
					</c:if>
				</c:if>
			</a>
		</div>
	</div>

	<div class="container">
	    <div class="swiper-container">
	        <div class="swiper-wrapper">
	        	<c:set var="i" value="0"/>
	        	<c:forEach items="${booklog.postingList}" var="posting">
					<c:set var="text" value="${posting.postingContent }"/>
					<c:set var="len" value="${fn:length(text)}"/>
					<c:set var="len" value="${len > 10 ? 10 : len }"/>
					<div class="swiper-slide div-posting" style="background-image:url(http://cfile9.uf.tistory.com/image/2261AA46582D467B3C3609)">
						<input type="hidden" name="postingNo" value="${posting.postingNo}"/>
						포스팅명 : ${posting.postingTitle}<br/>
						포스팅내용 : ${fn:substring(text,0,len-1)}${len==10 ? '...':'' }<br/>
		            </div>
	        	</c:forEach>
	        </div>
	        <!-- Add Pagination -->
	        <div class="swiper-pagination"></div>
	    </div>
	</div>
	
	<div class="container">
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
				<canvas id="dailyChart" width="400" height="200"></canvas>
			</div>
			<div role="tabpanel" class="tab-pane fade" id="weekly">
				<canvas id="weeklyChart" width="400" height="200"></canvas>
			</div>
			<div role="tabpanel" class="tab-pane fade" id="monthly">
				<canvas id="monthlyChart" width="400" height="200"></canvas>
			</div>
		</div>
	</div>
	<div class="container">
		<c:forEach items="${logList}" var="log">
			${log.toString()}<br/>
		</c:forEach>
	</div>
	
	
</body>
</html>