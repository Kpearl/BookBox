<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1.0, maximum-scale=1.0, width=device-width">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../resources/css/style.css">
<link
	href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css"
	rel="stylesheet">

<script type="text/javascript"> 

//댓글 추가
function addReply(isbn) {
	var content = document.getElementById("content").value;
	var curDate = new Date();
	var date = curDate.getFullYear() + "-" + (curDate.getMonth() + 1) + "-" + curDate.getDate();
	
	if(content == '') {
		alert('댓글을 입력하세요.');
	} else {		
		$.ajax ({
			url : "../unifiedsearch/rest/addReply",
			method : "POST",
			data : {"content" : content, "isbn" : isbn},
			success:function(){
				$("p").prepend("${user.nickname} : " + content + " / " + date + "<br><hr>");
                document.getElementById("content").value = "";
			} 
		});
	}		
}


//좋아요 추가
function addLike(isbn) {
	$.ajax ({
		url : "../unifiedsearch/rest/addLike",
		method : "POST",
		data : {"isbn" : isbn},
		success:function(){
			$("#addLike").replaceWith("<button id='deleteLike' onclick='deleteLike(${book.isbn});'>좋아요취소</button>");	
		} 
	});		
}

//좋아요 취소
function deleteLike(isbn) {
	$.ajax ({
		url : "../unifiedsearch/rest/deleteLike",
		method : "POST",
		data : {"isbn" : isbn},
		success:function(){
			$("#deleteLike").replaceWith("<button id='addLike' onclick='addLike(${book.isbn});'>좋아요</button>");
		} 
	});		
}

$(function(){
	 
/* 	//마우스 오버
	$('#starWrap').mouseenter(function(){
		var idx = $(this).index() + 1;
		$('#starWrapClick').removeClass();
		$('#starWrapClick').addClass('star'+idx);	
	})  */

	//클릭
	$('#starWrapClick ul li').click(function(){
		var idx = $(this).index() + 1;
		$('#starWrapClick').removeClass();
		$('#starWrapClick').addClass('star'+idx);
		
		if(${book.grade.doGrade} == true) {
			alert("이미 평점을 등록하셨습니다.");
		} else {
		alert(idx + "점을 등록하시겠습니까?");
			
	 	$.ajax ({
			url : "../unifiedsearch/rest/addGrade",
			method : "POST",
			data : {"isbn" : ${book.isbn}, "userCount" : idx},
			success:function(){
				var avg = (idx + ${book.grade.average}) / 2;
				$('#starWrap').removeClass();
				$('#starWrap').addClass('star' + avg);
				$('#starWrapClick ul li').on("click",function(){
					alert("이미 평점을 등록하셨습니다.");
				});
			}
		});	 	
		}
	});
});
</script>

<!-- 별점 주는 css -->
<style type="text/css">
/* 마우스오버 */
#starWrap {}
#starWrap ul:after {content:''; display:block; clear:both;}
#starWrap ul li {width:16px; height:15px; float:left; background:url('../resources/images/bgStarSolo.png') no-repeat; cursor:pointer;}
#starWrap.star1 .s1 {background-position:0 -15px;}
#starWrap.star2 .s1,#starWrap.star2 .s2 {background-position:0 -15px;}
#starWrap.star3 .s1,#starWrap.star3 .s2,#starWrap.star3 .s3 {background-position:0 -15px;}
#starWrap.star4 .s1,#starWrap.star4 .s2,#starWrap.star4 .s3,#starWrap.star4 .s4 {background-position:0 -15px;}
#starWrap.star5 .s1,#starWrap.star5 .s2,#starWrap.star5 .s3,#starWrap.star5 .s4,#starWrap.star5 .s5 {background-position:0 -15px;}

/* 마우스클릭 */
#starWrapClick ul:after {content:''; display:block; clear:both;}
#starWrapClick ul li {width:16px; height:15px; float:left; background:url('../resources/images/bgStarSolo.png') no-repeat; cursor:pointer;}
#starWrapClick.star1 .s1 {background-position:0 -15px;}
#starWrapClick.star2 .s1,#starWrapClick.star2 .s2 {background-position:0 -15px;}
#starWrapClick.star3 .s1,#starWrapClick.star3 .s2,#starWrapClick.star3 .s3 {background-position:0 -15px;}
#starWrapClick.star4 .s1,#starWrapClick.star4 .s2,#starWrapClick.star4 .s3,#starWrapClick.star4 .s4 {background-position:0 -15px;}
#starWrapClick.star5 .s1,#starWrapClick.star5 .s2,#starWrapClick.star5 .s3,#starWrapClick.star5 .s4,#starWrapClick.star5 .s5 {background-position:0 -15px;}
</style>

</head>
<body>
	<jsp:include page="../layout/toolbar.jsp">
		<jsp:param value="../" name="uri" />
	</jsp:include>
	
	<section class="blank items">
		<table border="1">
			<tr>
				<td>
					<div id="{book.isbn}">
						<img src="${book.thumbnail}">
						<h2>${book.title}</h2>
						
						<c:choose>
							<c:when test="${book.like.doLike == false}">
							<button id="addLike" onclick="addLike(${book.isbn});">좋아요</button>					
							</c:when>
							
							<c:when test="${book.like.doLike == true}">
							<button id="deleteLike" onclick="deleteLike(${book.isbn});">좋아요 취소</button>
							</c:when>
							<c:otherwise>
								비회원
							</c:otherwise>
							</c:choose>
							
							<br> <br> ${book.authors} | ${book.translators}
							|${book.datetime} | ${book.publisher} | ${book.price}원 <br> <br>
							사이트내 좋아요 개수 : ${book.like.totalLike}<br> <br> 
							<div>사이트내 평균 평점 : ${book.grade.average}</div><br> 
							<br>
				
							<!-- 별점 -->
							<div class="testStar">
							<div id="starWrapClick" class="star${book.grade.average}">
							<ul>
							<li class="s1"></li>
							<li class="s2"></li>
							<li class="s3"></li>
							<li class="s4"></li>
							<li class="s5"></li>
							</ul>
							</div>
						</div>	 
						<br>
						<br> 도서 소개 :
						${book.contents}<br> <br> <a href="${book.url}">판매
							페이지로 이동</a><br> <br> <br> 
						
							댓글 <input type="text" id="content" placeholder="댓글 입력">
							<button onclick="addReply(${book.isbn});">댓글입력</button>
						<br> <br>
						<h3>댓글리스트</h3>
						<hr>
						<p></p>
						<c:forEach items="${book.replyList}" var="reply">
							 ${reply.user.nickname} : ${reply.content} / ${reply.regDate}<br>
							<hr>
						</c:forEach>
					</div>
				</td>
			</tr>
		</table>
	</section>

</body>
</html>