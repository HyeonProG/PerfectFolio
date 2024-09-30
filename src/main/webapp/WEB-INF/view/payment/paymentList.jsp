<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

	<div class="container">

		<!-- 검색 폼 -->
		<form id="searchForm" class="d-flex">
			<div class="form-group p-2 flex-fill">
				<input type="search" class="form-control" id="searchContents"
					name="searchContents" placeholder="검색할 주문 번호를 입력하세요.">
			</div>
			<button type="submit" class="btn btn-outline-info p-2" style="width: 100px; height: 40px; margin-top: 6px;">검색</button>
		</form>

		<div class="custom-control custom-switch">
			<input type="checkbox" class="custom-control-input" id="switch1">
			<label class="custom-control-label" for="switch1">진행중인 결제만</label>
		</div>

		<button onclick="paymentKeyAlert()">결제 취소</button>

		<div id="" class="container text-center">
			<table class="table table-hover">
				<caption style="caption-side: top">결제 내역</caption>
				<thead>
					<tr>
						<th>번호</th>
						<th>주문번호</th>
						<th>상품명</th>
						<th>결제키</th>
						<th>자동결제키</th>
						<th>요청일</th>
						<th>승인일</th>
						<th>금액</th>
						<th>취소</th>
					</tr>
				</thead>
				<tbody id="paymentList">
					<!-- 데이터가 동적으로 삽입되는 구역 -->
				</tbody>
			</table>

			<!-- Pagination -->
			<div id="paginationContainer" class="d-flex justify-content-center">
				<!-- 페이지네이션이 동적으로 삽입되는 구역 -->
			</div>

		</div>

	</div>
</main>

<script>

//페이지가 로드될 때 데이터 불러오기
document.addEventListener('DOMContentLoaded', () => {
    fetchPage(1, 10); // 페이지 1, 사이즈 10으로 초기 데이터 로드
});

//검색 폼의 제출 이벤트 처리
   document.getElementById('searchForm').addEventListener('submit', function(event) {
            event.preventDefault(); // 폼 제출 시 페이지의 새로고침, 서버로 데이터 전송 방지

            const searchContents = document.getElementById('searchContents').value;

            fetchPage(1, 10, searchContents); // 페이지 1, 사이즈 10으로 검색
        });

   // 페이지를 불러오는 함수
   function fetchPage(page, size, searchContents = '') {
      
   	// 전체 리스트 조회 시 URL
   	let fetchUrl = `http://localhost:8080/pay/searchPaymentList?type=paymentList&page=` + page + `&size=` + size;
       
       // 검색 시 URL
       if (searchContents) {
           fetchUrl += `&searchContents=` + encodeURIComponent(searchContents);
       }

       fetch(fetchUrl)
           .then(response => response.json())
           .then(data => {
        	   console.log(data);
        	   renderPaymentList(data.paymentList); // 공지사항 목록 렌더링
               renderPagination(data.totalCount, data.currentPage, data.pageSize, data.totalPages, searchContents); // 페이징 처리 렌더링
           })
           .catch(error => {
               console.error('Error:', error);
           });
   }
   
   // 공지사항 목록을 렌더링하는 함수
   function renderPaymentList(paymentList) {
       const paymentListContainer = document.getElementById('paymentList');

       // 기존 공지사항 항목 제거 - 새 데이터 추가 시 중복 방지
       while (paymentListContainer.firstChild) {
    	   paymentListContainer.removeChild(paymentListContainer.firstChild);
       }
   // 공지사항 항목을 생성하고 컨테이너에 추가
   paymentList.forEach(paymentList => {
       // 행(tr) 요소 생성
       const tr = document.createElement('tr');

       // 각 셀(td) 요소 생성 및 추가
       const idCell = document.createElement('td');
       idCell.textContent = paymentList.id;
       tr.appendChild(idCell);

       const orderIdCell = document.createElement('td');
       orderIdCell.textContent = paymentList.orderId;
       tr.appendChild(orderIdCell);
       
       const orderNameCell = document.createElement('td');
       orderNameCell.textContent = paymentList.orderName;
       tr.appendChild(orderNameCell);

       const paymentKeyCell = document.createElement('td');
       paymentKeyCell.textContent = paymentList.paymentKey;
       tr.appendChild(paymentKeyCell);

       const billingKeyCell = document.createElement('td');
       billingKeyCell.textContent = paymentList.billingKey;
       tr.appendChild(billingKeyCell);
       
       const requestedAtCell = document.createElement('td');
       requestedAtCell.textContent = paymentList.requestedAt;
       tr.appendChild(requestedAtCell);
       
       const approvedAtCell = document.createElement('td');
       approvedAtCell.textContent = paymentList.approvedAt;
       tr.appendChild(approvedAtCell);
       
       const totalAmountCell = document.createElement('td');
       totalAmountCell.textContent = paymentList.totalAmount;
       tr.appendChild(totalAmountCell);
       
       const cancelAmountCell = document.createElement('td');
       cancelAmountCell.textContent = paymentList.cancel;
       tr.appendChild(cancelAmountCell);
       
       // 완성된 행을 공지사항 목록 컨테이너에 추가
       paymentListContainer.appendChild(tr);
   });
   }
   
   
//페이지네이션을 렌더링하는 함수
function renderPagination(totalCount, currentPage, pageSize, totalPages, searchContents = '') {

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
	        if (currentPage > 1) {fetchPage(currentPage - 1, pageSize,searchContents)};
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
	            fetchPage(i, pageSize,searchContents);
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
	        if (currentPage < totalPages) {fetchPage(currentPage + 1, pageSize, searchContents)};
	    });
	    nextLi.appendChild(nextLink);
	    ul.appendChild(nextLi);

	    // 완성된 페이지네이션을 페이지네이션 컨테이너에 추가
	    paginationContainer.appendChild(ul);
}


// alert
let payPk = null;
let paymentKey=null;  
let cancelReason=null;  

function paymentKeyAlert() {
	Swal.fire({
		  title: "결제 취소 요청",
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
				  	payPk = result.value;
				    console.log('payPk : ',payPk);
				    paymentKeyAlert1();
			  }
				});
	}

function paymentKeyAlert1() {
	Swal.fire({
		  title: "결제 취소 요청",
		  text: "결제 성공 후 받은 결제키를 입력하세요.",
		  input: "text",
		  icon: "warning",
		  showCancelButton: true,
		  confirmButtonText: "다음",
		  cancelButtonText: "닫기",
		  confirmButtonColor: "#7367f0",
		  cancelButtonColor: "#383872",
		  inputPlaceholder: "결제키 필수 입력",
		  showLoaderOnConfirm: true,
		})
		.then((result) => {
			  if (result.isConfirmed) {
				    paymentKey = result.value;
				    console.log('paymentKey : ',paymentKey);
				    paymentKeyAlert2();
			  }
				});
	}
	
	function paymentKeyAlert2(){
	     Swal.fire({
		      title: "결제 취소 사유",
		      input: "select",
		      inputOptions: {
		    	  simple: "단순 변심",
		    	  cancelSubscribe: "구독 취소",
		    	  portfolio: "포트폴리오 문제",
		    	  doublePay: "중복 결제됨",
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
					
					 fetch('http://localhost:8080/refund?paymentKey=' +paymentKey+ '&cancelReason=' +cancelReason +"&payPk=" +payPk, {
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

<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/adminLayout/footer.jsp"%>