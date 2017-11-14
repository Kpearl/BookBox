<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
	<!-- 기본설정 -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/css/custom.css">
    <link rel="stylesheet" href="../resources/css/star.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- 기본설정 끝 -->
<style type="text/css">
	.gradeAvg{
		display: inline-block; 
		float:left;
		padding-top: 0.2%;
		padding-left: 0.5%;
	}
	.add-grade{
		display: inline-block; float:left;margin-left: 2%;border-left: 2px groove;padding-left: 0.5%;
	}


</style>
<script type="text/javascript">

	var targetNo;

$(function() {
//================펀딩보러가기 Navigation=================
	$('.go-funding').on('click',function() {
		$(self.location).attr("href","../creation/getFundingList?creationNo="+$('input[name="creationNo"]').val());
	})
//=====================메뉴 Navigation=================
	$('.menu').on('click',function() {
		history.back();
	})
});

//=====================창작글 수정하기 EVENT=================
$(function() {
	
	var writingNo = $('input[name="writingNo"]').val();
	
	$('#update-writing').on('click',function() {
		$(self.location).attr("href","../creation/updateWriting?writingNo="+writingNo+"&creationNo="+$('input[name="creationNo"]').val());
	})	

//=====================창작글 삭제하기 EVENT=================

	$('#delete-writing').on('click',function() {
		$(self.location).attr("href","../creation/deleteWriting?writingNo="+writingNo+"&creationNo="+$('input[name="creationNo"]').val());
	
	})
})

//=======================댓글 추가========================
	$(function(){
		$('div.add-reply').on('click',function(){
			fncAddReply();
		});
		
	})
	
	
	function fncAddReply() {
		targetNo = $('input[name="writingNo"]').val();
		var content = $('input.reply-content').val();
		var curDate = new Date();
		var date = curDate.getFullYear() + "-" + (curDate.getMonth() + 1) + "-" + curDate.getDate();
		var hourTime = curDate.getHours()+":"+curDate.getMinutes()+":"+curDate.getSeconds();
		var regDate=date+" "+hourTime;
		
		if(content == '') {
			alert('댓글을 입력하세요.');
		} else {		
			$.ajax ({
				url : "../creation/rest/addReply/"+targetNo,
				method : "POST",
				data : JSON.stringify({
					content : content
					}),
				headers : {
					'Accept' : 'application/json',
					'Content-Type' : 'application/json'
				},
				success:function(JSONData, status){
					
					var prependReply='';
					prependReply+='<div class="row" style="margin:auto;">';
					prependReply+='<div class="reply-user" style="display:inline-block;float:left;font-weight: bold">${sessionScope.user.nickname}</div>';	
					prependReply+='<div class="reply-regdate"style="display:inline-block;float:right;">'+regDate+'</div></div>'
					prependReply+='<div class="reply-content">'+content+'</div><hr>'
					 
					$(".reply-list").prepend(prependReply);
	              	content = "";
				} 
			});
		}		
	}



//=====================별점 이벤트=================
 $(function() {
	$(document).ready(function() {
		if ('${grade.doGrade}' == 'true' || '${user.email}' == '') {
			$('.gradeAvg-present ul li').off();
		}
	});

	$('.gradeAvg-present ul li').mouseenter(function() {
  	var idx = $(this).index() + 1;
  	var idx
  	
		$('.gradeAvg-present').removeClass().addClass('gradeAvg-present star' + idx);
	});

	$(".gradeAvg-present ul li").click(function() {
		$(this).mouseenter();
		var idx = $(this).index() + 1;
		$('.gradeAvg-present ul li').off();
		
		if ("${grade.doGrade}" == "true") {
			alert("이미 평점을 등록하셨습니다.");
		} else {
			alert(idx + "점을 등록하시겠습니까?");
			
			$.ajax({
				url: "../creation/rest/addGrade/"+$('input[name="writingNo"]').val()+"/"+idx,
				method: "GET",
				success: function() {
					alert("평점이 등록되었습니다.");
					$("#gradeAvg").replaceWith("<span id='gradeAvg'>" + (Number(idx) + '${writing.grade.average}')/ + "</span>");
				}
			});
		}
	});
});





