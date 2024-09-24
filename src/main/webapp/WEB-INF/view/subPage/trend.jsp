<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- header.jsp -->
<%@ include file="/WEB-INF/view/layout/darkHeader.jsp" %>
<!-- css -->
<link rel="stylesheet" href="/css/trend.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/devicon.min.css">
<!-- sub banner -->
<div class="main--banner" style="margin-top: 130px">

    <h1 style="color: white; text-align: center; font-size: 4em">Analytics Trend Skill</h1>
</div>
<main class="trend--wrap" style="margin-top: 60px">
    <hr style="border: 2px solid white; position: relative; top: 48px;">
    <div class="radio-inputs">
        <label class="radio">
            <input type="radio" name="radio" onchange="getDataByYear()">
            <span class="name">YEAR</span>
        </label>
        <label class="radio">
            <input type="radio" name="radio" onchange="getDataByMonth()">
            <span class="name">MONTH</span>
        </label>
        <label class="radio">
            <input type="radio" name="radio" onchange="getDataByDate()" checked>
            <span class="name">DAY</span>
        </label>
    </div>

    <section class="trend" style="margin-top: 50px">
        <!-- Swiper -->
        <div class="swiper mySwiper">
            <div class="swiper-wrapper"></div>
        </div>
    </section>
</main>

<!-- Initialize Swiper -->
<script>

    var swiper;


    function getDataByDate(){
        //어제 날짜 yyyy-mm-dd 형식으로 가져오기
        var today = new Date();
        var year = today.getFullYear();
        var month = today.getMonth() + 1;
        var day = today.getDate();
        if (month < 10) {
            month = '0' + month;
        }
        if (day < 10) {
            day = '0' + day;
        }
        var today2 = year + '-' + month + '-' + day;
        console.log(today2);
        getTrend(today2, today2);
    }
    function getDataByMonth(){
        var today = new Date();
        var yesterday = new Date(today.setDate(today.getDate() - 1));
        var year = yesterday.getFullYear();
        var month = yesterday.getMonth() + 1;
        var day1 = '01';
        var  day2 = '31';
        if (month < 10) {
            month = '0' + month;
        }
        var startDate = year + '-' + month + '-' + day1;
        var endDate = year + '-' + month + '-' + day2;
        console.log(startDate, endDate);
        getTrend(startDate, endDate);
    }
    function getDataByYear(){
        var today = new Date();
        var yesterday = new Date(today.setDate(today.getDate() - 1));
        var year = yesterday.getFullYear();
        var month1 = '01';
        var month2 = '12';
        var day1 = '01';
        var  day2 = '31';
        var startDate = year + '-' + month1 + '-' + day1;
        var endDate = year + '-' + month2 + '-' + day2;
        console.log(startDate, endDate);
        getTrend(startDate, endDate);
    }




    function initializeSwiper() {
        swiper = new Swiper(".mySwiper", {
            loop: true,
            slidesPerView: 4,
            spaceBetween: 30,
            autoplay: {
                delay: 1500,
                disableOnInteraction: false,
            },
            pagination: {
                el: ".swiper-pagination",
                clickable: true,
            },
        });
    }

    function getTrend(startDate, endDate) {
        fetch('/analystic/trendskills?startDate='+startDate+'&endDate='+endDate)
            .then(response => response.json())
            .then(data => {
                console.log(data);
                createSlides(data);
                if (swiper) {
                    swiper.update();
                } else {
                    initializeSwiper();
                }
            })
            .catch(error => console.log("error: " + error));
    }

    function createSlides(skills) {
        const swiperContainer = document.querySelector('.swiper-wrapper');
        swiperContainer.innerHTML = '';

        skills.forEach((skill, index) => {
            const slide = document.createElement('div');
            slide.classList.add('swiper-slide');

            if (index % 2 === 1) {
                slide.classList.add('under--card');
            }

            // 카드 컨테이너 생성
            const cardContainer = document.createElement('div');
            cardContainer.classList.add('card-container');

            const card = document.createElement('div');
            card.classList.add('card');

            // 첫 번째 콘텐츠
            const firstContent = document.createElement('div');
            firstContent.classList.add('first-content');

            const skillImg = document.createElement('img');
            let formattedSkillName = skill.skillname.toLowerCase();
            if (formattedSkillName === 'aws') {
                formattedSkillName = 'amazonwebservices';
            }
            formattedSkillName = formattedSkillName.replace(/\+/g, 'plus').replace(/#/g, 'sharp');

            let imgUrl = '';
            switch (formattedSkillName) {
                case 'amazonwebservices':
                    imgUrl = 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/amazonwebservices/amazonwebservices-original-wordmark.svg';
                    break;
                default:
                    imgUrl = 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/' + formattedSkillName + '/' + formattedSkillName + '-original.svg';
            }

            fetch(imgUrl).then(response => {
                if (response.ok) {
                    skillImg.src = imgUrl;
                } else {
                    skillImg.src = '/images/main/PerfectFolio_logo_white.gif';
                }
            }).catch(() => {
                skillImg.src = '/images/main/PerfectFolio_logo_white.gif';
            });

            skillImg.alt = skill.skillname + ' 이미지';
            skillImg.style.width = '150px';
            skillImg.style.height = '150px';
            firstContent.appendChild(skillImg);

            // 두 번째 콘텐츠
            const secondContent = document.createElement('div');
            secondContent.classList.add('second-content');

            const skillName = document.createElement('span');
            skillName.textContent = skill.skillname;
            skillName.style.fontSize = '1.5rem'; // 폰트 크기 조절
            skillName.style.fontWeight = 'bold'; // 폰트 굵기 조절
            skillName.style.color = '#000000'; // 글자 색상 (예: 금색)

            const totalCount = document.createElement('span');

            totalCount.textContent = '공고 ' + skill.requirecount + '개 중';
            const includeCount = document.createElement('span');

            const includePercentage = ((skill.count / skill.requirecount) * 100).toFixed(1);
            includeCount.textContent = includePercentage + '%';

            secondContent.appendChild(skillName);
            secondContent.appendChild(totalCount);
            secondContent.appendChild(includeCount);

            slide.addEventListener('mouseenter', () => {
                swiper.autoplay.stop(); // 슬라이드 루프 멈춤
                card.classList.add('flipped'); // 카드 뒤집기
            });

            slide.addEventListener('mouseleave', () => {
                swiper.autoplay.start(); // 슬라이드 루프 재개
                card.classList.remove('flipped'); // 카드 원래대로
            });


            // 카드에 콘텐츠 추가
            card.appendChild(firstContent);
            card.appendChild(secondContent);
            cardContainer.appendChild(card);
            slide.appendChild(cardContainer);

            swiperContainer.appendChild(slide);
        });
    }

    window.onload = getDataByDate;
</script>

<!-- footer.jsp -->
<%@ include file="/WEB-INF/view/layout/lightFooter.jsp" %>