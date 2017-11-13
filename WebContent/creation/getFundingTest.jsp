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
	
	<!--Kakao Pay  -->
	<script src="https://service.iamport.kr/js/iamport.payment-1.1.4.js" type="text/javascript"></script>
	<!-- 주소 -->
	<!-- <script src="//cdn.poesis.kr/post/search.min.js"></script> -->
	<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
	 
	<style>
	.funding-content-detail{
	    margin-bottom: 50px;
	    height: 500px;
	    
	}
	
	div.funding-creation{
		    background-color: burlywood;
		    border-radius: 3px;
		    margin-left: 150px;
		    margin-right: 150px;
		    height: 35px;
		    padding-top: 4px;
		    font-weight: bolder;
		    font-size: large;
	}
	
	 body{
    		padding-top:0px;
    		
    	}
    	header{
    		background:url(../resources/images/newCreationTest6.jpg) no-repeat center;
    	}
    	
    	.funding-button{
    		margin-top:10px;
    		cursor:pointer;
    	}
	
	</style>

	<script type="text/javascript">
	 ToolbarOpacHeight(500);
		var fundingNo; 
		var fundingTitle;
		var perFunding;
		var creationNo;
		
//============메뉴 Navigation ============
		 $(function(){
			 $('.menu').on('click', function(){
				 $(self.location).attr("href","../creation/getFundingList");
			 })
		 })
		

 //============kakao Pay ============
	 $(function(){
		var IMP = window.IMP; // 생략가능
        IMP.init("${importIDcode}"); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
		
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
		                									uid : rsp.imp_uid,
		                									userName : rsp.buyer_name,
		                									postCode : $('.postcodify_postcode5').val(),
		                									addr : $('.postcodify_address').val(),
		                									addrDetail : $('.postcodify_details').val(),
		                									phone : rsp.buyer_tel
		                								}), 
		                            					dataType : "json",
		                            					headers : {
		                    								"Accept" : "application/json",
		                    								"Content-Type" : "application/json"
		                    								},
		                            					success : function(JSONData, status) {

		                            						//Debug...
		                            					//	alert(status);
		                            						
		                            						alert("결제가 완료되었습니다.");
		                            						$('#add-payInfo').modal("hide");
		                            						$('.funding-join').replaceWith
		                            						('<div class="row funding-pay-info text-center" style="padding-top: 7px;height: 45px;background-color: rgba(14, 197, 147, 0.87);color: aliceblue;font-size: large;"><strong>펀딩정보조회</strong></div>');
															
		                            						$('.funding-pay-info').on('click', function(){
		                            							fncFundingPayInfo();
		                            							});
		                            						
		                            						var msg = '결제가 완료되었습니다.';
		                            		    			msg += '\n고유ID : ' + rsp.imp_uid;
		                            		    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
		                            		    			msg += '\결제 금액 : ' + rsp.paid_amount;
													//		alert(msg);
		                            					
		                            					}
		                            				})
		           
		                                        } else {
		                                            var msg = '결제에 실패하였습니다.';
		                                            msg += '에러내용 : ' + rsp.error_msg;
		                                            alert(msg);
		                                        }
		                                        
		                                    });

		 })
	 })


	//===============주소입력===================
/*  	 $(function() { 

				  $(".addrSearch").postcodify({
				        insertPostcode5 : "#postcode",
				        insertAddress : "#address",
				        insertDetails : "#details",
				        insertExtraInfo : "#extra_info",
				        hideOldAddresses : false
				    }); 
						  
	 }); */   
			
		 function fncPostcodify(){   
			    	
			 $(".addrSearch").postcodify({
			        insertPostcode5 : "#postcode",
			        insertAddress : "#address",
			        insertDetails : "#details",
			        insertExtraInfo : "#extra_info",
			        hideOldAddresses : false
			    }); 
			}  

	//==============참여정보조회====================
		$(function(){
						
			$('.funding-pay-info').on('click', function(){
				fncFundingPayInfo();
				});
			
		});//참여정보조회 이벤트 끝
		
