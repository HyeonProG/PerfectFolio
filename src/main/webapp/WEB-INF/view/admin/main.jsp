<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/adminLayout/header.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/chart.css">

<main class="contents--wrap container-fluid">

	<section class="chart--string--main">
		<!-- 차트 -->
		<div id="userCount" class="statistics--box">
			<p class="statistics--title">전체 사용자 수</p>
			<p id="totalUsers" class="statistics--value"></p>
		</div>

		<div id="subscribingUserCount" class="statistics--box">
			<p class="statistics--title">전체 구독자 수</p>
			<p id="subscribingUsers" class="statistics--value"></p>
		</div>

		<div id="chartSubscribingAmount" class="statistics--box">
			<p class="statistics--title">전체 구독 결제 금액</p>
			<p id="subscribingAmount" class="statistics--value"></p>
		</div>

		<div id="chartCountAllSubRefund" class="statistics--box">
			<p class="statistics--title">전체 구독 환불 금액</p>
			<p id="subRefundAmount" class="statistics--value"></p>
		</div>

		<div id="countAllAdPayment" class="statistics--box">
			<p class="statistics--title">전체 광고 결제 금액</p>
			<p id="paymentAmount" class="statistics--value"></p>
		</div>

		<div id="countAllAdRefundPayment" class="statistics--box">
			<p class="statistics--title">전체 광고 환불 금액</p>
			<p id="refundAmount" class="statistics--value"></p>
		</div>
	</section>

	<section class="chart--sec">
		<div class="graph--wrap">
			<canvas id="countByMonth" class="graph"></canvas>
		</div>
		<div class="circle--chart--dash">
			<canvas id="chartWithdrawReason" class="circle--chart"></canvas>
		</div>
	</section>


	<!-- 문의사항 -->
	<section class="notice--qa">
		<div id="BoardListContainer" class="qa--board">
			<h2 class="qa--title">문의사항</h2>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>문의유형</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>답변여부</th>
					</tr>
				</thead>
				<tbody id="boardList">
					<!-- 데이터가 동적으로 삽입되는 구역 -->
				</tbody>
			</table>
		</div>
		<!-- 공지사항 -->
		<div id="noticeListContainer" class="notice--board">
			<h2 class="notice--title">공지사항</h2>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>카테고리</th>
						<th>제목</th>
						<th>내용</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody id="noticeList">
					<!-- 데이터가 동적으로 삽입되는 구역 -->
				</tbody>
			</table>
		</div>
	</section>
</main>


