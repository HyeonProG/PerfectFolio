<%--
  Created by IntelliJ IDEA.
  User: pth
  Date: 9/11/24
  Time: 14:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/view/layout/darkHeader.jsp" %>

<style>
    body {
        justify-content: center;
        align-items: flex-start; /* 중앙에서 위로 정렬 */
        height: 100vh;
        background-color: #444;
        margin: 0;
    }

    .container {
        display: flex;
        flex-direction: column;
        gap: 35px;
        width: 100%; /* 가로 크기 100%로 설정 */
        max-width: 750px; /* 최대 가로 크기 설정 */
        padding-top: 200px; /* 헤더와의 간격 추가 */
    }

    .box {
        width: 100%; /* 박스가 컨테이너의 가로 크기를 사용하도록 설정 */
        padding: 20px;
        background-color: white;
        border-radius: 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: 18px;
        font-weight: bold;
        color: #333;
        line-height: 1.5;
    }


    .info {
        display: flex;
        flex-direction: column;
    }

    .info div {
        margin-bottom: 10px;
    }
    body {
        justify-content: center;
        align-items: flex-start; /* 중앙에서 위쪽으로 정렬 */
        height: 100vh;
        background-color: #444;
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif; /* 기본 폰트 설정 */
    }

    .container {
        flex-direction: column;
        gap: 35px;
        width: 100%; /* 전체 가로 크기 100% */
        max-width: 750px; /* 최대 가로 크기 750px */
        padding-top: 200px; /* 헤더와의 간격 */
        margin: 0 auto; /* 가운데 정렬 */
    }

    .box {
        width: 100%; /* 컨테이너 가로 크기 */
        padding: 20px;
        background-color: white;
        border-radius: 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: 18px;
        font-weight: bold;
        color: #333;
        line-height: 1.5;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 박스 그림자 */
    }

    .info {
        display: flex;
        flex-direction: column;
    }

    .info div {
        margin-bottom: 10px;
    }

    .inline-info {
        display: flex;
        gap: 20px; /* 주소와 사이트 간 간격 */
    }

    .chart {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        display: flex;
        justify-content: center;
        align-items: center;
        position: relative;
        background: conic-gradient(
                white calc(100% - (var(--percentage) * 1%)),
                lightgreen calc(100% - (var(--percentage) * 1%)) 100%
        );
    }

    .inner-circle {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        background-color: white;
        position: absolute;
    }

    .chart::after {
        content: attr(data-percentage) '%';
        position: absolute;
        font-size: 18px;
        color: black;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        z-index: 1;
    }

    .filters-container {
        justify-content: flex-end;
        gap: 10px; /* 필터 사이 간격 */
        width: 100%;
        padding: 10px;
        position: absolute;
        top: 120px; /* 헤더 아래 위치 */
        right: 0;
    }

    .select-box {
        padding: 5px;
        border-radius: 5px;
        border: 1px solid #ccc;
        font-size: 16px;
    }

    /* 원형 그래프 */
    .chart {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        display: flex;
        justify-content: center;
        align-items: center;
        position: relative;
        background: conic-gradient(
                white calc(100% - (var(--percentage) * 1%)), /* 역시계 방향으로 비어있는 부분 */ lightgreen calc(100% - (var(--percentage) * 1%)) 100% /* 역시계 방향으로 차오르는 부분 */
        );
    }

    /*@keyframes fill-donut {*/
    /*    0% {*/
    /*        background: conic-gradient(white 100%, lightgreen 0%);*/
    /*    }*/
    /*    100% {*/
    /*        background: conic-gradient(*/
    /*                white calc(100% - (var(--percentage) * 1%)), !* 역시계 방향으로 비어있는 부분 *!*/
    /*                lightgreen calc(100% - (var(--percentage) * 1%)) 100% !* 역시계 방향으로 차오르는 부분 *!*/
    /*        );*/
    /*    }*/
    /*}*/

    .inner-circle {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        background-color: white; /* 내부 원 색상 */
        position: absolute;
    }

    .chart::after {
        content: attr(data-percentage) '%'; /* 백분율 표시 */
        position: absolute; /* 절대 위치 */
        font-size: 18px; /* 글자 크기 */
        color: black; /* 글자 색상 */
        top: 50%; /* 부모의 50% 위치 */
        left: 50%; /* 부모의 50% 위치 */
        transform: translate(-50%, -50%); /* 중앙 정렬 */
        z-index: 1; /* 텍스트를 위에 표시 */
    }

    .inline-info {
        display: flex;
        gap: 20px; /* 회사 주소와 사이트 간의 간격 */
    }

    .filters-container {
        justify-content: flex-end;
        gap: 10px; /* 필터들 사이의 간격 */
        width: 100%;
        padding: 10px;
        position: absolute;
        top: 120px; /* 헤더 아래 위치 */
        right: 0; /* 우측 정렬 */

    }
