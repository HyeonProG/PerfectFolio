<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/darkHeader.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/mainStyle.css">

<!-- 메인 배너 -->
<div class="main--banner">
	<div class="banner--text">
		<h1>개발자 성장을 위한 첫걸음 <br> 퍼펙트폴리오와 함께</h1>
		<p>1만개 이상의 모집 공고를 간단한 검색만으로 자동 매칭! <br> 신개념 서비스를 월 구독제로 편리하게 이용해보세요.</p>
		<a href="/pay/subscribe" class="more--btn">정기결제 상품 보러가기</a>

		<ul class="job--data">
			<li>
				<div class="counter-wrapper">
					<div class="counter-back" id="totalMatch-back">0</div>
					<div class="counter" id="totalMatch">0</div>
				</div>
				<p>누적 매칭 공고</p>
			</li>
			<li>
				<div class="counter-wrapper">
					<div class="counter-back" id="todayMatch-back">0</div>
					<div class="counter" id="todayMatch">0</div>
				</div>
				<p>오늘 매칭 공고</p>
			</li>
			<li>
				<div class="counter-wrapper">
					<div class="counter-back" id="totalNotice-back">0</div>
					<div class="counter" id="totalNotice">0</div>
				</div>
				<p>누적 공고</p>
			</li>
			<li>
				<div class="counter-wrapper">
					<div class="counter-back" id="todayNotice-back">0</div>
					<div class="counter" id="todayNotice">0</div>
				</div>
				<p>오늘 올라온 공고</p>
			</li>
		</ul>
	</div>
</div>


<main class="container">

	<section class="introduce section--area">
		<div class="title--heading">
			<h1>Perfect folio</h1>
			<h3>자체적인 기준으로 포트폴리오를 매칭하다.</h3>
			<p>
				퍼펙트폴리오는 개발자 취업준비생과 기업을 <br>매칭해드리는 서비스를 제공하는 플랫폼입니다.
			</p>
			<p>
				매일 공고를 찾아보느라 소비되는 30분, <br>퍼펙트폴리오는 개발자를 위해 개발자가 <br>소비하는
				시간을 절약할 수 있도록 <br>효율적인 방법을 찾고자 시작한 서비스입니다.
			</p>
			<p>
				개발자가 작업에만 집중할 수 있도록. <br>퍼펙트폴리오가 만들어 드릴 수 있습니다.
			</p>
			<a href="#" class="more--btn">more</a>
		</div>
		<div class="introduce--content">
			<ul class="demo-ul1">
				<li class="demo1" data-aos="fade-left"><img
					src="/images/main/code-1076536_1280.jpg" alt=""></li>
				<li class="demo2" data-aos="fade-left" data-aos-duration="1000"><img
					src="/images/main/8281945.jpg" alt=""></li>
			</ul>
			<ul class="demo-ul2">
				<li class="demo3" data-aos="fade-left"><img
					src="/images/main/213123.jpg" alt=""></li>
				<li class="demo4" data-aos="fade-left" data-aos-duration="1000"><img
					src="/images/main/php-programming-html-coding-cyberspace-concept.png"
					alt=""></li>
			</ul>
		</div>
	</section>

