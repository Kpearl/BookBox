<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en" dir="ltr">
<head>
  <meta charset="utf-8">
  <title>WebRTC Scalable Video Conferencing using RTCMultiConnection</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
 	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
  	<link rel="stylesheet" href="../resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/css/custom.css">
   
   	<script src="../resources/javascript/toolbar_opac.js"></script>
	<script src="../resources/javascript/custom.js"></script>
    <!-- RTC -->
    <script src="../resources/javascript/community/RTCMultiConnection.min.js"></script>
	<script src="../resources/javascript/community/socket.io.js"></script>
<!-- 
	<script src="https://cdn.webrtc-experiment.com/getMediaElement.js"></script>
 -->
 	<script src="../resources/javascript/community/getMediaElement.js"></script>
	<script src="../resources/javascript/community/adapter.js"></script>
	<script src="../resources/javascript/community/FileBufferReader.js"></script>
	
	<style type="text/css">
	
	.container{
    		height: 100%;
  
    	}
    .total-container{
    	padding: 20px 0 0 0;
    	border-top: 20px solid #62bfad;
    	width: 100%;
    }
	.videos-container{
		 	background-color: #62bfad38;
		 	margin: 0 0 0 0 !important;
		 	padding: 20px 0 20px 0;
	}
	
	.media-container{
		margin: 0 10px 0 10px !important;
	}
	hr{
		margin-top: 8px;
	}
	
	.media-box{
		border: 0 !important;
		maring: 0 !important;
	}
	.chat-container{
		margin-top: 20px;
	}
	.chat-output{
		border: solid 2px #62BFAD;
		height: 250px;
		overflow: auto;
		margin: 0 30px 0 30px;
		padding: 0 40px 0 40px;
		/*background-color: #eee;*/
	}
	
	.media-container{
		border: solid 2px #62BFAD;	
	}
	.file-container img{
		width: 100px;
		height: 100px;
		object-fit: contain;
	}
	
	.room-info{
		margin: 20px 10px 10px 10px;
		padding-bottom: 5px;
	}
	.room-info .room-head{
		height: 60px;
	}
	.room-info .room-title{
		font-size: 30px;
	}
	.room-info .host-nickname{
			
	}
	.room-info .regdate{
		margin: 0 0 0 20px;
	}
	
	.room-info .room-content{
		height: 80px;
		font-size:  15px;
		/*overflow: hidden;*/
	}
	.room-info .tag-list{
		margin: 10px 0 0 0;
	}
	.user-info{
		height: 55px;
		padding: 6px;
	}
	
	.user-info .img{
			vertical-align: top;
			display: inline-block;
	}
	.user-info img{
		height: 40px;
		width: 40px;
		border-radius: 50%;
		object-fit: cover;
	
	}
	.user-info .nickname{
		height:40px;
		font-size: 25px;	
		display: inline-block;	
		vertical-align: middle;
	}
	
	.user-info .empty{
		height: 100%;
	}
	
	.chat-input-area{
		margin: 20px 0 0 0;
	}
	.chat-input-form{
		width: 50%;
	}
	
	
	.file-container iframe{
		display: none;
	}
	
	.btn-custom{
		cursor: pointer;
		border: 1px #888 solid;
		border-radius:5px;
		color: #888;
		padding: 5px;
	}
	.btn-custom:hover{
		text-decoration: none;
	}
	
	</style>
	<script type="text/javascript">
	var room_id='${chatRoom.roomId}';
	//alert(room_id);
	/*
	$(window).on("beforeunload", function (){
	
			$.ajax({
				url:"rest/deleteChatRoom",
				method:"POST",
				data:{type:"camchat",roomId:room_id},
				success:function(){
				}
			});
	});
	*/
		
	$(function(){
			$("#exit").on("click",function(){
			
				self.location="getCommunityMain";
			});
			
	});
	</script>
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<div class="container">
	 <!--  비출력 정보 -->
	 <input type="hidden" id="roomId" value="${chatRoom.roomId}">
	 <input type="hidden" id="nickname" value="${user.nickname }">
	 <input type="hidden" id="userImg" value="${user.booklogImage}">
	 <c:if test="${ user.email == chatRoom.host.email }">
		 <input type="hidden" id="role" value="host">
	 </c:if>
	 <c:if test="${ user.email != chatRoom.host.email }">
	 	<input type="hidden" id="role" value="guest">
	 </c:if>
	 
	  <h1 style="display: none;">
	    
	  </h1>
	<div class="total-container">
	
	<!-- 방정보 새로작성 -->
	<div class="room-info">
		<div class="row room-head">
			<div class="col-xs-9">
				<div class="room-title">${chatRoom.title}</div>
			</div>
			<div class="text-right col-xs-3">
				<a class="btn-custom" id="exit">나가기</a>
			</div>
			<div class="col-xs-12">
				<span class="host-nickname">${chatRoom.host.nickname}</span><span class="regdate">${chatRoom.regDate}</span>
			</div>
		</div>
		
		<div class="room-content">${chatRoom.content }</div>
		<div class="tag-list">
			<c:forEach items="${chatRoom.tagList}" var="tag">
				<span class='tag'>${tag.tagName }</span>
			</c:forEach>
		</div>
	</div>
	<hr/>
	<!-- 방정보 새로작성 끝-->
		
	    <div id="videos-container" class="videos-container row text-center"></div>

		<div class="chat-container text-center">
        	<div class="chat-output text-left"></div>
        	<div class="chat-input-area">
	        	<input type="text" id="input-text-chat" class="chat-input-form">
		   		<a id="input-text-btn" class="btn-custom">전송</a>
		   		<a id="share-file" class="btn-custom">파일공유</a>
        	</div>
   		</div>
   		
	   	<div style="margin: 30px 0 0 30px;">공유 파일 목록</div>
	    <div id="file-container" class="file-container"></div>
	</div>
	</div>



