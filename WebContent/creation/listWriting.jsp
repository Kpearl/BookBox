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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/css/swiper.css">
	 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.jquery.js"></script>
	
	

<style type="text/css">

/* 페이지 css 설정 */
span.tag{
	margin-right: 5px;
}
div.row.writing-border{
	border-top: 1px solid #eeeeee;
}
  
  /* ////////////////별점 CSS  //////////// */
/* ////////////마우스오버///////////////// */
#starWrap ul:after {
	content: '';
	display: block;
	clear: both;
}

#starWrap ul li {
	width: 16px;
	height: 15px;
	float: left;
	background: url('../resources/images/bgStarSolo.png') no-repeat;
	cursor: pointer;
	display: inline-block;
}

#starWrap.star1 .s1 {
	background-position: 0 -15px;
}

#starWrap.star2 .s1, #starWrap.star2 .s2 {
	background-position: 0 -15px;
}

#starWrap.star3 .s1, #starWrap.star3 .s2, #starWrap.star3 .s3 {
	background-position: 0 -15px;
}

#starWrap.star4 .s1, #starWrap.star4 .s2, #starWrap.star4 .s3, #starWrap.star4 .s4
	{
	background-position: 0 -15px;
}

#starWrap.star5 .s1, #starWrap.star5 .s2, #starWrap.star5 .s3, #starWrap.star5 .s4,
	#starWrap.star5 .s5 {
	background-position: 0 -15px;
}

/*///////////////// 마우스클릭/////////////////////// */
#starWrapClick ul:after {
	content: '';
	display: block;
	clear: both;
}

#starWrapClick ul li {
	width: 16px;
	height: 15px;
	float: left;
	background: url('../resources/images/bgStarSolo.png') no-repeat;
	cursor: pointer;
}

#starWrapClick.star1 .s1 {
	background-position: 0 -15px;
}

#starWrapClick.star2 .s1, #starWrapClick.star2 .s2 {
	background-position: 0 -15px;
}

#starWrapClick.star3 .s1, #starWrapClick.star3 .s2, #starWrapClick.star3 .s3
	{
	background-position: 0 -15px;
}

#starWrapClick.star4 .s1, #starWrapClick.star4 .s2, #starWrapClick.star4 .s3,
	#starWrapClick.star4 .s4 {
	background-position: 0 -15px;
}

#starWrapClick.star5 .s1, #starWrapClick.star5 .s2, #starWrapClick.star5 .s3,
	#starWrapClick.star5 .s4, #starWrapClick.star5 .s5 {
	background-position: 0 -15px;
}
   
    </style>

	
    <script>

   $(function() {
	   
	   //============= 창작글쓰기 Navigation Event  처리 =============	
	   $(function() {
		  $("a.addWriting").on("click" , function() {
			  $(self.location).attr("href","../creation/addWriting");
	   	}); 
	 });   
		   
       //============= 창작글 조회 Navigation Event  처리 =============	
	   $("a.writingTitle").on("click" , function() {
	   		$(self.location).attr("href","../creation/getWriting?writingNo="+$(this).attr("id"));
   		}); 

   //============= 창작작품 수정 Navigation Event  처리 =============	
	   $("a.updateCreation").on("click" , function() {
		   $(self.location).attr("href","../creation/updateCreation?creationNo="+$("input[name='creationNo']").val());
		   
   		}); 

	   //============= 창작작품 삭제 Navigation Event  처리 =============	
	   $("a.deleteCreation").on("click" , function() {
		   alert("정말로 삭제하시겠습니까?");
		   $(self.location).attr("href","../creation/deleteCreation?creationNo="+$("input[name='creationNo']").val());
   		});	   
   }); 
   
   //============= 검색 Event  처리 =============	
	  $("a.creationSearch").on("click" , function() {
		$(self.location).attr("href","../creation/getCreationList?condition="+$("select[name='condition']").val()+"&keyword="+$("input[name='keyword']").val());
	
	}); 
   
   
 //========================구독신청 =======================
   $(function() {
	   $("a.doSubscription").on("click" , function() {
		   
		   if (${empty sessionScope.user }) {
			alert("로그인 후 이용가능합니다.");
			$(self.location).attr("href","../user/login");
		}else{
		   
		   $.ajax ({
			   url : "rest/doCreationSubscribe?creationNo="+$("input[name='creationNo']").val(),
	    		method : "get",
	    		dataType : "json",
	    		success: function(JSONData, status){
	    			$("a.doSubscription").replaceWith("<a style='background-color:rgba(232, 138, 138, 0.44);' class='btn btn-default doSubscription' type='button'><i class='glyphicon glyphicon-tags'></i>구독중</a>");
	    		 }  
		   });
		}
	   });
   });
 
   //========================구독신청 취소=======================
   $(function() {
	   $("a.doSubscription").on("click" , function() {
		   
		   if (${empty sessionScope.user }) {
			alert("로그인 후 이용가능합니다.");
			$(self.location).attr("href","../user/login");
		}else{
		   
		   $.ajax ({
			   url : "rest/deleteCreationSubscribe?creationNo="+$("input[name='creationNo']").val(),
	    		method : "get",
	    		dataType : "json",
	    		success: function(JSONData, status){
	    			$("a.doSubscription").replaceWith("<a class='btn btn-default doSubscription' type='button'><i class='glyphicon glyphicon-tags'></i>구독 하기</a>");
	    		 }  
		   });
		}
	   });
   });

    //========================좋아요 추가=======================
    function addLike(targetNo) {
    	var total = document.getElementById('likeSum').innerHTML;
    	
    	$.ajax ({
    		url : "../creation/rest/addLike",
    		method : "POST",
    		data : {"targetNo" : targetNo},
    		success:function(){
    			$("#addLike").replaceWith("<button id='deleteLike' onclick='deleteLike(${targetNo});'>좋아요취소</button>");
    			$("#likeSum").replaceWith("<span id='likeSum'>" + (Number(total)+1) + "</span>");
    		 } 
    	});
    	
    	alert("좋아요를 등록하셨습니다.");
    }

    //=========================좋아요 취소=================================
    function deleteLike(targetNo) {
    	var total = document.getElementById('likeSum').innerHTML;
    	
    	$.ajax ({
    		url : "../creation/rest/deleteLike",
    		method : "POST",
    		data : {"targetNo" : targetNo},
    		success:function(){
    			$("#deleteLike").replaceWith("<button id='addLike' onclick='addLike(${targetNo});'>좋아요</button>");
    		 	$("#likeSum").replaceWith("<span id='likeSum'>" + (Number(total)-1) + "</span>");
    		} 
    	});
    	alert("좋아요를 취소하셨습니다.");
    }


    
    </script>
		

