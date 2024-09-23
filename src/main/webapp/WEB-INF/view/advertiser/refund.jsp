<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/adminLayout/header.jsp"%>

<style>
.contents--wrap {
	padding-top: 64px;
	background-color: #fcfcfc;
	width: 80%;
	height: 100%;
	margin: 0 auto;
}
</style>

<main class="contents--wrap">

	<section class="hero is-info">
		<div class="hero-body">
			<div class="container">
				<h1 class="title">환불 요청</h1>
			</div>
		</div>
	</section>

	<!-- 환불 요청 리스트 -->
	<div id="" class="container text-center">
		<table class="table table-hover" id="table">
			<caption style="caption-side: top">환불 요청 내역</caption>
			<thead>
				<tr>
					<th>번호</th>
					<th>결제일</th>
					<th>결제금액</th>
					<th>환불요청금액</th>
					<th>사유</th>
					<th>요청시간</th>
					<th>승인</th>
					<th>신청인</th>
					<th>처리</th>
				</tr>
			</thead>
			<tbody id="refundList">
				<!-- 데이터가 동적으로 삽입되는 구역 -->
			</tbody>
		</table>

		<!-- Pagination -->
		<div id="paginationContainer" class="d-flex justify-content-center">
			<!-- 페이지네이션이 동적으로 삽입되는 구역 -->
		</div>
	</div>

	<section class="section">
		<div class="container">
			<form action="/advertiser/application-refund" method="post">
				<div class="field">
					<label class="label">결제 키</label>
					<div class="control">
						<input class="input" type="text" name="paymentKey"
							placeholder="결제 키를 입력하세요" required>
					</div>
				</div>

				<div class="field">
					<label class="label">환불 금액</label>
					<div class="control">
						<input class="input" type="number" name="cancelAmount"
							placeholder="환불 금액을 입력하세요" required>
					</div>
				</div>

				<div class="field">
					<label class="label">환불 사유</label>
					<div class="control">
						<textarea class="textarea" name="cancelReason"
							placeholder="환불 사유를 입력하세요" required></textarea>
					</div>
				</div>

				<div class="control">
					<button class="button is-primary" type="submit">환불 요청</button>
				</div>
			</form>
		</div>
	</section>
</main>

<script>
//페이지가 로드될 때 데이터 불러오기
document.addEventListener('DOMContentLoaded', () => {
    fetchPage(1, 10); // 페이지 1, 사이즈 10으로 초기 데이터 로드
});

   // 페이지를 불러오는 함수
   function fetchPage(page, size) {
      
   	// 전체 리스트 조회 시 URL
   	let fetchUrl = `http:perfecfolio.jinnymo.com/advertiser/refundList?page=` + page + `&size=` + size;

       fetch(fetchUrl)
           .then(response => response.json())
           .then(data => {
        	   console.log(data);
        	   renderRefundList(data.refundList); // 공지사항 목록 렌더링
               renderPagination(data.totalCount, data.currentPage, data.pageSize, data.totalPages); // 페이징 처리 렌더링
           })
           .catch(error => {
               console.error('Error:', error);
           });
   }
   
   // 공지사항 목록을 렌더링하는 함수
   function renderRefundList(refundList) {
       const refundListContainer = document.getElementById('refundList');

       // 기존 공지사항 항목 제거 - 새 데이터 추가 시 중복 방지
       while (refundListContainer.firstChild) {
    	   refundListContainer.removeChild(refundListContainer.firstChild);
       }
   // 공지사항 항목을 생성하고 컨테이너에 추가
   refundList.forEach(refundList => {
       // 행(tr) 요소 생성
       const tr = document.createElement('tr');

       // 각 셀(td) 요소 생성 및 추가
       const idCell = document.createElement('td');
       idCell.textContent = refundList.id;
       tr.appendChild(idCell);

       const paymentKeyCell = document.createElement('td');
       paymentKeyCell.textContent = refundList.paymentDate;
       tr.appendChild(paymentKeyCell);

       const cancelReasonCell = document.createElement('td');
       cancelReasonCell.textContent = refundList.paymentAmount;
       tr.appendChild(cancelReasonCell);
       
       const requestedAtCell = document.createElement('td');
       requestedAtCell.textContent = refundList.refundAmount;
       tr.appendChild(requestedAtCell);
       
       const approvedAtCell = document.createElement('td');
       approvedAtCell.textContent = refundList.reason;
       tr.appendChild(approvedAtCell);
       
       const cancelAmountCell = document.createElement('td');
       cancelAmountCell.textContent = refundList.createdAt;
       tr.appendChild(cancelAmountCell);
       
       const adminIdCell = document.createElement('td');
       adminIdCell.textContent = refundList.approved;
       tr.appendChild(adminIdCell);
       
       const personIdCell = document.createElement('td');
       personIdCell.textContent = refundList.userId;
       tr.appendChild(personIdCell);
       
       const treatmentIdCell = document.createElement('button');
       treatmentIdCell.textContent = "처리";
       treatmentIdCell.setAttribute("onclick", "paymentKeyAlert()");
       tr.appendChild(treatmentIdCell);
       
       // 완성된 행을 공지사항 목록 컨테이너에 추가
       refundListContainer.appendChild(tr);
   });
   }
   
   // 처리 버튼 이벤트
    let id = null;
	let treatment = null;
	let reject = null;
	
	function paymentKeyAlert() {
		Swal.fire({
			  title: "결제 처리",
			  text: "번호를 입력하세요. 주문번호가 아닙니다.",
			  input: "text",
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonText: "다음",
			  cancelButtonText: "닫기",
			  confirmButtonColor: "#7367f0",
			  cancelButtonColor: "#383872",
			  inputPlaceholder: "번호 필수 입력",
			  showLoaderOnConfirm: true,
			})
			.then((result) => {
				  if (result.isConfirmed) {
					    id = result.value;
					    console.log('id : ',id);
					    paymentKeyAlert1();
				  }
					});
		}
   
	function paymentKeyAlert1() {
	    Swal.fire({
	        title: "결제 처리",
	        input: "select",
	        inputOptions: {
	            승인: "승인",
	            반려: "반려",
	        },
	        icon: "question",
	        showCancelButton: true,
	        confirmButtonText: "완료",
	        cancelButtonText: "닫기",
	        confirmButtonColor: "#7367f0",
	        cancelButtonColor: "#383872",
	        inputAttributes: {
	            maxlength: "20",
	            autocapitalize: "off",
	            autocorrect: "off"
	        }
	    })
	    .then((result) => {
	        if (result.isConfirmed && result.value) {
	            const treatment = result.value;
	            console.log(treatment);
	            console.log(id);

	            if (treatment === "반려") {
	                console.log(treatment);
	                paymentKeyAlert2(treatment);
	            } else {
	                fetch('http://perfecfolio.jinnymo.com/advertiser/treatment?treatment=' + treatment + '&id=' + id, {
	                    method: 'POST',
	                    headers: {
	                        'Content-Type': 'application/json'
	                    },
	                    body: JSON.stringify({ treatment }),  // 객체로 감싸기
	                })
	                .then(res => res.json())
	                .then(data => console.log(data));
	            }
	        }
	    });
	}
	
	function paymentKeyAlert2(treatment) {
		Swal.fire({
			  title: "반려 사유",
			  text: "반려하시는 사유를 입력해주세요.",
			  input: "text",
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonText: "완료",
			  cancelButtonText: "닫기",
			  confirmButtonColor: "#7367f0",
			  cancelButtonColor: "#383872",
			  inputPlaceholder: "번호 필수 입력",
			  showLoaderOnConfirm: true,
			})
		    .then((result)=>{
		    	if(result.isConfirmed){
		    		reject = result.value;
					console.log('reject : ',reject);
					
					 fetch('http://perfecfolio.jinnymo.com/advertiser/treatment?treatment=' +treatment+'&id='+id+"&reject="+reject, {
					        method: 'POST',
					        headers: {
					          'Content-Type': 'application/json'
					        },
					        body: JSON.stringify(treatment),
					      })
					      .then(res => res.json())
					      .then(data => console.log(data));
					
		    	}
		    });
		}
   
   
