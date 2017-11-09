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

	<style>
	
	   body{
    		padding-top:0px;
    		
    	}
    	header{
    		background:url(../resources/images/creationTest7.jpg) no-repeat center;
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
	</script>
</head>

<body>
	<jsp:include page="../layout/toolbar.jsp">
		<jsp:param value="../" name="uri"/>
	</jsp:include>
		<header class="parallax"></header>
	<!-- 여기부터 코딩 -->

    <div class="container">
        <div class="row">
       <!-- 글쓰기, 펀딩등록 버튼 -->
			<div class="col-md-6 text-left" style="vertical-align: middle;">
			<c:if test="${!empty sessionScope.user }">
				<a class="btn btn-default addWriting">창작글 쓰기</a>
				<a class="btn btn-default addfunding">펀딩등록하기</a>
			</c:if>
			</div>
			<!-- 생성버튼 끝 -->

		 	<form class="form-inline text-right col-md-6" >
			  <div class="form-group" style="vertical-align: middle;">
			    <div class="input-group" style="vertical-align: middle;">
			      <div class="input-group-addon" style="vertical-align: middle;">
			      	<select class="form-control" name="condition">
			      		<option value="3" ${ ! empty search.condition && search.condition==3 ? "selected" : "" }></option>
			      		<option value="0" ${ ! empty search.condition && search.condition==0 ? "selected" : "" }>제목</option>
			      		<option value="1" ${ ! empty search.condition && search.condition==1 ? "selected" : "" }>작가</option>
			      		<option value="2" ${ ! empty search.condition && search.condition==2 ? "selected" : "" }>태그</option>
			      	</select>
			      </div>
			      <input type="text" class="form-control" name="keyword" id="keyword" placeholder="검색어" >
			  	 	<div class="input-group-addon">
			  			<a class="btn creationSearch">검색</a> 
			  			<!-- <button type="submit" class="btn" name="creationSearch">검색</button> -->
					</div>
			    </div>
			  </div>
			</form>
			
		</div> 
        

        <!-- 실제 데이터 들어갈 곳 -->
		<c:forEach items="${fundingList}" var="funding">
            <div class="col-md-6 funding-content">
                <div class="row">
                    <div class="col-md-10 col-md-offset-1" style="border:1px solid">
                        <div class="row">
                           	<input type="hidden" name="fundingNo" value="${funding.fundingNo}">
                           <%-- 	<input type="hidden" name="creation.creationNo" value="${funding.creation.creationNo}"> --%>
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
    
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>

	
</body>
</html>
