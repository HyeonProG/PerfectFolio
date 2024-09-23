<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>

<div class="container--main" style="background-color: white">
<h2>카카오 회원가입시 추가 정보 필요</h2>

	<div class="container">
		<form action="/user/addKakaoUserInfo" method="post">
			<div class="form-group">
				<label for="username">이름 <span class="necessary--sign">&#42;</span>
				</label> <input type="text" class="form-control" id="username"
					placeholder="이름을 입력하세요." name="username" required>
			</div>

			<!-- 이메일 입력란 -->
			<div class="form-group">
				<label for="userEmail">이메일 <span class="necessary--sign">&#42;</span></label>
				<input type="email" class="form-control" id="userEmail"
					placeholder="example@folio.com" name="userEmail" ${isReadOnly ? 'readonly' : ''} required>
			</div>

			<!-- 이메일 인증코드 발송 -->
			<div class="form-group">
				<button type="button" class="form-control" id="emailCode">발송</button>
				<button type="button" class="form-control" id="checkValidate">인증
					확인</button>
			</div>

			<div class="form-group">
				<label for="userBirth">생년월일 <span class="necessary--sign">&#42;</span></label>
				<input type="date" class="form-control" id="userBirth"
					placeholder="생년월일을 입력하세요." name="userBirth">
			</div>

			<p>
				성별
			</p>
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

			<div class="form-group">
				<label for="userTel">전화번호<span class="necessary--sign">&#42;</span></label> <input type="tel"
					class="form-control" id="userTel" placeholder="전화번호를 입력해주세요."
					pattern="[0-9]{3}-[0-9]{3,4}-[0-9]{4}"
					title="000-0000-0000 형식으로 입력해 주세요." name="userTel">
			</div>
			<div class="form-group form-check">
				<label class="form-check-label"> <input
					class="form-check-input" type="checkbox" name="remember">
					Remember me
				</label>
			</div>
			<button type="submit" class="btn btn-primary">가입하기</button>
		</form>
	</div>
</div>


<script>
//'발송' 버튼을 클릭하면 실행됩니다.
const socialType = document.getElementById('userSocialType');
console.log('Social Type : ' + socialType);
const UUID = document.getElementById('checkCode');
console.log('UUID Value : ' + UUID);

$("#emailCode").on('click', function () {


    const email = document.getElementById('userEmail').value;
    console.log('Email : ' + email);

    fetch('http://perfecfolio.jinnymo.com/send-mail/email?email=' + email)
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
			let username = document.getElementById('username').value;
			console.log(data.message.toString());
			username.innerText = data.message.toString();
		})
        .catch(error => {
            console.log('Error:', error);
         	// 에러 메시지를 alert으로 표시
            alert(error.message);
        });
});

//'중복 확인' 버튼을 클릭하면 실행됩니다.
$("#checkId").on('click', function() {
	const userId = document.getElementById('userId').value;
	console.log('userId : ', userId);

	fetch(`http://perfecfolio.jinnymo.com/user/checkId?userId=` + userId)
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
</script>

<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/layout/darkFooter.jsp"%>