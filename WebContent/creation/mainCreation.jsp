<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/css/swiper.css">
	 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.jquery.js"></script>
	
	
	<style>
    .swiper-container {
        width: 100%;
        height: 35%;
    }
    .swiper-slide {
        text-align: center;
        font-size: 18px;
        background: #fff;
        
        /* Center slide text vertically */
        display: -webkit-box;
        display: -ms-flexbox;
        display: -webkit-flex;
        display: flex;
        -webkit-box-pack: center;
        -ms-flex-pack: center;
        -webkit-justify-content: center;
        justify-content: center;
        -webkit-box-align: center;
        -ms-flex-align: center;
        -webkit-align-items: center;
        align-items: center;
    }
    
    body{
    		padding-top:0px;
    	}
    	header{
    		background:url(../resources/images/creationTest7.jpg) no-repeat center;
    	}
    	
    .creation-list{
    	margin : 4px 8px;
    	vertical-align: middle;
	    overflow-y: hidden;
	    height: 200px;
    	background-color: rgba(255, 236, 218, 0.63);
    }
    
    .creation-part{
    	margin-top :100px;
    	margin-bottom: 50px;
    }
    
    .tag-space{
    	font-size: 15px;
	    font-weight: 700;
	    margin-top: 130px;
	    margin-left: 8px;
    }
    	
    	
    </style>

	
	 <!-- Initialize Swiper -->
    <script>
    
    ToolbarOpacHeight(500);
    
    $(function(){
   
    	var swiper = new Swiper('.swiper-container', {
        	pagination: '.swiper-pagination',
        	slidesPerView: 3,
        	paginationClickable: true,
        	spaceBetween: 30
	    });
    })
    
    //============= 펀딩글보기 Navigation Event  처리 =============	
$(function() {
	$("a:contains('펀딩제목')").on("click" , function() {
		$(self.location).attr("href","../creation/getFunding");
	}); 
});
    
   //============= 펀딩글보기 Navigation Event  처리 =============	
   $(function() {
   	$("a[name='펀딩이미지']").on("click" , function() {
   		$(self.location).attr("href","../creation/getFunding");
   	}); 
 });
   
   //============= 펀딩리스트 더보기 Navigation Event  처리 =============	
   $(function() {
	   $("a.fundingMore").on("click" , function() {
   		$(self.location).attr("href","../creation/getFundingList");
   	}); 
 });  
   
   //============= 픽션 창작리스트 더보기 Navigation Event  처리 =============	
   $(function() {
	   $("a.fictionMore").on("click" , function() {
   		$(self.location).attr("href","../creation/getCreationList?condition=2&keyword=픽션");
   	}); 
 });   
   
   //============= 논픽션 창작리스트 더보기 Navigation Event  처리 =============	
   $(function() {
	   $("a.nonfictionMore").on("click" , function() {
   		$(self.location).attr("href","../creation/getCreationList?condition=2&keyword=논픽션");
   	}); 
 });   
   
   //============= 창작작품 회차리스트 Navigation Event  처리 =============	
   $(function() {
   	$("a:contains('창작작품명')").on("click" , function() {
   		$(self.location).attr("href","../creation/getWritingList?creationNo=");
   	}); 
 });  
   
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
   
   //============= 검색 Event  처리 =============	
	  $("a.creationSearch").on("click" , function() {
		$(self.location).attr("href","../creation/getCreationList?condition="+$("select[name='condition']").val()+"&keyword="+$("input[name='keyword']").val());
	
	}); 
   
/*    //============= 창작공간 Navigation Event  처리 =============	
   $(function() {
   	$("img[name='creationFile']).on("click" , function() {
   		$(self.location).attr("href","${param.uri}creation/getWritingList");
   	}); 
 });   */
    
    </script>
		

</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>
	
