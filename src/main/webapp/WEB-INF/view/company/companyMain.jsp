<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/darkHeader.jsp"%>
<style>

</style>
</head>
<body>

</body>

<div class="container" id="box-container">

</div>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        fetchRecommendations();
    });

    function  fetchRecommendations() {
        fetch('/com/getSimilarityList')
            .then(response => handleResponse(response))
            .then(data => renderRecommendations(data))
            .catch(error => {
                console.log('Error : ', error);
            })
    }

    function handleResponse(response) {
        if (!response.ok) {
            return response.json().then(data => {
                throw new Error('ERROR');
            });
        }
        return response.json();
    }

    function renderRecommendations(data) {
        const container = document.getElementById('box-container');
        if(!container) {
            console.error('Container not exist');
            return;
        }

        const boxes = [];
        container.innerHTML = '';

        data.forEach(item => {
            console.log(item);
            const box = createRecommendationBox(item);
            boxes.push(box);
        });

        boxes.forEach(box => {
            container.appendChild(box);
        });
    }

    function createRecommendationBox(item) {
        const box = document.createElement('div');
        box.className = 'box';

        const similarityPercentage = item.similarity * 100;


        const infoWrapper = document.createElement('div');
        infoWrapper.className = 'info';

        const oneLiner = document.createInfoElement('한줄소개 ;', '열심히 최선을 다하겠습니다.');

        const chart = document.createElement('div');
        chart.className = 'chart';
        chart.style.setProperty('--percentage', similarityPercentage);
        chart.setAttribute('data-percentage', similarityPercentage.toFixed(0));

        const innerCircle = document.createElement('div');
        innerCircle.className = 'inner-circle';
        chart.appendChild(innerCircle); // 내부 원을 그래프에 추가

        box.appendChild(infoWrapper);
        box.appendChild(chart);

        return box;
    }

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

    function createUserInfoElement(url) {
        const wrapper = document.createElement('div');

        const link = document.createElement('a');
        link.href = url;
        link.target = "_blank";
        link.textContent = '해당 유저 정보 확인하기';

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
</body>
</html>
