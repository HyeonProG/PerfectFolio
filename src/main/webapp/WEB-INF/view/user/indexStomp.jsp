<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
    <title>WebSocket Example</title>
    <!-- jQuery JavaScript library -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>



</head>
<body>
<div id="main-content" class="container">
    <div class="row">
        <div class="col-md-6">
            <form class="form-inline">
                <div class="form-group">
                    <label for="connect">웹소켓 연결:</label>
                    <button id="connect" class="btn btn-default" type="button">연결</button>
                    <button id="disconnect" class="btn btn-default" type="button" disabled="disabled">해제</button>
                </div>
            </form>
        </div>
        <div class="col-md-6">
            <form class="form-inline">
                <div class="form-group">
                    <label for="msg">문의사항</label>
                    <input type="text" id="msg" class="form-control" placeholder="내용을 입력하세요....">
                </div>
                <button id="send" class="btn btn-default" disabled type="button">보내기</button>
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table id="conversation" class="table table-striped">
                <thead>
                <tr>
                    <th>메세지</th>
                </tr>
                </thead>
                <tbody id="communicate">
                </tbody>
            </table>
        </div>
    </div>
</div>
<!-- Include SockJS JavaScript library -->
<script src="/js/sockjs.min.js"></script>

<!-- Include STOMP JavaScript library (correct path) -->
<script src="/js/stomp.umd.min.js"></script>
<script>
    console.log(window.stompJs);
    var stompClient = null;

    function setConnected(connected) {
        $("#connect").prop("disabled", connected);
        $("#disconnect").prop("disabled", !connected);
        $("#send").prop("disabled", !connected);
        if (connected) {
            $("#conversation").show();
        } else {
            $("#conversation").hide();
        }
        $("#msg").html("");
    }

    function connect() {
        var socket = new SockJS('/ws');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, function (frame) {
            setConnected(true);
            console.log('Connected: ' + frame);
            stompClient.subscribe('/topic/public', function (message) {
                showMessage("받은 메시지: " + message.body);
            });
        }, function (error) {
            console.error('Error connecting: ' + error);
        });
    }

    function disconnect() {
        if (stompClient !== null) {
            stompClient.disconnect();
        }
        setConnected(false);
        console.log("Disconnected");
    }

    function sendMessage() {
        let message = $("#msg").val();
        showMessage("보낸 메시지: " + message);
        stompClient.send("/app/sendMessage", {}, JSON.stringify(message));
    }

    function showMessage(message) {
        $("#communicate").append("<tr><td>" + message + "</td></tr>");
    }

    $(function () {
        $("form").on('submit', function (e) {
            e.preventDefault();
        });
        $("#connect").click(function() { connect(); });
        $("#disconnect").click(function() { disconnect(); });
        $("#send").click(function() { sendMessage(); });
    });
</script>
</body>
<%@ include file="/WEB-INF/view/layout/darkFooter.jsp"%>

</html>