/* 		if(${isFunding==true} ){
			if($('#add-payInfo').on('hidden.bs.modal')){
					
			}
		} */
		
		function fncFundingPayInfo() {
			/////////ajax 적용/////////
			$.ajax({
				url : "rest/getPayInfo?fundingNo="+$('#fundingNo-fundingInfo').val(),
				method : "get",
				dataType : "json",
				success : function(JSONData, status) {
					//Debug...
				//	alert(status);
									
					$('#add-payInfo').modal('show');
					$('.name-fundingInfo').val(JSONData.userName);
                    $('.postcodify_postcode5').val(JSONData.postCode);
                     $('.postcodify_address').val(JSONData.addr);
                     $('.postcodify_details').val(JSONData.addrDetail);
                     $('.phone').val(JSONData.phone);
                     $('#payInfoNo').val(JSONData.payInfoNo);
                     
                     $('#insert-payInfo').html('펀딩 참여정보 조회');
                     $('.inputValue').attr('readonly',true);
                     $('.addrSearch').addClass('sr-only');
                     $('#pay').attr('id','update').html('수정하기');
                	 $('#updatePayInfo').attr('id','update').html('수정하기');
                     
                     $('#update').off('click').on('click', function(){
                    	 $('#insert-payInfo').html('펀딩 참여정보 수정하기');
                    	 $('.inputValue').attr('readonly',false);
                    	 $('.addrSearch').removeClass('sr-only');
                    	 $('#update').attr('id','updatePayInfo').html('수정');
                    
                    	 $('#updatePayInfo').off('click').on('click', function(){
                    		 $('.payInfoForm').attr('method','post').attr('action','../creation/updatePayInfo').submit();
                    		
                    	 })
                    	 
                     });//수정하기 버튼 이벤트 끝
				}
			})//ajax 끝
			
		}
		
		
		
	//============================================	
		
		$(function(){
			fncPostcodify();
		
			$('.funding-creation').on('click', function(){
				$(self.location).attr('href', '../creation/getWritingList?creationNo='+$('input[name="creationNo"]').val());
			});
			$('.funding-userlist').on('click', function(){
				$(self.location).attr('href', '../creation/getFundingUserList?fundingNo='+$('input[name="fundingNo"]').val());
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
						return '<strong style="font-size:20px;">'+days + '</strong>일 남음';
					}
					var hours = Math.floor( diff/(1000*60*60) );
					if(hours > 0){
						return '<strong style="font-size:20px;">'+hours + '</strong>시간 남음';
					}
					var minutes = Math.floor( diff/(1000*60) );
					if(minutes > 0){
						return '<strong style="font-size:20px;">'+minutes + '<strong>분 남음';
					}else{
						return '마감 임박!!';
					}
					
				})
				
			});
		
		//===============펀딩자동취소===================
		$(function(){
			var today = new Date();
			var dd = today.getDate();
			var mm = today.getMonth()+1; //January is 0!
			var yyyy = today.getFullYear();

			if(dd<10) {
			    dd='0'+dd
			} 

			if(mm<10) {
			    mm='0'+mm
			} 

			today = yyyy+'-'+mm+'-'+dd;
		//	alert(today);
		//	alert('${funding.fundingEndDate}');
			if('${funding.fundingEndDate}'==today){
				
				$.ajax({
					url : "rest/cancelFunding?fundingNo="+$('input[name="fundingNo"]').val(),
					method : "get",
					dataType : "json",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
						},
					success : function(JSONData, status) {
						alert(status);
					}
				
				})
			}
		})
			
		
	</script>

</head>

