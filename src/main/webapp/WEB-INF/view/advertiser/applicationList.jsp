<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/myInfoAd.css">
<style>
.inner--personal {
	border: 0px solid #eee;
    border-radius: 20px;
    padding: 2rem;
}
.active, .collapsible:hover {
    background-color: #fff;
}
.table {
    width: 100%; /* 테이블의 너비를 100%로 설정 */
}

.table th, .table td {
    text-align: left; /* 왼쪽 정렬 */
    padding: 8px; /* 셀 여백 추가 */
    border: 1px solid #ddd; /* 셀 경계 스타일 */
    vertical-align: middle; /* 수직 가운데 정렬 */
    white-space: nowrap; /* 텍스트 줄 바꿈 방지 */
    overflow: hidden; /* 넘치는 텍스트 숨기기 */
    text-overflow: ellipsis; /* 넘치는 텍스트에 ellipsis(...) 추가 */
}
.user--info table td {
    padding-left: 0.5rem;
    padding: 10 px;
}
.table th {
    text-align: center !important; /* 강제로 왼쪽 정렬 */
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
			<a href="/advertiser/application-list" class="bar--selected"><span
				data-feather="file"></span>신청내역</a> <a href="/advertiser/active-list"><span
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
				<p>신청내역</p>
			</div>

			<div class="inner--personal">
				<div class="user--info">
					<!-- 광고 신청 내역 테이블 -->
					<div id="applicationsContainer">
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>신청 ID</th>
									<th>광고 제목</th>
									<th>내용</th>
									<th>신청일</th>
									<th>신청 상태</th>
									<th>작업</th>
								</tr>
							</thead>
							<tbody id="applicationsList">
								<!-- 데이터가 동적으로 삽입되는 구역 -->
							</tbody>
						</table>
						<!-- Pagination -->
						<div id="paginationContainer"
							class="d-flex justify-content-center">
							<!-- 페이지네이션이 동적으로 삽입되는 구역 -->
						</div>
					</div>

					<c:if test="${empty applicationsList}">
						<p>광고 신청 내역이 없습니다.</p>
					</c:if>
				</div>
			</div>
		</div>
	</section>



</main>

<%@ include file="/WEB-INF/view/layout/lightFooter.jsp"%>

<script>
// 페이지가 로드될 때 데이터 불러오기
document.addEventListener('DOMContentLoaded', () => {
    fetchPage(1, 5); // 페이지 1, 사이즈 5로 초기 데이터 로드
});

// 페이지를 불러오는 함수
function fetchPage(page, size) {
    let fetchUrl = `/advertiser/application-list/data?page=` + page + `&size=` + size;

    fetch(fetchUrl)
        .then(response => response.json())
        .then(data => {
            renderApplicationsList(data.applicationsList); // 광고 신청 목록 렌더링
            renderPagination(data.totalCount, data.currentPage, data.pageSize, data.totalPages); // 페이지네이션 처리 렌더링
        })
        .catch(error => {
            console.error('Error:', error);
        });
}

// 광고 신청 목록을 렌더링하는 함수
function renderApplicationsList(applicationsList) {
    const applicationsListContainer = document.getElementById('applicationsList');

    // 기존 광고 신청 항목 제거 - 새 데이터 추가 시 중복 방지
    while (applicationsListContainer.firstChild) {
        applicationsListContainer.removeChild(applicationsListContainer.firstChild);
    }

    // 광고 신청 항목을 생성하고 컨테이너에 추가
    applicationsList.forEach(application => {
        // 행(tr) 요소 생성
        const tr = document.createElement('tr');

        // 각 셀(td) 요소 생성 및 추가
        const idCell = document.createElement('td');
        idCell.textContent = application.id;
        tr.appendChild(idCell);

        const titleCell = document.createElement('td');
        titleCell.textContent = application.title;
        tr.appendChild(titleCell);

        const contentCell = document.createElement('td');
        contentCell.textContent = application.content;
        tr.appendChild(contentCell);

        const createdAtCell = document.createElement('td');
        createdAtCell.textContent = new Date(application.createdAt).toLocaleDateString(); // Date 객체를 사용하여 포맷
        tr.appendChild(createdAtCell);

        const stateCell = document.createElement('td');
        stateCell.textContent = application.state;
        tr.appendChild(stateCell);

        const actionCell = document.createElement('td');
        const deleteButton = document.createElement('button');
        deleteButton.textContent = '삭제';
        deleteButton.className = 'btn btn-danger btn-sm';
        deleteButton.addEventListener('click', (event) => {
            event.stopPropagation(); // 클릭 시 행의 클릭 이벤트와 중복되지 않게
            deleteApplication(application.id);
        });
        actionCell.appendChild(deleteButton);
        tr.appendChild(actionCell);

        // 완성된 행을 광고 신청 목록 컨테이너에 추가
        applicationsListContainer.appendChild(tr);
    });
}

// 페이지네이션을 렌더링하는 함수
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
        if (currentPage > 1) { fetchPage(currentPage - 1, pageSize); }
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
            fetchPage(i, pageSize);
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
        if (currentPage < totalPages) { fetchPage(currentPage + 1, pageSize); }
    });
    nextLi.appendChild(nextLink);
    ul.appendChild(nextLi);

    // 완성된 페이지네이션을 페이지네이션 컨테이너에 추가
    paginationContainer.appendChild(ul);
}

// 광고 신청을 삭제하는 함수
function deleteApplication(id) {
    if (confirm("정말로 삭제하시겠습니까?")) {
        fetch('/advertiser/application-list/delete/' + id, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        })
        .then(response => {
            if (response.ok) {
                alert("삭제가 완료되었습니다.");
                window.location.reload(); // 페이지 새로 고침
            } else {
                alert('삭제 요청 오류: ' + response.statusText);
            }
        })
        .catch(error => {
            console.error('오류 발생:', error);
            alert('삭제 요청 중 오류 발생');
        });
    }
}
</script>
