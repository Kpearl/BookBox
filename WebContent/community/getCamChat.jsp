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
	<script src="https://cdn.webrtc-experiment.com/getMediaElement.js"></script>
	<script src="../resources/javascript/community/adapter.js"></script>
	<script src="../resources/javascript/community/FileBufferReader.js"></script>
</head>
<body>
	<div class="container">
	 
	 <input type="text" id="roomId" value="${chatRoom.roomId}">
	 <!--  방정보 출력 -->
	 <div class="roomInfo">
	 		<div class="input-group">
	 		 <span class="input-group-addon" id="title-addon">방 제목</span>
			 <input type="text" name="title" class="form-control" value="${chatRoom.title}" placeholder="Title" aria-describedby="title-addon" disabled/>
			</div>
			
			<div class="input-group">
	 			<span class="input-group-addon" id="content-addon">방 내용</span>
				<textarea  name="content" class="form-control" placeholder="Title" aria-describedby="content-addon">${chatRoom.content }</textarea>
			</div>
			<div class="input-group">
	 		 <span class="input-group-addon" id="title-addon">최대인원</span>
			 <input type="text" name="maxUser" value="${chatRoom.maxUser}" class="form-control" placeholder="Title" aria-describedby="title-addon"/>
			</div>
			<div id="tagNames">
				<c:forEach items="${chatRoom.tagList}" var="tag">
				<span>${tag.tagName }</span>
				</c:forEach>
			</div>
	</div>
	 <!--  방정보 끝 -->
	  <h1>
	    WebRTC Scalable Video Conferencing using RTCMultiConnection
	  </h1>
	
	  <section class="make-center">
	    <input type="text" id="room-id" value="abcdef" autocorrect=off autocapitalize=off size=20>
	    <button id="open-room">Open Room</button>
	    <button id="join-room">Join Room</button>
	    <button id="open-or-join-room">Auto Open Or Join Room</button>
		<input type="text" id="input-text-chat" placeholder="Enter Text Chat" disabled>
	    <button id="share-file" disabled>Share File</button>
	    <br><br>
	    <button id="btn-leave-room" disabled>Leave /or close the room</button>
	
	    <div id="room-urls" style="text-align: center;display: none;background: #F1EDED;margin: 15px -10px;border: 1px solid rgb(189, 189, 189);border-left: 0;border-right: 0;"></div>
		<div id="chat-container">
        	<div id="file-container"></div>
        	<div class="chat-output"></div>
   		 </div>
	    <div id="videos-container"></div>
	  </section>
	</div>


<!-- custom layout for HTML5 audio/video elements -->

<script>
// ......................................................
// .......................UI Code........................
// ......................................................
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

// ......................................................
// ................FileSharing/TextChat Code.............
// ......................................................

document.getElementById('share-file').onclick = function() {
    var fileSelector = new FileSelector();
    fileSelector.selectSingleFile(function(file) {
        connection.send(file);
    });
};

document.getElementById('input-text-chat').onkeyup = function(e) {
    if (e.keyCode != 13) return;

    // removing trailing/leading whitespace
    this.value = this.value.replace(/^\s+|\s+$/g, '');
    if (!this.value.length) return;
	
    connection.send(this.value);
    appendDIV(this.value);
    this.value = '';
};



//채팅 출력 
var chatContainer = $('.chat-output');

function appendDIV(event) {
    
	//var div = document.createElement('div');
    //div.innerHTML = event.data || event;
    
   	//alert(div.innerHTML);
    //chatContainer.insertBefore(div, chatContainer.firstChild);
    var div=$("<div></div>");
    div.append(event.data)
    chatContainer.append(div);
    
    //div.tabIndex = 0;
    //div.focus();

    document.getElementById('input-text-chat').focus();
}


// ......................................................
// ..................RTCMultiConnection Code.............
// ......................................................

var connection = new RTCMultiConnection();

// by default, socket.io server is assumed to be deployed on your own URL
//로컬 테스트 
//connection.socketURL = 'https://127.0.0.1:9001/';
connection.socketURL = 'https://192.168.0.21:433/';
// comment-out below line if you do not have your own socket.io server
// connection.socketURL = 'https://rtcmulticonnection.herokuapp.com:443/';

connection.socketMessageEvent = 'video-conference-demo';

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
        buttons: ['full-screen'],
        width: width,
        showOnMouseEnter: false
    });

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

connection.onopen = function() {
    document.getElementById('share-file').disabled = false;
    document.getElementById('input-text-chat').disabled = false;
    document.getElementById('btn-leave-room').disabled = false;

    document.querySelector('h1').innerHTML = 'You are connected with: ' + connection.getAllParticipants().join(', ');
};

//파라미터 있을시 자동연결
connection.openOrJoin( $("#roomId").val(), function(isRoomExists, roomid) {
        if (!isRoomExists) {
        //    showRoomURL(roomid);
        }
    });

</script>

</body>
</html>
