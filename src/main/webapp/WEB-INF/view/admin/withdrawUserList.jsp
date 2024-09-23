<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/adminLayout/header.jsp"%>

<link rel="stylesheet" href="/css/chart.css">


<div class="contents--wrap">
	<form id="withdrawUserInfo" class="d-flex align-items-center">
		<div class="search--form">
			<!-- 검색 폼 -->
			<select name="searchType" id="searchType" class="form-control" style="margin-top: 9px;">
				<option value="">전체보기</option>
				<option value="reasonDetail">사유 상세보기</option>
			</select>
			<div class="form-group p-2" style="width: 200px;">
				<button type="submit" class="btn btn-primary search-btn">검색</button>
			</div>
		</div>
	</form>


	<!-- 탈퇴자 목록 -->
	<div id="withdrawListContainer" class="list--container">
		<h2>탈퇴자 목록</h2>
		<table class="table">
			<thead>
				<tr>
					<th>번호</th>
					<th>아이디</th>
					<th>가입 날짜</th>
					<th>탈퇴 날짜</th>
					<th>탈퇴 사유</th>
					<th>상세 사유</th>
				</tr>
			</thead>
			<tbody id="withdrawList">
				<!-- 동적으로 삽입 -->
			</tbody>
		</table>
	</div>

	<!-- Pagination -->
	<div id="paginationContainer" class="d-flex justify-content-center">
		<!-- 페이지네이션이 동적으로 삽입되는 구역 -->
	</div>
	<div class="select--btn">
		<a href="/admin/userListPage" class="btn btn-primary">회원 조회</a>
	</div>
</div>

