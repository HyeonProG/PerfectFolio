<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<link rel="stylesheet" href="/css/search.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<input type="hidden" id="companyId" value="${companyId}">
<!-- Flexbox로 검색창과 결과창을 가로로 나눈 컨테이너 -->
<div class="main-container">
    <!-- 검색창 섹션 -->
<%--    <div class="search-section">
        <div class="search-container">
            <div class="search-bar">
                <div class="search-input-wrapper">
                    <input type="text" id="search-input" placeholder="검색어를 입력하세요" autocomplete="off" readonly />
                    <!-- 태그 추가 버튼 -->
                    <button type="button" id="search-btn">
                        <i class="fa fa-search"></i>
                    </button>
                </div>
            </div>
            <div class="selected-tags" id="selected-tags">
                <!-- 선택된 태그들이 여기에 추가됨 -->
            </div>
            <!-- 태그를 JSON으로 보내는 검색하기 버튼 추가 -->
            <button id="submit-btn" class="additional-search-btn">검색하기</button>
        </div>
    </div>--%>
    <section class="search-section">
        <div class="title--heading">
            <h3>매일 수집하는 2000개 이상의 데이터</h3>
            <h1>기술 스택 검색으로 원하시는 인재를 찾아보세요.</h1>
        </div>
        <div class="search-input-wrapper">
            <input type="text" id="search-input" placeholder="기술 스택을 입력하세요" <%--autocomplete="off"--%> <%--readonly--%> />
            <!-- 태그 추가 버튼 -->
            <button type="button" id="search-btn">
                <i class="fa fa-search"></i>
            </button>
            <div id="autocomplete-box"></div>
        </div>

        <div class="selected-tags-wrap">
        <div class="selected-tags" id="selected-tags">
            <!-- 선택된 태그들이 여기에 추가됨 -->
            <!-- 태그를 JSON으로 보내는 검색하기 버튼 추가 -->
        </div>
        <button id="submit-btn" class="additional-search-btn">검색 계속 진행하기</button>
        </div>
    </section>

    <!-- 모달 창 -->
<%--    <div id="search-modal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>태그 검색</h2>
            <input type="text" id="modal-search-input" placeholder="검색어를 입력하세요">
            <button type="button" id="modal-search-btn">검색</button>
            <div id="autocomplete-box"></div>
        </div>
    </div>--%>

    <!-- 결과창 섹션 -->
    <div class="result-section" id="result-section">
        <div class="result-container" id="result-container">
            <!-- 결과 아이템이 JavaScript로 추가됨 -->
        </div>
    </div>

</div>