<script>


// ......................................................
// ................FileSharing/TextChat Code.............
// ......................................................

document.getElementById('share-file').onclick = function() {
    var fileSelector = new FileSelector();
    fileSelector.selectSingleFile(function(file) {
        connection.send(file);
    });
};

 
$("#input-text-chat").on("keyup",function(e){
	 if (e.keyCode != 13) return;
		
	    // removing trailing/leading whitespace
	    this.value = this.value.replace(/^\s+|\s+$/g, '');
	    if (!this.value.length) return;
	    
	    writeChatSelf(this.value);
	    connection.send(this.value);

	    this.value = '';
});
 

//채팅 출력 
var chatContainer = $('.chat-output');

function appendDIV(event) {
	writeChat(event);
}

function writeChat(event){
	var div=$("<div></div>");
    div.append(event.extra.nickname +" : "+event.data);
    div.css("color",event.extra.fontColor);
    chatContainer.append(div);

    chatContainer.scrollTop(chatContainer[0].scrollHeight);
    document.getElementById('input-text-chat').focus();
}

function writeChatSelf(message){
	var div=$("<div></div>");
    div.append("나 : "+message);
    chatContainer.append(div);

    chatContainer.scrollTop(chatContainer[0].scrollHeight);
    document.getElementById('input-text-chat').focus();
}


var connection = new RTCMultiConnection();


//학원 테스트
connection.socketURL = 'https://192.168.0.21:433/';
//집에서 테스트
//connection.socketURL = 'https://192.168.219.167:433/';
//할리스 테스트
//connection.socketURL = 'https://192.168.1.52:433/';

connection.socketMessageEvent = 'video-conference-demo';

//파일공유 설정
connection.chunkSize = 64 * 1000;
connection.enableFileSharing = true;


//추가정보 입력
var nickname=$("#nickname").val();
var fontColor=getRandomColor();
var userImg=$("#userImg").val();


connection.extra={nickname:nickname,
					fontColor:fontColor,
					userImg: userImg};
					
					
//디바이스 확인
if(connection.DetectRTC.hasWebcam) {
 console.log("find webcam @@@");
}
					
connection.session = {
    audio: true,
    video: true,
   	//video:false,
   	//screen:true,
    data: true
};

connection.sdpConstraints.mandatory = {
    OfferToReceiveAudio: true,
    OfferToReceiveVideo: true
};

