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
	text-align:center;
	color:rgb(94, 86, 76);
}
header{
	background:url(../resources/images/community.jpeg) no-repeat center;
}
.parallax { 
    background-attachment: fixed;
    background-size: cover;
}
#box{ 
  	/* border: 3px solid;   */
  	height:  300px;
  	/* border-radius: 10px; */
   	margin: 7px;
  	padding: 20px 10px; 
	font-family: "Source Sans Pro", "Helvertica Neue", Helvertica, Arial, sans-serif;
	background-color: #424141;
	color: #F7FDB6;
}

#box img{
	width: 200px; 
	height: auto;
	border-radius: 7px;
	-moz-border-radius: 7px;
	-khtml-border-radius: 7px;
	-webkit-border-radius: 7px;
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
			<br>
		</div>
		<div class="row">			
			<c:forEach items="${result}" var="result">
	            <div class="col-md-4">
    	        	<div id="box" onclick="location.href='../community/getBoard?boardNo=${result.id}'">
						<img class="img-responsive" src="${result.image}" onerror="this.src='../resources/images/commu_noimage.png'" height="200" width="300" style="margin-left: auto; margin-right: auto; display: block;">
		                <font size="5"><strong>${result.title}</strong></font> ${result.nick_name} <p style="color:#A4D792; font-weight: bold;">
	                	<c:forEach items="${result.tag}" var="tag" varStatus="status">#${tag}   </c:forEach></p>
        	    	</div>
            	</div>
       		</c:forEach>
		</div>
	</div>
</body>	
</html>