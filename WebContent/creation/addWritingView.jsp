<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	//============창작작품 등록하기=============
		function ConvertFormToJSON(form){
			 var array = jQuery(form).serializeArray();
			 var json = {};
			 
			 jQuery.each(array, function(){
				 if(this.name != 'tag'){
					 json[this.name] = this.value || '';
				 }
			 });
			 
			 return json;
			
		}
	
	 $(function() {

				$('#add-creation').on('click', function() {
						
				var creationForm = $("form[name='creationForm']");
				var json = ConvertFormToJSON(creationForm);
										
				 var formData = new FormData();
				 formData.append('creation', JSON.stringify(json));
				 formData.append('file',$('input[name="creationOriginName"]')[0].files[0]);
				 for(i=0; i< $('input[name="tag"]').length; i++){
					 formData.append('tag' , $($('input[name="tag"]')[i]).val());
				 }
				 alert("입력된 값은 "+formData.getAll('tag'));
				
				 /////////ajax 적용/////////
				$.ajax({
					url : "rest/addCreation/",
					method : "post",
					data : formData,
					contentType: false,
					processData: false,
						dataType : "json",
					success : function(JSONData, status) {

						//Debug...
						alert(status);
						
						var offset = $(".inWriting").offset();
				        $('html, body').animate({scrollTop : offset.top}, 400);

						$("form:hidden").show("fast");
						$('.inputValue').attr('disabled','true');
						$('span.glyphicon-remove').remove();
						$('a.tag-add:contains("추가하기")').off('click');
					}
				})
			})
	})		
	
	//=============말머리 선택시 태그에 추가=======
	
	$(function() {
	
		$('input:radio[name="creationHead"]').on('click', function() {
				$('input.headTag').val( $('input:radio[name="creationHead"]:checked').val().trim() );
				alert( $('input:radio[name="creationHead"]:checked').val() );
				alert("hiddenTag = "+$('input.headTag').val());
		})		
	})
		
	
	
	//==============있는 작품 선택================
		
	$(function() {
			
					$("select[name='creationNo']").on('change', function() {
						var creationNo = $("select[name='creationNo']").find("option:selected").val().trim();
						alert("creationNo = "+creationNo);
						
						if (creationNo == 0 ) {
							$('form')[0].reset();
							$('.inputValue').attr('disabled', false);
							
							$('a.tag-add:contains("추가하기")').on('click', function(){
								num = num + 1;
								tagHtml = '<span id="tag'+num+'">, # <input class="inputValue" type="text" name="tag"><span class="glyphicon glyphicon-remove" aria-hidden="true" onClick="javascript:fncRemoveTag('+num+')"></span></span>';
								$('.tag-list').append(tagHtml);
							});
							
							$('.addThing').remove();
							$('img').attr('src','../resources/upload_files/images/noImg_2.jpg');
							$('.glyphicon-remove').on('click',function(){
								fncRemoveTag(num);
							});
							$('form[name="writingForm"]').attr('class','hidden');
						}
						
					
					 /////////ajax 적용/////////
					$.ajax({
						url : "rest/getCreation?creationNo="+creationNo,
						method : "get",
						dataType : "json",
						success : function(JSONData, status) {
							
							//Debug...
						alert(status);
							
							var offset = $(".inWriting").offset();
														
							$('input[name="creationNo"]').val(JSONData.creationNo);
							$("input[name='creationTitle']").val(JSONData.creationTitle);
							$("textarea[name='creationIntro']").val(JSONData.creationIntro);
							$("img").attr("src","../resources/upload_files/images/"+JSONData.creationFileName);
							$("input[name='creationHead']").val(JSONData.creationHead);
							if($("input[name='creationHead']").val()==JSONData.creationHead){
								$("input[name='creationHead']").attr('checked','checked');
							}
							
							$("input[name='tag']").val(JSONData.tagList[0].tagName);
							$(".add-tag").remove();
							for (var i = 1; i < (JSONData.tagList).length; i++) {
								num = num+1;
								tagHtml = '<span class="add-tag addThing" id="tag'+num+'">, # <input class="inputValue addThing" type="text" name="tag" value='+JSONData.tagList[i].tagName+'>';
								tagHtml +='<span class="glyphicon glyphicon-remove addThing sr-only" aria-hidden="true" onClick="javascript:fncRemoveTag('+num+')"></span></span>';
								$('.tag-list').append(tagHtml);
							}
							
							$('form[name=writingForm]').attr('class','visible').show();
							$('.inputValue').attr('disabled','true');
							$('a.tag-add:contains("추가하기")').off('click');
					        $('html, body').animate({scrollTop : offset.top}, 400);
					        $('#add-creation').html('수정하기');
					        
					        alert("창작글 creationNo : "+$('input[name="creationNo"]').val());
						}
					})
				})
		})		
		
	//============창작작품 수정하러가기 버튼========
		 $(function() {

				$('#add-creation:contains("수정하기")').on('click', function() {
					self.location().attr('href','../creation/getWritingList');
				})
		 })
	
	
	
	//=============창작 글 등록====================
		var tagHtml;
		var num;
		var editor;
		
		$(function(){
			num = 0;
			$('a.add-writing:contains("등록하기")').on('click',function(){
				var data = CKEDITOR.instances.writingContent.getData();
				$('textarea').val(data);
				alert($('textarea').val());
				$('form[name="wiritingForm"]').attr('method','post').attr('action','../creation/addWriting').attr('enctype','multipart/form-data').submit();
			});
			
			$('a.tag-add:contains("추가하기")').on('click',function(){
				num = num + 1;
				tagHtml = '<span id="tag'+num+'">, # <input class="inputValue" type="text" name="tag"><span class="glyphicon glyphicon-remove" aria-hidden="true" onClick="javascript:fncRemoveTag('+num+')"></span></span>';
				$('.tag-list').append(tagHtml);
			});
		});
	
		$(function(){
			editor = CKEDITOR.replace('writingContent', { customConfig : 'config_writing.js'});
		
		});
	

	 
		function fncRemoveTag(num){
			$('#tag'+num).remove();
		}
	 

	</script>
