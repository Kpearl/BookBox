<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
	
	

<style type="text/css">

/* 페이지 css 설정 */
		span.tag{
			margin-right: 2px; 
			border: 1px solid;
			border-color: #bbbbbb;
			border-radius: 15px;
			padding: 4px;
			font-weight: bold;
		}
		div.row.writing-border{
			border-top: 1px solid #eeeeee;
		}
		  
		 
		body{
			padding-top:0px;
			
		}
		header{
			background:url(../resources/images/newCreationTest1.jpg) no-repeat center;
		}
		
		.btn-form{
	     	border: 2px groove; 
		    padding: 5px;
		    border-radius: 7px; 
		    display:inline-block;
	        padding-left: 15px;
   			padding-right: 15px;
   			cursor:pointer;
		}
		.like{
			padding: 4px 15px; 
		}
		


   
    </style>

	
    <script>
    
	   ToolbarOpacHeight(500);
	   
	   function fncDoSubscription(){
		   $.ajax ({
			   url : "rest/doCreationSubscribe?creationNo="+$("input[name='creationNo']").val(),
	    		method : "get",
	    		dataType : "json",
	    		success: function(JSONData, status){
	    		//	alert(JSONData);
	    			$(".doSubscription").css('background-color','rgba(255, 20, 44, 0.21)').removeClass('doSubscription').addClass('deleteSubscription').html("<i class='glyphicon glyphicon-tags'></i><strong>구독중</strong>").off('click');
	    		//	$("a.doSubscription").replaceWith("<a style='background-color:rgba(106, 98, 230, 0.46);' class='btn btn-default deleteSubscription' type='button'><i class='glyphicon glyphicon-tags'></i>구독중</a>");
	    			 $(".deleteSubscription").on("click" , function() {
			   	    		alert("구독취소");
			   	    		fncDeleteSubscription();
			   	    	}); 
	    		}  
		   });
	   }
	   
	   function fncDeleteSubscription(){
		   $.ajax ({
			   url : "rest/deleteCreationSubscribe?creationNo="+$("input[name='creationNo']").val(),
	    		method : "get",
	    		dataType : "json",
	    		success: function(JSONData, status){
	    			alert(JSONData);
	    			$(".deleteSubscription").css('background-color','#ffffff').removeClass('deleteSubscription').addClass('doSubscription').html("<strong>구독하기</strong>").off('click');
	    		//	$("a.deleteSubscription").replaceWith("<a class='btn btn-default doSubscription' type='button'><i class='glyphicon glyphicon-tags'></i>구독</a>");
	    			 $(".doSubscription").on("click" , function() {
			   	    		alert("구독");
			   	    		fncDoSubscription();
			   	    	});  
	    		
	    		}  
		   });
	   }
	   
	   function fncAddCreationLike(){   
		   var total = document.getElementById('likeSum').innerHTML;  	
		   	$.ajax ({
		   		url : "rest/addCreationLike?creationNo="+$("input[name='creationNo']").val(),
		   		method : "GET",
		   		success:function(JSONData, status){
		   		//	alert(status);
		   			alert(JSONData);
		   			
		   			$(".addCreationLike").removeClass('addCreationLike').addClass('deleteCreationLike').off('click');
		   			$('img.creationLike-link').attr('src','https://icongr.am/entypo/heart.svg?size=25&color=ff0000');
		   		
		   			$("#likeSum").replaceWith("<span id='likeSum'>" + (Number(total)+1) + "</span>");
		   	   		 $(".deleteCreationLike").on("click" , function() {
		   	    		alert("좋아요취소");
		   	    		fncDeleteCreationLike();
		   	    	});
		   		 } 
		   	});
		}  
	   
	   function fncDeleteCreationLike(){   
		   var total = document.getElementById('likeSum').innerHTML;	   	   	
	   	   	$.ajax ({
	   	   		url : "rest/deleteCreationLike?creationNo="+$("input[name='creationNo']").val(),
	   	   		method : "GET",
	   	   		success:function(JSONData, status){
	   	   			
	   	   		$(".deleteCreationLike").removeClass('deleteCreationLike').addClass('addCreationLike').off('click');
	   	   		$('img.creationLike-link').attr('src','https://icongr.am/entypo/heart-outlined.svg?size=25&color=ff0000');
	   	   		//	$("#addLike").replaceWith('<a id="addLike" class="btn btn-default addLike" type="button"><i class="glyphicon glyphicon-heart-empty "></i> 좋아요</a>');
	   	   			$("#likeSum").replaceWith("<span id='likeSum'>" + (Number(total)-1) + "</span>");
		   	   		 $(".addCreationLike").on("click" , function() {
		   	    		alert("좋아요");
		   	    		fncAddCreationLike();
		   		    	
		   	    	});
	   	   		} 
	   	   	});
		} 

	   
   $(function() {
	 //=====================메뉴 Navigation=================
		   	$('.menu').on('click',function() {
		   		history.back();
		   	})
	   //============= 창작글쓰기 Navigation Event  처리 =============	
		  $("a.addWriting").on("click" , function() {
			  $(self.location).attr("href","../creation/addWriting");
	   	}); 
       //============= 창작글 조회 Navigation Event  처리 =============	
	   $("a.writingTitle").on("click" , function() {
	   		$(self.location).attr("href","../creation/getWriting?writingNo="+$(this).attr("id"));
   		}); 
	   //============= 창작작품 수정 Navigation Event  처리 =============	
	   $(".updateCreation").on("click" , function() {
		   $(self.location).attr("href","../creation/updateCreation?creationNo="+$("input[name='creationNo']").val());
   		}); 
	   //============= 창작작품 삭제 Navigation Event  처리 =============	
	   $(".deleteCreation").on("click" , function() {
		   alert("정말로 삭제하시겠습니까?");
		   $(self.location).attr("href","../creation/deleteCreation?creationNo="+$("input[name='creationNo']").val());
   		});	   
 	   //============= 검색 Event  처리 ====================	
	  $("a.creationSearch").on("click" , function() {
		$(self.location).attr("href","../creation/getCreationList?condition="+$("select[name='condition']").val()+"&keyword="+$("input[name='keyword']").val());
		}); 
	  
		//============= 펀딩등록 ====================	
	  $("a.addFunding").on("click" , function() {
		$(self.location).attr("href","../creation/addFunding");
	  });	
		
	//============= 펀딩보러가기 ====================	
	  $("a.getFunding").on("click" , function() {
		$(self.location).attr("href","../creation/getFundingList?creationNo="+$("input[name='creationNo']").val());
	  });
		
   }); 
 	   
   $(function() {
 //========================구독신청 =======================
	   $(".doSubscription").on("click" , function() {
		   alert("구독");
		   fncDoSubscription();	
	   });
   //========================구독신청 취소=======================
	   $(".deleteSubscription").on("click" , function() {
		   alert("구독취소");		   
		   fncDeleteSubscription();
		});

    //========================좋아요 추가=======================
     	 $(".addCreationLike").on("click" , function() {
    		alert("좋아요");
    		fncAddCreationLike();
	    	
    	});
    //=========================좋아요 취소=================================
      	 $(".deleteCreationLike").on("click" , function() {
    		alert("좋아요취소");
    		fncDeleteCreationLike();
    	});
    });


    
    </script>
		

