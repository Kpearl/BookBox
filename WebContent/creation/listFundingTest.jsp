<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
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
	<script src="../resources/javascript/toolbar_opac.js"></script>
	<!-- <script src="../resources/javascript/custom.js"></script> -->

	<style>
	
	   body{
    		padding-top:0px;
    		
    	}
    	header{
    		background:url(../resources/images/creationTest7.jpg) no-repeat center;
    	}
		.progress-bar-warning:last-child.progress-bar:before {
		    background-color: rgb(221, 221, 221);
		}
		.progress-bar-warning {
		    background-color: rgba(14, 197, 147, 0.87);
		}
		span.enddate-style{
			    font-size: initial;
		}
		.check{
			cursor:pointer;
		}
		.funding-get{
			transition: 0.3s;
		}
	
	</style>


	<script type="text/javascript">
	
	ToolbarOpacHeight(500);
	
	  //============= 창작글쓰기 Navigation Event  처리 =============	
	   $(function() {
		  $("a.addWriting").on("click" , function() {
			  $(self.location).attr("href","../creation/addWriting");
	   	
	   	}); 
	 });   
	   
	   //============= 펀딩등록하기 Navigation Event  처리 =============	
	   $(function() {
		  $("a.addfunding").on("click" , function() {
			  $(self.location).attr("href","../creation/addFunding");
	   	
	   	}); 
	 });  
	
	
		$(function(){
			$('.funding-get').on('click', function(){
				$(self.location).attr('href', '../creation/getFunding?fundingNo='+$(this).parent().parent().find('input[name="fundingNo"]').val());

			});
			
			$('img.funding-get').hover(function(){
				$(this).css('cursor', 'pointer');
				$(this).css('transform', 'scale(1.024)');	//128/125
			}, function(){
				$(this).css('transform', 'scale(0.9765625)');	//125/128
			});
			
		});
		
		//============= 펀딩 남은기간 계산 =============
		   $(function(){
				$('.funding-endDate').html(function(){
					var today =new Date();
					var endDay =new Date($(this).html().trim()+" 00:00:00");
					var diff = endDay.getTime()-today.getTime();
					if(diff < 0){
						return '펀딩마감';
					}

					var days = Math.floor(diff/(1000*60*60*24));
					if(days > 0){
						return '<img src="https://icongr.am/octicons/calendar.svg?size=20px"><span class="enddate-style">앞으로 <strong>'+days + '<strong>일</span>';
					}
					var hours = Math.floor( diff/(1000*60*60) );
					if(hours > 0){
						return hours + '시간 남음';
					}
					var minutes = Math.floor( diff/(1000*60) );
					if(minutes > 0){
						return minutes + '분 남음';
					}else{
						return '마감 임박!!';
					}
					
				})
				
			});
		
		
	</script>
</head>

<body>
	<jsp:include page="../layout/toolbar.jsp">
		<jsp:param value="../" name="uri"/>
	</jsp:include>
		<header class="parallax"></header>
	<!-- 여기부터 코딩 -->

    <div class="container" id="list" style="margin-bottom:80px;background-color: rgba(221, 221, 221, 0.22);">
			<jsp:include page="creationToolbar.jsp"/>
			
			<div class="row" style="margin-top: 40px;">
				<div class="col-md-6 text-left">
					<p class="paging">전체 ${fundingList.size() } 건수, 현재
					${page.currentPage} 페이지</p>
				</div>
				<div class="col-md-6 col-xs-hidden" style="text-align: right;">
					<span class="check recent-list"><img src="https://icongr.am/entypo/check.svg?size=20px"> 최신순</span>
					<span class="check enddate-list"><img src="https://icongr.am/entypo/check.svg?size=20px&color=bbbbbb"> 마감순</span>
				</div>
			</div>
			
				<div class="row funding-list-form">
					<c:forEach var="funding" items="${fundingList }">
						
						<div class= "col-md-3 col-sm-6"> 
					<div class="row each-funding" style="width:100%;margin-left: 5px;">
					
						<div id="${funding.fundingNo}" class="funding-image button-form" style="height:200px; position:relative;overflow:hidden;">
							<img  class="funding-get img-object-fit" src="../resources/upload_files/images/${funding.fundingFileName}">
						</div>
					
						<div class="funding-content" style="height:150px;background-color:#ffffff;;padding-bottom: 10px; ">
						
							<div class="funding-title button-form" style="margin-left: 10px;padding-top: 15px;height: 75%;">
								<div id="${funding.fundingNo}" class="funding-get text-left funding-title" style="font-size: large;font-weight: bold;">${funding.fundingTitle}</div>
								<div id="${funding.creation.creationAuthor.email}" class="booklog-get text-left funding-nickname" style="font-size: small;">${funding.creation.creationAuthor.nickname}</div>
							</div>

		                    <div class="progress-form" >      
								<div class="progress progress-xs" style="height: 5px;margin-left: 8px;margin-right: 8px;">
			                          <div class="progress-bar progress-bar-warning progress-bar-striped active" 
			                          		aria-valuenow="${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}" aria-valuemin="0" aria-valuemax="100"
			                          		style="min-width: 0.5em; width: ${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}%;">
			                          </div>
			                     </div>
		                     </div>
						 
						 <div class="funding-bottom" style="position:relative;margin-right: 10px;">
	                          <div class="funding-endDate" style="padding-left: 10px;bottom: 5px;float: left;">${funding.fundingEndDate }</div>
							  <div class="funding-percent" style="padding-left: 10px;bottom: 5px;float: right;font-size: larger;">${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}%</div>
						</div>
					</div>
					<c:if test="${funding.active ==0 }">
					<div class="endfunding-img"><strong style="font-size: -webkit-xxx-large; color: burlywood;position: absolute;">펀딩종료</strong></div>
					</c:if>
				</div>
			</div>
					</c:forEach>
				</div>
			</div>
			
        

        <!-- 실제 데이터 들어갈 곳 -->
		<%-- <c:forEach items="${fundingList}" var="funding">
            <div class="col-md-6 funding-content">
                <div class="row">
                    <div class="col-md-10 col-md-offset-1" style="border:1px solid">
                        <div class="row">
                           	<input type="hidden" name="fundingNo" value="${funding.fundingNo}">
                           	<input type="hidden" name="creation.creationNo" value="${funding.creation.creationNo}">
                            <div class="col-md-5 col-xs-4">
                            	<img class="img-thumbnail img-responsive funding-get" src="../resources/upload_files/images/${funding.fundingFileName}">
                            </div>
                            <div class="col-md-7 col-xs-8">
                                <h4 class="btn-link funding-get">${funding.fundingTitle}</h4>
                                <div class="progress">
                                    <div class="progress-bar progress-bar-success progress-bar-striped active" 
                                    		aria-valuenow="${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}" aria-valuemin="0" aria-valuemax="100"
                                    		style="min-width: 2em; width: ${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}%;">
                                    	${(funding.perFunding * fn:length(funding.payInfoList)) / funding.fundingTarget * 100}%
                                    </div>
                                </div>
                                <p class="text-right">${funding.fundingTarget}</p>
                                <p class="text-right">${funding.fundingEndDate}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
            
        </div>
    </div> --%>
    
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>

	
</body>
</html>
