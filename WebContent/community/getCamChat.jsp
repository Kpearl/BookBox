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
	<style type="text/css">
	.chat-output{
		border: solid 1px;
		height: 250px;
		overflow: scroll;
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
	  <h1 style="display: none;">
	    WebRTC Scalable Video Conferencing using RTCMultiConnection
	  </h1>
	
	  <section class="make-center">
	    <!-- 
	    <input type="text" id="room-id" value="abcdef" autocorrect=off autocapitalize=off size=20>
	    <button id="open-room">Open Room</button>
	    <button id="join-room">Join Room</button>
	    <button id="open-or-join-room">Auto Open Or Join Room</button>
	    <button id="btn-leave-room" disabled>Leave /or close the room</button>
	     -->
		<input type="text" id="input-text-chat" placeholder="채팅내용입력+엔터" disabled>
	   	<button id="input-text-btn btn">전송</button>
	    <button id="share-file" disabled>Share File</button>
	    <br><br>
	
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

// ......................................................
// ..................RTCMultiConnection Code.............
// ......................................................

var connection = new RTCMultiConnection();

// by default, socket.io server is assumed to be deployed on your own URL

//학원 테스트
connection.socketURL = 'https://192.168.0.21:433/';
//집에서 테스트
//connection.socketURL = 'https://192.168.219.167:433/';
// comment-out below line if you do not have your own socket.io server
// connection.socketURL = 'https://rtcmulticonnection.herokuapp.com:443/';

connection.socketMessageEvent = 'video-conference-demo';

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
    //
	//console.log(event.extra.nickname);
    //var test=$(video);
    //test.append("<h2>"+event.extra.nickname+"</h2>")
    //
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
    //유저 닉네임 추가
	var test=$(mediaElement);
	test.append("<h2>"+event.extra.nickname+"</h2>");
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
   // document.getElementById('share-file').disabled = false;
    document.getElementById('input-text-chat').disabled = false;
    //document.getElementById('btn-leave-room').disabled = false;

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
