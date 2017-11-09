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
	background:url(../resources/images/creation.jpeg) no-repeat center;
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
</script>
</head>

<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>

	<div class="container">
		<div class="row" style="margin-top:50px">
			<font size="8" style=""><strong>Board Search</strong></font>
		</div>
		<div class="row">
			<div class="col-md-7">
				<p><font size="4">KEYWORD  "${keyword}"</font></p>
			</div>
			<div class="col-md-5">
				<p><font size="4">TOTAL  ${total}</font></p>
			</div>
		</div>   
		<div class="row">	
			<hr class="community-hr">
		</div>
	</div>
		
<%-- 		<div class="row" style="margin-bottom:90px">
			<div class="col-md-3" style="padding-left:30px;">
				<div class="row">
					<font size="5"><strong>RELATION TAG</strong></font>
				</div>
				
				<c:if test="${fn:length(tagList) == 0}">
					<div class="row">
						<p>관련 태그가 없습니다.</p>
					</div>
				</c:if>
				
 				<c:forEach items="${tagList}" var="result">
					<div class="row">
						#${result} 					
					</div>
				</c:forEach>
			</div>
			
			<div class="col-md-9" id="content">
				<div class="row" style="padding-left:50px;">
					<font size="5"><strong>RESULT</strong></font>
				</div>
				
				<c:if test="${total == 0}">
					<div class="row" style="padding-left:50px;">
						<p>"${keyword}"에 대한 검색 결과가 없습니다.</p>
					</div>
				</c:if>

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
   	</div> --%>
   	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
   </body>
</html>