<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<style>
body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
	background-color: #f2f2f2;
}

.container {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	text-align: center;
	padding: 20px;
	margin-top: 100px;
	text-align: center;
	justify-content: center;
}

.container--main {
	justify-content: center;
	text-align: center;
	padding-top: 100px;
}

h1 {
	display: flex;
	font-size: 24px;
	justify-content: center;
	color: #333;
	margin-bottom: 40px;
}

.auth-options {
	display: flex;
	justify-content: center;
	gap: 40px;
}

.auth-option a {
	text-decoration: none;
	color: #333;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.auth-option span {
	font-size: 16px;
	font-weight: bold;
}

.form-control {
	margin-right: 10px;
}
</style>
</head>
<body>
	<div class="container--main">
		<h1>이메일을 입력해주세요</h1>
		<div class="container">
			<div class="form-group">
				<label for="userEmail">이메일</label> <input type="email"
					class="form-control" id="userEmail" placeholder="example@folio.com"
					name="userEmail" required>
			</div>

			<!-- 이메일 인증코드 발송 -->
			<div class="form-group">
				<button type="button" class="form-control" id="emailCode">발송</button>
			</div>
		</div>
	</div>
	<script>
    $("#emailCode").on('click', function () {


        const email = document.getElementById('userEmail').value;
        console.log('Email : ' + email);

        fetch('http://localhost:8080/send-mail/findUserIdByEmail?email=' + email)
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