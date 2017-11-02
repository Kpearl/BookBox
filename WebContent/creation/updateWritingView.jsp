<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
	<!-- CKEditor 추가 -->
	<script src="../resources/ckeditor/ckeditor.js"></script>
		<!-- CDN Version -->
	<!-- <script src="https://cdn.ckeditor.com/4.7.3/standard/ckeditor.js"></script> -->
	<!-- CKEditor -->

<script type="text/javascript">

//=====================창작글 수정하기 EVENT=================

		var tagHtml;
		var num;
		var editor;
	
		$(function(){
			editor = CKEDITOR.replace('writingContent', { customConfig : 'config_writing.js'});
			num = 0;
		
			$('a.update-writing').on('click',function(){
				var data = CKEDITOR.instances.writingContent.getData();
				$('form[name="updateForm"] textarea').val(data);
				alert($('form[name="updateForm"] textarea').val());
				$("form[name='updateForm']").attr('method','post').attr('action','../creation/updateWriting').submit();
			});
		});	
				
		$(function(){	
			$(".removeImg").on("click",function(){
			
					var content=CKEDITOR.instances.writingContent.getData();
					//alert(content);
					var contentObj=$("<div>"+content+"</div>");
					var src=$(this).attr("id");
				//	alert(temp.html());
					contentObj.find("img[src*='"+src+"']").remove();
					alert(src);
				//	alert($("textarea[name='boardContent']",parent.document).find("img[src='resources']").attr("src"));
				//	$("textarea[name='boardContent']",parent.document).find("img[src*='"+src+"']").remove();
					
					//다른곳에서 쓸때는 에디터 접근 이름변경
					CKEDITOR.instances.writingContent.setData(contentObj.html());
					$(this).parent("div").remove();	
					
			});
		});
		

</script>

</head>

<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>

	<!-- 말머리 -->
	<div class="container">
		<form id="updateForm" name="updateForm">
		<div class="panel">
			<h2>${creation.creationHead }</h2>
			<br>
			
			<div class="row">
					<div>
						펀딩진행중 여부
					</div>
					<div class="col-md-4">
						<input type ="hidden" name="creationNo" value="${creation.creationNo }"/>
			    		<img src="../resources/upload_files/images/${creation.creationFileName }" width="320px" height="200px">
			  		</div>
					<div class="col-md-6">
						  <h4>작품명 : ${creation.creationTitle }</h4> 
						  <p>작성자 : ${creation.creationAuthor.nickname }</p> 
						  <p>태그리스트 : 
						  <c:forEach var="tag" items="${creation.tagList}">	  
						  	<span>#${tag.tagName }</span>	
						  </c:forEach>
						  </p>
						  <p>작품 소개글 : ${creation.creationIntro }</p>
		  			</div>
			</div>
		
		<br>
	
			<div>사이트내 좋아요 개수 : <span  id="likeSum">${like.totalLike}</span></div><br>
			<div>사이트내 평균 평점 : <span id="gradeAvg">${grade.average}</span></div><br>
		</div>

		<!-- 별점 -->
	<%-- 	<div id="starWrap" class="star${grade.average}">
			<ul>
				<li class="s1"></li>
				<li class="s2"></li>
				<li class="s3"></li>
				<li class="s4"></li>
				<li class="s5"></li>
			</ul>
		</div> --%>
		
		<div class="inWriting" id="inWriting">
		<!--창작글 등록란  -->
			<div class="panel panel-default">
		  		 <div class="panel-body">
					<div class="form-group">
						글제목 <input type="text" name="writingTitle" value="${writing.writingTitle }">
						<input type = "hidden" name="writingNo" value="${writing.writingNo }">
						<input type = "hidden" name="active" value="${writing.active }">
					</div>
					<div class="form-group">
						<textarea name="writingContent" id="writingContent" rows="20" cols="80">
						${writing.writingContent }</textarea>
					</div>
					
					<div class="panel imgList">
					이미지리스트
					<c:forEach var ="uploadFile" items="${writing.writingFileList }">
					<div id="${uploadFile.fileName}">
						<input type="hidden" name="writingFileName"   value="${uploadFile.fileName}" readonly>
						<input type="hidden" name="writingOriginName"    value="${uploadFile.originName}" readonly>
						<span>${uploadFile.originName}</span>
						<a class='btn removeImg' id="${uploadFile.fileName}">x</a>
					</div>		
					</c:forEach>
					
					</div>
				</div>
			
			</div>
	</div>
		</form>
		
		<div class="row ">
			<div class="col-md-12 text-right">
				<a class="btn delete-writing" id="delete-writing">삭제</a>
				<a class= "btn update-writing" id="update-writing" >수정</a>
			</div>
			<a class="btn add-writing" >창작글쓰기</a>
			<a class="btn">목록</a>
		</div>
		<br><br>

		
	
	</div>
</body>
</html>