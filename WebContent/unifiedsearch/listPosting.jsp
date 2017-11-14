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
	<script src="../resources/javascript/toolbar_opac.js"></script>

<style>
body{
	padding-top:0px;
}
font{
	padding-top:10px;
	padding-bottom:5px;
}
strong {
	color:rgba(82, 76, 76, 0.92);
}
header{
	background:url(../resources/images/unifiedsearch_posting.jpeg) no-repeat center;
}
.parallax { 
    background-attachment: fixed;
    background-size: cover;
}
.content-line{
	text-overflow: ellipsis;
	white-space: normal;
	word-wrap: normal;
	overflow: hidden;
	display: -webkit-box;
	-webkit-line-clamp: 3; /* 라인수 */
	-webkit-box-orient: vertical;
	word-wrap: break-word; 
	line-height: 1.2em;
}
.posting-hr {
    border: 2px solid #92746b;
}
#content{
	border-left: 4px dashed #c59e7d;
}
#content div{
	border-left: 10px;
}
.content-img{
    background: center center;
    height: 145px;
    box-shadow: 3px 3px 3px rgba(128, 128, 128, 0.53);
}
#shadow-box{
	box-shadow: 0.5px 0.5px 0.5px 1px rgba(128, 128, 128, 0.53);
	padding: 25px 20px 25px 10px; 
	margin: 20px 50px 30px 50px;
}
footer{
	margin-top: 60px;
}
</style>
<script type="text/javascript">
	ToolbarOpacHeight(500);
	
	$(function() {
		$(".nav-tag").on("click" , function() {
			var keyword = this.innerText.replace("#", "");
			$(self.location).attr("href","../unifiedsearch/getUnifiedsearchList?category=11&keyword="+keyword);
		});
		$(".nav-posting").on("click" , function() {
			var targetNo = this.getAttribute('id');
			$(self.location).attr("href","../booklog/getPosting?postingNo=" + targetNo);
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
	<div class="row" style="margin-top:50px">
			<font size="5"><strong>포스팅   "${keyword}" 에 대한 검색 결과 총  ${total}건 입니다. </strong></font>
		</div>  
		 
		<div class="row">	
			<hr class="posting-hr">
		</div>
				
		<c:if test="${total == 0}">
			<div class="row" style="padding-left:50px;">
				<p>"${keyword}"에 대한 검색 결과가 없습니다.</p>
			</div>
		</c:if>
		<c:forEach items="${result}" var="result">
			<div class="row nav-posting" id="${result.id}">
				<div class="row" id="shadow-box">
					<div class="col-md-3">
						<img class="content-img" src="../resources/upload_files/images/${result.image}" onerror="this.src='../resources/images/noimage.png'">							
					</div>
					<div class="col-md-9" style="padding-left:35px; padding-top:5px;">
						<div class="row">
							<p><font size="4"><strong>${result.title}</strong></font>  ${result.nick_name}</p>				
						</div>
						<div class="row">
							<p><c:forEach items="${result.tag}" var="tag" varStatus="status"><span class="tag">#${tag}</span> </c:forEach></p>
						</div>
						<div>
							<p class="content-line">${result.content}</p>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
   </body>
</html>