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
	.chat-container{
		margin-top: 20px;
	}
	.chat-output{
		border: solid 2px #62BFAD;
		height: 250px;
		overflow: auto;
	}
	
	.media-container{
		border: solid 2px #62BFAD;	
	}
	.file-container img{
		width: 100px;
		height: 100px;
		object-fit: contain;
	}
	
	</style>
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<div class="container">
	 <!--  비출력 정보 -->
	 <input type="hidden" id="roomId" value="${chatRoom.roomId}">
	 <input type="hidden" id="nickname" value="${user.nickname }">
	 
	 <!--  방정보 출력  여기 삭제예정-->
	 <div class="roomInfo" style="display: none">
	 		<div class="input-group">
	 		 <span class="input-group-addon" id="title-addon">방 제목</span>
			 <input type="text" name="title" class="form-control" value="${chatRoom.title}" placeholder="Title" aria-describedby="title-addon" disabled/>
			</div>
			
			<div class="input-group">
	 			<span class="input-group-addon" id="content-addon">방 내용</span>
				<textarea  name="content" class="form-control" placeholder="Title" aria-describedby="content-addon">${chatRoom.content }</textarea>
			</div>
			<div class="input-group">
	 		 <span class="input-group-addon" id="title-addon">인원</span>
			 <input type="text" name="maxUser" value="${chatRoom.maxUser}" class="form-control" placeholder="Title" aria-describedby="title-addon"/>
			</div>
			<div id="tagNames">
				<c:forEach items="${chatRoom.tagList}" var="tag">
				<span>${tag.tagName }</span>
				</c:forEach>
			</div>
	</div>
	 <!--  방정보 끝 -->
	 
	  <h1 style="display: none;">
	    WebRTC Scalable Video Conferencing using RTCMultiConnection
	  </h1>
	
	<!-- 방정보 새로작성 -->
	<div class="roomInfo">
		<h5>${chatRoom.title}</h5>
		<p>${chatRoom.content }</p>
		<div>
			<c:forEach items="${chatRoom.tagList}" var="tag">
				<span>${tag.tagName }</span>
			</c:forEach>
		</div>
	</div>
	<!-- 방정보 새로작성 끝-->
		
	    <div id="videos-container" class="row text-center"></div>

		<div class="chat-container text-center">
        	<div class="chat-output text-left"></div>
        	<input type="text" id="input-text-chat" placeholder="" >
	   		<button id="input-text-btn btn">전송</button>
	   		<button id="share-file">파일공유</button>
   		</div>
   		
	   
	    <div id="file-container" class="file-container"></div>
	</div>



<script>

// ......................................................
// .......................UI Code........................
// ......................................................
/* 버튼 없애면서 이벤트도 제거
document.getElementById('open-room').onclick = function() {
    disableInputButtons();
    connection.open(document.getElementById('room-id').value, function() {
      // showRoomURL(connection.sessionid);
    });
};

document.getElementById('join-room').onclick = function() {
    disableInputButtons();
    connection.join(document.getElementById('room-id').value);
};

document.getElementById('open-or-join-room').onclick = function() {
    disableInputButtons();
    connection.openOrJoin(document.getElementById('room-id').value, function(isRoomExists, roomid) {
        if (!isRoomExists) {
        //    showRoomURL(roomid);
        }
    });
};
document.getElementById('btn-leave-room').onclick = function() {
    this.disabled = true;

    if (connection.isInitiator) {
        // use this method if you did NOT set "autoCloseEntireSession===true"
        // for more info: https://github.com/muaz-khan/RTCMultiConnection#closeentiresession
        connection.closeEntireSession(function() {
            document.querySelector('h1').innerHTML = 'Entire session has been closed.';
        });
    } else {
        connection.leave();
    }
};
*/
// ......................................................
// ................FileSharing/TextChat Code.............
// ......................................................

document.getElementById('share-file').onclick = function() {
    var fileSelector = new FileSelector();
    fileSelector.selectSingleFile(function(file) {
        connection.send(file);
    });
};
/* 
document.getElementById('input-text-chat').onkeyup = function(e) {
    if (e.keyCode != 13) return;

    // removing trailing/leading whitespace
    this.value = this.value.replace(/^\s+|\s+$/g, '');
    if (!this.value.length) return;
	
    connection.send(this.value);
    appendDIV(this.value);
    this.value = '';
};
 */
  
$("#input-text-chat").on("keyup",function(e){
	 if (e.keyCode != 13) return;
		
	    // removing trailing/leading whitespace
	    this.value = this.value.replace(/^\s+|\s+$/g, '');
	    if (!this.value.length) return;
		
	    
	    writeChat("나: "+this.value);
	    connection.send($("#nickname").val()+": "+this.value);

	    this.value = '';
});
 

//채팅 출력 
var chatContainer = $('.chat-output');

function appendDIV(event) {
	writeChat(event.data);
}

function writeChat(message){
	var div=$("<div></div>");
    div.append(message);
    chatContainer.append(div);

    chatContainer.scrollTop(chatContainer[0].scrollHeight);
    //div.tabIndex = 0;
    //div.focus();
    document.getElementById('input-text-chat').focus();
}


var connection = new RTCMultiConnection();


//학원 테스트
connection.socketURL = 'https://192.168.0.21:433/';
//집에서 테스트
//connection.socketURL = 'https://192.168.219.167:433/';


connection.socketMessageEvent = 'video-conference-demo';

//파일공유 설정
connection.chunkSize = 64 * 1000;
connection.enableFileSharing = true;

var nickname=$("#nickname").val();
connection.extra={nickname:nickname};
connection.session = {
    audio: true,
    video: true,
    data: true
};

connection.sdpConstraints.mandatory = {
    OfferToReceiveAudio: true,
    OfferToReceiveVideo: true
};

connection.videosContainer = document.getElementById('videos-container');

connection.onstream = function(event) {
	
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
	mediaContainer.append("<h6>"+event.extra.nickname+"</h6>");
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
	
	writeChat(e.extra.nickname+"님이 입장하였습니다.");
    document.getElementById('share-file').disabled = false;
    document.getElementById('input-text-chat').disabled = false;
    //document.getElementById('btn-leave-room').disabled = false;
	currentUser =connection.getAllParticipants().length;
	console.log("currentUSer: "+currentUser);
	//참여인원 업데이트
	updateCurrentUser(currentUser);
	
	//사이즈 조절
	
	
    document.querySelector('h1').innerHTML = 'You are connected with: ' + connection.getAllParticipants().join(', ');
};

connection.onclose = function() {
    currentUser =connection.getAllParticipants().length;
	console.log("currentUSer: "+currentUser);
	//참여인원 업데이트
	updateCurrentUser(currentUser);
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
	    	success:function(){
	    		//alert("success"); 여기다 현재원 수정
	    	}
	    });	
}

function resizeVideo(userNum){
	
}
</script>

</body>
</html>
