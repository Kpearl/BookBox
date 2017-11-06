<%@page import="java.util.Random"%>
<%@page import="com.bookbox.service.domain.User"%>
<%@page import="com.bookbox.service.domain.ChatRoom"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% if(request.getAttribute("chatRoom")==null){
	ChatRoom chatRoom=new ChatRoom();
	chatRoom.setRoomId("test0001");
	request.setAttribute("chatRoom", chatRoom);
	Random rand=new Random();
	User user=new User();
	user.setNickname("user"+rand.nextInt(1000));
	request.setAttribute("user", user);
}
%>




<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" dir="ltr">
<head>
  <meta charset="utf-8">
  <title>WebRTC Scalable Broadcast using RTCMultiConnection</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
 	
 	<!-- RTC -->
 	<script src="../resources/javascript/community/RTCMultiConnection.min.js"></script>
	<script src="../resources/javascript/community/socket.io.js"></script>
 	
 	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
  	<link rel="stylesheet" href="../resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/css/custom.css">
    
    <style type="text/css">
    	video{
    		width: 400px;
    		height: 300px;
    	}
    
    </style>
</head>

<body>
 	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
 <!--  비출력 정보 -->
 	<div class="container">
	 <input type="hidden" id="roomId" value="${chatRoom.roomId}">
	 <input type="hidden" id="nickname" value="${user.nickname }">
	 <c:if test="${ user.email == chatRoom.host.email }">
		 <input type="hidden" id="role" value="host">
	 </c:if>
	 <c:if test="${ user.email != chatRoom.host.email }">
	 	<input type="hidden" id="role" value="guest">
	 </c:if>
	 
	 
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

	<div class="row">
		<div class="col-md-6 video-container">
	      <div class="make-center" id="broadcast-viewers-counter"></div>
	      <video id="video-preview" controls loop></video>
		</div>
		<div class="col-md-6 chat-container">
			<div class="chat-output">
			</div>
			<input type="text" class="chat-input"><button>전송</button>
		</div>
	</div>

	<h1 style="display: none;"></h1>
</div>
<!-- <script src="https://cdn.webrtc-experiment.com/RecordRTC.js"></script> -->
<script>

   
// recording is disabled because it is resulting for browser-crash
// if you enable below line, please also uncomment above "RecordRTC.js"
var enableRecordings = false;

var connection = new RTCMultiConnection();

// its mandatory in v3
connection.enableScalableBroadcast = true;

// each relaying-user should serve only 1 users
connection.maxRelayLimitPerUser = 1;

// we don't need to keep room-opened
// scalable-broadcast.js will handle stuff itself.
connection.autoCloseEntireSession = true;

// by default, socket.io server is assumed to be deployed on your own URL

	//학원테스트
	connection.socketURL = 'https://192.168.0.21:433/';
	//집에서 테스트
	//connection.socketURL = 'https://192.168.219.167:433/';
// comment-out below line if you do not have your own socket.io server
// connection.socketURL = 'https://rtcmulticonnection.herokuapp.com:443/';

connection.socketMessageEvent = 'scalable-media-broadcast-demo';

// document.getElementById('broadcast-id').value = connection.userid;

// user need to connect server, so that others can reach him.
connection.connectSocket(function(socket) {
    socket.on('logs', function(log) {
        document.querySelector('h1').innerHTML = log.replace(/</g, '----').replace(/>/g, '___').replace(/----/g, '(<span style="color:red;">').replace(/___/g, '</span>)');
    });

    // this event is emitted when a broadcast is already created.
    socket.on('join-broadcaster', function(hintsToJoinBroadcast) {
        console.log('join-broadcaster', hintsToJoinBroadcast);

        connection.session = hintsToJoinBroadcast.typeOfStreams;
        connection.sdpConstraints.mandatory = {
            OfferToReceiveVideo: !!connection.session.video,
            OfferToReceiveAudio: !!connection.session.audio
        };
        connection.broadcastId = hintsToJoinBroadcast.broadcastId;
        connection.join(hintsToJoinBroadcast.userid);
    });

    socket.on('rejoin-broadcast', function(broadcastId) {
        console.log('rejoin-broadcast', broadcastId);

        connection.attachStreams = [];
        socket.emit('check-broadcast-presence', broadcastId, function(isBroadcastExists) {
            if (!isBroadcastExists) {
                // the first person (i.e. real-broadcaster) MUST set his user-id
                connection.userid = broadcastId;
            }

            socket.emit('join-broadcast', {
                broadcastId: broadcastId,
                userid: connection.userid,
                typeOfStreams: connection.session
            });
        });
    });

    socket.on('broadcast-stopped', function(broadcastId) {
        // alert('Broadcast has been stopped.');
        // location.reload();
        console.error('broadcast-stopped', broadcastId);
        alert('방송이 중지.');
    });

    // this event is emitted when a broadcast is absent.
    socket.on('start-broadcasting', function(typeOfStreams) {
        console.log('start-broadcasting', typeOfStreams);

        // host i.e. sender should always use this!
        connection.sdpConstraints.mandatory = {
            OfferToReceiveVideo: false,
            OfferToReceiveAudio: false
        };
        connection.session = typeOfStreams;

        // "open" method here will capture media-stream
        // we can skip this function always; it is totally optional here.
        // we can use "connection.getUserMediaHandler" instead
        connection.open(connection.userid, function() {
           //showRoomURL(connection.sessionid);
        });
        
    });
});

