<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<link rel="stylesheet" href="/css/subscribe.css">
<script src="https://js.tosspayments.com/v1"></script>

<div class="sub--banner">
	<h1>입사 제안서</h1>
</div>

<div class="container-fluid"
	style="text-align: center; margin-top: 200px;">

	<div class="tabMenu">
		<ul class="tabs d-flex justify-content-center">
			<li class="active tabBtn" id="#tab1">입사 제안서 구매</li>
		</ul>
	</div>

	<div class="item--wrap">
    <!-- 10개 구매 -->
    <div class="plan">
        <div class="inner">
            <span class="pricing"> <span> 인기<small></small></span></span>
            <p class="title">10 개</p>
            <p class="info">퍼펙트폴리오 처음이신 분들을 <br> 위한 입문 패키지</p>
            <ul class="features">
                <li><span class="icon">
                    <svg height="24" width="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M0 0h24v24H0z" fill="none"></path>
                        <path fill="currentColor" d="M10 15.172l9.192-9.193 1.415 1.414L10 18l-6.364-6.364 1.414-1.414z"></path>
                    </svg>
                </span> <span><strong>9,900</strong>원</span></li>
                <li><span class="icon">
                    <svg height="24" width="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M0 0h24v24H0z" fill="none"></path>
                        <path fill="currentColor" d="M10 15.172l9.192-9.193 1.415 1.414L10 18l-6.364-6.364 1.414-1.414z"></path>
                    </svg>
                </span> <span> <strong>10명</strong>에게 입사제안 가능</span></li>
            </ul>
            <div class="action">
                <c:choose>
                    <c:when test="${principal != null }">
                        <a class="button" href="#" onclick="payItem10(9900, 10)"> 결제하기 </a>
                    </c:when>
                    <c:otherwise>
                        <a class="button" href="#" onclick="nessearySignIn()"> 구독하기</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- 30개 구매 -->
    <div class="plan">
        <div class="inner">
            <span class="pricing"> <span> 추천<small></small></span></span>
            <p class="title">30 개</p>
            <p class="info"> 더 많은 인재에게 보내고 싶다면 <br> 이 패키지를 선택하세요.</p>
            <ul class="features">
                <li><span class="icon">
                    <svg height="24" width="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M0 0h24v24H0z" fill="none"></path>
                        <path fill="currentColor" d="M10 15.172l9.192-9.193 1.415 1.414L10 18l-6.364-6.364 1.414-1.414z"></path>
                    </svg>
                </span> <span><strong>27,000</strong>원</span></li>
                <li><span class="icon">
                    <svg height="24" width="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M0 0h24v24H0z" fill="none"></path>
                        <path fill="currentColor" d="M10 15.172l9.192-9.193 1.415 1.414L10 18l-6.364-6.364 1.414-1.414z"></path>
                    </svg>
                </span> <span> <strong>30명</strong>에게 입사제안 가능</span></li>
            </ul>
            <div class="action">
                <c:choose>
                    <c:when test="${principal != null }">
                        <a class="button" href="#" onclick="payItem30(28900, 30)"> 결제하기 </a>
                    </c:when>
                    <c:otherwise>
                        <a class="button" href="#" onclick="nessearySignIn()"> 구독하기</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- 50개 구매 -->
    <div class="plan">
        <div class="inner">
            <span class="pricing"> <span> 베스트<small></small></span></span>
            <p class="title">50 개</p>
            <p class="info">폭넓은 제안으로 인재를 <br> 선점하세요!</p>
            <ul class="features">
                <li><span class="icon">
                    <svg height="24" width="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M0 0h24v24H0z" fill="none"></path>
                        <path fill="currentColor" d="M10 15.172l9.192-9.193 1.415 1.414L10 18l-6.364-6.364 1.414-1.414z"></path>
                    </svg>
                </span> <span><strong>45,000</strong>원</span></li>
                <li><span class="icon">
                    <svg height="24" width="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M0 0h24v24H0z" fill="none"></path>
                        <path fill="currentColor" d="M10 15.172l9.192-9.193 1.415 1.414L10 18l-6.364-6.364 1.414-1.414z"></path>
                    </svg>
                </span> <span> <strong>50명</strong>에게 입사제안 가능</span></li>
            </ul>
            <div class="action">
                <c:choose>
                    <c:when test="${principal != null }">
                        <a class="button" href="#" onclick="payItem50(46500, 50)"> 결제하기 </a>
                    </c:when>
                    <c:otherwise>
                        <a class="button" href="#" onclick="nessearySignIn()"> 구독하기</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- 100개 구매 -->
    <div class="plan">
        <div class="inner">
            <span class="pricing"> <span> 프리미엄<small></small></span></span>
            <p class="title">100 개</p>
            <p class="info">대규모 채용이 필요하다면 <br> 최강의 선택!</p>
            <ul class="features">
                <li><span class="icon">
                    <svg height="24" width="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M0 0h24v24H0z" fill="none"></path>
                        <path fill="currentColor" d="M10 15.172l9.192-9.193 1.415 1.414L10 18l-6.364-6.364 1.414-1.414z"></path>
                    </svg>
                </span> <span><strong>85,000</strong>원</span></li>
                <li><span class="icon">
                    <svg height="24" width="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M0 0h24v24H0z" fill="none"></path>
                        <path fill="currentColor" d="M10 15.172l9.192-9.193 1.415 1.414L10 18l-6.364-6.364 1.414-1.414z"></path>
                    </svg>
                </span> <span> <strong>100명</strong>에게 입사제안 가능</span></li>
            </ul>
            <div class="action">
                <c:choose>
                    <c:when test="${principal != null }">
                        <a class="button" href="#" onclick="payItem100(89900, 100)"> 결제하기 </a>
                    </c:when>
                    <c:otherwise>
                        <a class="button" href="#" onclick="nessearySignIn()"> 구독하기</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