connection.videosContainer = document.getElementById('videos-container');

connection.onstream = function(event) {
	
	console.log("스트림 받음");
	//추가부분
	event.mediaElement.removeAttribute('src');
    event.mediaElement.removeAttribute('srcObject');

    var video = document.createElement('video');

    video.controls = true;
    if(event.type === 'local') {
        video.muted = true;
    }
    video.srcObject = event.stream;
	//
	
    var width = parseInt(connection.videosContainer.clientWidth / 2) - 20;
    var mediaElement = getMediaElement(event.mediaElement, {
        title: event.userid,
        buttons: ['mute-audio', 'mute-video','full-screen'],
        width: width,
        showOnMouseEnter: true
    });
    //유저 닉네임 추가
	var mediaContainer=$(mediaElement);

	mediaContainer.append(	"<div class='user-info row'>"+
								"<div class='img'>"+
								"<img src=\"../resources/upload_files/images/"+event.extra.userImg+"\" onerror=\"this.src='../resources/images/no_booklog_image.png'\">"+
								"</div>"+
								"<div class='nickname'>"+
									"<div>"+event.extra.nickname+"</div>"+
								"</div>"+
							"</div>");
	//mediaContainer.addClass("col-xs-3");
	mediaContainer.css("width","");
	//console.log(test.html());
	console.log(event.extra.nickname);
	
	
    connection.videosContainer.appendChild(mediaElement);
	
    setTimeout(function() {
        mediaElement.media.play();
    }, 5000);

    mediaElement.id = event.streamid;
};

connection.onstreamended = function(event) {
    var mediaElement = document.getElementById(event.streamid);
    if (mediaElement) {
        mediaElement.parentNode.removeChild(mediaElement);
    }
};

function disableInputButtons() {
    document.getElementById('open-or-join-room').disabled = true;
    document.getElementById('open-room').disabled = true;
    document.getElementById('join-room').disabled = true;
    document.getElementById('room-id').disabled = true;
}

connection.onstreamended = function(event) {
    var mediaElement = document.getElementById(event.streamid);
    if (mediaElement) {
        mediaElement.parentNode.removeChild(mediaElement);
    }
};

connection.onmessage = appendDIV;
connection.filesContainer = document.getElementById('file-container');

connection.onopen = function(e) {
	e.data="입장하였습니다";
	writeChat(e);
    document.getElementById('share-file').disabled = false;
    document.getElementById('input-text-chat').disabled = false;
    //document.getElementById('btn-leave-room').disabled = false;
	currentUser =connection.getAllParticipants().length;
	console.log("currentUSer: "+currentUser);
	//참여인원 업데이트
	//updateCurrentUser(currentUser+1);
	
	//사이즈 조절
};

connection.onclose = function(e) {
	console.log(e)
	e.data="퇴장하였습니다.";
	writeChat(e);
    currentUser =connection.getAllParticipants().length;
	console.log("유저나감 currentUSer: "+currentUser);
	//참여인원 업데이트
	//updateCurrentUser(currentUser+1);
};

connection.onUserIdAlreadyTaken = function(useridAlreadyTaken, yourNewUserId) {
    // seems room is already opened
    connection.join(useridAlreadyTaken);
};
//파라미터 있을시 자동연결
connection.openOrJoin( $("#roomId").val(), function(isRoomExists, roomid) {
        if (!isRoomExists) {
        //    showRoomURL(roomid);
        }
    });
    
function updateCurrentUser(currentUser){
	
	 $.ajax({
	    	url:"rest/updateChatRoomCurrentUser",
	    	method: "POST",
	    	data:{
	    		currentUser: currentUser,
	    		roomType:"camchat",
	    		roomId:$("#roomId").val()
	    	},
	    	success:function(data){
	    		console.log("현재원서버수정완료"+data);
	    	}
	    });	
}

function resizeVideo(userNum){
	
}

function getRandomColor() {
    var letters = '0123456789ABCDEF';
    var color = '#';
    for (var i = 0; i < 6; i++) {
      color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
  }
</script>

<div style="height: 300px;"></div>
	<footer class="container-fluid">
			<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
</body>
</html>
