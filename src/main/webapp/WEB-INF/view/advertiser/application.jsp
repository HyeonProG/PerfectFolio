<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/myInfoAd.css">
<style>
.user--section{
	width:100vh;
}
</style>
<main class="user--section">
	<!-- 왼쪽 사이드바 -->
	<aside class="personal--bar">
		<div class="bar--items">
			<p>내 정보</p>
			<a href="/advertiser/my-info" data-feather="users"><span
				data-feather="users"></span>계정관리</a>
		</div>
		<div class="bar--items">
			<p>광고</p>
			<a href="/advertiser/application" class="bar--selected"><span
				data-feather="file"></span>신청하기</a> <a
				href="/advertiser/application-list"><span data-feather="file"></span>신청내역</a>
			<a href="/advertiser/active-list"><span
				data-feather="shopping-cart"></span>게시 내역</a> <a
				href="/advertiser/payment"><span data-feather="bar-chart-2"></span>충전하기</a>
				<a href="/advertiser/requesting-refund">환불 요청</a>
		</div>
		<div class="bar--items">
			<p>탈퇴</p>
			<a href="/advertiser/withdraw"><span
				data-feather="message-square"></span>탈퇴하기</a>
		</div>
	</aside>

	<!-- 메인 컨텐츠 영역 -->
	<section>
		<div class="personal--wrap">
			<div>
				<h2>광고</h2>
				<p>신청하기</p>
			</div>

			<div class="inner--personal">
				<div class="user--info">
				<!-- 신청폼 -->
					<form id="uploadForm" action="/advertiser/application"
						method="post" enctype="multipart/form-data">
						<div class="form-group">
							<input type="hidden" class="form-control" id="userId"
								name="userId" value="${userId}">
						</div>
						<div class="form-group">
							<label for="title">제목</label> <input type="text"
								class="form-control" placeholder="제목을 입력하세요." id="title"
								name="title" required>
						</div>
						<div class="form-group">
							<label for="content">내용</label> <input type="text"
								class="form-control" placeholder="내용을 입력하세요." id="content"
								name="content" required>
						</div>
						<div class="form-group">
							<label for="site">주소</label> <input type="text"
								class="form-control" placeholder="ex) https://www.abc.com"
								id="site" name="site" required>
						</div>
						<div class="form-group">
							<label for="file">파일 업로드</label>
							<p>이미지 양식 : .jpg, .jpeg, .png</p>
							<p>5 : 1 비율로 올려주세요.</p>
						</div>
						<div class="custom-file">
							<input type="file" class="custom-file-input" id="customFile"
								name="mFile" accept=".jpg,.jpeg,.png"
								onchange="previewImage(event)"> <label
								class="custom-file-label" for="customFile">파일 선택</label>
						</div>
						<div class="form-group">
							<!-- 미리보기가 보여질 부분 -->
							<img id="preview" src="#" alt="이미지 미리보기"
								style="display: none; max-width: 300px; margin-top: 20px;">
						</div>
						<div class="inline--btn--wrap">
							<button type="submit" class="info--btn">신청하기</button>
							</div>
						<div id="message" style="color: red; margin-top: 10px;"></div>
					</form>

				</div>
			</div>
		</div>
	</section>

</main>

<!-- 이미지 미리보기 및 크기 검증 스크립트 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	// 파일 이름 표시
	$(".custom-file-input").on(
			"change",
			function() {
				let fileName = $(this).val().split("\\").pop();
				$(this).siblings(".custom-file-label").addClass("selected")
						.html(fileName);
			});

	// 이미지 미리보기 및 크기 확인
	function previewImage(event) {
		let file = event.target.files[0]; // 선택된 파일
		let reader = new FileReader(); // FileReader 객체 생성

		// 파일 타입 검증
		const allowedExtensions = /(\.jpg|\.jpeg|\.png)$/i;
		if (!allowedExtensions.exec(file.name)) {
			document.getElementById('message').innerText = "허용되지 않는 파일 형식입니다. .jpg, .jpeg, .png 파일만 업로드할 수 있습니다.";
			event.target.value = ''; // 선택된 파일 초기화
			document.getElementById('preview').style.display = 'none'; // 미리보기 숨김
			return;
		}

		reader.onload = function(e) {
			let preview = document.getElementById('preview');
			preview.src = e.target.result; // 파일 데이터를 이미지 미리보기로 설정
			preview.style.display = 'block'; // 미리보기 표시
		};

		if (file) {
			reader.readAsDataURL(file); // 파일을 읽어서 Data URL로 변환
		}
	}

	// 폼 제출 처리
	$("#uploadForm").on("submit", function(e) {
		e.preventDefault(); // 기본 폼 제출 방지

		let formData = new FormData(this); // 폼 데이터 수집

		$.ajax({
			url : $(this).attr("action"),
			type : "POST",
			data : formData,
			contentType : false,
			processData : false,
			success : function(response) {
				alert(response); // 성공 메시지 표시
				window.location.href = "/advertiser/application-list"; // 리스트 페이지로 리다이렉트
			},
			error : function(xhr) {
				let errorMessage = xhr.responseText || "서버 오류가 발생했습니다.";
				document.getElementById('message').innerText = errorMessage; // 오류 메시지 표시
			}
		});
	});
</script>

<%@ include file="/WEB-INF/view/layout/lightFooter.jsp"%>