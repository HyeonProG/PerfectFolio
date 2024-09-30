<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/board.css">

<!-- sub banner -->
<div class="sub--banner">
	<h1>문의사항</h1>
</div>

<!-- s: container -->
<div class="container">

	<!-- s: QnA -->
	<section class="qna--area">
		<div class="sub--title">
			<div>
			<h3>문의사항</h3>
			<br>
			<p>서비스를 이용하시면서 궁금하셨던 점이나 불편하셨던 점을 편하게 문의해주세요.</p>
			<br>
			<p>답변에 소요되는 시간은 평균 1일 입니다.</p>
			</div>
			<c:if test="${principal != null }">
			<div>
			<a href="/board/write"><button class="search--btn">문의 남기기</button></a>
			</div>
		</c:if>
		</div>



		<!-- 검색 폼 -->
		<form id="searchForm" class="d-flex">
			<div class="form-group p-2">
				<select class="form-control" id="categories" name="categories">
					<option value="" disabled selected>문의유형 선택하기</option>
					<option value="회원정보">회원정보</option>
					<option value="구독/결제">구독/결제</option>
					<option value="포트폴리오">포트폴리오</option>
				</select>
			</div>
			<div class="form-group p-2">
				<select class="form-control" id="searchRange" name="searchRange">
					<option value="제목">제목</option>
					<option value="제목내용">제목+내용</option>
				</select>
			</div>
			<div class="form-group p-2 flex-fill">
				<input type="search" class="form-control" id="searchContents"
					name="searchContents" placeholder="검색할 내용을 입력하세요.">
			</div>
			<button type="submit" class="search--btn">검색</button>
		</form>

		<!-- 문의사항 목록 -->
		<div id="BoardListContainer" class="container text-center">
			<table class="table table-hover">
				<thead>
					<tr>
						<th>번호</th>
						<th>문의유형</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
						<th>답변여부</th>
					</tr>
				</thead>
				<tbody id="boardList">
					<!-- 데이터가 동적으로 삽입되는 구역 -->
				</tbody>
			</table>
			<!-- Pagination -->
			<div id="paginationContainer" class="d-flex justify-content-center">
				<!-- 페이지네이션이 동적으로 삽입되는 구역 -->
			</div>
		</div>
	</section>

	<div class="sub--top--nav">
		<span>서비스 > 문의사항</span>
	</div>
	<!-- e : QnA -->

	<!-- s: FAQ -->
	<section class="faq--area">
		<div class="sub--title">
			<h3>자주 묻는 질문</h3>
		</div>

		<div id="inner--faq">
			<div id="section1">
				<ul class="right">

					<li>
						<ul class="font0">
							<li class="font_10 c">
								<p>Q</p>
							</li>
							<li class="font_18">
								<div class="noc_po">매칭 정확도는 몇 퍼센트인가요?</div>
							</li>
							<li class="faq_plus"><i class="fa-solid fa-chevron-down"></i></li>
						</ul>
						<div class="text_info">
							<p class="answer">A</p>
							<p>퍼펙트 폴리오는 매일 수집되는 데이터를 기반으로 AI Model의 성능이 향상되고 있습니다.</p>
						</div>
						<p class="notice_line"></p>
					</li>

					<li>
						<ul class="font1">
							<li class="font_10 d">
								<p>Q</p>
							</li>
							<li class="font_18">
								<div class="noc_po">포트폴리오 관리는 어디까지 도와주나요?</div>
							</li>
							<li class="faq_plus"><i class="fa-solid fa-chevron-down"></i></li>
						</ul>
						<div class="text_info">
							<p class="answer">A</p>
							<p>취업 준비생은 본인의 기술 스택을 등록하여 설정한 레벨의 수준에 맞는 공고를 매칭합니다.</p>
						</div>
						<p class="notice_line"></p>
					</li>

					<li>
						<ul class="font1">
							<li class="font_10 d">
								<p>Q</p>
							</li>
							<li class="font_18">
								<div class="noc_po">어떻게 정기 구독을 해제하나요?</div>
							</li>
							<li class="faq_plus"><i class="fa-solid fa-chevron-down"></i></li>
						</ul>
						<div class="text_info">
							<p class="answer">A</p>
							<p>환불 신청을 하면 관리자 승인 후 규정에 따라 결제금액이 환불됩니다.</p>
						</div>
						<p class="notice_line"></p>
					</li>
					<li>
						<ul class="font1">
							<li class="font_10 d">
								<p>Q</p>
							</li>
							<li class="font_18">
								<div class="noc_po">이메일을 바꾸고 싶어요.</div>
							</li>
							<li class="faq_plus"><i class="fa-solid fa-chevron-down"></i></li>
						</ul>
						<div class="text_info">
							<p class="answer">A</p>
							<p>마이페이지에서 유효한 이메일을 인증하신 후 변경이 됩니다.</p>
						</div>
						<p class="notice_line"></p>
					</li>
					<li>
						<ul class="font1">
							<li class="font_10 d">
								<p>Q</p>
							</li>
							<li class="font_18">
								<div class="noc_po">광고 문의를 하고 싶어요.</div>
							</li>
							<li class="faq_plus"><i class="fa-solid fa-chevron-down"></i></li>
						</ul>
						<div class="text_info">
							<p class="answer">A</p>
							<p>광고주 계정을 생성하시면 자세한 정보를 확인하실 수 있습니다.</p>
						</div>
						<p class="notice_line"></p>
					</li>

				</ul>
			</div>
			<!-- Ad -->
			<div>
				<a id="imageLink" href="#"> <img id="randomImage"
					class="random-image" alt="" />
				</a>
			</div>
		</div>
	</section>
	<!-- e: FAQ -->

