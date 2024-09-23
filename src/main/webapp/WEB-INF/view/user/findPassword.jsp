<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }

        .container {
            text-align: center;
            padding: 20px;
            margin-top: 100px;
        }

        h1 {
            display: flex;
            font-size: 24px;
            justify-content: center;
            color: #333;
            margin-bottom: 40px;
        }

        .auth-options {
            display: flex;
            justify-content: center;
            gap: 40px;
        }

        .auth-option {
            background-color: #ffffff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .auth-option:hover {
            transform: translateY(-5px);
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
        }

        .auth-option a {
            text-decoration: none;
            color: #333;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .auth-option img {
            width: 80px;
            height: 80px;
            margin-bottom: 15px;
        }

        .auth-option span {
            font-size: 16px;
            font-weight: bold;
        }

    </style>
</head>
<body>
<div class="container">
<h1>본인인증 방식을 선택해주세요.</h1>
<div class="auth-options">

    <div class="auth-option">
        <a href="/user/findPasswordByEmail">
            <img src="email-icon.png" alt="이메일 인증">
            <span>이메일 인증</span>
        </a>
    </div>
</div>
</div>
</body>
</html>