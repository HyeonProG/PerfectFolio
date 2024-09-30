<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Perfectfolio</title>

<!--favicon-->
<link rel="icon" type="image/png" sizes="32x32" href="#">

<!-- css -->
<link rel="stylesheet" href="/css/common2.css">
<link rel="stylesheet" href="/css/signUp.css">

<!-- Bootstrap 4 + jquery-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
	<div class="container">
		<h2>광고주 전용 회원가입</h2>
		<p>퍼펙트폴리오에 광고를 원하신다면 회원가입을 해주세요.</p>
		<form action="/advertiser/sign-up" method="post">
			<div class="form-group">
				<label for="username">이름</label> <input type="text"
					class="form-control" id="username" placeholder="이름을 입력하세요."
					name="username" required>
			</div>
			<div class="form-group">
				<label for="userId">아이디</label> <input type="text"
					class="form-control" id="userId" placeholder="아이디를 입력하세요."
					name="userId" required>
			</div>
			<div class="d-flex justify-content-center">
				<button type="button" class="check--btn" id="checkDuplicateId">중복
					확인</button>
			</div>
			<div class="form-group">
				<label for="password">비밀번호</label>
				<p class="pw--info">
					8자 이상 20자 이하 입력 (공백 제외) <br>영문/숫자/특수문자(!@#$%^&*)포함
				</p>
				<input type="password" class="form-control" id="password"
					placeholder="비밀번호를 입력하세요" name="password" oninput="pwCheck()" minlength="8"
					maxlength="20" required>
			</div>
			<div class="form-group">
				<label for="passwordCheck">비밀번호 확인 <span id="pwConfirm"></span></label>
				<input type="password" class="form-control" id="passwordCheck"
					placeholder="비밀번호를 한 번 더 입력하세요." name="passwordCheck"
					oninput="pwCheck()" minlength="8" maxlength="20" required>
			</div>

			<div class="form-group">
				<label for="userTel">전화번호</label> <input type="tel"
					class="form-control" id="userTel"
					pattern="[0-9]{3}-[0-9]{3,4}-[0-9]{4}"
					title="000-0000-0000 형식으로 입력해 주세요." placeholder="전화번호를 입력해주세요."
					name="userTel">
			</div>
			<div>
				<button type="submit" id="signUp" class="sign--btn">가입하기</button>
			</div>
		</form>
	</div>
	<script type="text/javascript">
	// '중복 확인' 버튼을 클릭하면 실행됩니다.
	$("#checkDuplicateId").on('click', function() {
		const userId = document.getElementById('userId').value;
		console.log('userId : ', userId);

		fetch(`http://localhost:8080/advertiser/checkId?userId=` + userId)
				.then(response => {
					if (!response.ok) {
						return response.json().then(data => {
							throw new Error(data.message || '알 수 없는 에러가 발생했습니다.');
						});
					}
					return response.json();  // 응답을 JSON 형식으로 변환
				})
				.then(data => {
					console.log('Success:', data);
					alert(data.message);
					document.getElementById('userId').readOnly = true;
				})
				.catch(error => {
					console.log('Error:', error);
					alert(error.message);
				});
	});
	
	//비밀번호 일치 실시간 확인
	function pwCheck(){
	    if($('#password').val() === $('#passwordCheck').val()){
	        $('#pwConfirm').text('비밀번호 일치').css('color', 'green')
	    }else{
	        $('#pwConfirm').text('비밀번호 불일치').css('color', 'red')
	    }
	}
	</script>
</body>
</html>