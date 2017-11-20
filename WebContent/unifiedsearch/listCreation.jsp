<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	<script src="../resources/javascript/custom.js"></script>
	
	<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script> 
	<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>
	
<style>
body{
	padding-top:0px;
}
header{
	background:url(../resources/images/unifiedsearch_creation.jpg) no-repeat center;
}
.parallax { 
    background-attachment: fixed;
    background-size: cover;
}
strong {
	color:rgba(82, 76, 76, 0.92);
}
.creation-hr {
    border: 2px solid #a2b2b1;

}
.content-img{
    background: center center;
    width: 340px;
    box-shadow: 2px 3px 3px rgba(128, 128, 129, 0.53)
}
#tag-box{
	padding: 10px 15px 0px 15px;
	background: rgba(54, 69, 107, 0.99);
    box-shadow: 3px 3px 3px rgba(128, 128, 128, 0.53);
    width: 340px;
	color: #e0e0e0;
}
.total-box{
	padding: 15px 0px 0px 45px;
}
footer{
	margin-top: 60px;
}
#floatMenu {
	position: absolute;
	width: 200px;
	right: 8%;
	top: 600px;
	padding : 10px 20px 10px 20px;
	background-color: #a09aa2;
	color: rgb(246, 245, 247);
	transition: 0.5s;
}
</style>
<script type="text/ecmascript">
document.onreadystatechange = function () {
	if (document.readyState == "complete") { 
		var container = document.querySelector('#content-view'); 
		var msnry = new Masonry(container);
	}
} 
</script> 
<script type="text/javascript">
	ToolbarOpacHeight(500);var floatPosition = parseInt($("#floatMenu").css('top'));
	
$(function() {
	$(window).scroll(function() {
		var scrollTop = $(window).scrollTop();
		console.log(scrollTop);
		if(scrollTop > 500){
			
			var newPosition = scrollTop + 200;
	
			$("#floatMenu").css("top" , newPosition);
		}
	})

	$(".nav-creation").on("click" , function() {
		var targetNo = this.getAttribute('id');
		$(self.location).attr("href","../creation/getWritingList?creationNo=" + targetNo);
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
			<font size="5"><strong>작품   "${search.keyword}" 에 대한 검색 결과 총  ${total}건 입니다. </strong></font>
		</div>   
		
		<div class="row">	
			<hr class="creation-hr">
		</div>

		<c:if test="${total == 0}">
			<div class="row" style="padding-left:50px;">
				<p>"${keyword}"에 대한 검색 결과가 없습니다.</p>
			</div>
		</c:if>
			
		<c:forEach items="${result}" var="result">
			<div class="row">
				<div class="col-md-6">
					<div class="row" style="padding-left:10px"><font size=3>${result.title}</font></div> 
					<div class="row" style="padding-left:10px"><p><c:forEach items="${result.tag}" var="tag" varStatus="status"><span class="tag">#${tag}</span> </c:forEach></div>
				</div>
				<div class="col-md-6">
					<div class="row" style="padding-right:10px">${fn:length(result.writing)}</div>
					<div class="row" style="padding-right:10px">${result.nick_name}</div>
				</div>
			</div>
			<div class="row">
				<span>${result.writing}</span>
			</div>
		</c:forEach>
  	</div>
  	
  	<div id="floatMenu">
  		<div class="row" style="margin:10%;">
  			<strong>관련 태그</strong>
  		</div>
  	<c:if test="${fn:length(tagList) eq 0}">
  		<div class="row" style="margin:10%;">
  			관련 태그가 없습니다.
  		</div>
  	</c:if>
  		<c:forEach items="${tagList}" var="tag">
  			<div class="row" style="margin:10%;">
  				<span class="tag">#${tag}</span>
  			</div>
  		</c:forEach>
  	</div>
  	
   	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
   </body>
</html>