</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	
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
			  			<!-- <button type="submit" class="btn" name="creationSearch">검색</button> -->
					</div>
			    </div>
			  </div>
			</form>
				
		</div>


        <div class="row">
            <div class="col-md-12">
                <h3>${creation.creationHead}</h3>
            </div>
        </div>
        <div class="row">
            <div class="col-md-5">
				<input type ="hidden" name="creationNo" value="${creation.creationNo }"/>
            	<img class="img-rounded img-responsive" src="../resources/upload_files/images/${creation.creationFileName }">
            	<c:if test="${creation.doFunding}">
            		펀딩 진행 중!
            	</c:if>
            </div>
            <div class="col-md-7">
                <h4>창작작품명 : ${creation.creationTitle}</h4>
                <h5>작성자 : ${creation.creationAuthor.nickname}</h5>
                <p>소개글 : ${creation.creationIntro}</p>
        <div class="row">
            <div class="col-xs-12 ">
           	<c:forEach items="${creation.tagList}" var="tag">
           		<span class="tag">#${tag.tagName}</span>
           	</c:forEach>
            </div>
        </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
            <c:if test="${creation.doFunding}">
                <div class="btn-group" role="group">
                    <a class="btn btn-default getFunding" type="button">펀딩 보러 가기</a>
                </div>
            </c:if>
                <div class="btn-group" role="group" style="float:right">
                <c:if test="${creation.doSubscription}">
                    <a class="btn btn-default cancelSubscription" type="button"><i class="glyphicon glyphicon-tags"></i>구독중</a>
                </c:if>
                <c:if test="${!creation.doSubscription}">
                    <a class="btn btn-default doSubscription" type="button"><i class="glyphicon glyphicon-tags"></i>구독 하기</a>
                </c:if>
                <c:if test="${like.doLike}">
                    <a class="btn btn-default" type="button"><i class="glyphicon glyphicon-heart"></i> 좋아요 취소</a>
                </c:if>
                <c:if test="${!like.doLike}">
                    <a class="btn btn-default" type="button"><i class="glyphicon glyphicon-heart-empty"></i> 좋아요</a>
                </c:if>
                </div>
            </div>
            <div class="col-md-12">
				<p>좋아요 개수 : <span  id="likeSum">${like.totalLike}</span></p>
				<p>평균 평점 : <span id="gradeAvg">${grade.average}</span></p>
            </div>
            <c:if test="${sessionScope.user.email == creation.creationAuthor.email}">
                <div class="btn-group" role="group">
                    <a class="btn btn-default updateCreation" type="button">수정하기</a>
                    <a class="btn btn-default deleteCreation" type="button">삭제하기</a>
                </div>
            </c:if>
        </div>
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
        <div class="row"></div>
    </div>
	
   
</body>
</html>