<script>
    const resultWrap = document.getElementById('result-section');
    const container = document.getElementById('result-container');

    document.addEventListener('DOMContentLoaded', function () {
        let tags = []; // 태그 목록을 저장할 배열
        let  availableTags = []; // 서버에서 제공받은 태그 리스트를 저장할 배열
        let currentResultIndex = 0;

        // 모달 제어 변수
       /* const modal = document.getElementById("search-modal");*/
        const inputField = document.getElementById("search-input");
        const searchBtn = document.getElementById("search-btn");
      /*  const closeBtn = document.getElementsByClassName("close")[0];*/

        // 모달을 열면 서버로부터 리스트를 가져와 자동완성 박스에 표시
        inputField.addEventListener('click', function () {
          /*  modal.style.display = "block";*/
         /*   document.getElementById("modal-search-input").focus(); // 모달의 input에 커서 이동*/
            fetchTagList(); // 서버에서 리스트 데이터를 가져옴
        });

        searchBtn.addEventListener('click', function () {
        /*    modal.style.display = "block";*/
        /*    document.getElementById("modal-search-input").focus(); // 모달의 input에 커서 이동*/
            fetchTagList(); // 서버에서 리스트 데이터를 가져옴
        });

        // 서버에서 리스트 데이터를 받아오는 함수
        function fetchTagList() {
            fetch('http:perfecfolio.jinnymo.com/company/tagList')  // 컨트롤러에서 제공하는 리스트 API 경로
                .then(response => response.json())
                .then(data => {
                    availableTags = data; // 서버에서 받아온 태그 리스트 저장
                })
                .catch((error) => {
                    console.error('에러 발생:', error);
                });
        }

        // 모달 닫기 버튼
      /*  closeBtn.addEventListener('click', function () {
            modal.style.display = "none";
        }); */

        // 검색 버튼 클릭 시 입력된 값을 사용하여 필터링된 리스트 표시
        document.getElementById("search-btn").addEventListener("click", function () {
            const searchInput = document.getElementById("search-input");
            const searchText = searchInput.value.trim().toLowerCase();

            if (searchText === "") {
                alert('기술 스택을 입력해 주세요.');
                return;
            }
            console.log('dd')
            // 입력된 검색어와 일치하는 항목만 필터링
            const filteredTags = availableTags.filter(tag => tag.toLowerCase().includes(searchText));
            console.log('ddddddd')

            // 필터링된 리스트를 모달창에 표시
            displayTagList(filteredTags);
        });

        // 모달창의 input에서 Enter 키를 눌렀을 때도 검색이 동작하도록 수정
        document.getElementById('search-input').addEventListener('keydown', function (event) {
            if (event.key === 'Enter') {
                event.preventDefault(); // 기본 Enter 동작(폼 제출 등)을 막음
                document.getElementById('search-btn').click(); // 검색 버튼 클릭 이벤트 호출
            }
        });

        // 필터링된 리스트를 모달창에 div 태그로 표시하는 함수 수정
        function displayTagList(tagList) {
            const autocompleteBox = document.getElementById("autocomplete-box");
            autocompleteBox.style.display = "block"
            autocompleteBox.innerHTML = ""; // 기존 내용을 지움

            if (tagList.length === 0) {
                autocompleteBox.innerHTML = "<div>검색 결과가 없습니다.</div>";
                return;
            }

            tagList.forEach(tag => {
                const item = document.createElement("div");
                item.classList.add("autocomplete-item");
                item.textContent = tag;

                // 태그를 클릭하면 선택한 태그를 추가하는 기능
                item.addEventListener("click", function () {
                    addTag(tag);
                    document.getElementById("search-input").value = "";
                    autocompleteBox.style.display = "none";
                   /* modal.style.display = "none"; // 태그를 클릭한 후 모달창 닫기 */
                });

                autocompleteBox.appendChild(item);
            });
        }

        // 태그 추가 로직 - 서버에서 제공된 값만 태그로 추가
        function addTag(tagText) {
            const selectedTagsContainer = document.getElementById("selected-tags");

            // 중복 태그 방지
            const existingTags = [...selectedTagsContainer.querySelectorAll(".tag span")];
            if (existingTags.some(tag => tag.textContent === tagText)) {
                return; // 이미 동일한 태그가 있을 경우 추가하지 않음
            }

            // 태그를 담을 div 생성
            const tagDiv = document.createElement("div");
            tagDiv.classList.add("tag");

            // 태그 텍스트 추가
            const tagContent = document.createElement("span");
            tagContent.textContent = tagText;
            tagDiv.appendChild(tagContent);

            // x 버튼 추가
            const removeBtn = document.createElement("span");
            removeBtn.classList.add("remove-tag");
            removeBtn.textContent = "x";
            removeBtn.addEventListener("click", function () {
                tagDiv.remove();
                tags = tags.filter(t => t !== tagText); // 태그 목록에서 제거
            });

            tagDiv.appendChild(removeBtn);
            selectedTagsContainer.appendChild(tagDiv);
            tags.push(tagText); // 태그 목록에 추가
        }




        // 모달 외부를 클릭하면 모달 창 닫기
       /* window.addEventListener('click', function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }); */

        // 검색하기 버튼 클릭 시 검색창 애니메이션과 결과창 표시
        document.getElementById('submit-btn').addEventListener('click', function () {
            if (tags.length > 0) {
                // 검색창을 왼쪽으로 이동하는 애니메이션 적용
                /*document.querySelector('.search-container').classList.add('active');*/

                // 검색 결과 섹션을 활성화
                /*document.querySelector('.result-section').classList.add('active');*/

                container.innerHTML = '<div id="loading-wrap"><div id="load" style="font-size: 30px">' +
                    '<div>인</div>' +
                    '<div>재</div>' +
                    '<div>를</div>' +
                    '<div></div>' +
                    '<div>찾</div>' +
                    '<div>는</div>' +
                    '<div>중</div>' +
                    '</div></div>'

                // JSON으로 변환할 객체 생성
                const jsonData = JSON.stringify({
                    company_id: ${companyId},
                    qualifications: tags // 태그 목록을 qualifications로 전송
                });

                console.log("전송된 데이터:", jsonData); // 콘솔에 JSON 출력

                // fetch를 사용하여 서버로 데이터 전송 (POST 요청)
                fetch('http:perfecfolio.jinnymo.com/company/search', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: jsonData,
                })
                    .then(response => response.json())
                    .then(data => {
                        container.innerHTML = '';
                        console.log('서버 응답:', data);
                        displaySearchResults(data); // 받아온 데이터로 결과창에 유저 목록 표시
                    })
                    .catch((error) => {
                        console.error('에러 발생:', error);
                    });
            } else {
                alert("태그를 추가해 주세요!");
            }
        });

        // 유저 데이터를 결과창에 표시하는 함수 (검색하기 눌렀을 때만 실행)
        function displaySearchResults(users) {

            container.innerHTML = ''; // 기존 결과 지우기

            // matchCount를 기준으로 내림차순 정렬
            users.sort((a, b) => b.matchCount - a.matchCount);

            users.forEach(user => {
                const resultItem = document.createElement('div');
                resultItem.className = 'result-item animate'; // 애니메이션 추가


            // 매칭 상태 메시지 생성
            const matchStatus = tags.length + '개 중 ' + user.matchCount + '개 일치, 매칭률 : ' + user.rate;

                // 각 스킬을 순환하며 HTML 요소로 추가
                let skillsHTML = '';
                for (let i = 0; i < user.skills.length; i++) {
                    if (i >= 6) break;
                    skillsHTML += '<div class="skill">' + user.skills[i] + '</div>';
                }

            // 결과 아이템을 문자열 결합 방식으로 생성
                resultItem.innerHTML =
                    '<div class="' +
                    (tags.length === user.matchCount ? 'match-status-100' :
                        user.matchCount >= (tags.length / 2) ? 'match-status-50' : 'match-status-0') +
                    '">' + matchStatus + '</div>' +
                    '<div class="profile-header">' +
                    '<div class="profile-name">' + user.name + '</div>' +
                    '<i class="fa ' + (user.isFavorite ? 'fa-star favorite' : 'fa-star-o') + '" ' +
                    'data-id="' + user.id + '" ' +
                    'onclick="toggleFavorite(this, ' + user.id + ')" ' +
                    'style="cursor: pointer;">' +
                    '</i>' +  // 즐겨찾기 아이콘
                    '</div>' +
                    '<div class="skills">' +
                    skillsHTML +  // 각 스킬 리스트 추가
                    '</div>' +  // 매칭 상태 표시
                    '<div class="portfolio-btn-wrap"><button type="button" class="portfolio-btn" style="margin-bottom: 10px;' +
                    (user.portfolio === null ? 'background-color: grey;' : '') + '"' +
                    (user.portfolio === null ? ' disabled' : '') + '>' +
                    (user.portfolio !== null ?
                        '<a href="/portfolio/download/' + user.portfolio.uploadFileName + '" style="color: white; text-decoration: none;">포트폴리오 보기</a>' :
                        '포트폴리오 보기') +
                    '</button>' +
                    '<button type="button" id="proposal-btn-' + user.id + '" class="portfolio-btn" ' +
                    'onclick="sendProposal(' + user.id + ')" ' +
                    (user.isProposal ? 'disabled style="background-color: grey;"' : '') + '>' +
                    '입사제안서 넣기' +
                    '</button>';


                // 생성한 결과 아이템을 결과 컨테이너에 추가
                container.appendChild(resultItem);
            });
        }
    });

    //즐겨찾기 토글 함수
    function toggleFavorite(starIcon, userId) {
        const isFavorite = starIcon.classList.contains('fa-star');

        // 아이콘의 클래스 변경 (빈 별 ↔ 채워진 별)
        if (starIcon.classList.contains('fa-star-o')) {
            starIcon.classList.remove('fa-star-o');
            starIcon.classList.add('fa-star');
            starIcon.classList.add('favorite'); // 노란색 적용
            sendFavoriteToServer(userId, true);  // 서버에 즐겨찾기 등록 요청
        } else {
            starIcon.classList.remove('fa-star');
            starIcon.classList.add('fa-star-o');
            starIcon.classList.remove('favorite'); // 노란색 제거
            sendFavoriteToServer(userId, false);  // 서버에 즐겨찾기 해제 요청
        }
    }

    //서버로 즐겨찾기 상태 전송
    function sendFavoriteToServer(userId, isFavorite) {
        const companyId = document.getElementById("companyId").value;

        fetch('http:perfecfolio.jinnymo.com/company/favorite', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ comId: companyId, userId: userId, favorite: isFavorite }),
        })
            .then(response => response.json().then(data => ({ status: response.status, data: data })))
            .then(result => {
                if (result.status === 409) {
                    if (confirm("이미 즐겨찾기에 등록된 사용자입니다. 즐겨찾기를 해제하시겠습니까?")) {
                        deleteFavorite(userId);
                    }
                } else {
                    alert(result.data.message);
                }
            })
            .catch((error) => {
                console.error('즐겨찾기 변경 에러:', error);
            });
    }

    // 즐겨찾기 삭제 함수
    function deleteFavorite(userId) {
        const companyId = document.getElementById("companyId").value;

        fetch('http:perfecfolio.jinnymo.com/company/favorite/delete', {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ comId: companyId, userId: userId })
        })
            .then(response => response.json())
            .then(data => {
                alert('즐겨찾기가 해제되었습니다.');
            })
            .catch((error) => {
                console.error('즐겨찾기 해제 에러:', error);
            });
    }

    //입사제안서 보내기 함수
    function sendProposal(userId) {
        // 서버로 입사제안서 전송 (예시로 POST 요청 사용)
        if(confirm("정말 입사제안서를 보내시겠습니까? 수량이 소모됩니다.")) {
            fetch('http:perfecfolio.jinnymo.com/company/proposal', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ userId: userId }),
            })
                .then(response => {
                    if (!response.ok) {
                        // 상태 코드가 2xx가 아닌 경우 에러 처리
                        return response.json().then(data => { throw new Error(data.error); });
                    }
                    return response.json();
                })
                .then(data => {
                    alert('입사제안서가 성공적으로 전송되었습니다.');
                    document.getElementById("proposal-btn-" + userId).disabled = true;
                    document.getElementById("proposal-btn-" + userId).style.backgroundColor = "gray";
                })
                .catch((error) => {
                    alert('입사제안서 전송 에러: ' + error.message);
                    console.error('입사제안서 전송 에러:', error);
                });
        }
    }


