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

	<script type="text/javascript">
		$(function(){
			$('.funding-get').on('click', function(){
				$(self.location).attr('href', '../creation/getFunding?fundingNo='+$(this).parent().parent().find('input[name="fundingNo"]').val());
	//			$(self.location).attr('href', '../creation/getFundingTest.jsp');
			});
			
			$('img.funding-get').hover(function(){
				$(this).css('cursor', 'pointer');
				$(this).css('transform', 'scale(1.024)');	//128/125
			}, function(){
				$(this).css('transform', 'scale(0.9765625)');	//125/128
			});
			
		});
	</script>
</head>

<body>
	<jsp:include page="../layout/toolbar.jsp">
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<!-- 여기부터 코딩 -->

    <div class="container">
        <div class="row">
        <!-- 
            <div class="col-md-6 funding-content">
                <div class="row">
                    <div class="col-md-10 col-md-offset-1" style="border:1px solid">
                        <div class="row">
                            <div class="col-md-5 col-xs-4">
                            	<img class="img-thumbnail img-responsive" src="../resources/upload_files/images/test.jpg">
                            </div>
                            <div class="col-md-7 col-xs-8">
                                <h4>펀딩명</h4>
                                <div class="progress">
                                    <div class="progress-bar progress-bar-success progress-bar-striped active" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width: 70%;">70%</div>
                                </div>
                                <p class="text-right">Paragraph</p>
                                <p class="text-right">Paragraph</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 funding-content">
                <div class="row">
                    <div class="col-md-10 col-md-offset-1" style="border:1px solid">
                        <div class="row">
                            <div class="col-md-5 col-xs-4"><img class="img-thumbnail img-responsive"></div>
                            <div class="col-md-7 col-xs-8">
                                <h4>Heading</h4>
                                <div class="progress">
                                    <div class="progress-bar progress-bar-success progress-bar-striped active" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width: 70%;">70%</div>
                                </div>
                                <p class="text-right">Paragraph</p>
                                <p class="text-right">Paragraph</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 funding-content">
                <div class="row">
                    <div class="col-md-10 col-md-offset-1" style="border:1px solid">
                        <div class="row">
                            <div class="col-md-5 col-xs-4"><img class="img-thumbnail img-responsive"></div>
                            <div class="col-md-7 col-xs-8">
                                <h4>Heading</h4>
                                <div class="progress">
                                    <div class="progress-bar progress-bar-success progress-bar-striped active" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width: 70%;">70%</div>
                                </div>
                                <p class="text-right">Paragraph</p>
                                <p class="text-right">Paragraph</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 funding-content">
                <div class="row">
                    <div class="col-md-10 col-md-offset-1" style="border:1px solid">
                        <div class="row">
                            <div class="col-md-5 col-xs-4"><img class="img-thumbnail img-responsive"></div>
                            <div class="col-md-7 col-xs-8">
                                <h4>Heading</h4>
                                <div class="progress">
                                    <div class="progress-bar progress-bar-success progress-bar-striped active" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width: 70%;">70%</div>
                                </div>
                                <p class="text-right">Paragraph</p>
                                <p class="text-right">Paragraph</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 funding-content">
                <div class="row">
                    <div class="col-md-10 col-md-offset-1" style="border:1px solid">
                        <div class="row">
                            <div class="col-md-5 col-xs-4"><img class="img-thumbnail img-responsive"></div>
                            <div class="col-md-7 col-xs-8">
                                <h4>Heading</h4>
                                <div class="progress">
                                    <div class="progress-bar progress-bar-success progress-bar-striped active" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="min-width: 2em; width: 0%;"><span>0%</span></div>
                                </div>
                                <p class="text-right">Paragraph</p>
                                <p class="text-right">Paragraph</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 funding-content">
                <div class="row">
                    <div class="col-md-10 col-md-offset-1" style="border:1px solid">
                        <div class="row">
                            <div class="col-md-5 col-xs-4"><img class="img-thumbnail img-responsive"></div>
                            <div class="col-md-7 col-xs-8">
                                <h4>Heading</h4>
                                <div class="progress">
                                    <div class="progress-bar progress-bar-success progress-bar-striped active" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width: 70%;">70%</div>
                                </div>
                                <p class="text-right">Paragraph</p>
                                <p class="text-right">Paragraph</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
		 -->
        <!-- 실제 데이터 들어갈 곳 -->
		<c:forEach items="${fundingList}" var="funding">
            <div class="col-md-6 funding-content">
                <div class="row">
                    <div class="col-md-10 col-md-offset-1" style="border:1px solid">
                        <div class="row">
                           	<input type="hidden" name="fundingNo" value="${funding.fundingNo}">
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
    </div>

	
</body>
</html>