</div>


<script type="text/javascript">
// 로그인 창
function nessearySignIn() {
	Swal.fire({
		title: "로그인이 필요합니다.",
		icon: "warning",
		showLoaderOnConfirm: true,
	});
}

// 탭 메뉴
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
<script src="https://js.tosspayments.com/v1"></script>
<script>
    let tossPayments = TossPayments("test_ck_LlDJaYngro1K6KqdMdnG3ezGdRpX"); // 테스트 클라이언트 키
    let path = "/company";
    let successUrl = window.location.origin + path + "/success";
    let failUrl = window.location.origin + path + "/fail";
    let callbackUrl = window.location.origin + path + "/va_callback";

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

    function payItem10(selectedAmount, selectedCount) {
        let orderId = new Date().getTime();
        let orderName = "입사 제안서" + selectedCount + "개"
        let jsons = {
            card: {
                amount: selectedAmount, // 선택된 금액을 설정
                orderId: "company-" + orderId,
                orderName: orderName,
                successUrl: successUrl + "1" ,
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
    function payItem30(selectedAmount, selectedCount) {
        let orderId = new Date().getTime();
        let orderName = "입사 제안서" + selectedCount + "개"
        let jsons = {
            card: {
                amount: selectedAmount, // 선택된 금액을 설정
                orderId: "company-" + orderId,
                orderName: orderName,
                successUrl: successUrl + "2" ,
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
    function payItem50(selectedAmount, selectedCount) {
        let orderId = new Date().getTime();
        let orderName = "입사 제안서" + selectedCount + "개"
        let jsons = {
            card: {
                amount: selectedAmount, // 선택된 금액을 설정
                orderId: "company-" + orderId,
                orderName: orderName,
                successUrl: successUrl + "3" ,
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
    function payItem100(selectedAmount, selectedCount) {
        let orderId = new Date().getTime();
        let orderName = "입사 제안서" + selectedCount + "개"
        let jsons = {
            card: {
                amount: selectedAmount, // 선택된 금액을 설정
                orderId: "company-" + orderId,
                orderName: orderName,
                successUrl: successUrl + "4" ,
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
<!-- footer.jsp -->
<%@ include file="/WEB-INF/view/layout/darkFooter.jsp"%>
