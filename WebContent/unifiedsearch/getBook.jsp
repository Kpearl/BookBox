<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<!-- 기본설정 -->
	<meta charset="UTF-8">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/css/custom.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.bundle.js"></script>
    <script src="../resources/daumeditor/js/utils.js"></script>
	<!-- 기본설정 끝 -->
	
<script type="text/javascript">
//차트
    var age = ["0", "10", "20", "30", "40", "50", "60", "70"];

    var config = {
        type: 'line',
        data: {
            labels: ["0", "10", "20", "30", "40", "50", "60", "70"],
            datasets: [{
                label: "여성",
                fill: false,
                borderColor: window.chartColors.red,
                backgroundColor: window.chartColors.red,
                data: [
                	${women.age_0},
                	${women.age_10},
                	${women.age_20},
                	${women.age_30},
                	${women.age_40},
                	${women.age_50},
                	${women.age_60},
                	${women.age_70}
                ]
            }, {
                label: "남성",
                fill: false,
                borderColor: window.chartColors.blue,
                backgroundColor: window.chartColors.blue,
                data: [
                	${men.age_0},
                	${men.age_10},
                	${men.age_20},
                	${men.age_30},
                	${men.age_40},
                	${men.age_50},
                	${men.age_60},
                	${men.age_70}
                ]
            }]
        },
        options: {
            responsive: true,
            title: {
                display: true,
                text: "도서 조회 수 통계 그래프"
            },
            scales: {
                xAxes: [{
                    display: true,
                    ticks: {
                        callback: function(dataLabel, index) {
                            // Hide the label of every 2nd dataset. return null to hide the grid line too
                            return index % 2 === 0 ? dataLabel : '';
                        }
                    }
                }],
                yAxes: [{
                    display: true,
                    beginAtZero: false
                }]
            }
        }
    };

    window.onload = function() {
        var ctx = document.getElementById("canvas").getContext("2d");
        window.myLine = new Chart(ctx, config);
    };
    
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
	var total = document.getElementById('likeSum').innerHTML;
	
	$.ajax ({
		url : "../unifiedsearch/rest/addLike",
		method : "POST",
		data : {"isbn" : isbn},
		success:function(){
			$("#addLike").replaceWith("<button id='deleteLike' onclick='deleteLike(${book.isbn});'>좋아요취소</button>");
			$("#likeSum").replaceWith("<span id='likeSum'>" + (Number(total)+1) + "</span>");
		 } 
	});
	
	alert("좋아요를 등록하셨습니다.");
}

//좋아요 취소
function deleteLike(isbn) {
	var total = document.getElementById('likeSum').innerHTML;
	
	$.ajax ({
		url : "../unifiedsearch/rest/deleteLike",
		method : "POST",
		data : {"isbn" : isbn},
		success:function(){
			$("#deleteLike").replaceWith("<button id='addLike' onclick='addLike(${book.isbn});'>좋아요</button>");
		 	$("#likeSum").replaceWith("<span id='likeSum'>" + (Number(total)-1) + "</span>");
 		} 
	});
	alert("좋아요를 취소하셨습니다.");
}

//별점 이벤트
$(function() {
	$(document).ready(function() {
		if ('${book.grade.doGrade}' == 'true' || '${user.email}' == '') {
			$('#starWrap ul li').off();
		}
		
		var className=$("#starWrap").attr("class");
		className=className.split(".");
		//alert(className[0]);
		$("#starWrap").attr("class",className[0]);
		
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
		
		if ("${book.grade.doGrade}" == "true") {
			alert("이미 평점을 등록하셨습니다.");
		} else {
			alert(idx + "점을 등록하시겠습니까?");
			
			$.ajax({
				url: "../unifiedsearch/rest/addGrade",
				method: "POST",
				data: {"isbn": '${book.isbn}', "userCount": idx},
				success: function(data) {
					alert("평점이 등록되었습니다.");
					$("#gradeAvg").replaceWith("<span id='gradeAvg'>" + data + "</span>");
				}
			});
		}
	});
});

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

canvas {
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
}
</style>

</head>
<body>
	<jsp:include page="../layout/toolbar.jsp">
		<jsp:param value="../" name="uri" />
	</jsp:include>

	<section class="container">
		<table border="1">
			<tr>
				<td>
					<div id="{book.isbn}">
						<img src="${book.thumbnail}">
						<h2>${book.title}</h2>
						<c:choose>
							<c:when test="${user.email == null}">
							</c:when>
		
							<c:when test="${book.like.doLike == false}">
								<button id="addLike" onclick="addLike(${book.isbn});">좋아요</button>
							</c:when>

							<c:when test="${book.like.doLike == true}">
								<button id="deleteLike" onclick="deleteLike(${book.isbn});">좋아요
									취소</button>
							</c:when>
						</c:choose>

						<br> <br> ${book.authors} | ${book.translators}
						|${book.datetime} | ${book.publisher} | ${book.price}원 <br> <br>
						<div>사이트내 좋아요 개수 : <span  id="likeSum">${book.like.totalLike}</span></div><br> <br>
						<div>사이트내 평균 평점 : <span id="gradeAvg">${book.grade.average}</span></div>
						<br> <br>

						<!-- 별점 -->
						<div id="starWrap" class="star${book.grade.average}">
							<ul>
								<li class="s1"></li>
								<li class="s2"></li>
								<li class="s3"></li>
								<li class="s4"></li>
								<li class="s5"></li>
							</ul>
						</div>
						<br> <br> 도서 소개 : ${book.contents}<br> <br> <a
							href="${book.url}">판매 페이지로 이동</a><br> <br> <br> 
						
 						<div style="width:75%;">
        					<canvas id="canvas"></canvas>
    					</div>
						
						<br><br>
						<c:if test="${user.email != null}">	
							댓글<input type="text" id="content" placeholder="댓글 입력">
							<button onclick="addReply(${book.isbn});">댓글입력</button> <br>
						</c:if>	
						<br>
						<hr>
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