<!-- Matching Secret -->
	<section class="trade--secret section--area">
		<div class="title--heading" data-aos="fade-up" data-aos-duration="700">
			<h1>Matching Secret</h1>
			<h3>포트폴리오 매칭은 어떻게 이루어질까요?</h3>
		</div>
		<ul data-aos="fade-up" data-aos-duration="700" class="secret--items">
			<li>
				<figure>
					<img alt=""
						src="https://www.wellysis.com/img/main/main01_img01.png">
				</figure>
				<div>
					<p>서칭</p>
					<p>국내 모든 공고를 수시로 확인해요</p>
				</div>
			</li>
			<li>
				<figure>
					<img alt=""
						src="https://www.wellysis.com/img/main/main01_img02.png">
				</figure>
				<div>
					<p>인공지능</p>
					<p>모든 공고를 AI로 분석해요</p>
				</div>
			</li>
			<li>
				<figure>
					<img alt=""
						src="https://www.wellysis.com/img/main/main01_img03.png">
				</figure>
				<div>
					<p>알고리즘</p>
					<p>최적의 분석을 통해 최적의 공고를 추천해요</p>
				</div>
			</li>

		</ul>
	</section>

	<section class="matching--step section--area">
		<div class="title--heading" data-aos="fade-up" data-aos-duration="700">
			<h1>Progress</h1>
			<h3>기술 스택 매칭을 통해 포트폴리오를 트랜드에 맞춰 채워나갑니다.</h3>
		</div>

		<div class="step--wrap">
			<ul class="inner-step">
				<li class="step--item" data-aos="fade-up" data-aos-duration="800">
					<div>
						<span class="step--badge">1단계</span>
						<p class="step--text">자신의 기술 스택을 꼼꼼히 입력해주시고 포트폴리오를 업로드 해주세요.</p>
					</div>
					<div class="step--img">
						<img src="/images/main/2150170128.jpg"
							alt="">
					</div>
				</li>
				<li class="step--item" data-aos="fade-up" data-aos-duration="900">
					<div>
						<span class="step--badge">2단계</span>
						<p class="step--text">기술 스택을 키워드로 검색하면 일치 확률이 높을수록 상위권에 노출됩니다.
						</p>
					</div>
					<div class="step--img">
						<img src="/images/main/2149160932.jpg"
							alt="">
					</div>
				</li>
				<li class="step--item" data-aos="fade-up" data-aos-duration="900">
					<div>
						<span class="step--badge">3단계</span>
						<p class="step--text">이용자와 기업 모두 매칭을 통해 컨택을 취할 수 있습니다.</p>
					</div>
					<div class="step--img">
						<img src="/images/main/2151003789.jpg"
							alt="">
					</div>
				</li>
				<li class="step--item" data-aos="fade-up" data-aos-duration="900">
					<div>
						<span class="step--badge">4단계</span>
						<p class="step--text">
							최종적으로 이용자와 기업 모두 원하는 인재와 기업처를 찾는 것이 <br>퍼펙트폴리오가 추구하는 목적입니다.
						</p>
					</div>
					<div class="step--img">
						<img src="/images/main/12151256.png"
							alt="">
					</div>
				</li>
			</ul>
		</div>
	</section>
</main>

<!-- 크롤링 사이트 애니메이션 -->
<section class="section--area">
	<div class="title--heading text--center">
		<h1>Where from?</h1>
	</div>
	<div id="slider">
		<div class="image-box">
			<div>
				<img src="https://www.wellysis.com/img/main/par_img07.png" />
			</div>
			<div>
				<img src="https://www.wellysis.com/img/main/inv_img04.png" />
			</div>
			<div>
				<img src="https://www.wellysis.com/img/main/par_img03.png" />
			</div>
			<div>
				<img src="https://www.wellysis.com/img/main/inv_img02.png" />
			</div>
			<div>
				<img src="https://www.wellysis.com/img/main/par_img09.png" />
			</div>
			<div>
				<img src="https://www.wellysis.com/img/main/par_img07.png" />
			</div>
			<div>
				<img src="https://www.wellysis.com/img/main/par_img09.png" />
			</div>
			<div>
				<img src="https://www.wellysis.com/img/main/par_img05.png" />
			</div>

			<!--   clone     -->
			<div class="clone">
				<img src="https://www.wellysis.com/img/main/par_img07.png" />
			</div>
			<div class="clone">
				<img src="https://www.wellysis.com/img/main/inv_img04.png" />
			</div>
			<div class="clone">
				<img src="https://www.wellysis.com/img/main/par_img03.png" />
			</div>
			<div class="clone">
				<img src="https://www.wellysis.com/img/main/inv_img02.png" />
			</div>
			<div class="clone">
				<img src="https://www.wellysis.com/img/main/par_img09.png" />
			</div>
			<div class="clone">
				<img src="https://www.wellysis.com/img/main/par_img07.png" />
			</div>
			<div class="clone">
				<img src="https://www.wellysis.com/img/main/par_img09.png" />
			</div>
			<div class="clone">
				<img src="https://www.wellysis.com/img/main/par_img07.png" />
			</div>
		</div>
	</div>
</section>


