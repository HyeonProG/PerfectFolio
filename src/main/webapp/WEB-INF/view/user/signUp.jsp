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

<body class="body--bg">
	<section class="signup--wrap">

		<div class="sign--title">
			<h2>회원가입</h2>
			<p>퍼펙트한 개발자 여정에 함께 해주세요.</p>
		</div>

		<div class="sigup--form">
			<form action="/user/sign-up" method="post">

				<div class="form-group">
					<label for="username">이름 </label> <input type="text"
						class="form-control" id="username" placeholder="이름을 입력하세요."
						name="username" required>
				</div>

				<div class="form-group">
					<label for="userNickname">닉네임</label><span>(선택)</span> <input
						type="text" class="form-control" id="userNickname"
						placeholder="별명을 입력하세요." name="userNickname">
				</div>

				<div class="form-group">
					<label for="userId">아이디</label> <input type="text"
						class="form-control" id="userId" placeholder="아이디를 입력하세요."
						name="userId" required>
					<button type="button" class="check--btn" id="checkId">중복
						확인</button>
				</div>

				<div class="form-group">
					<label for="userPassword">비밀번호</label> <input type="password"
						class="form-control" id="userPassword" placeholder="비밀번호를 입력하세요."
						name="userPassword" oninput="pwCheck()" minlength="8" maxlength="20" required>
					<p class="pw--info">
						8자 이상 20자 이하 입력 (공백 제외) <br>영문/숫자/특수문자(!@#$%^&*)포함
					</p>
				</div>

				<div class="form-group">
					<label for="passwordCheck">비밀번호 확인 <span id="pwConfirm"></span></label> <input type="password"
						class="form-control" id="passwordCheck"
						placeholder="비밀번호를 한 번 더 입력하세요." name="passwordCheck"
						oninput="pwCheck()" minlength="8" maxlength="20" required>
				</div>

				<!-- 이메일 입력란 -->
				<div class="form-group">
					<label for="userEmail">이메일</label> <input type="email"
						class="form-control" id="userEmail"
						placeholder="example@folio.com" name="userEmail" value="" required>
				</div>

				<!-- 이메일 인증코드 발송 -->
				<div class="form-group">
					<button type="button" class="check--btn" id="emailCode">발송</button>
					<button type="button" class="check--btn" id="checkValidate"
						disabled="disabled" style="cursor: pointer;">인증 확인</button>
				</div>

				<div class="form-group">
					<label for="userTel">전화번호</label> <input type="tel"
						class="form-control" id="userTel" maxlength="13"
						oninput="autoHyphen(this)" placeholder="전화번호를 입력해주세요."
						name="userTel">
				</div>

				<div class="form-group">
					<label for="userBirth">생년월일</label> <input type="date"
						class="form-control" id="userBirth" placeholder="생년월일을 입력하세요."
						name="userBirth">
				</div>

				<div class="gender--wrap">
					<p>성별</p>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" class="custom-control-input" id="male"
							name="userGender" value="남성"> <label
							class="custom-control-label" for="male">남성</label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">

						<input type="radio" class="custom-control-input" id="female"
							name="userGender" value="여성"> <label
							class="custom-control-label" for="female">여성</label>
					</div>
				</div>

				<div class="form-group">
					<label>프로필 이미지</label> <input type="file"
						class="form-control-file border" name="mFile">
				</div>

				<div class="maintain--check">
					<input type="checkbox" id="checkMaintain" checked required>
					<label for="checkMaintain">회원가입 시, 퍼펙트폴리오에서 제공하는 모든 서비스를
						이용하실 수 있으며,<br> <span><a href="#">이용약관</a></span>및 <span><a
							href="#">개인정보처리 방침</a></span>에 동의하는 것으로 간주합니다.
					</label>
				</div>

				<input type="hidden" id="userSocialType" name="userSocialType"
					value="local">

				<button type="submit" id="signUp" class="sign--btn">가입하기</button>

			</form>
		</div>

		<div class="social--wrap">
			<p>소셜 연동 회원가입</p>
			<div class="social--btn--wrap">
				<a
					href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=${kakaoRestApiKey}&redirect_uri=${kakaoRedirectUri}">
					<img alt="카카오 로그인 버튼" class="social--btn"
					src="/images/kakao_login_medium_narrow.png">
				</a> <a
					href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=${naverClientId}&state=${state}&redirect_uri=${naverRedirectUri}">
					<img alt="네이버 로그인 버튼" class="social--btn"
					src="/images/btnG_완성형.png">
				</a> <a
					href="https://accounts.google.com/o/oauth2/v2/auth?client_id=${googleClientId}&redirect_uri=${googleRedirectUri}&response_type=code&scope=email profile&access_type=offline">
					<img alt="구글 소셜 로그인 이미지" class="social--btn"
					src="/images/googleLogIn.png">
				</a>
			</div>
		</div>
	</section>


<!-- script -->
	<script>
	// '발송' 버튼을 클릭하면 실행됩니다.
const socialType = document.getElementById('userSocialType');
console.log('Social Type : ' + socialType);
const UUID = document.getElementById('checkCode');
console.log('UUID Value : ' + UUID);

$("#emailCode").on('click', function () {


    const email = document.getElementById('userEmail').value;
    console.log('Email : ' + email);

    fetch('http://localhost:8080/send-mail/email?email=' + email)
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
			// let username = document.getElementById('username').value;
			// console.log(data.message.toString());
			// username.innerText = data.message.toString();
			const sendBtn = document.getElementById('emailCode');
			const checkValidate = document.getElementById('checkValidate');
			sendBtn.disabled = true;
			checkValidate.disabled = false;
		})
        .catch(error => {
            console.log('Error:', error);
         	// 에러 메시지를 alert으로 표시
            alert(error.message);
        });
});

// '중복 확인' 버튼을 클릭하면 실행됩니다.
$("#checkId").on('click', function() {
	const userId = document.getElementById('userId').value;
	console.log('userId : ', userId);

	fetch(`http://localhost:8080/user/checkId?userId=` + userId)
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


$("#checkValidate").on('click', function () {

    fetch('http://localhost:8080/send-mail/checkValidate')
    .then(response => {
		if (!response.ok) {
			return response.json().then(data => {
				throw new Error(data.message || '알 수 없는 에러가 발생했습니다.');
			});
		}
		return response.json();  // 응답을 JSON 형식으로 변환
		})
        .then(data => {
            // 서버로부터 받은 응답 데이터를 처리
            console.log('Success:', data);
         	// 서버에서 보낸 메시지를 alert으로 표시
            alert(data.message);
			const signUpBtn = document.getElementById('signUp');
			const emailInput = document.getElementById('userEmail');
			const checkValidateBtn = document.getElementById('checkValidate');

			signUpBtn.disabled = false;
			checkValidateBtn.disabled = true;
			emailInput.readOnly = true;

        })
        .catch(error => {
            console.log('Error:', error);
         	// 에러 메시지를 alert으로 표시
            alert(error.message);
        });
});
const autoHyphen = (target) => {
	target.value = target.value
			.replace(/[^0-9]/g, '')
			.replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
}

// Add the following code if you want the name of the file appear on select
$(".custom-file-input").on("change", function() {
  let fileName = $(this).val().split("\\").pop();
  $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
});

//비밀번호 일치 실시간 확인
function pwCheck(){
    if($('#userPassword').val() === $('#passwordCheck').val()){
        $('#pwConfirm').text('비밀번호 일치').css('color', 'green')
    }else{
        $('#pwConfirm').text('비밀번호 불일치').css('color', 'red')
    }
}
</script>
</body>
</html>