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
			<h2>기업 회원가입</h2>
			<p>퍼펙트한 개발자 여정에 함께 해주세요.</p>
		</div>
		<div class="essential">
		 <a><span style="color: red;">*</span>은 필수 입력란입니다.</a>
		</div>
		<br>

		<div class="sigup--form">
			<form action="/user/sign-up" method="post">



				<div class="form-group">
					<label for="userTexId">사업자 번호<span style="color: red;">*</span></label>
					<input type="text" class="form-control" id="userTexId" placeholder="사업자 번호를 입력해주세요.(하이픈 '-' 제거 후 입력)" name="userTexId" maxlength="12" required>
				</div>
				<div class="form-group">
					<label for="CEOName1">대표자 성명 1<span style="color: red;">*</span></label>
					<input type="text" class="form-control" id="CEOName1" placeholder="대표자 성명1을 입력하세요." name="CEOName1" required>
				</div>
				<div class="form-group">
					<label for="CEOName2">대표자 성명 2</label>
					<input type="text" class="form-control" id="CEOName2" placeholder="대표자 성명2을 입력하세요." name="CEOName2" required>
				</div>
				<div class="form-group">
					<label for="startDay">개업 일자<span style="color: red;">*</span></label>
					<input type="text" class="form-control" id="startDay" placeholder="대표자 성명을 입력하세요." name="startDay" required>
				</div>
				<div class="form-group">
					<label for="Pronunciation">상호명</label>
					<input type="text" class="form-control" id="Pronunciation" placeholder="상호명을 입력하세요." name="Pronunciation">
				</div>
				<div class="form-group">
					<label for="corporateNumber">법인번호</label>
					<input type="text" class="form-control" id="corporateNumber" placeholder="법인번호를 입력하세요." name="corporateNumber">
				</div>
				<div class="form-group">
					<label for="BSector">주업태명</label>
					<input type="text" class="form-control" id="BSector" placeholder="주업태명을 입력하세요." name="BSector">
				</div>
				<div class="form-group">
					<label for="BType">주종목명</label>
					<input type="text" class="form-control" id="BType" placeholder="주종목명을 입력하세요." name="BType">
				</div>
				<div class="form-group">
					<label for="basicAddress">사업장 주소</label>
					<input type="text" id="basicAddress" readonly>
					<input type="text" id="detailAddress" placeholder="상세 주소">
					<input type="button" class="check--btn" onclick="execDaumPostcode()" value="주소 검색"><br>
				</div>


				<div class="form-group">
					<button type="button" class="validate--btn" id="validateBtn" name="validateBtn" onclick="sendValidate()">인증</button>
				</div>

				<div class="form-group">
					<label for="enterpriseId">아이디</label> <input type="text"
						class="form-control" id="enterpriseId" placeholder="아이디를 입력하세요."
						name="userId" required>
					<button type="button" class="check--btn" id="checkId">중복
						확인</button>
				</div>

				<div class="form-group">
					<label for="userPassword">비밀번호</label> <input type="password"
						class="form-control" id="userPassword"
						placeholder="비밀번호를 입력하세요." name="userPassword" oninput="pwCheck()"
						minlength="8" maxlength="20" required>
					<p class="pw--info">
						8자 이상 20자 이하 입력 (공백 제외) <br>영문/숫자/특수문자(!@#$%^&*)포함
					</p>
				</div>

				<div class="form-group">
					<label for="passwordCheck">비밀번호 확인 <span id="pwConfirm"></span></label> <input
						type="password" class="form-control" id="passwordCheck"
						placeholder="비밀번호를 한 번 더 입력하세요." name="passwordCheck"
						oninput="pwCheck()" minlength="8" maxlength="20" required>
					
				</div>

				<!-- 이메일 입력란 -->
				<div class="form-group">
					<label for="enterpriseEmail">이메일</label> <input type="email"
						class="form-control" id="enterpriseEmail"
						placeholder="example@folio.com" name="userEmail" value="" required>
				</div>

				<!-- 이메일 인증코드 발송 -->
				<div class="form-group">
					<button type="button" class="check--btn" id="emailCode">발송</button>
					<button type="button" class="check--btn" id="checkValidate"
						disabled="disabled" style="cursor: pointer;">인증 확인</button>
				</div>

				<div class="form-group">
					<label for="enterpriseTel">기업 연락처</label> <input type="tel"
						class="form-control" id="enterpriseTel" maxlength="13"
						oninput="autoHyphen(this)" placeholder="연락처를 입력해주세요."
						name="userTel">
				</div>

				<div class="form-group">
					<label for="userBirth">생년월일</label> <input type="date"
						class="form-control" id="userBirth" placeholder="생년월일을 입력하세요."
						name="userBirth">
				</div>

				<div class="form-group">
					<label>기업 로고 이미지</label> <input type="file"
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
					value="com">

				<button type="submit" id="signUp" class="sign--btn">가입하기</button>

			</form>
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

    fetch('/send-mail/email?email=' + email)
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

	fetch(`/user/checkId?userId=` + userId)
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

    fetch('/send-mail/checkValidate')
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

// 비밀번호 일치 실시간 확인
function pwCheck(){
    if($('#userPassword').val() === $('#passwordCheck').val()){
        $('#pwConfirm').text('비밀번호 일치').css('color', 'green')
    }else{
        $('#pwConfirm').text('비밀번호 불일치').css('color', 'red')
    }
}


function sendValidate() {
	const userTexId = document.getElementById('userTexId').value;
	const CEOName1 = document.getElementById('CEOName1').value;
	const CEOName2 = document.getElementById('CEOName2').value;
	const startDay = document.getElementById('startDay').value;
	const pronunciation = document.getElementById('Pronunciation').value;
	const corporateNumber = document.getElementById('corporateNumber').value;
	const BSector = document.getElementById('BSector').value;
	const BType = document.getElementById('BType').value;
	const basicAddress = document.getElementById('basicAddress').value;
	const detailAddress = document.getElementById('detailAddress').value;
	const BAddress= basicAddress + ' ' + detailAddress;
	console.log('BAddress', BAddress);
	const data = {
		"businesses": [
			{
				"b_no": userTexId,
				"start_dt": startDay,
				"p_nm": CEOName1,
				"p_nm2": CEOName2,
				"b_nm": pronunciation,
				"corp_no": corporateNumber,
				"b_sector": BSector,
				"b_type": BType,
				"b_adr": BAddress
			}
		]
	};

	fetch('http://api.odcloud.kr/api/nts-businessman/v1/validate?serviceKey=gYS%2FgRwwe7EVACU2CnFbsqAsKl%2FgzIC3Vf7AoMkcrLCBEwDrkJo%2B2V1ILEfSkrnvBUmc%2BEGTfnjlqmViLzpN8Q%3D%3D', { // serviceKey 값을 xxxxxx에 입력
		method: "POST",
		headers: {
			"Content-Type": "application/json",
			"Accept": "application/json"
		},
		body: JSON.stringify(data) // JSON 데이터를 문자열로 변환하여 전송
	})
			.then(response => response.json()) // 응답을 JSON으로 변환
			.then(result => {
				console.log(result); // 결과 출력
				alert(result.data[0].valid_msg);
			})
			.catch(error => {
				console.error('Error:', error); // 에러 발생 시 에러 내용 출력
			});
}
</script>
	<script
			src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3aea5e049cf7a27eae091e77ca0e1429&libraries=services"></script>
	<script>
		function execDaumPostcode() {
			new daum.Postcode({
				oncomplete: function(data) {
					var addr = data.address; // 최종 주소 변수
					// 주소 정보를 해당 필드에 넣는다.
					document.getElementById("basicAddress").value = addr;
					// 주소로 상세 정보를 검색
					geocoder.addressSearch(data.address, function(results, status) {
					});
				}
			}).open();
		}
	</script>
</body>
</html>