window.onbeforeunload = function() {
    // Firefox is ugly.
    document.getElementById('open-or-join').disabled = false;
};

var videoPreview = document.getElementById('video-preview');

connection.onstream = function(event) {
    if (connection.isInitiator && event.type !== 'local') {
        return;
    }

    connection.isUpperUserLeft = false;
    videoPreview.srcObject = event.stream;
    videoPreview.play();

    videoPreview.userid = event.userid;

    if (event.type === 'local') {
        videoPreview.muted = true;
    }

    if (connection.isInitiator == false && event.type === 'remote') {
        // he is merely relaying the media
        connection.dontCaptureUserMedia = true;
        connection.attachStreams = [event.stream];
        connection.sdpConstraints.mandatory = {
            OfferToReceiveAudio: false,
            OfferToReceiveVideo: false
        };

        var socket = connection.getSocket();
        socket.emit('can-relay-broadcast');

        if (connection.DetectRTC.browser.name === 'Chrome') {
            connection.getAllParticipants().forEach(function(p) {
                if (p + '' != event.userid + '') {
                    var peer = connection.peers[p].peer;
                    peer.getLocalStreams().forEach(function(localStream) {
                        peer.removeStream(localStream);
                    });
                    event.stream.getTracks().forEach(function(track) {
                        peer.addTrack(track, event.stream);
                    });
                    connection.dontAttachStream = true;
                    connection.renegotiate(p);
                    connection.dontAttachStream = false;
                }
            });
        }

        if (connection.DetectRTC.browser.name === 'Firefox') {
            // Firefox is NOT supporting removeStream method
            // that's why using alternative hack.
            // NOTE: Firefox seems unable to replace-tracks of the remote-media-stream
            // need to ask all deeper nodes to rejoin
            connection.getAllParticipants().forEach(function(p) {
                if (p + '' != event.userid + '') {
                    connection.replaceTrack(event.stream, p);
                }
            });
        }

        // Firefox seems UN_ABLE to record remote MediaStream
        // WebAudio solution merely records audio
        // so recording is skipped for Firefox.
        if (connection.DetectRTC.browser.name === 'Chrome') {
            repeatedlyRecordStream(event.stream);
        }
    }
};

// ask node.js server to look for a broadcast
// if broadcast is available, simply join it. i.e. "join-broadcaster" event should be emitted.
// if broadcast is absent, simply create it. i.e. "start-broadcasting" event should be fired.
/*
document.getElementById('open-or-join').onclick = function() {
    var broadcastId = document.getElementById('broadcast-id').value;
    if (broadcastId.replace(/^\s+|\s+$/g, '').length <= 0) {
        alert('Please enter broadcast-id');
        document.getElementById('broadcast-id').focus();
        return;
    }

    document.getElementById('open-or-join').disabled = true;

    connection.session = {
        audio: true,
        video: true,
        oneway: true
    };

    var socket = connection.getSocket();

    socket.emit('check-broadcast-presence', broadcastId, function(isBroadcastExists) {
        if (!isBroadcastExists) {
            // the first person (i.e. real-broadcaster) MUST set his user-id
            connection.userid = broadcastId;
        }

        console.log('check-broadcast-presence', broadcastId, isBroadcastExists);

        socket.emit('join-broadcast', {
            broadcastId: broadcastId,
            userid: connection.userid,
            typeOfStreams: connection.session
        });
    });
};
*/
connection.onstreamended = function() {};