</style>
<div class="main--banner" style="margin-top: 130px">

    <h1 style="color: white; text-align: center; font-size: 4em">Personal Analytics Service</h1>
</div>
<div class="filters-container">
    <div class="qualification-options-container">
        <select id="qualification-recommendOptions" class="select-box">
            <option value="downArray">매칭률 내림차순</option>
            <option value="upArray">매칭률 오름차순</option>
        </select>
    </div>

    <c:if test="${principal.subscribing == 'Y'}">
        <div class="date-options-container">
            <select id="date-recommendOptions" class="select-box">
                <option value="today">오늘</option>
                <c:if test="${principal.orderName == 'premium'}">
                    <option value="yesterday">어제</option>
                    <option value="oneWeek">최근 1주일</option>
                </c:if>
            </select>
        </div>

        <c:if test="${principal.orderName == 'premium'}">
            <div class="date-options-container">
            <select id="fix-similarity" class="select-box">
            <option value="all">전체 보기</option>
            <option value="six">60% 이상</option>
            <option value="seven">70% 이상</option>
            <option value="eight">80% 이상</option>
            <option value="nine">90% 이상</option>
        </c:if>
        </select>
        </div>
    </c:if>

</div>

<div class="container" id="box-container">
    <%--동적으로 추가되는 부분--%>
</div>



