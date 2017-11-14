<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<style>
		
	.creation-toolbar{
		clear: both;
	    height: 40px;
	    _height: 40px;
	    padding: 0 0 2px;
	    background: #3d3d3d
	}
	
	ul.menu li {
       float: left;
   	 	position: relative;
}
	
	.li-form{
		    list-style: none;
	        margin: 0;
    		padding: 0;
    		text-align: -webkit-match-parent;
	}
	
	.creation-menu-each{
		margin-right : 30px;
	    font-size: initial;
	}

	.creation-menu{
	    display: inline-block;
	    height: 100%;
	    margin-top: 5px;
	 	color: beige;
 	    font-style: normal;
   		 font-weight: bold;
	}
  
    .add-btn{
    	padding-left: 15px;
	    padding-right: 15px;
	    padding: 7px 15px 7px 15px;
	    font-weight: bold;
	    font-size: small;
    }
    .button-form{
    	cursor:pointer;
    }

    	
    	
    </style>

    <script>

    $(function() {
	//============= 창작글쓰기 Navigation Event  처리 =============	
		$(".addWriting").on("click" , function() {
			$(self.location).attr("href","../creation/addWriting");
   	}); 
	//============= 펀딩등록하기 Navigation Event  처리 =============	
	 	$(".addfunding").on("click" , function() {
		  $(self.location).attr("href","../creation/addFunding");
   	}); 
   //============= 창작홈 Navigation Event  처리 =============	
		$(".creation-home").on("click" , function() {
		  $(self.location).attr("href","../creation/getCreationMain");
   	}); 
   //============= 창작리스트 Navigation Event  처리 =============	
		$(".creation-writing-home").on("click" , function() {
			$(self.location).attr("href","../creation/getCreationList");
   	}); 
   //============= 창작리스트 Navigation Event  처리 =============	
		$(".funding-home").on("click" , function() {
			$(self.location).attr("href","../creation/getFundingList");
   	});  
   
 });  
   
  
    </script>
		

	
	<div class="row">
		<div class="col-md-10 creation-toolbar">
			<div class ="creation-toolbar-main" style="display:inline-block; height:100%;">
				<ul class="creation-menu" style="display:inline-block; height:100%;">
					<li class="li-form creation-home" style="display:inline-block;"><div class="creation-menu-each button-form" >창작홈</div></li>
					<li class="li-form creation-writing-home" style="display:inline-block;"><div class="creation-menu-each button-form">창작작품</div></li>
					<li  class="li-form funding-home" style="display:inline-block;"><div class="creation-menu-each button-form">펀딩</div></li>
				</ul>
			</div>
		</div>
		<div class="col-md-2" style="padding:0px;background-color: rgba(187, 187, 187, 0.62);border: 2px groove;height: 40px;border-left-width: medium;color: #3d3d3d;">
			<c:if test="${!empty sessionScope.user and !empty sessionScope.user.email}">
			<div class="creation-toolbar-sub" style="display:inline-block; height:100%;">
				<div class="add-btn addfunding text-center" style="display:inline-block;border-right-width: thin;border-right-color: rgba(0,0,0,0.4);border-right-style: double;">
					<div class="addfnding-inner button-form">
						펀딩등록하기
					</div>
				</div>
				<div class="add-btn addWriting text-center" style="display:inline-block;">
					<div class="addWriting-inner button-form">
					글쓰기
					</div>
				</div>
			</div>
		</c:if>
		</div>
	</div>



 