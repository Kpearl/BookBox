<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	background:url(../resources/images/posting.jpeg) no-repeat center;
}
.parallax { 
    background-attachment: fixed;
    background-size: cover;
}
#content p{
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

.box{ /* 
 	border: 1px solid;  
/* 	padding: 40px 20px; */ */
	font-family: "Source Sans Pro", "Helvertica Neue", Helvertica, Arial, sans-serif;
	font-size: 14px;
}
hr {
    border: 3px dashed #e9d18f;
}
#content{
	border-left: 4px dashed #e9d18f;
}
#content div{
	border-left: 10px;
}
.content-img{
    background: center center;
    height: 120px;
    box-shadow: 3px 3px 3px rgba(128, 128, 128, 0.53);
	
}
#shadow-box{
	box-shadow: 0.5px 0.5px 0.5px 1px rgba(128, 128, 128, 0.53);
	margin: 30px 50px 30px 50px;
	padding: 20px 20px 20px 10px; 
	margin: 10px 10px 10px 20px;
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
		<div class="row">
			<font size="8"><strong>Posting Search</strong></font>
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
			<hr>
		</div>
		
		<div class="row">
			<div class="col-md-3">
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
						${result} 					
					</div>
				</c:forEach>
			</div>
			
			<div class="col-md-9" id="content">
				<div class="row" style="padding-left:40px;">
					<font size="5"><strong>RESULT</strong></font>
				</div>
				
				<c:if test="${total == 0}">
					<div class="row">
						<p>"${keyword}"에 대한 검색 결과가 없습니다.</p>
					</div>
				</c:if>
				
				<c:forEach items="${result}" var="result">
					<div class="row">
						<div class="row" id="shadow-box">
							<div class="col-md-3">
								<img class="content-img" src="../resources/upload_files/images/${result.image}" onerror="this.src='../resources/images/noimage.jpg'">							
							</div>
							<div class="col-md-9">
								<div class="row">
									<p><font size="4"><strong>${result.title}</strong></font>  ${result.nick_name}</p>				
								</div>
								<div class="row">
									<p><c:forEach items="${result.tag}" var="tag" varStatus="status">#${tag}  </c:forEach></p>
								</div>
								<div>
									<p>${result.content}</p>
								</div>
							</div>
						</div>
					</div>
					<%-- 
					<div class="row" style="padding-bottom:30px;">
						<div class="col-md-12" id="shadow-box">
						<div class="col-md-3">
							<div class="row">
							</div>
						</div>
					
						<div class="col-md-9">
							<div class="row">
								<p><font size="4"><strong>${result.title}</strong></font>  ${result.nick_name}</p>				
							</div>
							<div class="row">
								<p><c:forEach items="${result.tag}" var="tag" varStatus="status">#${tag}  </c:forEach></p>
							</div>
							<div>
								<p>${result.content}</p>
							</div>
						</div>
						</div>
					</div> --%>
				</c:forEach>
			</div>
		</div>
   	</div>
   </body>
</html>