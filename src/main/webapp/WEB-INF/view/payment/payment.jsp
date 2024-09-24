<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/subscribe.css">
<!-- tosspayments js -->
<script src="https://js.tosspayments.com/v1"></script>

<div class="sub--banner">
	<h1>구독</h1>
</div>

<div class="container-fluid" style="text-align: center">

	<!-- tab menu -->
	<div class="tabMenu">
		<ul class="tabs d-flex justify-content-center">
			<li class="active tabBtn" id="#tab1">서비스 소개</li>
			<li class="tabBtn" id="#tab2">정기 구독</li>
		</ul>
	</div>

	<!-- service section -->

	<section class="tabPanel" id="tab1">
		<div class="">
			<div class="title--heading">
				<h1>따라잡을 수 없는 모집 공고 보유량</h1>
				<h3>원티드, 점핏, 잡코리아 등 구인구직 사이트에서 개발자 모집 공고 2000개를 수집합니다.</h3>
			</div>
			
		</div>
	</section>

	<!-- subscribe section -->
	<section class="tabPanel" id="tab2" style="display: none">
		<div class="title--heading">
			<h1>정기구독</h1>
			<p>정기 구독으로 포트폴리오를 꾸준히 관리해보세요.</p>
		</div>

		<!-- subscribe options -->
		<div class="item--wrap">

			<div class="plan">
				<div class="inner">
					<span class="pricing"> <span> 인기<small></small>
					</span>
					</span>
					<p class="title">Basic</p>
					<p class="info">퍼펙트폴리오 이용이 처음이신 분께 추천드리는 구독제입니다.</p>
					<ul class="features">
						<li><span class="icon"> <svg height="24" width="24"
									viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
							<path d="M0 0h24v24H0z" fill="none"></path>
							<path fill="currentColor"
										d="M10 15.172l9.192-9.193 1.415 1.414L10 18l-6.364-6.364 1.414-1.414z"></path>
						</svg>
						</span> <span><strong>5,900</strong>원</span></li>
						<li><span class="icon"> <svg height="24" width="24"
									viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
							<path d="M0 0h24v24H0z" fill="none"></path>
							<path fill="currentColor"
										d="M10 15.172l9.192-9.193 1.415 1.414L10 18l-6.364-6.364 1.414-1.414z"></path>
						</svg>
						</span> <span><strong>매달</strong> 정기결제</span></li>
						<li><span class="icon"> <svg height="24" width="24"
									viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
							<path d="M0 0h24v24H0z" fill="none"></path>
							<path fill="currentColor"
										d="M10 15.172l9.192-9.193 1.415 1.414L10 18l-6.364-6.364 1.414-1.414z"></path>
						</svg>
						</span> <span>매칭 정보 추가 <strong> 60%</strong> 제공
						</span></li>
					</ul>
					<div class="action">
						<c:choose>
							<c:when test="${principal != null }">
								<a class="button" href="#" onclick="basicPay()"> 구독하기 </a>
							</c:when>
							<c:otherwise>
								<a class="button" href="#" onclick="nessearySignIn()"> 구독하기
								</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>

			<div class="plan">
				<div class="inner">
					<span class="pricing"> <span> 추천 <small></small>
					</span>
					</span>
					<p class="title">Premium</p>
					<p class="info">적극적인 매칭을 원하시는 분께 추천드립니다.</p>
					<ul class="features">
						<li><span class="icon"> <svg height="24" width="24"
									viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
							<path d="M0 0h24v24H0z" fill="none"></path>
							<path fill="currentColor"
										d="M10 15.172l9.192-9.193 1.415 1.414L10 18l-6.364-6.364 1.414-1.414z"></path>
						</svg>
						</span> <span><strong>12,900</strong>원</span></li>
						<li><span class="icon"> <svg height="24" width="24"
									viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
							<path d="M0 0h24v24H0z" fill="none"></path>
							<path fill="currentColor"
										d="M10 15.172l9.192-9.193 1.415 1.414L10 18l-6.364-6.364 1.414-1.414z"></path>
						</svg>
						</span> <span><strong>매달</strong> 정기결제</span></li>
						<li><span class="icon"> <svg height="24" width="24"
									viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
							<path d="M0 0h24v24H0z" fill="none"></path>
							<path fill="currentColor"
										d="M10 15.172l9.192-9.193 1.415 1.414L10 18l-6.364-6.364 1.414-1.414z"></path>
						</svg>
						</span> <span>매칭 정보 추가 <strong> 100%</strong> 제공
						</span></li>
					</ul>
					<div class="action">
						<c:choose>
							<c:when test="${principal != null }">
								<a class="button" href="#" onclick="premiumPay()"> 구독하기 </a>
							</c:when>
							<c:otherwise>
								<a class="button" href="#" onclick="nessearySignIn()"> 구독하기
								</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>

		</div>

	</section>

</div>


<!-- Ad -->
<div>
	<a id="imageLink" href="#"> <img id="randomImage"
		class="random-image" alt="" />
	</a>
</div>

<script type="text/javascript">
//로그인 창
function nessearySignIn() {
	Swal.fire({
		  title: "로그인이 필요합니다.",
		  icon: "warning",
		  showLoaderOnConfirm: true,
		})
	};

// 베이직 결제창 호출
function basicPay(){
    	const clientKey = "test_ck_LlDJaYngro1K6KqdMdnG3ezGdRpX"; // 서버에서 전달받은 클라이언트 키
        const tossPayments = TossPayments(clientKey);
        const customerKey = Math.random().toString(36).substring(2, 12); // 고객 고유키를 서버로부터 받아옵니다.

        tossPayments.requestBillingAuth("카드", {
            customerKey : customerKey, // 서버에서 전달받은 고객 키
            successUrl: "/pay/success", // 성공 시 리디렉션 URL
            failUrl: "/pay/fail" // 실패 시 리디렉션 URL
        })
        .catch(function (error) {
if (error.code === "USER_CANCEL") {
  // 결제 고객이 결제창을 닫았을 때 에러 처리
} else if (error.code === "INVALID_CARD_COMPANY") {
  // 유효하지 않은 카드 코드에 대한 에러 처리
}
});
};

//프리미엄 결제창 호출
function premiumPay(){
    	const clientKey = "test_ck_LlDJaYngro1K6KqdMdnG3ezGdRpX"; // 서버에서 전달받은 클라이언트 키
        const tossPayments = TossPayments(clientKey);
        const customerKey = Math.random().toString(36).substring(2, 12); // 고객 고유키를 서버로부터 받아옵니다.

        tossPayments.requestBillingAuth("카드", {
            customerKey : customerKey, // 서버에서 전달받은 고객 키
            successUrl: "/pay/success2", // 성공 시 리디렉션 URL
            failUrl: "/pay/fail" // 실패 시 리디렉션 URL
        })
        .catch(function (error) {
if (error.code === "USER_CANCEL") {
  // 결제 고객이 결제창을 닫았을 때 에러 처리
} else if (error.code === "INVALID_CARD_COMPANY") {
  // 유효하지 않은 카드 코드에 대한 에러 처리
}
});
};
        
// tap menu
        $(function () {
            var tabAnchor = $('.tabMenu li'),
                tabPanel = $('.tabPanel');

            tabAnchor.click(function (e) {
                e.preventDefault();

                tabAnchor.removeClass('active');
                $(this).addClass('active');

                tabPanel.hide();

                var $target = $(this).attr('id');
                $($target).show();
            });
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
