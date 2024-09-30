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
			<a href="/user/my-info">계정관리</a> <a href="/user/my-subscribe"
				class="bar--selected">구독 내역</a>
			<a href="/user/mySkillPage">스킬스택 관리</a>

		</div>
		<div class="bar--items">
			<p>포트폴리오</p>
			<a href="/user/my-portfolio">포트폴리오</a>
		</div>
	</aside>

	<!-- content -->
	<div class="personal--wrap">
		<div>
			<h2>구독 내역</h2>
		</div>

		<div class="inner--personal">
			<div class="user--info">
				<c:choose>
					<c:when test="${subscribing != null }">
						<table>
							<tr>
								<th>결제 유형</th>
								<td>${subscribing.orderName }</td>
							</tr>
							<tr>
								<th>결제한 금액</th>
								<td>${subscribing.amount }</td>
							</tr>

							<tr>
								<th>마지막 결제일</th>
								<td><fmt:formatDate value="${subscribing.createdAt }"
										pattern="yyyy-MM-dd" /></td>
							</tr>
							<tr>
								<th>다음 결제일</th>
								<td>${subscribing.nextPay }</td>
							</tr>
						</table>
						<div class="inline--btn--wrap">
							<button class="info--btn" onclick="paymentKeyAlert2()">구독해지</button>
						</div>
					</c:when>
					<c:otherwise>
						<p>현재 구독중인 서비스가 없습니다.</p>
						<div class="inline--btn--wrap">
							<a href="/pay/subscribe" class="info--btn">구독하러 가기</a>
						</div>
					</c:otherwise>
				</c:choose>
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

<script>
const principal = '<%=session.getAttribute("principal")%>';

function paymentKeyAlert2(){
    Swal.fire({
	      title: "구독 해지 사유",
	      input: "select",
	      inputOptions: {
	    	  another: "다른 구독제로 변경하고 싶어요.",
	    	  macthing: "매칭이 만족스럽지 못했어요.",
	    	  simple: "더 이상 사이트를 이용하지 않아요.",
	    	    },
	      text: "결제를 취소하는 사유는 필수 입력입니다.",
	      icon: "question",
	    	showCancelButton: true,
	    	confirmButtonText: "입력완료",
	    	cancelButtonText: "닫기",
	    	confirmButtonColor: "#7367f0",
			  cancelButtonColor: "#383872",
			  inputAttributes: {
				    maxlength: "20",
				    autocapitalize: "off",
				    autocorrect: "off"
				  }
	    })
	    .then((result)=>{
	    	if(result.isConfirmed){
	    		cancelReason = result.value;
				console.log('cancelReason : ',cancelReason);
				
				 fetch('http://localhost:8080/user/termination?cancelReason=' +cancelReason +'&userPk='+ ${principal.id}, {
				        method: 'POST',
				        headers: {
				          'Content-Type': 'application/json'
				        },
				        body: JSON.stringify(cancelReason),
				      })
				      .then(res => res.json())
				      .then(data => console.log(data));
				
	    	}
	    });
}
</script>
<!-- 광고 이미지 -->
<script>
    function fetchRandomImage() {
        fetch('http://localhost:8080/advertiser/random-image')
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
        fetch('http://localhost:8080/advertiser/increment-click', {
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