connection.onleave = function(event) {
    if (event.userid !== videoPreview.userid) return;

    var socket = connection.getSocket();
    socket.emit('can-not-relay-broadcast');

    connection.isUpperUserLeft = true;

    if (allRecordedBlobs.length) {
        // playing lats recorded blob
        var lastBlob = allRecordedBlobs[allRecordedBlobs.length - 1];
        videoPreview.src = URL.createObjectURL(lastBlob);
        videoPreview.play();
        allRecordedBlobs = [];
    } else if (connection.currentRecorder) {
        var recorder = connection.currentRecorder;
        connection.currentRecorder = null;
        recorder.stopRecording(function() {
            if (!connection.isUpperUserLeft) return;

            videoPreview.src = URL.createObjectURL(recorder.getBlob());
            videoPreview.play();
        });
    }

    if (connection.currentRecorder) {
        connection.currentRecorder.stopRecording();
        connection.currentRecorder = null;
    }
};

var allRecordedBlobs = [];

function repeatedlyRecordStream(stream) {
    if (!enableRecordings) {
        return;
    }

    connection.currentRecorder = RecordRTC(stream, {
        type: 'video'
    });

    connection.currentRecorder.startRecording();

    setTimeout(function() {
        if (connection.isUpperUserLeft || !connection.currentRecorder) {
            return;
        }

        connection.currentRecorder.stopRecording(function() {
            allRecordedBlobs.push(connection.currentRecorder.getBlob());

            if (connection.isUpperUserLeft) {
                return;
            }

            connection.currentRecorder = null;
            repeatedlyRecordStream(stream);
        });
    }, 30 * 1000); // 30-seconds
};

function disableInputButtons() {
    document.getElementById('open-or-join').disabled = true;
    document.getElementById('broadcast-id').disabled = true;
}


/*
if (broadcastId && broadcastId.length) {
    document.getElementById('broadcast-id').value = broadcastId;
    localStorage.setItem(connection.socketMessageEvent, broadcastId);

    // auto-join-room
    (function reCheckRoomPresence() {
        connection.checkPresence(broadcastId, function(isRoomExists) {
            if (isRoomExists) {
                document.getElementById('open-or-join').onclick();
                return;
            }

            setTimeout(reCheckRoomPresence, 5000);
        });
    })();

    disableInputButtons();
}
*/
// below section detects how many users are viewing your broadcast

connection.onNumberOfBroadcastViewersUpdated = function(event) {
    if (!connection.isInitiator) return;

    document.getElementById('broadcast-viewers-counter').innerHTML = '시청자: <b>' + event.numberOfBroadcastViewers + '</b>';
};


//자동연결
setTimeout(function(){           
	//	console.log("join Room");
	  var broadcastId = $("#roomId").val();

	    connection.session = {
	        audio: true,
	        video: true,
	       // screen:true,
	        oneway: true
	    };

	    var socket = connection.getSocket();
		console.log(socket);
		
		try{
			
	    socket.emit('check-broadcast-presence', broadcastId, function(isBroadcastExists) {
	        if (!isBroadcastExists) {
	            // the first person (i.e. real-broadcaster) MUST set his user-id
	            connection.userid = broadcastId;
	        }

	        console.log('check-broadcast-presence', broadcastId, isBroadcastExists);

	        socket.emit('join-broadcast', {
	            broadcastId: broadcastId,
	            userid: connection.userid,
	            typeOfStreams: connection.session
	        });
	    });
	
		}catch (e) {
			console.log(e);
		}
	
},2000);

//=================================채팅========================================================
//채팅 서버연결

var chatSocket=io.connect('https://192.168.0.21:433/chat');
	
	//chatSocket.join($("#roomId").val());

	chatSocket.on("success-connect",function(data){
		console.log(data)
		chatSocket.emit("initUserInfo",{nickname:$("#nickname").val(),
											roomId:$("#roomId").val()});
		chatSocket.emit("infoTest");
	});
	
	chatSocket.on("receiveChatMessage",function(data){
		//alert(data.nickname+":"+data.message);
		writeChatOutput(data.nickname+":"+data.message);	
	});

	//채팅입력이벤트
	$(".chat-input").on("keyup",function(event){
		if(event.keyCode!=13){
			return;
		}
		var message=$(this).val();
		chatSocket.emit("sendChatMessage",message);
		writeChatOutput("자신:"+message);
		$(this).val("");
	});
	
	function writeChatOutput(message){
		var outObj=$("<p>"+message+"</p>")
		$(".chat-output").append(outObj);
	}
	

 


</script>

</body>
</html>
