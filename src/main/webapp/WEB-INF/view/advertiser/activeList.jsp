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
    width: 100%;
}

.table th, .table td {
    text-align: left;
    padding: 8px;
    border: 1px solid #ddd;
    vertical-align: middle;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
.user--info table td {
    padding-left: 0.5rem;
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
			<a href="/advertiser/my-info" data-feather="users"><span data-feather="users"></span>계정관리</a>
		</div>
		<div class="bar--items">
			<p>광고</p>
			<a href="/advertiser/application"><span data-feather="file"></span>신청하기</a>
			<a href="/advertiser/application-list"><span data-feather="file"></span>신청내역</a>
			<a href="/advertiser/active-list" class="bar--selected"><span data-feather="shopping-cart"></span>게시 내역</a>
			<a href="/advertiser/payment"><span data-feather="bar-chart-2"></span>충전하기</a>
			<a href="/advertiser/requesting-refund">환불 요청</a>
		</div>
		<div class="bar--items">
			<p>탈퇴</p>
			<a href="/advertiser/withdraw"><span data-feather="message-square"></span>탈퇴하기</a>
		</div>
	</aside>

	<!-- 메인 컨텐츠 영역 -->
	<section>
		<div class="personal--wrap">
			<div>
				<h2>광고</h2>
				<p>사용중인 광고 내역</p>
			</div>

			<div class="inner--personal">
				<div class="user--info">
					<!-- 광고 내역 테이블 -->
					<div id="activeAdsContainer">
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>광고 ID</th>
									<th>제목</th>
									<th>상태</th>
									<th>광고 시작일</th>
									<th>조회수</th>
									<th>접속수</th>
									<th></th>
								</tr>
							</thead>
							<tbody id="activeAdsList">
								<!-- 데이터가 동적으로 삽입되는 구역 -->
							</tbody>
						</table>

						<!-- Pagination -->
						<div id="paginationContainer" class="d-flex justify-content-center">
							<!-- 페이지네이션이 동적으로 삽입되는 구역 -->
						</div>
					</div>
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
    let fetchUrl = `http:perfecfolio.jinnymo.com/advertiser/active-list/data?page=` + page + `&size=` + size;

    fetch(fetchUrl)
        .then(response => response.json())
        .then(data => {
            renderActiveAdsList(data.activeAdList);
            renderPagination(data.totalCount, data.currentPage, data.pageSize, data.totalPages);
        })
        .catch(error => {
            console.error('Error:', error);
        });
}

// 광고 내역 목록을 렌더링하는 함수
function renderActiveAdsList(activeAdList) {
    const activeAdsListContainer = document.getElementById('activeAdsList');

    while (activeAdsListContainer.firstChild) {
        activeAdsListContainer.removeChild(activeAdsListContainer.firstChild);
    }

    activeAdList.forEach(ad => {
        const tr = document.createElement('tr');

        const idCell = document.createElement('td');
        idCell.textContent = ad.id;
        tr.appendChild(idCell);

        const titleCell = document.createElement('td');
        titleCell.textContent = ad.title;
        tr.appendChild(titleCell);

        const stateCell = document.createElement('td');
        stateCell.textContent = ad.state;
        tr.appendChild(stateCell);

        const createdAtCell = document.createElement('td');
        createdAtCell.textContent = new Date(ad.createdAt).toLocaleDateString();
        tr.appendChild(createdAtCell);

        const viewCountCell = document.createElement('td');
        viewCountCell.textContent = ad.viewCount;
        tr.appendChild(viewCountCell);

        const clickCountCell = document.createElement('td');
        clickCountCell.textContent = ad.clickCount;
        tr.appendChild(clickCountCell);

        const actionCell = document.createElement('td');
        const form = document.createElement('form');
        form.action = "/advertiser/update-ad";
        form.method = "post";
        form.onsubmit = function() { return confirmChange(ad.state === '승인' ? '중지' : '승인'); };

        const idInput = document.createElement('input');
        idInput.type = 'hidden';
        idInput.name = 'id';
        idInput.value = ad.id;

        const stateInput = document.createElement('input');
        stateInput.type = 'hidden';
        stateInput.name = 'state';
        stateInput.value = ad.state === '승인' ? '중지' : '승인';

        const button = document.createElement('button');
        button.type = 'submit';
        button.className = 'btn btn-success';
        button.textContent = ad.state === '승인' ? '중지' : '사용';

        form.appendChild(idInput);
        form.appendChild(stateInput);
        form.appendChild(button);
        actionCell.appendChild(form);
        tr.appendChild(actionCell);

        activeAdsListContainer.appendChild(tr);
    });
}

// 페이지네이션을 렌더링하는 함수
function renderPagination(totalCount, currentPage, pageSize, totalPages) {
    const paginationContainer = document.getElementById('paginationContainer');

    while (paginationContainer.firstChild) {
        paginationContainer.removeChild(paginationContainer.firstChild);
    }

    const ul = document.createElement('ul');
    ul.className = 'pagination';

    // 이전 페이지 링크
    const prevLi = document.createElement('li');
    prevLi.className = currentPage > 1 ? 'page-item' : 'page-item disabled';
    const prevLink = document.createElement('a');
    prevLink.className = 'page-link';
    prevLink.textContent = 'Previous';
    prevLink.addEventListener('click', (event) => {
        event.preventDefault();
        if (currentPage > 1) { fetchPage(currentPage - 1, pageSize); }
    });
    prevLi.appendChild(prevLink);
    ul.appendChild(prevLi);

    for (let i = 1; i <= totalPages; i++) {
        const li = document.createElement('li');
        li.className = i === currentPage ? 'page-item active' : 'page-item';
        const link = document.createElement('a');
        link.className = 'page-link';
        link.textContent = i;
        link.addEventListener('click', (event) => {
            event.preventDefault();
            fetchPage(i, pageSize);
        });
        li.appendChild(link);
        ul.appendChild(li);
    }

    const nextLi = document.createElement('li');
    nextLi.className = currentPage < totalPages ? 'page-item' : 'page-item disabled';
    const nextLink = document.createElement('a');
    nextLink.className = 'page-link';
    nextLink.textContent = 'Next';
    nextLink.addEventListener('click', (event) => {
        event.preventDefault();
        if (currentPage < totalPages) { fetchPage(currentPage + 1, pageSize); }
    });
    nextLi.appendChild(nextLink);
    ul.appendChild(nextLi);

    paginationContainer.appendChild(ul);
}

// 광고 상태 변경 확인 함수
function confirmChange(action) {
    return confirm("정말로 광고 상태를 '" + action + "'로 변경하시겠습니까?");
}
</script>