</script>

<style>
    /* 모달 스타일 */
    /*.modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.4);
        padding-top: 60px;
    }*/

/*    .modal-content {
        background-color: #fefefe;
        margin: 5% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
        max-width: 500px;
    }*/

/*    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }*/

/*    .close:hover, .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }*/

    /* 기본 상태는 검정색 */
    .fa-star-o, .fa-star {
        color: black;
        font-size: 32px;
    }

    /* 클릭 후 활성화된 상태는 노란색 */
    .favorite {
        color: gold;
    }

    /* 검색창 초기 상태 (중앙 배치) */
/*    .search-container {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        transition: all 0.5s ease;
        width: 400px;
    }*/

    /* 검색창이 왼쪽으로 이동할 때 적용되는 클래스 */
/*    .search-container.active {
        top: 20px;
        left: 20px;
        transform: translate(0, 0);
        width: 300px;
    }*/

    /* 결과창 숨김 상태 */
    .result-section {
        transition: opacity 0.5s ease;
    }

    /* 검색 결과가 나타날 때 활성화 */
    .result-section.active {
        display: block;
        opacity: 1;
        animation: fadeIn 1s ease, slideIn 1s ease; /* 애니메이션 추가 */
    }

    /* 태그 선택 후에도 결과를 보기 위한 스타일 */
    .result-container {
        margin-top: 60px;
    }

    /* 페이드 인 애니메이션 */
    @keyframes fadeIn {
        from {
            opacity: 0;
        }
        to {
            opacity: 1;
        }
    }

    /* 슬라이드 인 애니메이션 (위쪽에서 아래로) */
    @keyframes slideIn {
        from {
            transform: translateY(-50px);
        }
        to {
            transform: translateY(0);
        }
    }
</style>

<%@ include file="/WEB-INF/view/layout/lightFooter.jsp"%>
