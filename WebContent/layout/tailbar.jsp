<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
 	$(function(){
		if($(window).height() == $(document).height()){
			$('footer').css('position', 'absolute')
					.css('top', $(document).height()-85);
		}
	});
	
</script>
	<h5>BOOKBOX COMMUNITY © 2017</h5>