</script>

<!-- 별점 주는 css -->
<style type="text/css">


</style>

</head>

<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>

<div class="container">
			<jsp:include page="creationToolbar.jsp"/>

   
        <div class="row" style="height:325px;margin-top: 30px;overflow:hidden;">
				<input type ="hidden" name="creationNo" value="${creation.creationNo }"/>
            <div class="col-md-5">
            	<img class="img-rounded img-responsive  img-object-fit" src="../resources/upload_files/images/${creation.creationFileName }">
            	<c:if test="${creation.doFunding}">
            		펀딩 진행 중!
            	</c:if>
            </div>
            <div class="col-md-7" style="height: 100%;">
            	<div class="row">
	            	<strong style="font-size: xx-large;padding-left:15px">${creation.creationTitle}  </strong>
	           		<span style="font-size: small;">  ${creation.creationAuthor.nickname}</span>
	          </div>
   			 <div class="row">
                	<div class="col-sm-12" style="padding-left: 10%;padding-right: 3%;">
	                	${creation.creationIntro}
	                </div>
                </div>
                
		        <div class="row">
		            <div class="col-xs-12 " style="padding-left: 10%;padding-top: 4px;bottom: 6%;position: absolute;">
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
                	
            <c:if test="${creation.doFunding}">
                <div class="go-funding btn-form" style="margin-right: 20px;"><strong>펀딩보러가기</strong></div>
            </c:if>
                
	                <c:if test="${creation.doSubscription}">
	                	<div class="subscription deleteSubscription btn-form" style="background-color:rgba(255, 20, 44, 0.21);"><i class="glyphicon glyphicon-tags"></i><strong>  구독중</strong></div>
	                    
	                </c:if>
	                <c:if test="${!creation.doSubscription}">
	                	<div class="subscription doSubscription btn-form"><strong>구독하기</strong></div>
	                </c:if>
	                <c:if test="${creation.like.doLike}">
	                    <div class="like deleteCreationLike btn-form">	
	                    	<img class="creationLike-link" src="https://icongr.am/entypo/heart.svg?size=25&color=ff0000"> <span  id="likeSum">${creation.like.totalLike}</span>
	                    </div>
	                   
	                </c:if>
	                <c:if test="${!creation.like.doLike}">
	                    <div class="like addCreationLike btn-form" >
	                    	<img class="creationLike-link" src="https://icongr.am/entypo/heart-outlined.svg?size=25&color=ff0000"> <span  id="likeSum">${creation.like.totalLike}</span>
	                    </div>
	               </c:if>
                </div>
            </div>
        </div><!--창작부분 버튼 끝  -->
   </div><!--창작 container 끝  -->
	
	<!--writing 시작  -->
	<div class="container">
		<input type ="hidden" name="writingNo" value="${writing.writingNo }">
				
		<div class="row writing-form" id="writing-form" >
			<div style="border-bottom: 2px inset;padding: 0px 50px 50px 50px;margin-top: 40px;border-top: 2px groove;background-color: rgba(221, 221, 221, 0.12);">
				<div class = "row writing-head" style="margin-top:15px;">
					<div class="writing-title" style="font-size: xx-large;">${writing.writingTitle }</div>
					<div class="row grade-part" style="padding-left: 1.5%;">
						<div  style="display: inline-block; float:left;">회차별점</div>	
						<div id="starWrap" class="gradeAvg-result star${writing.grade.average}" style="display: inline-block; float:left;padding-top: 0.2%;padding-left: 0.5%;">
								<ul style="padding-left:0;">
									<li class="s1" style="cursor:auto;"></li>
									<li class="s2" style="cursor:auto;"></li>
									<li class="s3" style="cursor:auto;"></li>
									<li class="s4" style="cursor:auto;"></li>
									<li class="s5" style="cursor:auto;"></li>
								</ul>
						</div>
						<div class="get-gradeAvg" style="display: inline-block; float:left;"><strong>(${writing.grade.average})</strong></div>
						<div class="add-grade">별점주기</div>
						<div id="starWrap" class="gradeAvg-present star${writing.grade.average}" style="display: inline-block; float:left;padding-top: 0.2%;padding-left: 0.5%;">
								<ul style="padding-left:0">
									<li class="s1"></li>
									<li class="s2"></li>
									<li class="s3"></li>
									<li class="s4"></li>
									<li class="s5"></li>
								</ul>
						</div>
						<div class="updatedate text-right" style="float:right">
							<p style="margin: auto;">${writing.updateDate }</p>
						</div>
						</div>
					<hr style="margin-top:0;">
				
				</div>
				<div class="row writing-content">
					${writing.writingContent }	
				</div>
			</div>
		</div>
	
		<c:if test="${sessionScope.user.email == creation.creationAuthor.email}">
			<div class="row"> 
				<div class="col-md-12 text-right" style="margin-top:1%">
					<div class="btn delete-writing" id="delete-writing" style="border: none;font-weight: bold;">삭제</div>
					<div class= "btn update-writing" id="update-writing" style="border: none;font-weight: bold;">수정</div>
				</div>
			</div>
		</c:if>

		
		<!-- 댓글 -->
		<div class="row reply-form" style="margin: 2% 5%;">
				<div class="row reply-head" style="margin: auto;font-size: x-large;">의견쓰기 ${writing.replyList.size() }</div>
				<div class="reply-border" style="padding: 2%;border: 1px groove; height:150px;">
					<strong>${user.nickname }</strong> 
				<c:if test="${empty sessionScope.user and empty sessionScope.user.email}">
					<input class="form-control reply-content" type="text" id="reply-content" placeholder="댓글 입력" readonly>
					<div class="btn btn-form " style="margin-top: 1%;float:right;border: none;" disabled>등록</div>
				</c:if>
				<c:if test="${!empty sessionScope.user and !empty sessionScope.user.email}"> 
					<input class="form-control reply-content" type="text" id="reply-content" placeholder="댓글 입력">
					<div class="btn btn-form add-reply" style="margin-top: 1%;float:right;border: none;">등록</div>
				</c:if>
			</div>
			
		<hr>
			<!-- <div class="row" style="margin: auto;">댓글리스트</div>
		<hr> -->
			<div class="row" id="restReply">
					<div class="row reply-list" style="margin:auto;height:150px;padding: 0% 2%;">
			
			<c:forEach items="${writing.replyList}" var="reply">
						<div class="row" style="margin:auto;">
							<div class="reply-user" style="display:inline-block;float:left;font-weight: bold">${reply.user.nickname}</div>
							<div class="reply-regdate"style="display:inline-block;float:right;">${reply.regDate }</div> 
						</div>	
						<div class="reply-content">${reply.content }</div>
						<hr>
			</c:forEach>
					
					</div>
				
						
			<!-- <div class="row reply-list" style="margin:auto;height:150px;padding: 0% 2%;">
						<div class="row" style="margin:auto;">
							<div class="reply-user" style="display:inline-block;float:left;"><strong>히정계정</strong></div>
							<div class="reply-regdate"style="display:inline-block;float:right;">2017-11-14 15:34</div> 
						</div>	
						<div class="reply-content">댓글내용내용</div>
						<hr>
						
						<div class="row" style="margin:auto;">
							<div class="reply-user" style="display:inline-block;float:left;"><strong>히정계정</strong></div>
							<div class="reply-regdate"style="display:inline-block;float:right;">2017-11-14 15:34</div> 
						</div>	
						<div class="reply-content">댓글내용내용댓글내용내용댓글내용내용댓글내용내용</div>
						<hr>
			</div> -->
		</div>
	
		
	</div>
	
	
</body>
</html>