<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/adminLayout/header.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/chart.css">

<main class="contents--wrap">
	<!-- 통계 자료 -->

	<div class="chart--string">
		<div class="chart--string--first">
			<div id="userCount" class="statistics--box">
				<p class="statistics--title">전체 사용자 수</p>
				<p id="totalUsers" class="statistics--value"></p>
			</div>

			<div id="subscribingUserCount" class="statistics--box">
				<p class="statistics--title">전체 구독자 수</p>
				<p id="subscribingUsers" class="statistics--value"></p>
			</div>

			<div id="unSubscribingUserCount" class="statistics--box">
				<p class="statistics--title">전체 구독 해지자 수</p>
				<p id="unSubscribingUsers" class="statistics--value"></p>
			</div>

			<div id="chartSubscribingAmount" class="statistics--box">
				<p class="statistics--title">전체 구독 결제 금액</p>
				<p id="subscribingAmount" class="statistics--value"></p>
			</div>

			<div id="chartCountAllSubRefund" class="statistics--box">
				<p class="statistics--title">전체 구독 환불 금액</p>
				<p id="subRefundAmount" class="statistics--value"></p>
			</div>
		</div>

		<div class="chart--string--second">
			<div id="countAllViewCount" class="statistics--box">
				<p class="statistics--title">전체 광고 본 횟수</p>
				<p id="viewCount" class="statistics--value"></p>
			</div>
			<div id="countAllClickCount" class="statistics--box">
				<p class="statistics--title">전체 광고 클릭 횟수</p>
				<p id="clickCount" class="statistics--value"></p>
			</div>

			<div id="countAllAdPayment" class="statistics--box">
				<p class="statistics--title">전체 광고 결제 금액</p>
				<p id="paymentAmount" class="statistics--value"></p>
			</div>

			<div id="countAllAdRefundPayment" class="statistics--box">
				<p class="statistics--title">전체 광고 환불 금액</p>
				<p id="refundAmount" class="statistics--value"></p>
			</div>
		</div>
	</div>


	<!-- canvas : 차트 그림 -->

	<!-- 원형 그래프 -->
	<section class="chart--sec">
		<div class="circle">
			<canvas id="chartByGender"></canvas>
		</div>
		<div class="circle">
			<canvas id="chartBySocialType"></canvas>
		</div>
		<div class="circle">
			<canvas id="chartByAge"></canvas>
		</div>
		<div class="circle">
			<canvas id="chartWithdrawReason"></canvas>
		</div>
	</section>

	<!-- 가입자 수/ 탈퇴자 수  -->
	<section class="chart--sec">
		<div class="container py-4">

			<div class="mb-3">
				<label for="weekPicker" class="form-label">Select a week:</label> <input
					type="text" id="weekPicker" class="form-control" readonly
					placeholder="Click to select a week">
			</div>

			<div class="mb-3">
				<canvas id="myChart"></canvas>
			</div>
		</div>
		<!-- 달력 모달 -->
		<div class="modal fade" id="calendarModal" tabindex="-1"
			aria-labelledby="calendarModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="calendarModalLabel">Select a Week</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="calendar-controls">
							<div class="controls-group">
								<select id="yearSelect" class="form-select"></select> <select
									id="monthSelect" class="form-select"></select>
							</div>
							<div class="controls-group">
								<button id="prevMonth" class="btn btn-outline-primary btn-sm">◀</button>
								<button id="nextMonth" class="btn btn-outline-primary btn-sm">▶</button>
							</div>
						</div>
						<div id="calendarContainer"></div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section class="chart--sec">
		<!-- 월별 사용자 수 -->
		<div class="graph--wrap" style="margin-bottom: 30px">
			<canvas id="countByMonth" class="graph"></canvas>
		</div>
	</section>

	</div>
	</div>
	</div>

</main>