<script>
    document.addEventListener('DOMContentLoaded', () => {
        const qualificationElement = document.getElementById('qualification-recommendOptions');
        const dateElement = document.getElementById('date-recommendOptions');
        const fixSimilarityElement = document.getElementById('fix-similarity')
        if (qualificationElement) {
            qualificationElement.addEventListener('change', fetchRecommendations);
        } else {
            console.error('qualification-recommendOptions element not found.');
        }

        if (dateElement) {
            dateElement.addEventListener('change', fetchRecommendations);
        } else {
            console.error('date-recommendOptions element not found.');
        }
        if (fixSimilarityElement) {
            fixSimilarityElement.addEventListener('change', fetchRecommendations);
        } else {
            console.error('fix-similarity element not found.');
        }
        fetchRecommendations();
    });

    /**
     * 서버로부터 추천 데이터를 가져오는 함수
     */
    function fetchRecommendations() {
        const defaultQualificationOption = 'downArray'; // 기본 정렬: 내림차순
        const defaultDateOption = 'today'; // 기본 날짜: 오늘
        const defaultSimilarity = 'all';
        // 요소가 null이 아닐 경우에만 값을 가져옴
        const qualificationOption = document.getElementById('qualification-recommendOptions')
            ? document.getElementById('qualification-recommendOptions').value
            : defaultQualificationOption;

        const dateOption = document.getElementById('date-recommendOptions')
            ? document.getElementById('date-recommendOptions').value
            : defaultDateOption;

        const similarityOption = document.getElementById('fix-similarity')
            ? document.getElementById('fix-similarity').value
            : defaultSimilarity;
        const url = 'http://perfecfolio.jinnymo.com/user/getRecommend?dateOption=' + dateOption + '&qualificationOption=' + qualificationOption + '&similarityOption=' + similarityOption;
        console.log('url', url)
        fetch(url)
            .then(response => handleResponse(response))
            .then(data => renderRecommendations(data))
            .catch(error => console.error('Error fetching recommendations:', error));
        console.log('qualificationOption:', qualificationOption);
        console.log('dateOption:', dateOption);

    }


    /**
     * 서버 응답을 처리하는 함수
     * @param {Response} response - fetch API의 응답 객체
     * @returns {Promise<any>} - JSON 형식의 데이터
     */
    function handleResponse(response) {
        if (!response.ok) {
            return response.json().then(data => {
                throw new Error('ERROR');
            });
        }
        return response.json();
    }

    /**
     * 추천 데이터를 DOM에 렌더링하는 함수
     * @param {Array} data - 추천 데이터 배열
     */
    function renderRecommendations(data) {
        const container = document.getElementById('box-container');
        if (!container) {
            console.error('Container element not found.');
            return;
        }

        // 기존 내용을 비우기 위해 배열 사용
        const boxes = [];
        container.innerHTML = ''; // 기본적으로 innerHTML로 초기화

        data.forEach(item => {
            console.log(item);
            console.log(item.similarity);
            const box = createRecommendationBox(item);
            boxes.push(box); // 박스를 배열에 추가
        });

        // 배열에 있는 박스들을 컨테이너에 추가
        boxes.forEach(box => {
            container.appendChild(box);
        });
    }


    /**
     * 추천 정보를 담은 박스를 생성하는 함수
     * @param {Object} item - 추천 데이터 객체
     * @returns {HTMLElement} - 생성된 박스 요소
     */
    function createRecommendationBox(item) {
        const box = document.createElement('div');
        box.className = 'box';

        // 매칭 점수 백분율 계산
        const similarityPercentage = item.similarity * 100;

        // 각 항목을 위한 요소 생성
        const infoWrapper = document.createElement('div');
        infoWrapper.className = 'info';

        // 분야명 표기
        const titleElement = createInfoElement('분야: ', item.title);
        infoWrapper.appendChild(titleElement);

        // 회사명 표기
        if (item.companyName === null) {
            const hiddenNameELement = createInfoElement('회사명 : ', '???');
            infoWrapper.appendChild(hiddenNameELement);
        } else {
            const companyNameElement = createInfoElement('회사명: ', item.companyName);
            infoWrapper.appendChild(companyNameElement);
        }

        // 회사 주소와 사이트를 가로로 배치
        const inlineInfo = document.createElement('div');
        inlineInfo.className = 'inline-info';
        if (item.jobUrl === null) {
            const paymentUrl = 'http://perfecfolio.jinnymo.com/pay/subscribe';
            const hiddenUrlElement = createPaymentLinkElement(paymentUrl)
            hiddenUrlElement.addEventListener('click', function (event) {
                handleLinkClick(event, paymentUrl);  // URL을 핸들러로 전달
            });
            inlineInfo.appendChild(hiddenUrlElement);
        } else {
            const jobUrlElement = createLinkElement(item.jobUrl);
            inlineInfo.appendChild(jobUrlElement);
        }

        if (item.site === null) {
            const hiddenSite = createInfoElement('참고 사이트:', '???');
            inlineInfo.appendChild(hiddenSite);
        } else {
            const jobSiteElement = createInfoElement('참고 사이트:', item.site);
            inlineInfo.appendChild(jobSiteElement);
        }
        infoWrapper.appendChild(inlineInfo);

        // 원형 그래프 생성
        const chart = document.createElement('div');
        chart.className = 'chart';
        chart.style.setProperty('--percentage', similarityPercentage);
        chart.setAttribute('data-percentage', similarityPercentage.toFixed(0));

        const innerCircle = document.createElement('div');
        innerCircle.className = 'inner-circle';
        chart.appendChild(innerCircle); // 내부 원을 그래프에 추가

        setTimeout(() => {
            chart.classList.add('animate');
        }, 10);

        // chart.style.background = 'rgba(0, 128, 0, 0.82)';
        // const chart = document.createElement('div');
        // chart.className = 'chart';
        // chart.style.setProperty('--percentage', similarityPercentage);

        // 색상 결정
        <%--    let chartColor;--%>
        <%--    if (similarityPercentage < 50) {--%>
        <%--        chartColor = 'rgba(255,0,0,0.76)';--%>
        <%--    } else if (similarityPercentage >= 50 && similarityPercentage < 60) {--%>
        <%--        chartColor = 'rgba(255,133,40,0.93)';--%>
        <%--    } else if (similarityPercentage >= 60 && similarityPercentage < 70) {--%>
        <%--        chartColor = 'rgba(255,224,0,0.91)';--%>
        <%--    } else if (similarityPercentage >= 70 && similarityPercentage < 80) {--%>
        <%--        chartColor = 'rgba(162,255,0,0.7)';--%>
        <%--    } else if (similarityPercentage >= 80 && similarityPercentage < 90) {--%>
        <%--        chartColor = 'rgba(0,255,157,0.82)';--%>
        <%--    } else {--%>
        <%--        chartColor = 'rgb(108,255,255)';--%>
        <%--    }--%>
        <%--    console.log('chartColor', chartColor);--%>
        <%--    chart.style.background = `conic-gradient(--%>
        <%--    ${chartColor} 0% ${similarityPercentage}%,--%>
        <%--    white ${similarityPercentage}% 100%--%>
        <%--)`;--%>
        //     chart.setAttribute('data-percentage', similarityPercentage.toFixed(0));

        // 박스에 정보와 그래프 추가
        box.appendChild(infoWrapper);
        box.appendChild(chart);


        return box;
    }

    /**
     * 정보 요소를 생성하는 함수
     * @param {string} label - 정보 레이블
     * @param {string} text - 텍스트 내용
     * @returns {HTMLElement} - 생성된 정보 요소
     */
    function createInfoElement(label, text) {
        const wrapper = document.createElement('div');

        const strong = document.createElement('strong');
        strong.textContent = label;

        const span = document.createElement('span');
        span.textContent = text;

        wrapper.appendChild(strong);
        wrapper.appendChild(span);

        return wrapper;
    }

    /**
     * 링크 요소를 생성하는 함수
     * @param {string} url - 링크 주소
     * @returns {HTMLElement} - 생성된 링크 요소
     */
    function createLinkElement(url) {
        const wrapper = document.createElement('div');

        const link = document.createElement('a');
        link.href = url;
        link.target = '_blank';
        link.textContent = '회사 사이트 바로가기';

        // wrapper.appendChild(strong);
        wrapper.appendChild(link);

        return wrapper;
    }

    /**
     * !결제! 링크 요소를 생성하는 함수
     * @param {string} url - 링크 주소
     * @returns {HTMLElement} - 생성된 링크 요소
     */
    function createPaymentLinkElement(url) {
        const wrapper = document.createElement('div');

        const link = document.createElement('a');
        link.href = url;

        link.target = '_blank';
        link.textContent = '해당 정보는 구독을 통해 확인하실 수 있습니다.';
        link.style.color = 'gray'

        // wrapper.appendChild(strong);
        wrapper.appendChild(link);

        return wrapper;
    }

    // 클릭 이벤트 핸들러 함수
    function handleLinkClick(event, url) {
        event.preventDefault();  // 기본 링크 동작을 막음
        openPopup(url);  // 팝업 열기
    }

    // 팝업 창을 여는 함수
    function openPopup(url) {
        window.open(url, 'popupWindow', 'width=900,height=1600,scrollbars=yes');
    }

</script>


<!-- footer.jsp -->
<%@ include file="/WEB-INF/view/layout/lightFooter.jsp" %>