<body>
	<jsp:include page="../layout/toolbar.jsp">
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>
	<!-- 여기부터 코딩 -->
    <div class="container">
    		<jsp:include page="creationToolbar.jsp"/>
    	
       	
  <div class="row creation-part" >
      <!-- 펀딩정보 시작 -->
        <div class="row col-sm-12 col-md-12 get-funding" style="margin-top: 25px;">
           	<input class="fundingNo" type="hidden" name="fundingNo" value="${funding.fundingNo}">
           	<div class="col-md-8 funding-title-image" style="overflow:hidden;height: 350px;padding:0 20px">
            	<img style="width: 100%;height:100%;object-fit:cover;" class="img-responsive" src="../resources/upload_files/images/${funding.fundingFileName}">
            </div>
            
            <div class="col-md-4 funding-content">
				<div class="fundingTitle" style="font-weight: 600;font-size: 25px;">${funding.fundingTitle}</div>
                <input type="hidden" class="fundingTitle" value="${funding.fundingTitle}">
              <%--  <div class="creationTitle">글제목 : ${funding.creation.creationTitle}</div> --%>
               <div class="row progress" style="height:25px;margin-bottom: 0;margin-top: 30px;">
                    <div class="progress-bar progress-bar-success progress-bar-striped" 
                    		aria-valuenow="${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}" aria-valuemin="0" aria-valuemax="100"
                    		style="width: ${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}%;">
                    	${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}%
                    </div>
                </div><!--progress bar END  -->
                <div class="row funding-target text-right" style="font-size:large;"> 목표금액 : <strong style="font-size:x-large;">${funding.fundingTarget }</strong>원</div>
               	<div class="row perFunding text-right" style="padding-left: 0;margin-left: 0;font-size:initial;font-family: unset;font-weight: 500;margin-top: 0;">
               	참여금액 : <strong style="font-size:x-large;">${funding.perFunding}</strong> 원
               	</div>
                <div class="row funding-endDate text-left" style="margin-left: 0px;font-size: 18px;font-family: unset;font-weight:500">${funding.fundingEndDate}</div>
                <div class="row funding-percent" style="margin-left: 0;font-size:18px;font-family: unset;">
                	<strong style="font-size:20px;">${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}</strong>% 달성!
                </div>
                <div class="row funding-join-count text-left" style="margin-left: 0px;font-size: 18px;font-family: unset;font-weight:500">
                	<strong style="font-size:20px;">${fn:length(funding.payInfoList) }</strong>명 참여중
                </div>
                  
                  <!--payInfoList Hidden  START-->  
                  <c:forEach items="${funding.payInfoList}" var="payInfo">
                  		<c:if test="${payInfo.user.email == sessionScope.user.email}">
                  			<c:set var="isFunding" value="true"/>
                  			<input type="hidden" name="payInfoNo" value="${payInfo.payInfoNo}">
                  		</c:if>
                  	</c:forEach>
                  <!--payInfoList Hidden END -->
              
               <c:if test="${!empty sessionScope.user}">
                    	<c:if test="${sessionScope.user.email == funding.creation.creationAuthor.email}">
	                    	<div class="row funding-userlist text-center funding-button" style="padding-top: 7px;height: 45px;background-color: rgba(14, 197, 147, 0.87);color: aliceblue;font-size: large;">
	              			<strong>참여자목록조회</strong></div>   
                        </c:if>
	                     <c:if test="${!isFunding}">
				              <div data-toggle="modal" data-target="#add-payInfo" class="row funding-join text-center funding-button" style="padding-top: 7px;height: 45px;background-color: rgba(14, 197, 147, 0.87);color: aliceblue;font-size: large;">
				              <strong>펀딩하기</strong></div>    
	                    </c:if>
	                    <c:if test="${isFunding}">
	                    	<div class="row funding-pay-info text-center funding-button" style="padding-top: 7px;height: 45px;background-color: rgba(14, 197, 147, 0.87);color: aliceblue;font-size: large;">
	              			<strong>펀딩정보조회</strong></div>
	                    </c:if>
	       		</c:if>
           
           </div><!-- funding-content 끝 -->
         </div><!-- 펀딩정보 끝 -->
        </div><!-- creation-part 끝 -->
 	</div><!-- div container 끝 -->
        	<%-- <div class="row col-sm-12 col-md-12 button-position text-right" style="margin-top: 30px;">
                    <c:if test="${!empty sessionScope.user}">
                    	<c:if test="${sessionScope.user.email == funding.creation.creationAuthor.email}"> 
                        	<a class="btn btn-default funding-userlist" type="button">참여자목록조회</a>
                    	</c:if>
	                     <c:if test="${!isFunding}">
	                        <a class="btn btn-default funding-join" type="button" data-toggle="modal" data-target="#add-payInfo">펀딩하기</a>
	                    </c:if>
	                    <c:if test="${isFunding}">
	                    	<a class="btn btn-default funding-pay-info" type="button">펀딩정보조회</a>
 	                   </c:if>
	              </c:if>
	        </div> --%>
	        <hr style="margin-bottom:0;    margin-top: 50px;">
	<div class="container-fluid" style="background-color:rgba(0,0,0,0.075);">
		<div class="container">
	        <div class="row funding-content-detail" style="text-align:center;">
	            <div class="text-center" style="height:100%;background-color:#ffffff;">
		            <div class="row content-detail" style="margin-bottom: 50px;padding-top:30px;">
		                ${funding.fundingIntro}
		            </div>
	            	<div class="enter-block funding-creation" style="cursor:pointer;">
	            	작품보러 가기
	            	</div>
	                
	                <c:if test="${sessionScope.user.email == funding.creation.creationAuthor.email}">
		               <!--  <button class="btn btn-link funding-update" type="button">수정</button> -->
		            </c:if>
	            </div>
	        </div>
	    </div>
    </div>
 
    
    <!--===================== addPayInfo Modal================================ -->
		<div class="modal fade add-payInfo"  id="add-payInfo" tabindex="-1" role="dialog" style="z-index:1090;">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="insert-payInfo">펀딩 참여정보 입력</h4>
		      </div>
		      
		      <form class="payInfoForm">
		      <div class="modal-body">
		     
		      	<div class="form-group">
		      		<div class="row">
		                <div class="col-sm-3 ">
		                    <label class="control-label" for="title-fundingInfo">펀딩명</label>
		                    <input class="fundingNo" type="hidden" id="fundingNo-fundingInfo" name="fundingNo" value="${funding.fundingNo }">
		                	<input class="payInfoNo" type="hidden" id="payInfoNo" name="payInfoNo"  value="${payInfo.payInfoNo }">
		                	<input class="creationNo"  type="hidden" name="creationNo" value="${funding.creation.creationNo}">
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
		                    <input class="form-control name-fundingInfo inputValue" type="text" name="userName" placeholder="이름"   id="name-fundingInfo" value="${payInfo.userName }">
		                </div>
	              	 </div>
	              	<div class="postcodify"></div>
		                <div class="row" >
			                <div class="col-sm-3 ">
			                <label class="control-label" for="addr-fundingInfo">우편번호</label>
			                </div>
			                <div class="row col-sm-9 ">
			                    <input class=" postcodify_postcode5 inputValue" type="text" name="postCode"    id="postcode" value="${payInfo.postCode}">
			                <div class="row addrSearch" style="overflow: auto; max-height: 250px;">
			                	   	
			                </div>
			                </div>
		                </div>
		                
		                <div class="row">
			                <div class="col-sm-3 ">
			                <label class="control-label" for="addr-fundingInfo">도로명주소</label>
			                </div>
			                <div class="col-sm-9">
			                    <input class="form-control postcodify_address inputValue" type="text" name="addr" placeholder="도로명주소"   id="address" value="${payInfo.addr }">
			                </div>
		                </div>
		                <div class="row">
			                <div class="col-sm-3">
			                <label class="control-label" for="addr-fundingInfo">상세주소</label>
			                </div>
			                <div class="col-sm-9">
			                    <input class="form-control postcodify_details inputValue" type="text" name="addrDetail" placeholder="상세주소"   id="addrDetails" value="${payInfo.addrDetail }">
			                </div>
			              </div>
		              
		              
		              <div class="row">
		                <div class="col-sm-3">
		                    <label class="control-label" for="phone-fundingInfo">연락처</label>
		                </div>
		                <div class="col-sm-9">
		                    <input class="form-control phone inputValue" type="text" name="phone" placeholder="01012341234"   id="phone-fundingInfo" value="${payInfo.phone }">
		                </div>
	                </div>
            	</div>
				<br/>           
		      </div>
		      </form>
		      
		      <div class="modal-footer">
		        <a type="button" class="btn btn-default" data-dismiss="modal">Close</a>
		        <a type="button " class="btn btn-primary" id="pay">결제하기</a>
		      </div>
		    </div>
		  </div>
		</div>
    
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
	
</body>
</html>