<!-- 	<section class="board section--area">
		<div class="title--heading">
			<h2>구독제 후기</h2>
		</div>

		Swiper
		<div class="swiper subcribleSwiper">
			<div class="swiper-wrapper">
				<div class="swiper-slide">Slide 1</div>
				<div class="swiper-slide">Slide 2</div>
				<div class="swiper-slide">Slide 3</div>
				<div class="swiper-slide">Slide 4</div>
				<div class="swiper-slide">Slide 5</div>
				<div class="swiper-slide">Slide 6</div>
				<div class="swiper-slide">Slide 7</div>
				<div class="swiper-slide">Slide 8</div>
				<div class="swiper-slide">Slide 9</div>
			</div>
			<div class="swiper-pagination"></div>
		</div>



		Initialize Swiper
		<script>
			var swiper = new Swiper(".subcribleSwiper", {
				slidesPerView : 3,
				spaceBetween : 30,
				loop : true,
				pagination : {
					el : ".swiper-pagination",
					clickable : true,
				},
			});
		</script>
	</section> -->

<main class="container">
	<!-- 공지사항 -->
	<%-- <section class="notice section--area">
		<div class="title--heading d-flex justify-content-between">
			<h1>Notice</h1>
			<a href="/notice/listPage" class="notice--more--btn">더보기<i class="fa-solid fa-arrow-right"></i></a>
		</div>
		<div class="notice--board">
			<ul class="notice--item">
				<c:forEach var="notice" items="${notice}">
					<li class="notice--link" data-aos="fade-up"><span>${notice.createdAt}</span>
						<p>${notice.title}</p></li>
				</c:forEach>
			</ul>

		</div>
	</section> --%>

	<!-- Contact Us -->
	<section class="section--area">
		<div class="title--heading">
			<h1>Contact Us</h1>
		</div>
		<div class="contact--us">
			<a href="#">
				<div>
					<img src="/images/main/digital-marketing-1725340_1280.png" alt="">
				</div>
				<div class="cover--text">
					<p class="cover--p">퍼펙트폴리오는 언제나 사업제안을 기다리고 있습니다.</p>
				</div>
			</a>
		</div>
	</section>

</main>
<div id="hidden-click-area"></div>
<script>
	function animateValue(id, idBack, start, end, duration) {
		const obj = document.getElementById(id);
		const objBack = document.getElementById(idBack);

		if (end === 0) {
			obj.textContent = '통계중';
			objBack.textContent = '통계중';
			obj.style.width = '100px';
			objBack.style.width = '100px';
			// 애니메이션이나 추가 작업 중단
			window.cancelAnimationFrame(step);  // step 함수가 애니메이션을 호출할 때 사용
			return;
		}

		const range = end - start;
		let startTime = null;

		function step(timestamp) {
			if (!startTime) startTime = timestamp;
			const progress = timestamp - startTime;
			const current = Math.min(Math.floor(start + (range * progress) / duration), end);

			// 현재 숫자를 설정하고 콤마 추가
			obj.textContent = current.toLocaleString();
			objBack.textContent = current.toLocaleString();

			// 투명도를 계산하여 적용 (0에서 1로 점차적으로 증가)
			const opacity = progress / duration;
			obj.style.opacity = opacity;
			objBack.style.opacity = opacity;

			// 현재 숫자가 목표 숫자보다 작으면 계속 애니메이션 진행
			if (current < end) {
				window.requestAnimationFrame(step);
			} else {
				// 숫자가 끝까지 올라가면 커짐
				obj.classList.add('grow');
				objBack.classList.add('grow');

				setTimeout(() => {
					// 0.3초 후 원래 크기로 돌아옴
					obj.classList.remove('grow');
					objBack.classList.remove('grow');
				}, 300);
			}
		}

		// 초기 상태 설정
		obj.style.opacity = 0;
		objBack.style.opacity = 0;
		window.requestAnimationFrame(step);
	}


	window.onload = function() {
		// 각 숫자에 대한 애니메이션 호출
		animateValue("totalMatch", "totalMatch-back", 0, ${totalMatch}, 2000); // 누적 매칭 공고
		animateValue("todayMatch", "todayMatch-back", 0, ${todayMatch}, 2000); // 오늘 매칭 공고
		animateValue("totalNotice", "totalNotice-back", 0, ${totalNotice}, 2000); // 누적 공고
		animateValue("todayNotice", "todayNotice-back", 0, ${todayNotice}, 2000); // 오늘 올라온 공고
	};

	let clickCount = 0;
	const hiddenArea = document.getElementById("hidden-click-area");

	hiddenArea.addEventListener("click", () => {
		clickCount++;
		if (clickCount >= 10) {
			window.location.href = "/admin/sign-in";
		}
	});
</script>

<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/layout/darkFooter.jsp"%>