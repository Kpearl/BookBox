<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<!-- 기본설정 -->
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/css/custom.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- 기본설정 끝 -->
	<link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
	<link rel="stylesheet" href="../resources/css/star.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.bundle.js"></script>
    <script src="../resources/daumeditor/js/utils.js"></script>
	
<style type="text/css">
body{
	padding-top:0px;
}
header{
	background:url(../resources/images/getBook.jpg) no-repeat center;
}
.parallax { 
    background-attachment: fixed;
    background-size: cover;
}

canvas {
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
}
</style>

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
				$("#restReply").prepend("<div class='col-xs-10 col-xs-offset-0 col-xs-pull-0'><div class='col-xs-1 col-xs-offset-1'><p><strong>${user.nickname}</strong></p></div><div class='col-xs-7'> : "+content+"</div><div class='col-xs-2 col-xs-offset-0'><span class='text-muted'>"+date+"</span></div></div>");
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
			$("#addLike").replaceWith("<span class='btn-primary success btn-lg' disabled='disabled' id='deleteLike' onclick='deleteLike(${book.isbn});'>Like Cancel</span>");
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
			$("#deleteLike").replaceWith("<span class='btn-primary success btn-lg' disabled='disabled' id='addLike' onclick='addLike(${book.isbn});'>Like</span>");
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
</head>

<body>
	<jsp:include page="../layout/toolbar.jsp">
		<jsp:param value="../" name="uri" />
	</jsp:include>
	<header class="parallax"></header>
	
	<div class="container">
		<div class="row" id="{book.isbn}">
            <div class="col-lg-10 col-md-offset-1 post-title">
                <h1>${book.title}</h1>
                <p class="author"><strong>
                	<c:forEach items="${book.authors}" var="str" varStatus="status">
		   				${str} | </c:forEach>
   					<c:forEach items="${book.translators}" var="str" varStatus="status">
               	 		${str} |
   					</c:forEach> ${book.publisher} | ${book.price}원</strong> 
                	<span class="text-muted">${book.datetime}</span>
                </p>
            </div>
            <div class="col-lg-2 col-lg-offset-1 col-md-3 col-md-offset-1col-xs-12">
           		<c:choose>
					<c:when test="${book.thumbnail == ''}">
     		   			<img class="img-thumbnail" src="http://t1.daumcdn.net/book/KOR${book.isbn}" height="240px" width="170px" onerror="this.src='../resources/images/noimage.jpg'">  					
					</c:when>
					<c:otherwise>
 						<td rowspan="3">
	  						<img class="img-thumbnail" src="http://t1.daumcdn.net/book/KOR${book.isbn}" height="240px" width="170px" onerror="this.src='${book.thumbnail}'">
						</td>
					</c:otherwise>
				</c:choose>
           	 	<div id="starWrap" class="star${book.grade.average}">
					<ul>
						<li class="s1"></li>
						<li class="s2"></li>
						<li class="s3"></li>
						<li class="s4"></li>
						<li class="s5"></li>
					</ul>
				</div>
                <p class="lead author"><strong> </strong> </p>
            </div>
            
            <div class="col-lg-7 col-lg-offset-0 col-lg-push-1 col-lg-pull-0 col-md-7 col-md-offset-0 col-md-push-0 post-body">
                <p>사이트내 좋아요 수 : <span id="likeSum">${book.like.totalLike}</span></p>
                <p>사이트내 평균 평점 : <span id="avgGrade">${book.grade.average}</span></p>
                <p>도서 소개 : ${book.contents}</p>
                <p><a href="${book.url}">판매 페이지로 이동</a></p>
                
                <c:choose>
					<c:when test="${user.email == null}">
					</c:when>
					<c:when test="${book.like.doLike == false}">
						<span class="btn-primary success btn-lg" disabled="disabled" id="addLike" onclick="addLike(${book.isbn});">Like</span>
					</c:when>
					<c:when test="${book.like.doLike == true}">
						<span class="btn-primary success btn-lg" disabled="disabled" id="deleteLike" onclick="deleteLike(${book.isbn});">Like Cancel</span>
					</c:when>
				</c:choose>
            </div>
                  
            <div>
                <div class="row">
                    <div class="col-xs-10 col-xs-offset-1 col-xs-pull-0">            
                        <div style="width:75%;">
                        <canvas id="canvas"></canvas>
 						</div>
					</div>
                </div>
            </div>
				
            <div>
				<div class="row">
					<div class="col-xs-10 col-xs-offset-1 col-xs-pull-0">
                    	<h3>댓글 리스트</h3>                    
	                    <c:if test="${user.email ne null}">	
	                    	<div class="col-xs-1 col-xs-offset-1">
    	                   		<p><strong>댓글</strong> </p>
        	            	</div>
                    		<div class="col-xs-7">
    	                   		<input type="text" id="content" placeholder="댓글 입력">
								<span  class="btn-primary success btn-sm" disabled="disabled" onclick="addReply(${book.isbn});">Send</span><br>
            	       		</div>
						</c:if>
					</div>
				</div>
                 
            	<div id="restReply" class="row"></div>
            	
            	<c:forEach items="${book.replyList}" var="reply">
            		<div class="row">
            			<div class="col-xs-10 col-xs-offset-0 col-xs-pull-0">
            	   	 		<div class="col-xs-2 col-xs-offset-1">
								<p><strong>${reply.user.nickname}</strong> </p>
							</div>
            	   	 		<div class ="col-xs-6">
					 			: ${reply.content}
							</div>
            	    		<div class="col-xs-2 col-xs-offset-0">
            	    			<span class="text-muted">${reply.regDate} </span>
            	    		</div>
						</div>	
           	 		</div>
            	</c:forEach>
        	</div>
        </div>
	
		<div  class="row">
			<br>
			<br>
		</div>
	</div>
</body>
</html>