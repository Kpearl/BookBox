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
	
	<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script> 
	<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>
	
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
	background:url(../resources/images/unifiedsearch_search.jpg) no-repeat center;
}
.parallax { 
    background-attachment: fixed;
    background-size: cover;
}

.book{
	margin: 30px 10px 20px 20px;
}
footer{
	margin-top: 60px;
}
.search-hr {
    border: 2px solid #6e6571;
}
.creation-content-img{
    background: center center;
    width: 340px;
    box-shadow: 2px 3px 3px rgba(128, 128, 129, 0.53)
}
#creation-tag-box{
	padding: 10px 15px 0px 15px;
	background: rgba(54, 69, 107, 0.99);
    box-shadow: 3px 3px 3px rgba(128, 128, 128, 0.53);
    width: 340px;
	color: #e0e0e0;
}
.creation-total-box{
	padding: 15px 0px 0px 45px;
}
#board-title-box{
	padding: 10px 5px 10px 10px; 
	height: 100px;
	background: #74B49B;
}
#board-tag-box{
	padding: 10px 15px 10px 15px;
	height: 100px;
	background: #D3F6D1;
}
.board-total-box{
	padding: 10px 35px 30px 35px;
	height: 240px; 
}
.board-content-img{
    background: center center;
    width: 70px;
    height: 70px;
    object-fit:cover;
    border-radius: 50%;
    box-shadow: 3px 3px 3px rgba(128, 128, 128, 0.53);
}
#posting-content{
	border-left: 4px dashed #c59e7d;
}
#posting-content div{
	border-left: 10px;
}
.posting-content-img{
    background: center center;
    height: 145px;
    box-shadow: 3px 3px 3px rgba(128, 128, 128, 0.53);
}
#posting-shadow-box{
	box-shadow: 0.5px 0.5px 0.5px 1px rgba(128, 128, 128, 0.53);
	padding: 25px 20px 25px 10px; 
	margin: 20px 50px 30px 50px;
}
.posting-content-line{
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
</style>

<script type="text/javascript">
ToolbarOpacHeight(500);

$(function() {
	$(".nav-tag").on("click" , function() {
		var keyword = this.innerText.replace("#", "");
		$(self.location).attr("href","../unifiedsearch/getUnifiedsearchList?category=11&keyword="+keyword);
	});
	$(".nav-creation").on("click" , function() {
		var targetNo = this.getAttribute('id');
		$(self.location).attr("href","../creation/getWritingList?creationNo=" + targetNo);
	}); 
	$(".nav-posting").on("click" , function() {
		var targetNo = this.getAttribute('id');
		$(self.location).attr("href","../booklog/getPosting?postingNo=" + targetNo);
	}); 
	$(".nav-community").on("click" , function() {
		var targetNo = this.getAttribute('id');
		$(self.location).attr("href","../community/getBoard?boardNo=" + targetNo);
	});
});
	
function getBook(isbn) {
	$(self.location).attr("href","../unifiedsearch/getBook?isbn="+isbn);
}
</script>

<script type="text/ecmascript">
document.onreadystatechange = function () {
	if (document.readyState == "complete") { 
		var container = document.querySelector('#content-view'); 
		var msnry = new Masonry(container);
	}
} 
</script> 

<body>
<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>

	<div class="container">
		<div class="row" style="margin-top:50px">
			<font size="5"><strong>통합검색   "${keyword}" 에 대한 검색 결과 총  ${result.total + fn:length(bookList)}건 입니다. </strong></font>
		</div>  
		 
		<div class="row">	
			<hr class="search-hr">
		</div>
		 		
		<c:if test="${result.total + fn:length(bookList) eq 0}">
			<div class="row" style="padding-left:50px;">
				<p>"${keyword}"에 대한 검색 결과가 없습니다.</p>
			</div>
		</c:if> 
			
		<c:if test="${fn:length(bookList) eq 0}">
			<h3>관련 도서가 없습니다.</h3>
		</c:if>
		
		<c:if test="${fn:length(bookList) ne 0}">
			<div class="row">
				<p>total ${fn:length(bookList)} 더보기</p>
			</div>
		</c:if>	
			
	    <div class="row">
			<c:forEach items="${bookList}" var="book" end="4">
				 <div class="col-md-2 book">
		       		<c:choose>
  						<c:when test="${book.thumbnail == ''}">
	       		   			<img class="img-thumbnail" src="http://t1.daumcdn.net/book/KOR${book.isbn}" height="240px" width="170px" onerror="this.src='../resources/images/noimage.jpg'">  					
  						</c:when>
  						<c:otherwise>
    						<img class="img-thumbnail" src="http://t1.daumcdn.net/book/KOR${book.isbn}" height="240px" width="170px" onerror="this.src='${book.thumbnail}'">
  						</c:otherwise>
					</c:choose>
					<p>${book.title}</p>
				</div>
			</c:forEach>
	    </div>
		
		<div class="row">	
			<hr class="search-hr">
		</div>

		<c:if test="${creationList.total eq 0}">
			<h3>관련 작품이 없습니다.</h3>
		</c:if> 
		
		<c:if test="${creationList.total ne 0}">
			<div class="row">
				<p>total ${creationList.total} 더보기</p>
			</div>
		</c:if>
		
		<div class="row" id="creation-content">	
			<div id="content-view">	
				<c:set var="doneLoop" value="false"/>	
				<c:forEach items="${creationList.result}" var="creation" varStatus="status">
					<c:if test="${not doneLoop}">
						<c:if test="${status.count == 4}"> 
							<c:set var="doneLoop" value="true"/> 
						</c:if> 
					</c:if> 
					<c:if test="${not doneLoop}"> 
						<div class="creation-total-box nav-creation" id="${creation.id}">
							<div class="row">
								<img class="creation-content-img" src="../resources/upload_files/images/${creation.image}" onerror="this.src='../resources/images/noimage.jpg'">
							</div>
							<div class="row" id="creation-tag-box">
								<div class="row" style="padding-left:10px"><font size=3>${creation.title}</font></div> 
								<div class="row" style="padding-left:10px">${creation.nick_name}</div>
								<div class="row" style="padding-left:10px"><p><c:forEach items="${creation.tag}" var="tag" varStatus="status"><span class="tag">#${tag}</span> </c:forEach></div>
							</div>							
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
		
		<div class="row">	
			<hr class="search-hr">
		</div>

		<c:if test="${boardList.total eq 0}">
			<h3>관련 게시판이 없습니다.</h3>
		</c:if> 
		
		<c:if test="${boardList.total ne 0}">
			<div class="row">
				<p>total ${boardList.total} 더보기</p>	
			</div>
		</c:if>
		
		<div class="row">
		<c:set var="doneLoop" value="false"/>	
		<c:forEach items="${boardList.result}" var="board" varStatus="status">
			<c:if test="${not doneLoop}">
				<c:if test="${status.count == 5}"> 
					<c:set var="doneLoop" value="true"/> 
				</c:if> 
			</c:if> 
			<c:if test="${not doneLoop}"> 
				<div class="col-md-3 nav-community board-total-box" id="${board.id}">
					<div class="row" id="board-title-box">
						<div class="col-md-7 col-xs-7" style="padding: 5px;">
							<p><strong>${board.title}</strong></p>
						<div >${board.nick_name}</div>
					</div>
					<div class="col-md-5 col-xs-5"  style="padding-right: 0px;" align="right">
						<img class="board-content-img" src="${board.image}" onerror="this.src='../resources/images/noimage.jpg'">
					</div>	
				</div>
				<div class="row" id="board-tag-box">
					<p><c:forEach items="${board.tag}" var="tag" varStatus="status"><span class="tag">#${tag}</span> </c:forEach></p>
				</div>
			</div>
		</c:if>
	</c:forEach>
	</div>
	
	<div class="row">	
		<hr class="search-hr">
	</div>

	<c:if test="${postingList.total eq 0}">
		<div class="row">
			<h3>관련 포스팅이 없습니다.</h3>
		</div>
	</c:if> 
	
	<c:if test="${postingList.total ne 0}">
		<div class="row">
			<p>total ${postingList.total} 더보기</p>	
		</div>
	</c:if>
	
	<c:set var="doneLoop" value="false"/>	
	<c:forEach items="${postingList.result}" var="posting" varStatus="status">
		<c:if test="${not doneLoop}">
			<c:if test="${status.count == 5}"> 
				<c:set var="doneLoop" value="true"/>
			</c:if> 
		</c:if>
		<c:if test="${not doneLoop}"> 
			<div class="row nav-posting" id="${posting.id}">
				<div class="row" id="posting-shadow-box">
					<div class="col-md-3">
						<img class="posting-content-img" src="../resources/upload_files/images/${posting.image}" onerror="this.src='../resources/images/noimage.png'">							
					</div>
					<div class="col-md-9" style="padding-left:35px; padding-top:5px;">
						<div class="row">
							<p><font size="4"><strong>${posting.title}</strong></font>  ${posting.nick_name}</p>				
						</div>
						<div class="row">
							<p><c:forEach items="${posting.tag}" var="tag" varStatus="status"><span class="tag">#${tag}</span> </c:forEach></p>
						</div>
						<div>
							<p class="posting-content-line">${posting.content}</p>
						</div>
					</div>
				</div>
			</div>
		</c:if> 
	</c:forEach>
	
  	</div> 
   	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
   </body>
</html>
