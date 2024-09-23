<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/myInfo.css">
<link rel="stylesheet" href="/css/adButtonStyle.css">
<style>
.container {
    display: flex;
    flex-wrap: wrap; /* 줄 바꿈을 가능하게 함 */
    justify-content: space-between;
}

.inner--personal {
	width: 50vh;
}

.button {
    flex: 0 1 48%; /* 48% 크기로 설정하여 두 개씩 나란히 배치 */
    margin-bottom: 10px; /* 버튼들 간의 세로 간격 설정 */
}
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
			<a href="/advertiser/application"><span data-feather="file"></span>신청하기</a>
			<a href="/advertiser/application-list"><span data-feather="file"></span>신청내역</a>
			<a href="/advertiser/active-list"><span
				data-feather="shopping-cart"></span>게시 내역</a> <a
				href="/advertiser/payment" class="bar--selected"><span
				data-feather="bar-chart-2"></span>충전하기</a> <a
				href="/advertiser/requesting-refund">환불 요청</a>
		</div>
		<div class="bar--items">
			<p>탈퇴</p>
			<a href="/advertiser/withdraw"><span
				data-feather="message-square"></span>탈퇴하기</a>
		</div>
	</aside>

	<!-- 메인 콘텐츠 영역 -->
	<section>
		<div class="personal--wrap">
			<div>
				<h2>광고</h2>
				<p>충전하기</p>
			</div>

			<div class="inner--personal">
				<div class="user--info">

					<div class="section">
						<div class="container">
							<h2 class="subtitle">결제 금액을 선택하세요:</h2>
								<!-- 10,000원 버튼 -->
								<button class="button is-link" onclick="setAmountAndPay(10000);">
									<div>
										<span>
											<p>10000원</p>
										</span>
									</div>
									<div>
										<span>
											<p>결제하기</p>
										</span>
									</div>
								</button>

								<!-- 30,000원 버튼 -->
								<button class="button is-link" onclick="setAmountAndPay(30000);">
									<div>
										<span>
											<p>30000원</p>
										</span>
									</div>
									<div>
										<span>
											<p>결제하기</p>
										</span>
									</div>
								</button>
								<!-- 50,000원 버튼 -->
								<button class="button is-link" onclick="setAmountAndPay(50000);">
									<div>
										<span>
											<p>50000원</p>
										</span>
									</div>
									<div>
										<span>
											<p>결제하기</p>
										</span>
									</div>
								</button>
								<!-- 70,000원 버튼 -->
								<button class="button is-link" onclick="setAmountAndPay(70000);">
									<div>
										<span>
											<p>70000원</p>
										</span>
									</div>
									<div>
										<span>
											<p>결제하기</p>
										</span>
									</div>
								</button>
								<!-- 100,000원 버튼 -->
								<button class="button is-link"
									onclick="setAmountAndPay(100000);">
									<div>
										<span>
											<p>100000원</p>
										</span>
									</div>
									<div>
										<span>
											<p>결제하기</p>
										</span>
									</div>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>

	</section>
</main>


<!-- Footer -->
<%@ include file="/WEB-INF/view/layout/lightFooter.jsp"%>

<script src="https://js.tosspayments.com/v1"></script>
<script>
    let tossPayments = TossPayments("test_ck_LlDJaYngro1K6KqdMdnG3ezGdRpX"); // 테스트 클라이언트 키
    let path = "/advertiser";
    let successUrl = window.location.origin + path + "/success";
    let failUrl = window.location.origin + path + "/fail";
    let callbackUrl = window.location.origin + path + "/va_callback";
    let orderId = new Date().getTime();

    // JSP에서 세션으로부터 사용자 이름을 가져옵니다.
    let customerName = "<%=session.getAttribute("username") != null ? session.getAttribute("username") : ""%>";

    function pay(method, requestJson) {
        console.log(requestJson);
        tossPayments.requestPayment(method, requestJson).catch(function (error) {
            if (error.code === "USER_CANCEL") {
                alert("결제를 취소했습니다.");
            } else {
                alert(error.message);
            }
        });
    }

    function setAmountAndPay(selectedAmount) {
        let jsons = {
            card: {
                amount: selectedAmount, // 선택된 금액을 설정
                orderId: "token-" + orderId,
                orderName: "광고 토큰",
                successUrl: successUrl ,
                failUrl: failUrl,
                cardCompany: null,
                cardInstallmentPlan: null,
                maxCardInstallmentPlan: null,
                useCardPoint: false,
                customerName: customerName, // JSP에서 가져온 사용자 이름을 설정
                customerEmail: null,
                customerMobilePhone: null,
                taxFreeAmount: null,
                useInternationalCardOnly: false,
                flowMode: "DEFAULT",
                discountCode: null,
                appScheme: null,
            },
        };

        // 선택된 금액으로 결제 요청
        pay("카드", jsons.card);
    }
</script>