<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/view/layout/darkHeader.jsp" %>
<style>
    body {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
        background-color: #1e1e1e; /* 어두운 배경 */
        color: #f5f5f5; /* 밝은 글씨 색 */
    }

    .container {
        text-align: center;
        padding: 20px;
        margin-top: 100px;
    }

    h1 {
        font-size: 24px;
        color: #ffffff; /* 제목 글씨 색상 */
        margin-bottom: 40px;
    }

    .form-group {
        width: 550px;
        height: 50px;
        padding-left: 100px;
        position: relative;
        display: flex;
        justify-content: center;
        align-content: center;
        align-items: center;
    }

    .form-group.input {
        width: 80%;
        border-radius: 15px;
    }

    .form-group.input::placeholder {
        color: #999; /* placeholder 색상 */
    }

    .form-group.button {
        width: 20%;
        position: absolute;
        top: 5px;
        bottom: 5px;
        right: 5px;
        border-radius: 15px;
    }

    button:hover {
        background-color: #bcbcbc; /* 호버 시 버튼 색상 */
    }
</style>

<body>
<div class="container">
    <h1>이메일을 입력해주세요</h1>
    <div class="form-group">
        <input type="email" class="form-control" id="userEmail"
               placeholder="example@folio.com" name="userEmail" value="qkrakdth@gmail.com" required>
        <button type="button" class="form-control" id="emailCode">발송</button>
    </div>
</div>
<script>
    $("#emailCode").on('click', function () {


        const email = document.getElementById('userEmail').value;
        console.log('Email : ' + email);

        fetch('http://localhost:8080/send-mail/findPasswordByEmail?email=' + email)
            .then(response => {
                if (!response.ok) {
                    return response.json().then(data => {
                        throw new Error(data.message || '알 수 없는 에러가 발생했습니다.');
                    });
                }
                // 응답을 JSON 형식으로 변환
                return response.json();
            })
            .then(data => {
                // 서버로부터 받은 응답 데이터를 처리
                console.log('Success:', data);
                // EmailController에서 보낸 response를 alert으로 표시
                alert(data.message);
            })
            .catch(error => {
                console.log('Error:', error);
                // 에러 메시지를 alert으로 표시
                alert(error.message);
            });
    });
</script>
</body>
</html>