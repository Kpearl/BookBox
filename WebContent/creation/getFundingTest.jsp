<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<jsp:include page="fundingData.jsp"/>
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
		var fundingNo, creationNo, payInfoNo;
		$(function(){
			fundingNo = $('input[name="fundingNo"]').val();
			creationNo = $('input[name="creationNo"]').val();
			payInfoNo = $('input[name="payInfoNo"]').val();
			
			$('button.funding-join').on('click', function(){
				//$(self.location).attr('href', '../creation/addPayInfo?fundingNo='+fundingNo));
				alert('(e^-\')c준비 중 입니다.');
				$(self.location).attr('href', 'addPayInfoView.jsp');
			});
			$('button.funding-creation').on('click', function(){
				$(self.location).attr('href', '../creation/getWritingList?creationNo='+creationNo);
			});
			$('button.funding-update').on('click', function(){
				//$(self.location).attr('href', '../creation/updateFundingView?fundingNo='+fundingNo);
				alert('(e^-\')c준비 중 입니다.');
				$(self.location).attr('href', 'updateFundinvViewTest.jsp');
			});
			$('button.funding-userlist').on('click', function(){
				//$(self.location).attr('href', '../creation/getFundingUserList?fundingNo='+fundingNo);
				alert('(e^-\')c준비 중 입니다.');
				$(self.location).attr('href', 'listFundingUser.jsp');
			});
			$('button.funding-pay-info').on('click', function(){
				//$(self.location).attr('href', '../creation/getPayInfo?payInfoNo='+payInfoNo);
				alert('(e^-\')c준비 중 입니다.');
				$(self.location).attr('href', 'getPayInfo.jsp');
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
           	<input type="hidden" name="fundingNo" value="${funding.fundingNo}">
           	<input type="hidden" name="creationNo" value="${funding.creation.creationNo}">
            <div class="col-md-6">
            	<img class="img-responsive" src="../resources/upload_files/images/${funding.fundingImage}">
            </div>
            <div class="col-md-6">
                <p>펀딩명 : ${funding.fundingTitle}</p>
                <p>글제목 : ${funding.creation.creationTitle}</p>
                <div class="progress">
                    <div class="progress-bar progress-bar-info progress-bar-striped active" 
                    		aria-valuenow="${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}" aria-valuemin="0" aria-valuemax="100"
                    		style="width: ${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}%;">
                    	${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}%
                    </div>
                </div>
                <p>남은 진행기간 : ${funding.fundingEndDate}</p>
                <div class="row">
                    <div class="col-xs-6">
                        <p>1인당 금액 : ${funding.perFunding}</p>
                    </div>
                    <div class="col-xs-6 text-center">
                  	<c:forEach items="${funding.payInfoList}" var="payInfo">
                  		<c:if test="${payInfo.user.email == sessionScope.user.email}">
                  			<c:set var="isFunding" value="true"/>
                  			<input type="hidden" name="payInfoNo" value="${payInfo.payInfoNo}">
                  		</c:if>
                  	</c:forEach>
                    <c:if test="${sessionScope.user.role == admin}">
                        <button class="btn btn-default funding-userlist" type="button">참여자목록조회</button>
                    </c:if>
                    <c:if test="${empty isFunding}">
                        <button class="btn btn-default funding-join" type="button">참여하기</button>
                    </c:if>
                    <c:if test="${!empty isFunding}">
                    	<button class="btn btn-default funding-pay-info" type="button">참여정보조회</button>
                    </c:if>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <p>${funding.fundingIntro}</p>
                <button class="btn btn-link center-block funding-creation" type="button">글보러 가기</button>
                <c:if test="${sessionScope.user.email == funding.creation.creationAuthor.email}">
	                <button class="btn btn-link funding-update" type="button">수정</button>
	            </c:if>
            </div>
        </div>
    </div>

	
</body>
</html>