</div>

<script>

//페이지가 로드될 때 데이터 불러오기
document.addEventListener('DOMContentLoaded', () => {
    fetchPage(1, 10); // 페이지 1, 사이즈 10으로 초기 데이터 로드
});

//검색 폼의 제출 이벤트 처리
   document.getElementById('searchForm').addEventListener('submit', function(event) {
            event.preventDefault(); // 폼 제출 시 페이지의 새로고침, 서버로 데이터 전송 방지

            const categories = document.getElementById('categories').value;
            const searchRange = document.getElementById('searchRange').value;
            const searchContents = document.getElementById('searchContents').value;

            fetchPage(1, 10, categories, searchRange, searchContents); // 페이지 1, 사이즈 10으로 검색
        });

   // 페이지를 불러오는 함수
   function fetchPage(page, size, categories = '', searchRange = '', searchContents = '') {
      
   	// 전체 리스트 조회 시 URL
   	let fetchUrl = `http://localhost:8080/board/list?page=` + page + `&size=` + size;
       
       // 검색 시 URL
       if (categories) {
           fetchUrl += `&categories=` + encodeURIComponent(categories);
       }
       if (searchRange) {
           fetchUrl += `&searchRange=` + encodeURIComponent(searchRange);
       }
       if (searchContents) {
           fetchUrl += `&searchContents=` + encodeURIComponent(searchContents);
       }

       fetch(fetchUrl)
           .then(response => response.json())
           .then(data => {
        	   console.log(data);
               renderBoardList(data.boardList); // 공지사항 목록 렌더링
               renderPagination(data.totalCount, data.currentPage, data.pageSize, data.totalPages, categories, searchRange, searchContents); // 페이징 처리 렌더링
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
   function renderBoardList(boardList) {
       const boardListContainer = document.getElementById('boardList');

       // 기존 공지사항 항목 제거 - 새 데이터 추가 시 중복 방지
       while (boardListContainer.firstChild) {
    	   boardListContainer.removeChild(boardListContainer.firstChild);
       }
   // 공지사항 항목을 생성하고 컨테이너에 추가
   boardList.forEach(board => {
       // 행(tr) 요소 생성
       const tr = document.createElement('tr');
       tr.addEventListener('click', () => {
           window.location.href = "/board/view?boardId=" + board.id;
       });

       // 각 셀(td) 요소 생성 및 추가
       const idCell = document.createElement('td');
       idCell.textContent = board.id;
       tr.appendChild(idCell);

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
       
       const viewsCell = document.createElement('td');
       viewsCell.textContent = board.views;
       tr.appendChild(viewsCell);

       // 완성된 행을 공지사항 목록 컨테이너에 추가
       boardListContainer.appendChild(tr);
   });
   }
   
   
//페이지네이션을 렌더링하는 함수
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




// FAQ
$(function(){

	$(".right> li> .font0").click(function(){
		$(this).next().slideToggle();
		$( '.c p' ).toggleClass( 'ab' );
	});
	
		$(".right> li> .font1").click(function(){
		$(this).next().slideToggle();
		$( '.d p' ).toggleClass( 'ab' );
	});

});

$(function(){
	$(".right> li> ul").click(function(){
		$(this).children().children("i").toggleClass("turn");
	});
});

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