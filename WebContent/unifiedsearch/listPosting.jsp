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
header{
	background:url(../resources/images/posting.jpeg) no-repeat center;
}
.parallax { 
    background-attachment: fixed;
    background-size: cover;
}
span.posting-content{
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

.box{ /* 
 	border: 1px solid;  
/* 	padding: 40px 20px; */ */
	font-family: "Source Sans Pro", "Helvertica Neue", Helvertica, Arial, sans-serif;
	font-size: 14px;
}
</style>
<script type="text/javascript">
ToolbarOpacHeight(500);
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
   			<div class="box">
            	<div class="row">
                	<div class="col-md-8">
                    	<font size="8"><strong>${result.title}</strong></font>
                    	${result.nick_name} <p style="color:#955940; font-weight: bold;">
           	 			<c:forEach items="${result.tag}" var="tag" varStatus="status">${tag} <c:if test="${!status.last}"> | </c:if> </c:forEach>
           	 			</p>
           				<p>${result.content}</p>
           			</div>
                	<div class="col-xs-4 icon-feature">
                		<c:if test="${result.category == 'board'}">
                			<img class="img-responsive" src="${result.image}" height="430" width="500" onerror="this.src='../resources/images/noimage.jpg'">
                		</c:if>
                		<c:if test="${result.category != 'board'}">
                    	<img class="img-responsive" src="../resources/upload_files/images/${result.image}" height="430" width="500" onerror="this.src='../resources/images/noimage.jpg'">
                    	</c:if>
		            </div>
        		</div>
    		</div>
        </c:forEach>
   	</div>
   </body>
</html>