<div class="container">	
	<div class="row" style="vertical-align: middle;">
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
	

  <div class="row creation-part" >
      <div style="width: 42%;border: #bbbbbb 1px solid;display: inline-block;"></div>
      <div class="text-center" style="width: 13%; display: inline-block; font-size: 27px;font-weight: 400; font-style: italic;">
         <span>Funding</span>
      </div>
      <div style="width: 42%;border: #bbbbbb 1px solid;display: inline-block;"></div>
   </div>
	
		   <div class="row text-right col-sm-offset-11 col-sm-1">
		   		<a  class="fundingMore" name="fundingMore">더보기</a>
		   </div>
	
    <!-- Swiper -->
    	<div class="swiper-container" id= list>
        	<div class="swiper-wrapper">
            <c:forEach items="${fundingList}" var="funding">	
			        
            <div class="swiper-slide" >
				<div class="item">
					<input type="hidden" name="fundingNo" value="${funding.fundingNo}">
					<div class="row funding-image" style="height:200px; position:relative;">
						<img style="position: absolute;  left: 50%;  top: 50%; transform: translate(-50%, -50%);" class="img-thumbnail img-responsive funding-get" src="../resources/upload_files/images/${funding.fundingFileName}">
					</div>
					<div class="row funding-title">
					<h4 class="btn-link funding-get">${funding.fundingTitle}</h4>
					</div>
					<p>Funding content</p>
					<div class="progress">
                          <div class="progress-bar progress-bar-success progress-bar-striped active" 
                          		aria-valuenow="${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}" aria-valuemin="0" aria-valuemax="100"
                          		style="min-width: 2em; width: ${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}%;">
                          	${(funding.perFunding * fn:length(funding.payInfoList)) / funding.fundingTarget * 100}%
                          </div>
                     </div>
					
				</div>
			</div>
		</c:forEach>
     </div>
        <!-- Add Pagination -->
        <div class="swiper-pagination row" style="height:6px;"></div>
    </div>
        
  <div class="row creation-part" >
      <div style="width: 42%;border: #bbbbbb 1px solid;display: inline-block;"></div>
      <div class="text-center" style="width: 13%; display: inline-block; font-size: 27px;font-weight: 400; font-style: italic;">
         <span>Fiction</span>
      </div>
      <div style="width: 42%;border: #bbbbbb 1px solid;display: inline-block;"></div>
   </div>
   
   <div class="row">
	   <div class="col-sm-12 col-md-12">
		<c:forEach var="fiction" items="${fictionList }" >
		  		 <div class="row creation-list" >
					<div class="col-sm-4 col-md-4" style="height:100%; background-color:rgba(114, 114, 114, 0.48);">
						<img style="position: absolute;  left: 50%;  top: 50%; transform: translate(-50%, -50%);" class="img-responsive" alt="Image" src="../resources/upload_files/images/${fiction.creationFileName}" name="creationFile">
					</div>
					<div class="col-sm-8 col-md-8">
						<div class="col-sm-"></div>
							<h5><span>${fiction.creationTitle }</span>&nbsp;&nbsp;&nbsp;<span>by.${fiction.creationAuthor.nickname }</span></h5>
							<%-- <h6><span>by.${fiction.creationAuthor.nickname }</span></h6> --%>
						<div class="col-sm-offset-1 col-sm-11 text-left">
						${fiction.creationIntro }
						</div>
							<div class="row tag-space">
						<c:forEach var="tag" items="${fiction.tagList }">
								<span>#${tag.tagName }</span>
						</c:forEach>
							</div>
					</div>
		   		</div>
		   		<hr>
		</c:forEach>	   
	   </div>
   </div>
   
   <div class="row text-right col-sm-offset-11 col-sm-1">
		<a  class="fictionMore" name="fundingMore">더보기</a>
	</div>
   
  <div class="row creation-part" >
      <div style="width: 42%;border: #bbbbbb 1px solid;display: inline-block;"></div>
      <div class="text-center" style="width: 13%; display: inline-block; font-size: 27px;font-weight: 400; font-style: italic;">
         <span>nonFiction</span>
      </div>
      <div style="width: 42%;border: #bbbbbb 1px solid;display: inline-block;"></div>
   </div>
   
   <div class="row">
	   <div class="col-sm-12 col-md-12">
		<c:forEach var="nonfiction" items="${nonFinctionList }" >
		  		 <div class="row creation-list" >
					<div class="col-sm-8 col-md-8" >
						<h5><span>${nonfiction.creationTitle }</span>&nbsp;&nbsp;&nbsp;<span>by.${nonfiction.creationAuthor.nickname }</span></h5>
						<div class="col-sm-offset-1 col-sm-11 text-left">
						${nonfiction.creationIntro }
						</div>
						<div class="row tag-space">
					<c:forEach var="tag" items="${nonfiction.tagList }">
							<span>#${tag.tagName }</span>
					</c:forEach>
						</div>
					</div>
					<div class="col-sm-4 col-md-4" style="height:100%; background-color:rgba(114, 114, 114, 0.48);">
						<img style="position: absolute;  left: 50%;  top: 50%; transform: translate(-50%, -50%);" class="img-responsive" alt="Image" src="../resources/upload_files/images/${nonfiction.creationFileName }" name="creationFile">
					</div>
		   		</div>
		   		<hr>
		</c:forEach>	   
	   </div>
   </div>
    <div class="row text-right col-sm-offset-11 col-sm-1">
		<a  class="nonfictionMore" name="fundingMore">더보기</a>
	</div>


</div>

	
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
   
</body>
</html>