<script>
/* 		const toggleBtn = document.querySelector('.navbar--toggleBtn');
		const menu = document.querySelector('.wrapper--menu');
		
		toggleBtn.addEventListener('click', () => {
		    menu.classList.toggle('active'); // 메뉴가 활성화되거나 비활성화되도록 함
		}); */
		
		/* 차트 시작 */
		
        // 전역 변수 선언
        let countByMonth; 
		let chartWithdrawReason;
		
		

		/* 전체 사용자 수 */
		function getAllUsersCount() {
		    fetch('http://perfecfolio.jinnymo.com/admin/chartCountAllUsers')
		        .then(response => response.json())
		        .then(data => {
		            document.getElementById('totalUsers').innerText = data;
		        })
		        .catch(error => {
		            console.log("error:" + error);
		        });
		}
		
		 /* 전체 구독자 수 */
        function countSubscribingUsers() {
            fetch('http://perfecfolio.jinnymo.com/pay/countSubscribing')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('subscribingUsers').innerText = data;
                })
                .catch(error => {
                    console.log("error:" + error);
                });
        }
		 
        /* 전체 구독 결제 금액 */
        function chartSubscribingAmount() {
            fetch('http://perfecfolio.jinnymo.com/admin/chartCountAllSubAmount')
                .then(response => response.json())
                .then(data => {
                    const formattedAmount = formatKoreanWon(data);
                	document.getElementById('subscribingAmount').innerText = formattedAmount;
                })
                .catch(error => {
                    console.log("error:" + error);
                });
        }
        
        /* 전체 구독 환불 금액 */
        function chartCountAllSubRefund() {
            fetch('http://perfecfolio.jinnymo.com/admin/chartCountAllSubRefund')
                .then(response => response.json())
                .then(data => {
                	const formattedAmount = formatKoreanWon(data);
                	document.getElementById('subRefundAmount').innerText = formattedAmount;
                })
                .catch(error => {
                    console.log("error:" + error);
                });
        }
        
        /* 전체 광고 결제 금액 */
        function countAllAdPayment() {
            fetch('http://perfecfolio.jinnymo.com/advertiser/payment-count')
                .then(response => response.json())
                .then(data => {
                    const formattedAmount = formatKoreanWon(data);
                	document.getElementById('paymentAmount').innerText = formattedAmount;
                })
                .catch(error => {
                    console.log("error:" + error);
                });
        }
        
        /* 전체 광고 환불 금액 */
        function countAllAdRefundPayment() {
            fetch('http://perfecfolio.jinnymo.com/advertiser/ad-refund-amount')
                .then(response => response.json())
                .then(data => {
                    const formattedAmount = formatKoreanWon(data);
                	document.getElementById('refundAmount').innerText = formattedAmount;
                })
                .catch(error => {
                    console.log("error:" + error);
                });
        }
        
        /* 금액 포맷 */
        function formatKoreanWon(amount) {
            // JavaScript 내장 함수를 사용하여 금액을 한국 원화 형식으로 포맷
            return amount.toLocaleString('ko-KR') + '원';
        }
        
        /* 월별 사용자 수 */
        function getUserMonth() {
            fetch('http://perfecfolio.jinnymo.com/admin/chartCountUserByMonth')
                .then(response => response.json())
                .then(data => {
                    const fullData = fillMissingMonths(data);
                    chartCountUserByMonth(fullData);
                })
                .catch(error => {
                    console.log("error:" + error);
                })
        }
        
        /* 탈퇴 사유 및 개수 조회 */
        function getWithdrawReason() {
			fetch('http://perfecfolio.jinnymo.com/admin/chartCountWithdrawReason')
				.then(response => response.json())
				.then(data => {
					console.log(data);
			        chartCountWithdrawReason(data);
				})
				.catch(error => {
					console.log("error:" + error);
				})
				}
        
        
        /* 월별 사용자 수 - 차트 생성 */
        function chartCountUserByMonth(data) {
            const labels = data.map(item => item.year + " - " + item.month);
            const userCountData = data.map(item => item.count);

            const ctx = document.getElementById('countByMonth').getContext('2d');

            if(countByMonth) {
            	countByMonth.destroy();
            }

            countByMonth = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '월별 사용자 수',
                        data: userCountData,
                        borderColor: 'rgba(75, 192, 192, 1)',
                        backgroundColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: false,
                    maintainAspectRatio: false, // 비율 유지 설정
                    plugins: {
                        legend: {
                            display: true,
                        },
                        tooltip: {
                           enabled: true
                        }
                    }
                }
            });
        }
        
        // data(날짜)가 비어있어도 채우도록 하는 function
        function fillMissingMonths(data) {
            const year = data.length > 0 ? data[0].year : new Date().getFullYear();
            const fullData = Array.from({ length: 12 }, (_, index) => {
                const month = index + 1;
                const existingData = data.find(item => parseInt(item.month) === month);
                return existingData || { year: year, month: month, count: 0 };
            });
            return fullData;
        }
        
        /* 탈퇴 사유 및 탈퇴자 수  - 차트 생성 */
        function chartCountWithdrawReason(data) {
			const labels = data.map(item => item.reason);
			const userCountData = data.map(item => item.count);
			const ctx = document.getElementById('chartWithdrawReason').getContext('2d');
			
			if(chartWithdrawReason) {
				chartWithdrawReason.destroy();
			}
			
			chartWithdrawReason = new Chart(ctx, {
				type: 'doughnut',
				data: {
					labels: labels,
					datasets:[{
						label: '사유를 선택한 수',
						data: userCountData,
						backgroundColor: [
							/* 탈퇴사유 */
						    'rgba(3, 199, 90, 1)',  // 초
							'rgba(66, 133, 244, 1)', // 파
							'rgba(155, 89, 182, 1)', // 보
							'rgba(247, 227, 0, 1)',  // 노
							'rgba(75, 192, 192, 1)', // 청록
						],
						borderColor: [
							 'rgba(3, 199, 90, 1)',  // 초
							 'rgba(66, 133, 244, 1)', // 파
							 'rgba(155, 89, 182, 1)', // 보
							 'rgba(247, 227, 0, 1)',  // 노
							 'rgba(75, 192, 192, 1)' // 청록
						],
						borderWidth: 1
					}]
				},
				options: {
					responsive: false,
					maintainAspectRatio: false, // 비율 유지 설정
					plugins: {
						legend: {
							position: 'top',
						},
						title: {
                            display: true,
                            text: '탈퇴 회원 사유 및 수'
                        },
						tooltip: {
							enabled: true
						}
					}
				}
			});
        }
        
        
        
		
		// 공지사항을 불러오는 함수
		function fetchNotices() {
		    fetch('http:perfecfolio.jinnymo.com/notice/list?page=1&size=5') // 첫 페이지에서 7개 항목 요청
		        .then(response => response.json())
		        .then(data => {
		            renderNoticeList(data.noticeList); // 공지사항 목록 렌더링
		        })
		        .catch(error => {
		            console.error('Error:', error);
		        });
		}
		
		function renderNoticeList(noticeList) {
		    const noticeListContainer = document.getElementById('noticeList');

		    // 기존 공지사항 항목 제거
		    while (noticeListContainer.firstChild) {
		        noticeListContainer.removeChild(noticeListContainer.firstChild);
		    }

		    // 공지사항 항목 생성 및 추가
		    noticeList.forEach(notice => {
		        const tr = document.createElement('tr');
		        tr.addEventListener('click', () => {
		            window.location.href = "/notice/detail?id=" + notice.id;
		        });

		        // 각 셀 요소 생성
		        const categoriesCell = document.createElement('td');
		        categoriesCell.textContent = notice.categories;
		        tr.appendChild(categoriesCell);

		        const titleCell = document.createElement('td');
		        titleCell.textContent = notice.title;
		        tr.appendChild(titleCell);

		        const contentCell = document.createElement('td');
		        contentCell.textContent = notice.content;
		        tr.appendChild(contentCell);

		        const createdAtCell = document.createElement('td');
		        createdAtCell.textContent = formatDate(notice.createdAt);
		        tr.appendChild(createdAtCell);
		        
		        // 행을 공지사항 목록 컨테이너에 추가
		        noticeListContainer.appendChild(tr);
		    });
		}
		
		 // 날짜를 YYYY-MM-DD HH:MM:SS 형식으로 포맷
        function formatDate(dateString) {
        	
            const date = new Date(dateString);

            // padStart(2, '0') -> 두자리, 0부터 시작(예: 08월/일/시/분/초)
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
            const day = String(date.getDate()).padStart(2, '0');

            return year + '-' + month + '-' + day;
        }
		 
        // Q & A 목록을 불러오는 함수
		function fetchBoards() {
		    const fetchUrl = 'http:perfecfolio.jinnymo.com/board/list?page=1&size=5'; // URL 정의
		    fetch(fetchUrl)
		        .then(response => response.json())
		        .then(data => {
		            renderBoardList(data.boardList); // Q & A 목록 렌더링
		        })
		        .catch(error => {
		            console.error('Error:', error);
		        });
		}

		
        // Q & A 목록을 렌더링하는 함수
        function renderBoardList(boardList) {
            const boardListContainer = document.getElementById('boardList');

            // 기존 Q & A 항목 제거 - 새 데이터 추가 시 중복 방지
            while (boardListContainer.firstChild) {
         	   boardListContainer.removeChild(boardListContainer.firstChild);
            }
        // Q & A 항목을 생성하고 컨테이너에 추가
        boardList.forEach(board => {
            // 행(tr) 요소 생성
            const tr = document.createElement('tr');
            tr.addEventListener('click', () => {
                window.location.href = "/board/view?boardId=" + board.id;
            });

            // 각 셀(td) 요소 생성 및 추가
            const categoriesCell = document.createElement('td');
            categoriesCell.textContent = board.categories;
            tr.appendChild(categoriesCell);

            const titleCell = document.createElement('td');
            titleCell.textContent = board.title;
            tr.appendChild(titleCell);

            const contentCell = document.createElement('td');
            contentCell.textContent = board.writer;
            tr.appendChild(contentCell);

          	const createdAtCell = document.createElement('td');
            createdAtCell.textContent = formatDate(board.createdAt);
            tr.appendChild(createdAtCell);
            

            // 완성된 행을 목록 컨테이너에 추가
            boardListContainer.appendChild(tr);
        	});
        }
		 
		 
		

		// 페이지 로드 시 데이터 불러오기
		window.onload = function() { 
		    getAllUsersCount(); // 전체 사용자 수
		    countSubscribingUsers(); // 전체 구독자 수
		    chartSubscribingAmount();
        	chartCountAllSubRefund();
        	countAllAdPayment();
        	countAllAdRefundPayment();
        	getUserMonth();
        	getWithdrawReason();
		    fetchNotices(); // 공지사항
		    fetchBoards(); // Q & A
		};
		</script>

<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/adminLayout/footer.jsp"%>