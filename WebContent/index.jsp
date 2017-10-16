<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1.0; maximum-scale=1.0; width=device-width;">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
<link rel="stylesheet" href="resources/css/style.css">
<link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="layout/toolbar.jsp" />
	<section class="blank items">
		<div class="row">
			<div class="col-md-3">
				<div class="item">
					<img alt="Image" src="resources/images/test1.jpg"/>
					<h1>Funding title</h1>
					<p>Funding content</p>
					<p>Graph</p>
					<a class="button button-buy" href="#">Funding navigation</a>
				</div>
			</div>
			<div class="col-md-3">
				<div class="item">
					<img alt="Image" src="resources/images/test2.jpg" />
					<h1>Funding title</h1>
					<p>Funding content</p>
					<p>Graph</p>
					<a class="button button-buy" href="#">Funding navigation</a>
				</div>
			</div>
			<div class="col-md-3">
				<div class="item">
					<img alt="Image" src="resources/images/test3.jpg"/>
					<h1>Funding title</h1>
					<p>Funding content</p>
					<p>Graph</p>
					<a class="button button-buy" href="#">Funding navigation</a>
				</div>
			</div>
			<div class="col-md-3">
				<div class="item">
					<img alt="Image" src="resources/images/test4.jpg"/>
					<h1>Funding title</h1>
					<p>Funding content</p>
					<p>Graph</p>
					<a class="button button-buy" href="#">Funding navigation</a>
				</div>
			</div>
		</div>
	</section>
	
	<section>
	<div class="row book">
		<div class="row">
			<div class="best col-md-2">
				<img alt="Image" src="resources/images/book1.jpg" href="#"/>
				<h3>BestSeller / Author</h3>
			</div>
	
			<div class="recommend col-md-2">
				<img alt="Image" src="resources/images/book2.jpg" href="#"/>
				<h3>Recommend / Author</h3>
			</div> 
		</div>
		
		<div class="row">
			<div class="best col-md-2">
				<img alt="Image" src="resources/images/book3.jpg" href="#"/>
				<h3>BestSeller / Author</h3>
			</div>
	
			<div class="recommend col-md-2">
				<img alt="Image" src="resources/images/book4.jpg" href="#"/>
				<h3>Recommend / Author</h3>
			</div>
		</div> 	
		
		<div class="activity" style="width:50%; float:left">
			<h1 class="item-header">Booklog</h1>

			<div class="activity-list-update">
				<img src="resources/images/test.jpg" alt="Image" width="100px" height="80px">
				<p><strong>Booklog Title</strong> Booklog Context <a href="#">user profile</a>.</p>
				<div class="clear"></div>
			</div>

			<div class="activity-list-update">
				<img src="resources/images/test.jpg" alt="Image" width="100px" height="80px">
				<p><strong>Booklog Title</strong> Booklog Context <a href="#">user profile</a>.</p>
				<div class="clear"></div>
			</div>

			<div class="activity-list-update">
				<img src="resources/images/test.jpg" alt="Image" width="100px" height="80px">
				<p><strong>Booklog Title</strong> Booklog Context <a href="#">user profile</a>.</p>
				<div class="clear"></div>
			</div>

			<a href="#" class="item-footer green">
				Booklog navigation
			</a>
			</div>
		</div>
	</section>
	
	<jsp:include page="layout/tailbar.jsp" /> 
</body>
</html>