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
		var creationNo;
		

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
		                            						alert(status);
		                            						
		                            						alert("결제가 완료되었습니다.");
		                            						$('#add-payInfo').modal("hide");
		                            						$('a.funding-join').replaceWith('<a class="btn btn-default funding-pay-info" type="button">참여정보조회</a>');
															
		                            						var msg = '결제가 완료되었습니다.';
		                            		    			msg += '\n고유ID : ' + rsp.imp_uid;
		                            		    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
		                            		    			msg += '\결제 금액 : ' + rsp.paid_amount;
															alert(msg);
		                            					
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
						
			$('a.funding-pay-info').on('click', function(){
				//	$(self.location).attr('href', '../creation/getPayInfo?payInfoNo='+payInfoNo);
				
				/////////ajax 적용/////////
					$.ajax({
						url : "rest/getPayInfo?fundingNo="+$('#fundingNo-fundingInfo').val(),
						method : "get",
						dataType : "json",
						success : function(JSONData, status) {
							//Debug...
							alert(status);
											
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
				});
			
		});//참여정보조회 이벤트 끝
		
		
		
	//============================================	
		
		$(function(){
			fncPostcodify();
		
			$('a.funding-creation').on('click', function(){
				$(self.location).attr('href', '../creation/getWritingList?creationNo='+$('input[name="creationNo"]').val());
			});
			$('a.funding-userlist').on('click', function(){
				$(self.location).attr('href', '../creation/getFundingUserList?fundingNo='+$('input[name="fundingNo"]').val());
			});
			
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
			alert(today);
			alert('${funding.fundingEndDate}');
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
	<!-- 여기부터 코딩 -->

    <div class="container">
        <div class="row">
           	<input class="fundingNo" type="hidden" name="fundingNo" value="${funding.fundingNo}">
           	<div class="col-md-6">
            	<img class="img-responsive" src="../resources/upload_files/images/${funding.fundingFileName}">
            </div>
            <div class="col-md-6">

                <div class="fundingTitle">${funding.fundingTitle}</div>
                <input type="hidden" class="fundingTitle" value="${funding.fundingTitle}">
               <div class="creationTitle">글제목 : ${funding.creation.creationTitle}</div>
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
                        <div class="perFunding">${funding.perFunding}</div>
                    </div>
                    <div class="col-xs-6 text-center">
                  	<c:forEach items="${funding.payInfoList}" var="payInfo">
                  		<c:if test="${payInfo.user.email == sessionScope.user.email}">
                  			<c:set var="isFunding" value="true"/>
                  			<input type="hidden" name="payInfoNo" value="${payInfo.payInfoNo}">
                  		</c:if>
                  	</c:forEach>
                    <c:if test="${!empty sessionScope.user}">
                    	<c:if test="${sessionScope.user.email == funding.creation.creationAuthor.email}"> 
                        	<a class="btn btn-default funding-userlist" type="button">참여자목록조회</a>
                    	</c:if>
	                     <c:if test="${!isFunding}">
	                        <a class="btn btn-default funding-join" type="button" data-toggle="modal" data-target="#add-payInfo">참여하기</a>
	                    </c:if>
	                    <c:if test="${isFunding}">
	                    	<a class="btn btn-default funding-pay-info" type="button">참여정보조회</a>
 	                   </c:if>
	                 </c:if>
                   </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <p>${funding.fundingIntro}</p>
                <a class="btn btn-link center-block funding-creation" type="button">글보러 가기</a>
                <c:if test="${sessionScope.user.email == funding.creation.creationAuthor.email}">
	                <button class="btn btn-link funding-update" type="button">수정</button>
	            </c:if>
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
    

	
</body>
</html>
