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
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- 기본설정 끝 -->

<script type="text/javascript">

//=====================창작글 수정하기 EVENT=================
$(function() {
	$('#update-writing').on('click',function() {
		$(self.location).attr("href","../creation/updateWriting?writingNo="+$('input[name="writingNo"]').val()+"&creationNo="+$('input[name="creationNo"]').val());
	})	
})

//=====================창작글 삭제하기 EVENT=================
$(function() {
	$('#delete-writing').on('click',function() {
		$(self.location).attr("href","../creation/deleteWriting?writingNo="+$('input[name="writingNo"]').val());
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
/* $(function() {
	$(document).ready(function() {
		if ('${grade.doGrade}' == 'true' || '${user.email}' == '') {
			$('#starWrap ul li').off();
		}
	});

	$('#starWrap ul li').mouseenter(function() {
  	var idx = $(this).index() + 1;
		$('#starWrap').removeClass();
		$('#starWrap').addClass('star' + idx);
	});

	$("#starWrap ul li").click(function() {
		$(this).mouseenter();
		var idx = $(this).index() + 1;
		$('#starWrap ul li').off();
		
		if ("${grade.doGrade}" == "true") {
			alert("이미 평점을 등록하셨습니다.");
		} else {
			alert(idx + "점을 등록하시겠습니까?");
			
			$.ajax({
				url: "../creation/rest/addGrade",
				method: "POST",
				data: {"targetNo": '${targetNo}', "userCount": idx},
				success: function() {
					alert("평점이 등록되었습니다.");
					$("#gradeAvg").replaceWith("<span id='gradeAvg'>" + (Number(idx) + ${grade.average})/2 + "</span>");
				}
			});
		}
	});
});
 */


</script>

<!-- 별점 주는 css -->
<style type="text/css">

/* 마우스오버 */
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

/* 마우스클릭 */
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

</head>

<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>

	<!-- 말머리 -->
	<div class="container">
	<h2>${creation.creationHead }</h2>
	<br>
	
	<div class="row">
			<div>
				펀딩진행중 여부
			</div>
			<div class="col-md-4">
				<input type ="hidden" name="creationNo" value="${creation.creationNo }"/>
	    		<img src="../resources/upload_files/images/${creation.creationFileName }" width="320px" height="200px">
	  		</div>
			<div class="col-md-6">
				  <h4>작품명 : ${creation.creationTitle }</h4> 
				  <p>작성자 : ${creation.creationAuthor.nickname }</p> 
				  <p>태그리스트 : 
				  <c:forEach var="tag" items="${creation.tagList}">	  
				  	<span>#${tag.tagName }</span>	
				  </c:forEach>
				  </p>
				  <p>작품 소개글 : ${creation.creationIntro }</p>
  			</div>
	</div>
		
		<div>사이트내 좋아요 개수 : <span  id="likeSum">${like.totalLike}</span></div><br>
		<div>사이트내 평균 평점 : <span id="gradeAvg">${grade.average}</span></div><br>

		<!-- 별점 -->
		<div id="starWrap" class="star${grade.average}">
			<ul>
				<li class="s1"></li>
				<li class="s2"></li>
				<li class="s3"></li>
				<li class="s4"></li>
				<li class="s5"></li>
			</ul>
		</div>
		<br>
		<br>
	
		<div>
			<button>펀딩보러가기</button>
			<c:choose>
				<c:when test="${!empty user.email}">
			<button>구독</button>
				</c:when>
		
				<c:when test="${like.doLike == false}">
					<a class="btn" id="addLike" onclick="addLike(${targetNo});">좋아요</a>
				</c:when>

				<c:when test="${like.doLike == true}">
					<a class="btn" id="deleteLike" onclick="deleteLike(${targetNo});">좋아요 취소</a>
				</c:when>
			</c:choose>
		</div>
	
	<section class="contatiner">
		<div>
			<button>이전글</button>
			<button>다음글</button>
			<button>목록</button>
		</div>
		
		<br>
		<form name="writingForm">
			<div class = "row">
					<input type ="hidden" name="writingNo" value="${writing.writingNo }">
					<h5>창작글 제목 : ${writing.writingTitle }</h5>
				<div class="col-md-12 text-right">
					<p>창작글 등록일 :${writing.regDate }</p>
					<p>창작글 수정일 :${writing.updateDate }</p>
				</div>
			</div>
			<div class="panel panel-defalt">
				<div>
				${writing.writingContent }	
				</div>
			</div>
		</form>
		
		
		<br>
		<br>
		

		<a class="btn">펀딩보러가기</a>
		<br><br>
		<div class="row col-md-12 text-right">
			<a class="btn delete-writing" id="delete-writing">삭제</a>
			<a class= "btn update-writing" id="update-writing" >수정</a>
		</div>
		<br><br>
		
		<!-- 댓글 -->
		댓글 수 / 조회 수<br><br>
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
		<button>창작글쓰기</button>
	</section>
	</div>
</body>
</html>