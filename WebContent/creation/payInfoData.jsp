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
	<!--Kakao Pay  -->
	<script src="https://service.iamport.kr/js/iamport.payment-1.1.4.js" type="text/javascript"></script>
	<!-- 주소 -->
	<!-- <script src="//cdn.poesis.kr/post/search.min.js"></script> -->
	<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
	 
	

	<script type="text/javascript">
		var fundingNo; 
		var fundingTitle;
		var perFunding;
		

 //============kakao Pay ============
	 $(function(){
		var IMP = window.IMP; // 생략가능
        IMP.init("imp00965317"); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
		
        $("#pay").on('click', function(){
        	
			  IMP.request_pay({
		                                        pg : 'kakao',  
		                                        pay_method : 'card',
		                                        merchant_uid : 'merchant_' + new Date().getTime(),
		                                        name : $('#fundingTitle').val(),
		                                        amount : '1000',		                                   
		                                        //  amount : $('#perFunding').val(),
		                                        buyer_email : "${sessionScope.user.email}",
		                                        buyer_name : $('.name-fundingInfo').val(),
		                                        buyer_tel : $('.phone').val(),
		                                        buyer_addr : $('.postcodify_address').val()+", "+$('.postcodify_details').val(),
		                                        buyer_postcode : $('.postcodify_postcode5').val()
		                                       
		                                    }, function(rsp) {
		                                        if ( rsp.success ) {
		                                        	var fundingNo = $('#fundingNo-fundingInfo').val();
		                                        
		                                        	/////////ajax 적용/////////
		                            				$.ajax({
		                            					url : "rest/addPayInfo/",
		                            					method : "post",
		                            					data : JSON.stringify({
		                									fundingNo : fundingNo,
		                									fundingTitle : rsp.name,
		                									tid : rsp.pg_tid,
		                									userName : rsp.buyer_name,
		                									addr : rsp.buyer_addr,
		                									phone : rsp.buyer_tel
		                								}), 
		                            					dataType : "json",
		                            					headers : {
		                    								"Accept" : "application/json",
		                    								"Content-Type" : "application/json"
		                    								},
		                            					success : function(JSONData, status) {

		                            						//Debug...
		                            						alert(status);
		                            						
		                            						alert("결제가 완료되었습니다.");
		                            						$('#add-payInfo').modal("hide");
		                            						$('a.funding-join').replaceWith('<a class="btn btn-default funding-pay-info" type="button">참여정보조회</a>');

		                            						var msg = '결제가 완료되었습니다.';
				                                            msg += '고유ID : ' + rsp.imp_uid;
				                                           msg += '상점 거래ID : ' + rsp.merchant_uid;
				                                           msg +='주문자 Email : '+rsp.buyer_email;
				                                            msg +='주문자 이름 : '+rsp.buyer_name;
				                                            msg +='주문자 연락처 : '+rsp.buyer_tel;
				                                            msg +='주문자 주소 : '+rsp.buyer_addr;
				                                            msg += '결제번호 : '+rsp.pg_tid;
		                            					}
		                            				})
		           
		                                        } else {
		                                            var msg = '결제에 실패하였습니다.';
		                                            msg += '에러내용 : ' + rsp.error_msg;
		                                        }
		                                        alert(msg);
		                                    });

		 })
	 })


	//===============주소입력===================
	 $(function() { 

				  $(".addrSearch").postcodify({
				        insertPostcode5 : "#postcode",
				        insertAddress : "#address",
				        insertDetails : "#details",
				        insertExtraInfo : "#extra_info",
				        hideOldAddresses : false
				    }); 
						  
	 });  
			

	//==================================	
		
	
	</script>

</head>

<body>
<%-- 	<jsp:include page="../layout/toolbar.jsp">
		<jsp:param value="../" name="uri"/>
	</jsp:include> --%>
	<!-- 여기부터 코딩 -->

<div class="form-group">
		      		<div class="row">
		                <div class="col-sm-3 ">
		                    <label class="control-label" for="title-fundingInfo">펀딩명</label>
		                    <input class="fundingNo" type="hidden" id="fundingNo-fundingInfo" value="${funding.fundingNo }">
		                </div>
		                <div class="col-sm-9">
		                
		                    <input class="form-control fundingTitle" type="text" id="fundingTitle" placeholder="펀딩명"   id="title-fundingInfo" value="${funding.fundingTitle }" readonly>
		                
		                </div>
	              	 </div>
		      		
		      		<div class="row">
		                <div class="col-sm-3 ">
		                    <label class="control-label" for="perFunding-fundingInfo">결제금액</label>
		                </div>
		                <div class="col-sm-9">
		                   <input class="form-control perFunding" type="text" id="perFunding" placeholder="결제금액"   id="perFunding" value="${funding.perFunding }" readonly>
		                </div>
	              	 </div>
	              	 
		      		<div class="row">
		                <div class="col-sm-3 ">
		                    <label class="control-label" for="name-fundingInfo">이&nbsp;&nbsp;&nbsp;&nbsp;름</label>
		                </div>
		                <div class="col-sm-9">
		                    <input class="form-control name-fundingInfo" type="text" name="name-fundingInfo" placeholder="이름"   id="name-fundingInfo">
		                </div>
	              	 </div>
	              	<div class="postcodify"></div>
		                <div class="row" >
			                <div class="col-sm-3 ">
			                <label class="control-label" for="addr-fundingInfo">우편번호</label>
			                </div>
			                <div class="row col-sm-9 ">
			                    <input class=" postcodify_postcode5" type="text" name="postcode"    id="postcode">
			                <div class="row addrSearch" style="overflow: auto; max-height: 250px;">
			                	   	
			                </div>
			                </div>
		                </div>
		                
		                <div class="row">
			                <div class="col-sm-3 ">
			                <label class="control-label" for="addr-fundingInfo">도로명주소</label>
			                </div>
			                <div class="col-sm-9">
			                    <input class="form-control postcodify_address" type="text" name="address" placeholder="도로명주소"   id="address">
			                </div>
		                </div>
		                <div class="row">
			                <div class="col-sm-3">
			                <label class="control-label" for="addr-fundingInfo">상세주소</label>
			                </div>
			                <div class="col-sm-9">
			                    <input class="form-control postcodify_details" type="text" name="addrDetails" placeholder="상세주소"   id="addrDetails">
			                </div>
			              </div>
		              
		              
		              <div class="row">
		                <div class="col-sm-3">
		                    <label class="control-label" for="phone-fundingInfo">연락처</label>
		                </div>
		                <div class="col-sm-9">
		                    <input class="form-control phone" type="text" name="phone-fundingInfo" placeholder="01012341234"   id="phone-fundingInfo">
		                </div>
	                </div>
            	</div>
				<br/>  

	
</body>
</html>