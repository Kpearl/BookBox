<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

	<style>
		.div-booklog{
			padding: 5px;
		}
	</style>
	
	<script type="text/javascript">
		var isListLoading = false;
		var condition, keyword, currentPage;
		
		$(function(){
			condition = $('input[name="condition"]').val();
			keyword = $('input[name="keyword"]').val();
			currentPage = 1;

			fncTransformDiv();
			fncBooklogEventOn();
			if( $(window).height() >= $(document).height() ){
				if(!isListLoading){
					fncGetBooklogList();
				}
			}
		});
		
		
		$(window).resize(function(){
			fncTransformDiv();
		})
		
		$(window).scroll(function(){
			if($(window).scrollTop() >= $(document).height() - $(window).height() - 40){
				if(!isListLoading){
					fncGetBooklogList();
				}
			}
		});
		
		function fncTransformDiv(){
			if($(window).width() > 1200){
				$('.div-block:nth-child(4n-3)').css('transform', 'translate(0, 0)');
				$('.div-block:nth-child(4n-2)').css('transform', 'translate(0, 20px)');
				$('.div-block:nth-child(4n-1)').css('transform', 'translate(0, 40px)');
				$('.div-block:nth-child(4n)').css('transform', 'translate(0, 60px)');
			} else if($(window).width() > 992){
				$('.div-block:nth-child(3n-2)').css('transform', 'translate(0, 0)');
				$('.div-block:nth-child(3n-1)').css('transform', 'translate(0, 20px)');
				$('.div-block:nth-child(3n)').css('transform', 'translate(0, 40px)');
			} else if($(window).width() > 768){
				$('.div-block:nth-child(2n-1)').css('transform', 'translate(0, 0)');
				$('.div-block:nth-child(2n)').css('transform', 'translate(0, 20px)');
			} else{
				$('.div-block').css('transform', 'translate(0, 0)');
			}

		}
		
		function fncGetBooklogList(){
			$('.img-loading').show();
			isListLoading = true;
			currentPage = currentPage + 1;
			$.ajax({
				url: 'rest/getBooklogList/'+currentPage,
				method: 'post',
				data: JSON.stringify({
					condition : condition,
					keyword : keyword
				}),
				headers : {
					'Accept' : 'application/json',
					'Content-Type' : 'application/json'
				},
				dataType: 'json',
				success: function(data){
					if(data.booklogList.length == 0){
						$('.img-loading').hide();
						return;
					}
					for(var i=0; i<data.booklogList.length; i++){
						var divHtml = '<div class="col-sm-6 col-md-4 col-lg-3 div-block"><div class="row booklog-profile div-booklog">';
						divHtml += '<input type="hidden" name="booklogNo" value="' + data.booklogList[i].booklogNo + '">';
						divHtml += '<input type="hidden" name="booklogUser" value="' + data.booklogList[i].user.email + '">';
						divHtml += '<div class="col-sm-12"><div class="row text-center booklog-img"><div class="col-xs-offset-1 col-xs-10 booklog-img">';
						divHtml += '<img class="img-responsive img-circle center-block img-object-fit" src="../resources/upload_files/images/' + data.booklogList[i].booklogImage + '">';
						divHtml += '</div></div><div class="row text-center booklog-name">';
						divHtml += '<p><em>' + data.booklogList[i].booklogName + '</em></p></div>';
						divHtml += '<div class="row text-center booklog-intro booklog-background">';
						divHtml += '<p>' + data.booklogList[i].booklogIntro + '</p></div><div class="row text-center booklog-content-num"><div class="col-xs-4 text-center">';
						divHtml += '<span class="content-icon"><i class="glyphicon glyphicon-pencil"></i></span><br/><span class="content-count"><img class="loading-img" src="../resources/images/loading.gif" style="height: 25px;"></span></div>';
						divHtml += '<div class="vertical-line"></div><div class="col-xs-4 text-center"><span class="content-icon"><i class="glyphicon glyphicon-grain"></i></span><br/><span class="content-count"><img class="loading-img" src="../resources/images/loading.gif" style="height: 25px;"></span>';
						divHtml += '</div><div class="vertical-line"></div><div class="col-xs-4 text-center"><span class="content-icon"><i class="glyphicon glyphicon-bookmark"></i></span><br/><span class="content-count"><img class="loading-img" src="../resources/images/loading.gif" style="height: 25px;"></span>';
						divHtml += '</div></div></div></div></div>';
						$('.booklog-list').append(divHtml);
					}
					fncTransformDiv();
					fncFooterPositioning();
					fncBooklogEventOn();
					isListLoading = false;
					$('.img-loading').hide();
				}
			});
			
		}
		function fncBooklogEventOn(){
			$('div.div-booklog').off('click').on('click', function(){
				var booklogNo = $(this).find('input[type="hidden"]').val();
				$(self.location).attr("href","../booklog/getBooklog?booklogNo="+booklogNo);
			});

			for(var i=0; i<$('.div-booklog').length; i++){
				var booklogUser = $($('.div-booklog')[i]).find('input[name="booklogUser"]').val();
				$.ajax({
					url: 'rest/getCounts/'+booklogUser.split('@')[0]+'/'+booklogUser.split('.')[0].split('@')[1]+'/'+booklogUser.split('.')[1]+'/'+i,
					method: 'get',
					dataType: 'json',
					success: function(data){
						$($($('.div-booklog')[data.index]).find('.content-count')[0]).html(data.counts.cc>999? '999+':data.counts.wc).find('.loading-img').hide();
						$($($('.div-booklog')[data.index]).find('.content-count')[1]).html(data.counts.pc>999? '999+':data.counts.pc).find('.loading-img').hide();
						$($($('.div-booklog')[data.index]).find('.content-count')[2]).html(data.counts.bc>999? '999+':data.counts.bc).find('.loading-img').hide();
						$($('.div-booklog')[data.index]).find('i.glyphicon-bookmark').removeClass('bookmarked nobookmarked').addClass(data.bookmark == 'true'? 'bookmarked':'nobookmarked');
					}
				});
			}
		}
	</script>
	
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>

	<div class="container">
		<input type="hidden" name="condition" value="${search.condition}">
		<input type="hidden" name="keyword" value="${search.keyword}">
		<div class="row booklog-list">
			<c:forEach items="${booklogList}" var="booklog">
			<c:set var="text" value="${booklog.booklogIntro }"/>
			<div class="col-sm-6 col-md-4 col-lg-3 div-block">
				<div class="row booklog-profile div-booklog">
					<input type="hidden" name="booklogNo" value="${booklog.booklogNo}">
					<input type="hidden" name="booklogUser" value="${booklog.user.email}">
					<div class="col-sm-12">
						<div class="row text-center booklog-img">
							<div class="col-xs-offset-1 col-xs-10 booklog-img">
								<img class="img-responsive img-circle center-block img-object-fit" src="../resources/upload_files/images/${booklog.booklogImage}">
							</div>
						</div>
				
						<!-- 북로그이미지, 소개글, 이름 -->
						<div class="row text-center booklog-name">
							<p><em>${booklog.booklogName}</em></p>
						</div>
						<div class="row text-center booklog-intro booklog-background">
							<p>${booklog.booklogIntro}</p>
						</div>
						<div class="row text-center booklog-content-num">
							<div class="col-xs-4 text-center">
								<span class="content-icon"><i class="glyphicon glyphicon-pencil"></i></span><br/>
								<span class="content-count"><img class="loading-img" src="../resources/images/loading.gif" style="height: 25px;"></span>
							</div>
							<div class="vertical-line"></div>
							<div class="col-xs-4 text-center">
								<span class="content-icon"><i class="glyphicon glyphicon-grain"></i></span><br/>
								<span class="content-count"><img class="loading-img" src="../resources/images/loading.gif" style="height: 25px;"></span>
							</div>
							<div class="vertical-line"></div>
							<div class="col-xs-4 text-center">
								<span class="content-icon"><i class="glyphicon glyphicon-bookmark"></i></span><br/>
								<span class="content-count"><img class="loading-img" src="../resources/images/loading.gif" style="height: 25px;"></span>
							</div>
						</div>
					</div>
				</div>
			</div>
			</c:forEach>
		</div>
		<img class="img-loading" src="../resources/images/loading.gif" style="display: none;">
	</div>
	
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
	
</body>
</html>