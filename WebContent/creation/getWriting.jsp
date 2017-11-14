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

//================펀딩보러가기 Navigation=================
$(function() {
	$('.go-funding').on('click',function() {
		$(self.location).attr("href","../creation/getFundingList?creationNo="+$('input[name="creationNo"]').val());
	})
})

//=====================메뉴 Navigation=================
$(function() {
	$('.menu').on('click',function() {
		history.back();
	})
})

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
function addReply(targetNo) {
	var content = document.getElementById("content").value;
	var curDate = new Date();
	var date = curDate.getFullYear() + "-" + (curDate.getMonth() + 1) + "-" + curDate.getDate();
	
	if(content == '') {
		alert('댓글을 입력하세요.');
	} else {		
		$.ajax ({
			url : "../creation/rest/addReply",
			method : "POST",
			data : {"content" : content, "targetNo" : targetNo},
			success:function(){
				$("p").prepend("${user.nickname} : " + content + " / " + date + "<br><hr>");
              document.getElementById("content").value = "";
			} 
		});
	}		
}

//=====================좋아요 추가=====================
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

//====================좋아요 취소=====================
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

//=====================별점 이벤트=================
 $(function() {
	$(document).ready(function() {
		if ('${grade.doGrade}' == 'true' || '${user.email}' == '') {
			$('.gradeAvg-present ul li').off();
		}
	});

	$('.gradeAvg-present ul li').mouseenter(function() {
  	var idx = $(this).index() + 1;
  	console.log(idx);
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
					$("#gradeAvg").replaceWith("<span id='gradeAvg'>" + (Number(idx) + '${writing.grade.average}')/2 + "</span>");
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
			<div style="padding: 0px 50px 50px 50px;margin-top: 40px;border-top: 2px groove;background-color: rgba(221, 221, 221, 0.12);">
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
						<div class="get-gradeAvg" style="display: inline-block; float:left;">(${writing.grade.average})</div>
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
			<div class="row col-md-12 text-right" style="margin-top:1%">
				<a class="btn delete-writing" id="delete-writing">삭제</a>
				<a class= "btn update-writing" id="update-writing" >수정</a>
			</div>
		</c:if>

		
		<!-- 댓글 -->
		<div>댓글 수 / 조회 수</div>
		
		<c:if test="${user.email != null}">	
			댓글  <input type="text" id="content" placeholder="댓글 입력">
			<a class="btn" onclick="addReply(${book.isbn});">댓글입력</a><br>
		</c:if>	
		
		<br>
		<hr>
		<h3>댓글리스트</h3>
		<hr>
		<p></p>
		<c:forEach items="${replyList}" var="reply">
			${reply.user.nickname} : ${reply.content} / ${reply.regDate}<br>
			<hr>
		</c:forEach>
		
		<br>
		
	</div>
	
	
</body>
</html>