</head>

<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<!-- 여기부터 코딩 -->
	
	<div class="container">
	
		<!--창작작품 등록란  -->
	<div class="panel panel-default">
  		<div class="panel-heading">
	     <h3>창작작품 등록란</h3>
	  </div>
  		<div class="panel-body" >
		<form id="creationForm" name="creationForm" >
			<div class="form-group">
				말머리 선택
				<input class="inputValue" type="radio" name ="creationHead"  value ="픽션" ${creation.creationHead =='픽션' ? 'checked' : '' } >픽션
				<input class="inputValue" type="radio" name ="creationHead"  value ="논픽션" ${creation.creationHead =='논픽션' ? 'checked' : '' } >논픽션
				<p></p>
				<p>작품명</p>
				<input class="inputValue" type="text" name="creationTitle" id ="creationTitle" value="${creation.creationTitle }">
				
					<c:if test="${!empty creationList}">
						<select class="form-control" name="creationNo" >
							<option value="0">새작품</option>
							<c:forEach var="creation" items="${creationList }">
					      		<option value="${creation.creationNo }" >${creation.creationTitle }</option>
							</c:forEach>
					     </select>
				     </c:if>
				
				<p></p>
				<p>작품소개</p>
				<textarea class="inputValue" name="creationIntro" rows="5" cols="100">${creation.creationIntro }</textarea>
			</div>
			<p>대표이미지</p>
			<c:if test="${!empty creation }">
				<img src="../resources/upload_files/images/${creation.creationFileName }"/>
			</c:if>
			<c:if test="${empty creation }">
				<img src="../resources/upload_files/images/noImg_2.jpg"/>
			</c:if>
			<input class="inputValue" type="file"  class="form-control" id="creationOriginName" name="creationOriginName" value="${creation.creationOriginName }">
		
			<div class="form-group tag-list">
				<label>태그</label>
				<input type="hidden" class="headTag" name="tag" id="tag">
				<a href="#" class="btn tag-add ">추가하기</a>
				<span># <input class="inputValue" type="text" name="tag" id="tag"  value="${creation.tagList[0].tagName}"></span>
							
			</div>
		
		<%-- <c:if test="${creationList != null }"> --%>	
			<a href="#" class="btn btn-default" id="add-creation" >등록하기</a>
		<%-- </c:if> --%>
		
		</form>
		</div>
	</div>
	
	<div class="inWriting" id="inWriting">
		<!--창작글 등록란  -->
	<form style="display:none;" id="writingForm" name="writingForm">
		<div class="panel panel-default">
	  		 <div class="panel-heading">
		     <h3>창작글 등록란</h3>
		  </div>
	  		<div class="panel-body">
				<div class="form-group">
					글제목 <input type="text" name="writingTitle">
					<input type = "hidden" name="creationNo">
				</div>
				<div class="form-group">
					<textarea name="writingContent" id="writingContent" rows="20" cols="80"></textarea>
				</div>
				
				<div class="panel imgList">
				
				</div>
			
				<a href="#" class="btn btn-default" id="add-writing">등록하기</a>
			</div>
		
		</div>
	</form>
	</div>
	
</div>
	
	
</body>
</html>