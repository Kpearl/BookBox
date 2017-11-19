<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<!-- 기본설정 -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/css/custom.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- 기본설정 끝 -->
	<script src="../resources/javascript/toolbar_opac.js"></script>
	<script src="../resources/javascript/custom.js"></script>

<script type="text/javascript">
	var condition;
	ToolbarOpacHeight(500);
</script>
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>
	<!-- 무한 스크롤 -->
	<section>
		<div class="activity" style="width:100%; float:left">
			<h1 class="item-header">User Info List</h1>

			<div class="activity-list-update">
				<p><strong>number</strong> email nickname birthday</p>
				<div class="clear"></div>
			</div>

			<div class="activity-list-update">
				<p><strong>number</strong> email nickname birthday</p>
				<div class="clear"></div>
			</div>

			<div class="activity-list-update">
				<p><strong>number</strong> email nickname birthday</p>
				<div class="clear"></div>
			</div>
			
			<div class="activity-list-update">
				<p><strong>number</strong> email nickname birthday</p>
				<div class="clear"></div>
			</div>
			
			<div class="activity-list-update">
				<p><strong>number</strong> email nickname birthday</p>
				<div class="clear"></div>
			</div>
			
			<div class="activity-list-update">
				<p><strong>number</strong> email nickname birthday</p>
				<div class="clear"></div>
			</div>
			
			<div class="activity-list-update">
				<p><strong>number</strong> email nickname birthday</p>
				<div class="clear"></div>
			</div>
			
			<div class="activity-list-update">
				<p><strong>number</strong> email nickname birthday</p>
				<div class="clear"></div>
			</div>
		</div>
	</section> 
</body>
</html>