//페이지네이션을 렌더링하는 함수
function renderPagination(totalCount, currentPage, pageSize, totalPages) {

	 const paginationContainer = document.getElementById('paginationContainer');

	    // 기존 페이지네이션 항목 제거
	    while (paginationContainer.firstChild) {
	        paginationContainer.removeChild(paginationContainer.firstChild);
	    }

	    // 페이지네이션 리스트 생성
	    const ul = document.createElement('ul');
	    ul.className = 'pagination';

	    // 이전 페이지 링크
	    const prevLi = document.createElement('li');
	    prevLi.className = currentPage > 1 ? 'page-item' : 'page-item disabled';
	    const prevLink = document.createElement('a');
	    prevLink.className = 'page-link';
	    prevLink.textContent = 'Previous';
	    prevLink.addEventListener('click', (event) => {
	        event.preventDefault(); // 페이지 이동 및 새로 고침 방지
	        if (currentPage > 1) {fetchPage(currentPage - 1, pageSize, categories, searchRange,searchContents)};
	    });
	    prevLi.appendChild(prevLink);
	    ul.appendChild(prevLi);

	    // 페이지 번호 링크
	    for (let i = 1; i <= totalPages; i++) {
	        const li = document.createElement('li');
	        li.className = i === currentPage ? 'page-item active' : 'page-item';
	        const link = document.createElement('a');
	        link.className = 'page-link';
	        link.textContent = i;
	        link.addEventListener('click', (event) => {
	            event.preventDefault(); // 페이지 이동 및 새로 고침 방지
	            fetchPage(i, pageSize, categories, searchRange,searchContents);
	        });
	        li.appendChild(link);
	        ul.appendChild(li);
	    }

	    // 다음 페이지 링크
	    const nextLi = document.createElement('li');
	    nextLi.className = currentPage < totalPages ? 'page-item' : 'page-item disabled';
	    const nextLink = document.createElement('a');
	    nextLink.className = 'page-link';
	    nextLink.textContent = 'Next';
	    nextLink.addEventListener('click', (event) => {
	        event.preventDefault(); // 페이지 이동 및 새로 고침 방지
	        if (currentPage < totalPages) {fetchPage(currentPage + 1, pageSize, categories, searchRange, searchContents)};
	    });
	    nextLi.appendChild(nextLink);
	    ul.appendChild(nextLi);

	    // 완성된 페이지네이션을 페이지네이션 컨테이너에 추가
	    paginationContainer.appendChild(ul);
}
</script>

</body>
</html>