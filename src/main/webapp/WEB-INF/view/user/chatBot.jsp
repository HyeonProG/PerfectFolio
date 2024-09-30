<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Chat</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #000000;
            color: #000000;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            overflow: hidden; /* 전체 페이지에 스크롤바가 나타나지 않도록 함 */
        }
        h1 {
            margin: 20px 0;
            color: #e0e0e0;
        }
        .chat-box {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            justify-content: flex-start;
            padding: 15px;
            border: none;
            width: 100%;
            max-width: 1000px;
            height: 60vh; /* 화면의 60%를 차지하도록 설정 */
            overflow-y: auto;
            border-radius: 8px;
            background-color: #000000;
            margin-bottom: 20px;
        }
        .chat-message {
            display: flex;
            max-width: 100%;
            padding: 8px;
            margin: 5px 0;
            border-radius: 5px;
        }
        .chat-message.bot {
            color: rgb(255, 255, 255);
            justify-content: flex-start; /* 좌측 정렬 */
            align-self: flex-start; /* 상대방 메시지는 좌측에 배치 */
        }
        .chat-message.user {
            background-color: #4a4a4a;
            color: #ffffff;
            justify-content: flex-end; /* 우측 정렬 */
            align-self: flex-end; /* 사용자 메시지는 우측에 배치 */
        }
        .input-container {
            display: flex;
            align-items: center;
            width: 100%;
            max-width: 1000px;
        }
        input[type="text"] {
            flex: 1; /* 입력 필드가 가능한 많은 공간을 차지하도록 설정 */
            padding: 10px;
            margin-right: 10px;
            border: none; /* 구분선을 완전히 제거 */
            border-radius: 5px;
            font-size: 14px;
            outline: none;
            background-color: #2e2e2e;
            color: #ffffff;
        }
        button {
            padding: 10px 15px;
            background-color: #61c556;
            color: #ffffff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        button:hover {
            background-color: rgba(97, 197, 86, 0.67);
        }
    </style>
    <script>
        let webSocket;

        function initWebSocket() {
            webSocket = new WebSocket('ws://http://localhost:8080/ws/chat');

            webSocket.onmessage = function(event) {
                // JSON 형태의 메시지 처리
                try {
                    let data = JSON.parse(event.data);
                    let chatContent = '';

                    // JSON 구조에 맞게 데이터를 추출하여 HTML에 추가
                    console.log(data);

                    chatContent += "<div class='chat-message bot'>" + "NamBa : " + data.bubbles[0].data.description + "</div>";
                    document.querySelector(".chat-box").innerHTML += chatContent;
                    document.querySelector(".chat-box").scrollTop = document.querySelector(".chat-box").scrollHeight; // 자동 스크롤
                } catch (e) {
                    console.error('파싱 오류 :', event.data);
                }
            };

            webSocket.onclose = function(event) {
                console.error('WebSocket closed:', event);
                initWebSocket(); // Reconnect
            };

            webSocket.onerror = function(event) {
                console.error('WebSocket error:', event);
            };
        }

        window.onload = function() {
            initWebSocket();
        };
        document.addEventListener("DOMContentLoaded", function() {
            const messageInput = document.getElementById("message");
            if (messageInput) {
                messageInput.addEventListener("keyup", function(event) {
                    if (event.key === "Enter") { // 엔터 키가 눌렸을 때
                        console.log('Enter key pressed.');
                        sendMessage();
                    }
                });
            } else {
                console.error('Message input element not found.');
            }
        });
        function sendMessage() {
            const message = document.getElementById("message").value;
            if (message.trim() !== "") {
                webSocket.send(message);

                // 사용자 메시지를 화면에 표시
                let userMessageHTML = "<div class='chat-message user'>" + message + "</div>";
                document.querySelector(".chat-box").innerHTML += userMessageHTML;
                document.getElementById("message").value = ''; // 입력 창 초기화
                document.querySelector(".chat-box").scrollTop = document.querySelector(".chat-box").scrollHeight; // 자동 스크롤
            }
        }

    </script>
</head>
<body>
<h1>Perfect Folio</h1>

<div class="chat-box">
    <!-- 채팅 내역 -->
</div>
<br>
<div class="input-container">
<input type="text" id="message" placeholder="메시지를 입력하세요." />
<button onclick="sendMessage()">Send</button>
</div>
</body>
</html>