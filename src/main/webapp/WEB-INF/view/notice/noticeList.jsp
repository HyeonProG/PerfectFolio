<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/notice.css">
<!-- sub banner -->
<div class="sub--banner">
	<h1>공지사항</h1>
</div>

<!-- s: container -->
<div class="container">
	<section class="notice--area">
		<h2>공지사항</h2>
		<c:if test="${admin != null}">
			<a href="/notice/create" class="btn btn-info">공지사항 글쓰기</a>
		</c:if>

		<!-- 검색 폼 -->
		<form id="searchForm" class="d-flex">
			<div class="form-group p-2">
				<select name="searchType" id="searchType" class="form-control">
					<option value="categories">카테고리</option>
					<option value="title">제목</option>
					<option value="titleAndContent">제목 + 내용</option>
				</select>
			</div>
			<div class="form-group p-2 flex-fill">
				<input type="text" name="keyword" id="keyword" class="form-control"
					placeholder="검색할 내용을 입력하세요.">
			</div>
			<button type="submit" class="search--btn">검색</button>
		</form>

		<!-- 공지사항 목록 -->
		<div id="noticeListContainer" class="container text-center">
			<table class="table table-hover" style="font-size: small;">
				<thead>
					<tr>
						<th>번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>내용</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody id="noticeList">
					<!-- 데이터가 동적으로 삽입되는 구역 -->
				</tbody>
			</table>

			<!-- Pagination -->
			<div id="paginationContainer" class="d-flex justify-content-center">
				<!-- 페이지네이션이 동적으로 삽입되는 구역 -->
			</div>
			<!-- Ad -->
			<div>
				<a id="imageLink" href="#"> <img id="randomImage"
					class="random-image" alt="" />
				</a>
			</div>
		</div>
	</section>
</div>



<script>
        // 페이지가 로드될 때 데이터 불러오기
        document.addEventListener('DOMContentLoaded', () => {
		const toggleBtn = document.querySelector('.navbar--toggleBtn');
		const menu = document.querySelector('.wrapper--menu');
		
		   if (toggleBtn) {
		        toggleBtn.addEventListener('click', () => {
		            if (menu) {
		                menu.classList.toggle('active');
		            }
		        });
		    }
		
            fetchPage(1, 10); // 페이지 1, 사이즈 10으로 초기 데이터 로드
        });

        // 검색 폼의 제출 이벤트 처리
        document.getElementById('searchForm').addEventListener('submit', function(event) {
            event.preventDefault(); // 폼 제출 시 페이지의 새로고침, 서버로 데이터 전송 방지

            const searchType = document.getElementById('searchType').value;
            const keyword = document.getElementById('keyword').value;

            fetchPage(1, 10, searchType, keyword); // 페이지 1, 사이즈 10으로 검색
        });

        // 페이지를 불러오는 함수
        function fetchPage(page, size, searchType = '', keyword = '') {
           
        	// 전체 리스트 조회 시 URL
        	let fetchUrl = `http:perfecfolio.jinnymo.com/notice/list?page=` + page + `&size=` + size;
            
            // 검색 시 URL
            if (searchType) {
                fetchUrl += `&searchType=` + encodeURIComponent(searchType);
            }
            if (keyword) {
                fetchUrl += `&keyword=` + encodeURIComponent(keyword);
            }

            fetch(fetchUrl)
                .then(response => response.json())
                .then(data => {
                    renderNoticeList(data.noticeList); // 공지사항 목록 렌더링
                    renderPagination(data.totalCount, data.currentPage, data.pageSize, data.totalPages, searchType, keyword); // 페이징 처리 렌더링
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

	 // 공지사항 목록을 렌더링하는 함수
	    function renderNoticeList(noticeList) {
	        const noticeListContainer = document.getElementById('noticeList');

	        // 기존 공지사항 항목 제거 - 새 데이터 추가 시 중복 방지
	        while (noticeListContainer.firstChild) {
	            noticeListContainer.removeChild(noticeListContainer.firstChild);
	        }

	        // 공지사항 항목을 생성하고 컨테이너에 추가
	        noticeList.forEach(notice => {
	            // 행(tr) 요소 생성
	            const tr = document.createElement('tr');
	            tr.addEventListener('click', () => {
	                window.location.href = "/notice/detail?id=" + notice.id;
	            });

	            // 각 셀(td) 요소 생성 및 추가
	            const idCell = document.createElement('td');
	            idCell.textContent = notice.id;
	            tr.appendChild(idCell);

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
	            
	            const viewsCell = document.createElement('td');
	            viewsCell.textContent = notice.views;
	            tr.appendChild(viewsCell);

	            // 완성된 행을 공지사항 목록 컨테이너에 추가
	            noticeListContainer.appendChild(tr);
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
				if (currentPage > 1) {
					fetchPage(currentPage - 1, pageSize, searchType, keyword);
				}
			});
			prevLi.appendChild(prevLink);
			ul.appendChild(prevLi);

			// 페이지 번호 링크
			const maxPages = 5; // 한 번에 표시할 최대 페이지 수
			let startPage = Math.max(1, currentPage - Math.floor(maxPages / 2));
			let endPage = Math.min(totalPages, startPage + maxPages - 1);

			// 시작 페이지를 조정하여 끝 페이지가 전체 페이지 수를 초과하지 않도록 합니다.
			if (endPage - startPage < maxPages - 1) {
				startPage = Math.max(1, endPage - maxPages + 1);
			}

			for (let i = startPage; i <= endPage; i++) {
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
				if (currentPage < totalPages) {
					fetchPage(currentPage + 1, pageSize, searchType, keyword);
				}
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
<!-- 광고 이미지 -->
<script>
    function fetchRandomImage() {
        fetch('http:perfecfolio.jinnymo.com/advertiser/random-image')
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
        fetch('http:perfecfolio.jinnymo.com/advertiser/increment-click', {
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