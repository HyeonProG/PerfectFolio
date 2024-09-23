<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/darkHeader.jsp"%>
	<style>
		body {
			font-family: 'Arial', sans-serif;
			margin: 0;
			padding: 0;
		}

		.button {
			display: inline-block;
			padding: 10px 20px;
			font-size: 16px;
			color: white;
			background-color: #4CAF50;
			text-align: center;
			text-decoration: none;
			border-radius: 5px;
			margin: 20px 0;
			cursor: pointer;
		}

		.container {
			max-width: 600px;
			margin: 20px auto;
			background-color: rgba(0, 0, 0, 0.09);
			border: 1px solid rgba(0, 0, 0, 0.22);
			padding: 20px;
			padding-top: 140px;
			box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		}

		.header {
			text-align: center;
			margin-bottom: 20px;
		}

		.header img {
			width: 80px;
		}

		.title {
			font-size: 22px;
			font-weight: bold;
			color: rgba(255, 255, 255, 0.8);
			text-align: center;
			margin-bottom: 20px;
		}

		.content {
			font-size: 14px;
			line-height: 1.6;
			color: rgba(255, 255, 255, 0.8);
			text-align: center;
			margin-bottom: 30px;
		}

		.btn {
			display: block;
			width: 200px;
			margin: 0 auto;
			padding: 10px;
			background-color: GREEN;
			color: white;
			text-align: center;
			border-radius: 5px;
			text-decoration-line: none;
			font-weight: bold;

		}

		.footer {
			text-align: center;
			font-size: 12px;
			color: #999999;
			margin-top: 20px;
		}

		.footer a {
			color: #0073e6;
			text-decoration: none;
		}

		.info {
			margin-top: 20px;
			text-align: center;
			font-size: 12px;
			color: #777777;
		}

		a:link {
			text-decoration: none;
		}

		a:visited,
		a:active {
			color: white;
		}

	</style>
</head>
<body>
<div class="container">
	<div class="header">
		<img src="../images/main/PerfectFolio.logo.gif" alt="Wix Logo">
	</div>

	<div class="title">인증이 완료되었습니다.</div>

	<div class="content">
		<p>Perfect Folio로 돌아가 회원가입을 완료해주세요.</p>
		<form action="/user/completeValidateEmail" method="get">
			<button type="submit" class="button">돌아가기</button>
			<input type="hidden" name="action" value="isCompleted">
		</form>
	</div>

	<div class="footer">
		도움이 필요하세요? <a href="#">도움말 센터</a> 또는 <a href="#">문의 페이지</a>를 이용하세요.
	</div>
</div>
</body>
<script>

</script>

</html>