<script>
/* const toggleBtn = document.querySelector('.navbar--toggleBtn');
const menu = document.querySelector('.wrapper--menu');

toggleBtn.addEventListener('click', () => {
    menu.classList.toggle('active'); // 메뉴가 활성화되거나 비활성화되도록 함
}); */


		/* 차트 시작 */
		
        // 전역 변수 선언
        let countByMonth; 
        let chartByGender;
        let chartBySocialType;
        let chartByAge;
        let chartWithdrawReason;

        /* 전체 사용자 수 */
        function getAllUsersCount() {
            fetch('/admin/chartCountAllUsers')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('totalUsers').innerText = data;
                })
                .catch(error => {
                    console.log("error:" + error);
                });
        }
        
        /*** 결제 파트 ***/
        
        /* 전체 구독자 수 */
        function countSubscribingUsers() {
            fetch('/pay/countSubscribing')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('subscribingUsers').innerText = data;
                })
                .catch(error => {
                    console.log("error:" + error);
                });
        }
        
        /* 전체 구독 해지자 수 */
        function countUnSubscribingUsers() {
            fetch('/admin/chartCountUnsubscribe')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('unSubscribingUsers').innerText = data;
                })
                .catch(error => {
                    console.log("error:" + error);
                });
        }
        
        /* 전체 구독 결제 금액 */
        function chartSubscribingAmount() {
            fetch('/admin/chartCountAllSubAmount')
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
            fetch('/admin/chartCountAllSubRefund')
                .then(response => response.json())
                .then(data => {
                    const formattedAmount = formatKoreanWon(data);
                	document.getElementById('subRefundAmount').innerText = formattedAmount;
                })
                .catch(error => {
                    console.log("error:" + error);
                });
        }
        
       
        
        /*** 광고 파트 ***/
        /* 전체 광고 본 횟수 */
        function countAllViewCount() {
            fetch('/advertiser/view-count')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('viewCount').innerText = data;
                })
                .catch(error => {
                    console.log("error:" + error);
                });
        }
        
        /* 전체 광고 클릭 횟수 */
        function countAllClickCount() {
            fetch('/advertiser/click-count')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('clickCount').innerText = data;
                })
                .catch(error => {
                    console.log("error:" + error);
                });
        }
        
        
        /* 전체 광고 결제 금액 */
        function countAllAdPayment() {
            fetch('/advertiser/payment-count')
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
            fetch('/advertiser/ad-refund-amount')
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
        
        /*** 유저 파트 ***/
        
        /* 월별 사용자 수 */
        function getUserMonth() {
            fetch('/admin/chartCountUserByMonth')
                .then(response => response.json())
                .then(data => {
                    const fullData = fillMissingMonths(data);
                    chartCountUserByMonth(fullData);
                })
                .catch(error => {
                    console.log("error:" + error);
                })
        }
        
        /* 남/여 사용자 수 */
        function getUserGender() {
            fetch('/admin/chartCountUserByGender')
                .then(response => response.json())
                .then(data => {
                    chartCountUserByGender(data);
                })
                .catch(error => {
                    console.log("error:" + error);
                })
        }
        
        /* 소셜 타입별 사용자 수 */
        function getUserSocialType() {
			fetch('/admin/chartCountUserBySocialType')
        		.then(response => response.json())
        		.then(data => {
        			chartCountUserBySocialType(data);
        		})
        		.catch(error => {
					console.log("error:" + error);
        		})
        }
        
        /* 연령별 사용자 수(네이버만) */
        function getUserAge() {
			fetch('/admin/chartCountUserByAge')
				.then(response => response.json())
				.then(data => {
					chartCountUserByAge(data);
				})
				.catch(error => {
					console.log("error:" + error);
				})
        }
        
        /* 탈퇴 사유 및 개수 조회 */
        function getWithdrawReason() {
			fetch('/admin/chartCountWithdrawReason')
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
        
        /* 남/여 사용자 수 - 차트 생성 */
        function chartCountUserByGender(data) {
            const labels = data.map(item => item.gender);
            const userCountData = data.map(item => item.count);

            const ctx = document.getElementById('chartByGender').getContext('2d');

            if(chartByGender) {
                chartByGender.destroy();
            }

            chartByGender = new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '사용자 수',
                        data: userCountData,
                        backgroundColor: [
                            'rgba(54, 162, 235, 1)', // 여
                            'rgba(255, 99, 132, 1)', // 남
                            'rgba(75, 192, 192, 1)' // 설정안함
                        ],
                        borderColor: [
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 99, 132, 1)',
                            'rgba(75, 192, 192, 1)' 
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: false,
                    plugins: {
                        legend: {
                        	position: 'top',
                        },
                        title: {
                            display: true,
                            text: '남/여 사용자 수'
                        },
                        tooltip: {
                            enabled: true
                        }
                    }
                }
            });
        }
        
        /* 소셜 타입별 사용자 수 - 차트 생성 */
        function chartCountUserBySocialType(data) {
			const labels = data.map(item => item.socialType);
			const userCountData = data.map(item => item.count);
			const ctx = document.getElementById('chartBySocialType').getContext('2d');
			
			if(chartBySocialType) {
				chartBySocialType.destroy();
			}
			
			chartBySocialType = new Chart(ctx, {
				type: 'doughnut',
				data: {
					labels: labels,
					datasets:[{
						label: '사용자 수',
						data: userCountData,
						backgroundColor: [
							/* 소셜 로그인(4가지) */
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
					plugins: {
						legend: {
							position: 'top',
						},
						title: {
                            display: true,
                            text: '소셜 로그인 사용자 수'
                        },
						tooltip: {
							enabled: true
						}
					}
				}
			});
        }
        
        /* 연령별 사용자  수(네이버만) - 차트 생성*/
        function chartCountUserByAge(data) {
			const labels = data.map(item => item.ageGroup);
			const userCountData = data.map(item => item.count);
			const ctx = document.getElementById('chartByAge').getContext('2d');
			
			if(chartByAge) {
				chartByAge.destroy();
			}
			
			chartByAge = new Chart(ctx, {
				type:'pie',
				data: {
					labels: labels,
					datasets:[{
						label:'사용자 수',
						data: userCountData,
						backgroundColor:[
						/* 연령별 색상(7가지)*/
						'rgba(255, 99, 132, 1)', // 분홍
						'rgba(75, 192, 192, 1)', // 청록
						'rgba(255, 159, 64, 1)', // 주황
						'rgba(66, 133, 244, 1)', // 파랑
						'rgba(155, 89, 182, 1)', // 보라
						'rgba(247, 227, 0, 1)',  // 노랑
						'rgba(3, 199, 90, 1)' // 초록
						],
						borderColor:[
						'rgba(255, 99, 132, 1)', // 분홍
						'rgba(75, 192, 192, 1)', // 청록
						'rgba(255, 159, 64, 1)', // 주황
						'rgba(66, 133, 244, 1)', // 파랑
						'rgba(155, 89, 182, 1)', // 보라
						'rgba(247, 227, 0, 1)',  // 노랑
						'rgba(3, 199, 90, 1)' // 초록
						],
						borderWidth: 1
					}]
				},
				options: {
					responsive: false,
					plugins: {
						legend: {
							position: 'top',
						},
						title: {
							display: true,
							text:'연령별 사용자 수(네이버만)'
						},
						tooltip: {
							enabled: true
						}
					}
				}
			});
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
        
        /* 가입자 수/ 탈퇴자 수 */
        
        // 현재 날짜 기준으로 초기 연도와 월을 설정
        let today = new Date();
        let currentYear = today.getFullYear();
        let currentMonth = today.getMonth();

        // 전역 변수 선언
        let startOfWeek; // 선택된 주의 시작일
        let endOfWeek;   // 선택된 주의 종료일
        let myChart;     // Chart.js 차트 인스턴스

        /**
         * generateCalendar(year, month)
         * 지정된 연도와 월에 대한 달력을 생성하여 화면에 표시합니다.
         * @param {number} year - 생성할 달력의 연도
         * @param {number} month - 생성할 달력의 월 (0-11)
         */
        function generateCalendar(year, month) {
            const container = document.getElementById('calendarContainer');
            container.innerHTML = ''; // 이전에 생성된 달력을 제거

            const calendar = document.createElement('table');
            calendar.className = 'table table-bordered text-center';

            // 달력 헤더 (요일)
            const header = document.createElement('thead');
            const daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
            const headerRow = document.createElement('tr');
            daysOfWeek.forEach(day => {
                const th = document.createElement('th');
                th.textContent = day;
                headerRow.appendChild(th);
            });
            header.appendChild(headerRow);
            calendar.appendChild(header);

            // 달력 본문 (날짜)
            const body = document.createElement('tbody');
            const firstDay = new Date(year, month, 1).getDay(); // 해당 월의 첫 번째 날의 요일
            const daysInMonth = new Date(year, month + 1, 0).getDate(); // 해당 월의 총 일수
            let date = 1;

            // 달력의 주단위로 날짜를 채우는 루프
            for (let i = 0; i < 6; i++) { // 최대 6주 표시
                const row = document.createElement('tr');
                let hasDates = false; // 이번 주에 날짜가 있는지 확인하는 플래그

                for (let j = 0; j < 7; j++) {
                    const cell = document.createElement('td');
                    if (i === 0 && j < firstDay) {
                        // 이전 달의 날짜 표시
                        const prevMonthDay = new Date(year, month, 0).getDate() - (firstDay - 1) + j;
                        cell.textContent = prevMonthDay;
                        cell.classList.add('other-month');
                        cell.dataset.date = new Date(year, month - 1, prevMonthDay).toISOString().split('T')[0];
                        cell.classList.add('clickable');
                        cell.addEventListener('mouseover', highlightWeek); // 마우스 오버 시 해당 주를 하이라이트
                        cell.addEventListener('click', selectWeek); // 클릭 시 해당 주를 선택
                    } else if (date > daysInMonth) {
                        // 다음 달의 날짜 표시
                        if (j < 7 && hasDates) { // 이번 주에 날짜가 있다면 빈칸을 다음 달 날짜로 채움
                            const nextMonthDate = date - daysInMonth;
                            cell.textContent = nextMonthDate;
                            cell.classList.add('other-month');
                            cell.dataset.date = new Date(year, month + 1, nextMonthDate).toISOString().split('T')[0];
                            cell.classList.add('clickable');
                            cell.addEventListener('mouseover', highlightWeek); // 마우스 오버 시 해당 주를 하이라이트
                            cell.addEventListener('click', selectWeek); // 클릭 시 해당 주를 선택
                            date++;
                        }
                    } else {
                        // 현재 달의 날짜 표시
                        cell.textContent = date;
                        cell.dataset.date = new Date(year, month, date).toISOString().split('T')[0];
                        cell.classList.add('clickable');
                        cell.addEventListener('mouseover', highlightWeek); // 마우스 오버 시 해당 주를 하이라이트
                        cell.addEventListener('click', selectWeek); // 클릭 시 해당 주를 선택
                        date++;
                        hasDates = true; // 이번 주에 날짜가 있음을 플래그로 설정
                    }
                    row.appendChild(cell);
                }

                body.appendChild(row);

                // 현재 달의 마지막 주에서 부족한 날짜가 없으면 루프 종료
                if (date > daysInMonth) break;
            }
            calendar.appendChild(body);
            container.appendChild(calendar);
        }

        /**
         * highlightWeek(event)
         * 사용자가 마우스를 날짜 셀에 올렸을 때 해당 주를 하이라이트 처리합니다.
         * @param {Event} event - 마우스 오버 이벤트 객체
         */
        function highlightWeek(event) {
            clearHighlight(); // 이전 하이라이트를 제거
            const cell = event.currentTarget;
            const row = cell.parentElement;
            row.querySelectorAll('td').forEach(td => td.classList.add('highlight'));
        }

        /**
         * selectWeek(event)
         * 사용자가 날짜 셀을 클릭했을 때 해당 주의 시작일과 종료일을 입력 필드에 표시하고, 전역 변수에 저장합니다.
         * @param {Event} event - 클릭 이벤트 객체
         */
        function selectWeek(event) {
            const cell = event.currentTarget;
            const row = cell.parentElement;

            // 선택한 셀의 날짜를 기준으로 주의 시작일과 종료일을 계산
            const selectedDate = new Date(cell.dataset.date);
            const dayOfWeek = selectedDate.getDay();

            // 주의 시작일 (일요일) 계산
            const startDate = new Date(selectedDate);
            startDate.setDate(selectedDate.getDate() - dayOfWeek);

            // 주의 종료일 (토요일) 계산
            const endDate = new Date(selectedDate);
            endDate.setDate(selectedDate.getDate() + (6 - dayOfWeek));

            // 전역 변수에 저장
            startOfWeek = startDate.toISOString().split('T')[0];
            endOfWeek = endDate.toISOString().split('T')[0];

            // 텍스트 필드에 선택된 주 표시
            document.getElementById('weekPicker').value = startOfWeek + ' - ' + endOfWeek;

            // 달력 모달 닫기
            const calendarModal = bootstrap.Modal.getInstance(document.getElementById('calendarModal'));
            calendarModal.hide();
            getUserStatisticsPerWeek();
        }

        /**
         * clearHighlight()
         * 주 하이라이트를 초기화합니다. 이전에 하이라이트된 주의 하이라이트를 제거합니다.
         */
        function clearHighlight() {
            document.querySelectorAll('.highlight').forEach(td => td.classList.remove('highlight'));
        }

        /**
         * populateYearAndMonthSelectors()
         * 연도와 월 선택 드롭다운을 생성하고 초기 값을 설정합니다.
         */
        function populateYearAndMonthSelectors() {
            const monthSelect = document.getElementById('monthSelect');
            const yearSelect = document.getElementById('yearSelect');
            const currentYear = new Date().getFullYear();
            const startYear = currentYear - 100;
            const endYear = currentYear + 10;
            const monthNames = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];

            // 월 선택 드롭다운에 옵션 추가
            monthNames.forEach((month, index) => {
                const option = document.createElement('option');
                option.value = index;
                option.textContent = month;
                monthSelect.appendChild(option);
            });

            // 연도 선택 드롭다운에 옵션 추가
            for (let year = startYear; year <= endYear; year++) {
                const option = document.createElement('option');
                option.value = year;
                option.textContent = year;
                yearSelect.appendChild(option);
            }

            // 현재 연도와 월을 기본값으로 설정
            monthSelect.value = currentMonth;
            yearSelect.value = currentYear;
        }

        /**
         * updateCalendar()
         * 사용자가 선택한 연도와 월을 기준으로 달력을 업데이트합니다.
         */
        function updateCalendar() {
            currentYear = parseInt(document.getElementById('yearSelect').value);
            currentMonth = parseInt(document.getElementById('monthSelect').value);
            generateCalendar(currentYear, currentMonth);
        }

        // 초기 설정 및 이벤트 리스너 추가
        document.addEventListener('DOMContentLoaded', function () {
            populateYearAndMonthSelectors(); // 연도와 월 선택 드롭다운을 초기화
            generateCalendar(currentYear, currentMonth); // 초기 달력 생성

            // 월 선택 변경 시 달력 업데이트
            document.getElementById('monthSelect').addEventListener('change', updateCalendar);

            // 연도 선택 변경 시 달력 업데이트
            document.getElementById('yearSelect').addEventListener('change', updateCalendar);

            // 이전 달 버튼 클릭 시 달력 업데이트
            document.getElementById('prevMonth').addEventListener('click', function () {
                currentMonth--;
                if (currentMonth < 0) {
                    currentMonth = 11;
                    currentYear--;
                }
                document.getElementById('monthSelect').value = currentMonth;
                document.getElementById('yearSelect').value = currentYear;
                updateCalendar();
            });

            // 다음 달 버튼 클릭 시 달력 업데이트
            document.getElementById('nextMonth').addEventListener('click', function () {
                currentMonth++;
                if (currentMonth > 11) {
                    currentMonth = 0;
                    currentYear++;
                }
                document.getElementById('monthSelect').value = currentMonth;
                document.getElementById('yearSelect').value = currentYear;
                updateCalendar();
            });

            // 주 선택 입력 필드 클릭 시 달력 모달 표시
            document.getElementById('weekPicker').addEventListener('click', function () {
                const calendarModal = new bootstrap.Modal(document.getElementById('calendarModal'));
                calendarModal.show();
            });
        });

        /**
         * getUserStatisticsPerWeek()
         * 선택된 주의 날짜를 사용하여 서버에 통계를 요청하고, 그 데이터를 사용하여 차트를 업데이트합니다.
         * 주가 선택되지 않은 경우, 경고 메시지를 표시합니다.
         */
        function getUserStatisticsPerWeek() {
            // weekPicker 필드에 값이 있는지 확인
            const weekPickerValue = document.getElementById('weekPicker').value;
            if (!weekPickerValue) {
                const today = new Date();
                const day = today.getDay();
                const diff = today.getDate() - day + (day == 0 ? -6 : 1);
                startOfWeek = new Date(today.setDate(diff)).toISOString().split('T')[0];
                endOfWeek = new Date(today.setDate(diff + 6)).toISOString().split('T')[0];
                document.getElementById('weekPicker').value = startOfWeek + ' - ' + endOfWeek;
            }

            // fetch 요청
            fetch('/admin/count-all/week?startDate=' + startOfWeek + '&endDate=' + endOfWeek)
                .then(response => response.json())
                .then(data => {
    				// console.log(data[0]);
                    updateChart(data); // 차트 업데이트
                })
                .catch(error => {
                    console.log("error: " + error);
                });
        }

        /**
         * updateChart(data)
         * Chart.js를 사용하여 바 차트를 업데이트합니다.
         * @param {Object[]} data - 서버에서 받은 데이터
         */
        function updateChart(data) {
            const labels = data.map(item => item.day);
            const signupData = data.map(item => item.signup_count);
            const withdrawData = data.map(item => item.withdraw_count);
            const ctx = document.getElementById('myChart').getContext('2d');
            if (myChart) {
                myChart.destroy(); // 기존 차트를 제거하고 새로운 차트를 생성
            }

            myChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [
                        {
                            label: '가입자 수',
                            data: signupData,
                            backgroundColor: 'rgba(54, 162, 235, 0.7)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1,
                            borderRadius: 10, // 모서리 반경 설정
                            borderSkipped: false
                        },
                        {
                            label: '탈퇴자 수',
                            data: withdrawData,
                            backgroundColor: 'rgba(255, 99, 132, 0.7)',
                            borderColor: 'rgba(255, 99, 132, 1)',
                            borderWidth: 1,
                            borderRadius: 10, // 모서리 반경 설정
                            borderSkipped: false
                        }
                    ]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    },
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        tooltip: {
                            enabled: true
                        }
                    }
                }
            });
        }

        
        
        
        // 페이지 로드 시 밑의 함수들을 호출하여 데이터 가져오기 및 차트 그리기
        window.onload = function() { 
        	getAllUsersCount();
        	countSubscribingUsers();
        	countUnSubscribingUsers();
        	chartSubscribingAmount();
        	chartCountAllSubRefund();
        	countAllViewCount();
        	countAllClickCount();
        	countAllAdPayment();
        	countAllAdRefundPayment();
            getUserMonth();
            getUserGender();
            getUserSocialType();
            getUserAge();
            getWithdrawReason();
            incrementClickCount();
            getUserStatisticsPerWeek();
        }; 
    </script>

<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/adminLayout/footer.jsp"%>