<script>

	document.getElementById('withdrawUserInfo').addEventListener('submit', function(event) {
		event.preventDefault(); // 새로고침 방지
		const searchType = document.getElementById('searchType').value;
		fetchPage(1, 10, searchType);
	});

	function fetchPage(page, size, searchType='') {

		// 전체 리스트 조회 URL
		let fetchUrl = `http:perfecfolio.jinnymo.com/admin/withdrawUserInfo?page=` + page + `&size=` + size;

		if(searchType) {
			fetchUrl +=`&searchType=` + encodeURIComponent(searchType);
		}

		fetch(fetchUrl)
				.then(response => response.json())
				.then(data => {
					console.log(data);
					renderWithdrawList(data.withdrawList);
					renderPagination(data.totalCount, data.currentPage, data.pageSize, data.totalPages); // 페이징 처리 렌더링
				})
				.catch(error => {
					console.error('Error:', error);
				});
	}

	// 날짜를 YYYY-MM-DD HH:MM:SS 형식으로 포맷
	function formatDate(dateString) {

		const date = new Date(dateString);

		// padStart(2, '0') -> 두자리, 0부터 시작(예: 08월/일/시/분/초)
		const year = date.getFullYear();
		const month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
		const day = String(date.getDate()).padStart(2, '0');
		const hours = String(date.getHours()).padStart(2, '0');
		const minutes = String(date.getMinutes()).padStart(2, '0');
		const seconds = String(date.getSeconds()).padStart(2, '0');

		return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
	}

	// 사용자 목록을 렌더링하는 함수
	function renderWithdrawList(withdrawList) {
		const withdrawListContainer = document.getElementById('withdrawList');

		// 기존 공지사항 항목 제거 - 새 데이터 추가 시 중복 방지
		while (withdrawListContainer.firstChild) {
			withdrawListContainer.removeChild(withdrawListContainer.firstChild);
		}

		// 사용자 목록을 생성하고 컨테이너에 추가
		withdrawList.forEach(user => {
			// 행(tr) 요소 생성
			const tr = document.createElement('tr');

			// 각 셀(td) 요소 생성 및 추가
			const idCell = document.createElement('td');
			idCell.textContent = user.id;
			tr.appendChild(idCell);

			const userIdCell = document.createElement('td');
			userIdCell.textContent = user.userId;
			tr.appendChild(userIdCell);

			const createAtCell = document.createElement('td');
			createAtCell.textContent = formatDate(user.createdAt);
			tr.appendChild(createAtCell);

			const withdrawAtCell = document.createElement('td');
			withdrawAtCell.textContent = formatDate(user.withdrawAt);
			tr.appendChild(withdrawAtCell);

			const reasonCell = document.createElement('td');
			reasonCell.textContent = user.reason;
			tr.appendChild(reasonCell);

			const reasonDetailCell = document.createElement('td');
			reasonDetailCell.textContent = user.reasonDetail;
			tr.appendChild(reasonDetailCell);

			// 완성된 행을 공지사항 목록 컨테이너에 추가
			withdrawListContainer.appendChild(tr);
		});
	}

    // 페이지네이션을 렌더링하는 함수
    function renderPagination(totalCount, currentPage, pageSize, totalPages, searchType = '', keyword = '') {

    	 const paginationContainer = document.getElementById('paginationContainer');

    	    // 기존 페이지네이션 항목 제거
    	    while (paginationContainer.firstChild) {
    	        paginationContainer.removeChild(paginationContainer.firstChild);
    	    }

    	    // 페이지네이션 리스트 생성
    	    const ul = document.createElement('ul');
    	    ul.className = 'pagination';
    	    
    		// 이전 10페이지 링크
    	    const prev10Li = document.createElement('li');
    	    prev10Li.className = currentPage > 10 ? 'page--item' : 'page--item disabled';
    	    const prev10Link = document.createElement('a');
    	    prev10Link.className = 'page--link';
    	    prev10Link.textContent = '<<';
    	    prev10Link.addEventListener('click', (event) => {
    	    	 event.preventDefault();
    	    	    if (currentPage > 1) {
    	    	        if (currentPage > 10) {
    	    	            fetchPage(currentPage - 10, pageSize, searchType, keyword);
    	    	        } else {
    	    	            fetchPage(1, pageSize, searchType, keyword); // 첫 페이지로 이동
    	    	        }
    	    	    }

    	    });
    	    prev10Li.appendChild(prev10Link);
    	    ul.appendChild(prev10Li);
    	    

    	    // 이전 페이지 링크
    	    const prevLi = document.createElement('li');
    	    prevLi.className = currentPage > 1 ? 'page--item' : 'page--item disabled';
    	    const prevLink = document.createElement('a');
    	    prevLink.className = 'page--link';
    	    prevLink.textContent = '<';
    	    prevLink.addEventListener('click', (event) => {
    	        event.preventDefault(); // 페이지 이동 및 새로 고침 방지
    	        if (currentPage > 1) {fetchPage(currentPage - 1, pageSize, searchType, keyword)};
    	    });
    	    prevLi.appendChild(prevLink);
    	    ul.appendChild(prevLi);

    	    // 페이지 번호 링크
    	    for (let i = 1; i <= totalPages; i++) {
    	        const li = document.createElement('li');
    	        li.className = i === currentPage ? 'page--item active' : 'page--item';
    	        const link = document.createElement('a');
    	        link.className = 'page--link';
    	        link.textContent = i;
    	        link.addEventListener('click', (event) => {
    	            event.preventDefault(); // 페이지 이동 및 새로 고침 방지
    	            fetchPage(i, pageSize, searchType, keyword);
    	        });
    	        li.appendChild(link);
    	        ul.appendChild(li);
    	    }

    	    // 다음 페이지 링크
    	    const nextLi = document.createElement('li');
    	    nextLi.className = currentPage < totalPages ? 'page--item' : 'page--item disabled';
    	    const nextLink = document.createElement('a');
    	    nextLink.className = 'page--link';
    	    nextLink.textContent = '>';
    	    nextLink.addEventListener('click', (event) => {
    	        event.preventDefault(); // 페이지 이동 및 새로 고침 방지
    	        if (currentPage < totalPages) {fetchPage(currentPage + 1, pageSize, searchType, keyword)};
    	    });
    	    nextLi.appendChild(nextLink);
    	    ul.appendChild(nextLi);
    	    
    		// 다음 10페이지 링크
    	    const next10Li = document.createElement('li');
    	    next10Li.className = currentPage < totalPages - 9 ? 'page--item' : 'page--item disabled';
    	    const next10Link = document.createElement('a');
    	    next10Link.className = 'page--link';
    	    next10Link.textContent = '>>';
    	    next10Link.addEventListener('click', (event) => {
    	        event.preventDefault();
    	        if (currentPage < totalPages) {
    	            if (currentPage < totalPages - 9) {
    	                fetchPage(currentPage + 10, pageSize, searchType, keyword);
    	            } else {
    	                fetchPage(totalPages, pageSize, searchType, keyword); // 마지막 페이지로 이동
    	            }
    	        }
    	    });
    	    next10Li.appendChild(next10Link);
    	    ul.appendChild(next10Li);

    	    // 완성된 페이지네이션을 페이지네이션 컨테이너에 추가
    	    paginationContainer.appendChild(ul);
    }
</script>
<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/adminLayout/footer.jsp"%>