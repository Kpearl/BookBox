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
p#content{
	text-overflow: ellipsis;
	white-space: normal;
	word-wrap: normal;
	overflow: hidden;
	display: -webkit-box;
	-webkit-line-clamp: 3; /* 라인수 */
	-webkit-box-orient: vertical;
	word-wrap: break-word; 
	line-height: 1.2em;
	height: 3.6em;
}
body{
	padding-top:0px;
}
header{
	background:url(../resources/images/unifiedsearch.jpg) no-repeat center;
}
.parallax { 
    background-attachment: fixed;
    background-size: cover;
}

.box{ /* 
 	border: 1px solid;  
/* 	padding: 40px 20px; */ */
	font-family: "Source Sans Pro", "Helvertica Neue", Helvertica, Arial, sans-serif;
	font-size: 14px;
}
footer{
	margin-top: 70px;
}
</style>

<script type="text/javascript">
ToolbarOpacHeight(500);
setToolbarOpac(false);

$(function() {
	$nav("click" , function() {
		alert("creation");
		/* switch (category) {
		case "creation" : $(self.location).attr("href","${param.uri}creation/getWritingList?creationNo="+targetNo);
		case "posting" : $(self.location).attr("href","${param.uri}booklog/getPosting?postingNo="+targetNo);
		case "board" : $(self.location).attr("href","${param.uri}unifiedsearch/getBoard?boardNo="+targetNo);
		} */
	})
})

</script>
</head>

<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>
	<div class="container">   	
		<div class="row post-title">
			<br>
			<font size="10"><strong>검색 결과 총 ${total} 건</strong></font>
			<br>
		</div>

		<c:forEach items="${result}" var="result">
			<c:choose>
				<c:when test="${result.category == 'creation'}">
   					<div class="box" onclick="location.href='../creation/getWritingList?creationNo=${result.id}'">
           	 			<div class="row">
            		    	<div class="col-md-8">
            		        	<font size="8"><strong>${result.title}</strong></font>
            		        	${result.nick_name} <p style="color:#955940; font-weight: bold;">
           	 					<c:forEach items="${result.tag}" var="tag" varStatus="status">${tag} <c:if test="${!status.last}"> | </c:if> </c:forEach>
           	 					</p>
           						<p id="content">${result.content}</p>
           					</div>
            		    	<div class="col-xs-4 icon-feature">
            		        	<img class="img-responsive" src="../resources/upload_files/images/${result.image}" height="430" width="500" onerror="this.src='../resources/images/noimage.jpg'">
            		    	</div>
        				</div>
    				</div>
				</c:when>
			
				<c:when test="${result.category == 'board'}">
   					<div class="box" onclick="location.href='../community/getBoard?boardNo=${result.id}'">
            			<div class="row">
            		    	<div class="col-md-8">
            	    	    	<font size="8"><strong>${result.title}</strong></font>
            	        		${result.nick_name} <p style="color:#955940; font-weight: bold;">
           	 					<c:forEach items="${result.tag}" var="tag" varStatus="status">${tag} <c:if test="${!status.last}"> | </c:if> </c:forEach>
           	 					</p>
           						<p id="content">${result.content}</p>
           					</div>
            	   		 	<div class="col-xs-4 icon-feature">
            	   		     	<img class="img-responsive" src="${result.image}" height="430" width="500" onerror="this.src='../resources/images/noimage.jpg'">
            	    		</div>
        				</div>
    				</div>
				</c:when>
				
				<c:when test="${result.category == 'posting'}">
   					<div class="box" onclick="location.href='../booklog/getPosting?postingNo=${result.id}'">
           	 			<div class="row">
            		    	<div class="col-md-8">
            		        	<font size="8"><strong>${result.title}</strong></font>
            		        	${result.nick_name} <p style="color:#955940; font-weight: bold;">
           	 					<c:forEach items="${result.tag}" var="tag" varStatus="status">${tag} <c:if test="${!status.last}"> | </c:if> </c:forEach>
           	 					</p>
           						<p id="content">${result.content}</p>
           					</div>
            		    	<div class="col-xs-4 icon-feature">
            		        	<img class="img-responsive" src="../resources/upload_files/images/${result.image}" height="430" width="500" onerror="this.src='../resources/images/noimage.jpg'">
            		    	</div>
        				</div>
    				</div>
				</c:when>
			</c:choose>
        </c:forEach>
   	</div>
   	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
   </body>
</html>
