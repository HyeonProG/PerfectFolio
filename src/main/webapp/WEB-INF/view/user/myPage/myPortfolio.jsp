<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/myInfo.css">


<section class="user--section">
	<!-- side bar -->
	<aside class="personal--bar">
		<div class="bar--items">
			<p>내 정보</p>
			<a href="/user/my-info">계정관리</a>
			<a href="/user/my-subscribe">구독내역</a>
			<a href="/user/mySkillPage">스킬스택 관리</a>


		</div>
		<div class="bar--items">
			<p>포트폴리오</p>
			<a href="/user/my-portfolio" class="bar--selected">포트폴리오</a>
		</div>
	</aside>

	<!-- content -->
	<div class="personal--wrap">
		<div>
			<h2>포트폴리오</h2>
		</div>

		<div class="inner--personal">
			<div class="user--info">

				<table>
					<tr>
						<th>나의 포트폴리오</th>
						<td><c:choose>
								<c:when test="${portfolio != null}">
									<a href="/portfolio/download/${portfolio.uploadFileName}">${portfolio.originFileName}
										<i class="fa-solid fa-file-arrow-down"></i>
									</a>
									<p>현재 포트폴리오는 "${portfolio.status}"상태입니다.</p>
								</c:when>
								<c:otherwise>포트폴리오를 업로드 해보세요!</c:otherwise>
							</c:choose></td>
					</tr>
				</table>

				<form id="uploadForm" action="/portfolio/upload" method="post"
					enctype="multipart/form-data">
					<div class="custom-file">
						<input type="file" class="custom-file-input" id="customFile"
							name="mFile" accept=".pdf" onchange="previewImage(event)">
						<label class="custom-file-label" for="customFile">파일 선택 (.pdf)</label>
					</div>
					<input type="hidden" value="${principal.id}" name="userId">
					<div class="inline--btn--wrap">
						<button class="info--btn">업로드하기</button>
					</div>
				</form>
			</div>
		</div>
		<!-- Ad -->
		<div>
			<a id="imageLink" href="#"> <img id="randomImage"
				class="random-image" alt="" />
			</a>
		</div>
	</div>
</section>

<!-- script -->
<script>
	// 파일 이름 표시
	$(".custom-file-input").on(
			"change",
			function() {
				let fileName = $(this).val().split("\\").pop();
				$(this).siblings(".custom-file-label").addClass("selected")
						.html(fileName);
			});
</script>
<!-- 광고 이미지 -->
<script>
    function fetchRandomImage() {
        fetch('http:perfecfolio.jinnymo.com/advertiser/random-image')
            .then(response => response.json())
            .then(data => {
            	console.log("서버 응답 데이터: " + data);
                if (data.imageUrl && data.site && data.uploadFileName) {
                    // 이미지와 링크 업데이트
                    document.getElementById('randomImage').src = data.imageUrl;
                    document.getElementById('imageLink').href = data.site;

                    // 이미지 클릭 시 클릭 카운트를 증가시키는 함수 등록
                    document.getElementById('imageLink').onclick = function () {
                        incrementClickCount(data.imageUrl);
                        console.log('Image clicked:', data.imageUrl);
                    };
                } else {
                    console.error('데이터 오류:', data);
                }
            })
            .catch(error => console.error('오류 발생:', error));
    }

    function incrementClickCount(imageUrl) {
        fetch('http:perfecfolio.jinnymo.com/advertiser/increment-click', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ imageUrl: imageUrl })
        })
        .then(response => {
            if (!response.ok) {
                console.error('클릭 카운트 증가 실패');
            }
        })
        .catch(error => console.error('오류 발생:', error));
    }

    // 페이지 로드 시 이미지 요청
    document.addEventListener('DOMContentLoaded', fetchRandomImage);
</script>

<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightFooter.jsp"%>