</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>
	
    <div class="container">
		<div class="row">
			<!-- 글쓰기, 펀딩등록 버튼 -->
			<c:if test="${!empty sessionScope.user }">
				<div class="col-md-6 text-left">
					<a type="button" class="btn btn-default addWriting">창작글쓰기</a>
					<a type="button" class="btn btn-default addFunding">펀딩등록하기</a>
				</div>
			</c:if>
				<!-- 생성버튼 끝 -->
			 	
		 	<form class="form-inline text-right " >
			  <div class="form-group">
			    <div class="input-group">
			      <div class="input-group-addon">
			      	<select class="form-control" name="condition">
			      		<option value="3" ${ ! empty search.condition && search.condition==3 ? "selected" : "" }></option>
			      		<option value="0" ${ ! empty search.condition && search.condition==0 ? "selected" : "" }>제목</option>
			      		<option value="1" ${ ! empty search.condition && search.condition==1 ? "selected" : "" }>작가</option>
			      		<option value="2" ${ ! empty search.condition && search.condition==2 ? "selected" : "" }>태그</option>
			      	</select>
			      </div>
			      <input type="text" class="form-control" name="keyword" id="keyword" placeholder="검색어">
			  	 	<div class="input-group-addon">
			  			<a class="btn creationSearch">검색</a> 
			  			
					</div>
			    </div>
			  </div>
			</form>
				
		</div>


       
          
        <div class="row" style="height:325px">
				<input type ="hidden" name="creationNo" value="${creation.creationNo }"/>
            <div class="col-md-5">
            	<img class="img-rounded img-responsive  img-object-fit" src="../resources/upload_files/images/${creation.creationFileName }">
            	<c:if test="${creation.doFunding}">
            		펀딩 진행 중!
            	</c:if>
            </div>
            <div class="col-md-7">
            	<div class="row">
	            	<strong style="font-size: xx-large;">${creation.creationTitle}  </strong>
	           		<span style="    font-size: small;">  ${creation.creationAuthor.nickname}</span>
	          </div>
	          <div>
           			<span id="gradeAvg">평균 평점 :${creation.grade.average}</span>
	          </div>
   			 <div class="row">
                	<div class="col-sm-12" style="padding-left: 10%;padding-right: 3%;">
	                	${creation.creationIntro}
	                </div>
                </div>
                
		        <div class="row">
		            <div class="col-xs-12 " style="padding-left: 10%;    padding-top: 4%;">
			           	<c:forEach items="${creation.tagList}" var="tag">
			           		<span style="border: 1px solid;border-color: #bbbbbb;border-radius: 15px;padding: 4px;" class="tag">
			           		<strong>#${tag.tagName}</strong></span>
			           	</c:forEach>
		            </div>
		        </div>
            </div>
        </div>
        <div class="row">
        	<div class="col-md-6" >
        		<div class="row">
				<c:if test="${sessionScope.user.email == creation.creationAuthor.email}">
                	<div class="btn-form control-btn updateCreation" style="display:inline-block;">수정</div>
                	<div class="btn-form control-btn deleteCreation" style="display:inline-block;">삭제</div>
	             </c:if>
	             </div>
			</div>
        
            <div class="col-md-6">
            	<div class="row" role="group" style="float:right">
                	
                	<%-- <c:if test="${creation.doFunding}"> --%>
                <div class="go-funding btn-form" style="margin-right: 20px;"><strong>펀딩보러가기</strong></div>
            <%-- </c:if> --%>
                
	                <c:if test="${creation.doSubscription}">
	                	<div class="subscription deleteSubscription btn-form" style="background-color:rgba(255, 20, 44, 0.21);"><i class="glyphicon glyphicon-tags"></i><strong>  구독중</strong></div>
	                    <!-- <a style="background-color:rgba(106, 98, 230, 0.46);" class="btn btn-default deleteSubscription" type="button"><i class="glyphicon glyphicon-tags"></i>구독중</a> -->
	                </c:if>
	                <c:if test="${!creation.doSubscription}">
	                	<div class="subscription doSubscription btn-form"><strong>구독하기</strong></div>
	                </c:if>
	                <c:if test="${creation.like.doLike}">
	                    <div class="like deleteCreationLike btn-form">	
	                    	<img class="creationLike-link" src="https://icongr.am/entypo/heart.svg?size=25&color=ff0000"> <span  id="likeSum">${creation.like.totalLike}</span>
	                    </div>
	                    <!-- </a> -->
	                </c:if>
	                <c:if test="${!creation.like.doLike}">
	                    <div class="like addCreationLike btn-form" >
	                    	<img class="creationLike-link" src="https://icongr.am/entypo/heart-outlined.svg?size=25&color=ff0000"> <span  id="likeSum">${creation.like.totalLike}</span>
	                    </div>
	               </c:if>
                </div>
            </div>
        </div>
            
            
           <!--  <a class= "btn menu" id="update-writing" >메뉴</a> -->
    
    </div>
    
    <hr>
    
    <div class="container">
        <div class="row hidden-xs hidden-sm">
            <div class="col-md-2 text-center">
                <p>이미지</p>
            </div>
            <div class="col-md-7 text-center">
                <p>제목</p>
            </div>
            <div class="col-md-2 text-center">
                <p>평점</p>
            </div>
            <div class="col-md-1 text-center">
                <p>등록일</p>
            </div>
        </div>
        
    <c:forEach items="${creation.writingList}" var="writing">
        <div class="row writing-border">
        	<input type ="hidden" class="writingNo" name="writingNo" value="${writing.writingNo }" readonly>
            <div class="col-md-2 col-xs-3">
            	<img class="img-responsive" src="../resources/upload_files/images/${writing.writingFileList[0].fileName }">
            </div>
            <div class="col-md-7 col-xs-9">
                <div class="row">
                    <div class="col-md-12">
                        <p><a href="#" class="writingTitle" id="${writing.writingNo}">${writing.writingTitle }</a></p>
                    </div>
                </div>
                <div class="row hidden-md hidden-lg">
                    <div class="col-xs-7">
						<div id="starWrap" class="star4<%-- ${book.grade.average} --%>">
							<ul>
								<li class="s1"></li>
								<li class="s2"></li>
								<li class="s3"></li>
								<li class="s4"></li>
								<li class="s5"></li>
							</ul>
						</div>
					</div>
                    <div class="col-xs-5"><span>${writing.regDate}</span></div>
                </div>
            </div>
            <div class="col-md-2 hidden-xs hidden-sm">
				<div id="starWrap" class="star4<%-- ${book.grade.average} --%>">
					<ul>
						<li class="s1"></li>
						<li class="s2"></li>
						<li class="s3"></li>
						<li class="s4"></li>
						<li class="s5"></li>
					</ul>
				</div>
			</div>
            <div class="col-md-1 hidden-xs hidden-sm"><span>${writing.regDate}</span></div>
        </div>
	</c:forEach>
       
    </div>
	
	
		<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
   
</body>
</html>