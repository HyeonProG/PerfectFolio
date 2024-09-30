<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/darkHeader.jsp"%>
<link rel="stylesheet" href="/css/search.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<input type="hidden" id="companyId" value="${companyId}">


<style>
    .result-section{
        width: 80%;
        margin: 0 auto;
        padding-top: 64px;
    }
</style>

<!-- Flexbox로 검색창과 결과창을 가로로 나눈 컨테이너 -->
<div class="main-container">
    <!-- 결과창 섹션 -->
    <div class="result-section">
        <div class="result-container" id="result-container">
            <!-- 결과 아이템이 JavaScript로 추가됨 -->
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        let tags = []; // 태그 목록을 저장할 배열
        // 서버에서 즐겨찾기된 유저 목록을 가져오는 함수 호출
        fetchFavoriteUserList();

// 서버로부터 즐겨찾기 유저 목록을 가져오는 함수
        function fetchFavoriteUserList() {
            fetch('http://localhost:8080/company/favoriteList', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                }
            })
                .then(response => response.json())
                .then(data => {
                    console.log('서버 응답:', data);
                    // 결과 컨테이너만 업데이트
                    updateResultContainer(data);
                })
                .catch((error) => {
                    console.error('에러 발생:', error);
                });
        }

// 결과 컨테이너만 업데이트하는 함수 추가
        function updateResultContainer(users) {
            const container = document.getElementById('result-container');
            container.innerHTML = ''; // 기존 결과 지우기

            if (Array.isArray(users) && users.length > 0) {
                // users가 배열이고 데이터가 있을 때만 렌더링
                users.forEach(user => {
                    const resultItem = document.createElement('div');
                    resultItem.className = 'result-item animate';

                    let skillsHTML = '';
                    if (Array.isArray(user.skills)) {
                        user.skills.forEach(function(skill) {
                            skillsHTML += '<div class="skill">' + skill + '</div>';
                        });
                    }

                    resultItem.innerHTML =
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
                        '<button type="button" class="portfolio-btn" style="margin-right: 30px;' +
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

                    container.appendChild(resultItem);
                });
            } else {
                // users가 비어 있을 때
                const resultItem = document.createElement('div');
                resultItem.className = 'result-item animate';
                resultItem.innerHTML = '<div>즐겨찾기한 유저가 없습니다.</div>';
                container.appendChild(resultItem);
            }
        }
    }); // document.addEventListener 종료
        window.toggleFavorite = function(starIcon, userId) {
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

        };

        // 서버로 즐겨찾기 상태 전송
        function sendFavoriteToServer(userId, isFavorite) {
            const companyId = document.getElementById("companyId").value;

            fetch('http://localhost:8080/company/favorite', {
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
                    // 페이지 새로 고침 추가
                    window.location.reload();
                })
                .catch((error) => {
                    console.error('즐겨찾기 변경 에러:', error);
                });
        }

        // 즐겨찾기 삭제 함수
        function deleteFavorite(userId) {
            const companyId = document.getElementById("companyId").value;

            fetch('http://localhost:8080/company/favorite/delete', {
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
                fetch('http://localhost:8080/company/proposal', {
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
                        window.location.reload();
                    })
                    .catch((error) => {
                        alert('입사제안서 전송 에러: ' + error.message);
                        console.error('입사제안서 전송 에러:', error);
                    });
            }
        }

</script>


<style>
   /* !* 기본 상태는 검정색 *!
    .fa-star-o, .fa-star {
        color: black;
        font-size: 32px;
    }

    !* 클릭 후 활성화된 상태는 노란색 *!
    .favorite {
        color: gold;
    }

    !* 태그 선택 후에도 결과를 보기 위한 스타일 *!
    .result-container {
        margin-top: 60px;
    }

    !* 페이드 인 애니메이션 *!
    @keyframes fadeIn {
        from {
            opacity: 0;
        }
        to {
            opacity: 1;
        }
    }

    !* 슬라이드 인 애니메이션 (위쪽에서 아래로) *!
    @keyframes slideIn {
        from {
            transform: translateY(-50px);
        }
        to {
            transform: translateY(0);
        }
    }

    .skills {
        display: grid;
        grid-template-columns: repeat(6, 1fr); !* 한 줄에 6개의 스킬을 배치 *!
        gap: 10px; !* 스킬들 사이의 간격 조절 *!
    }

    .skill {
        !* 각 스킬의 스타일을 정의 *!
        padding: 10px;
        background-color: #f0f0f0; !* 배경 색상 *!
        border-radius: 5px; !* 둥근 테두리 *!
        text-align: center; !* 텍스트 가운데 정렬 *!
    }*/
</style>

<%@ include file="/WEB-INF/view/layout/darkFooter.jsp"%>
