<%--
  Created by IntelliJ IDEA.
  User: pth
  Date: 8/26/24
  Time: 21:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script
            src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
    <script
            src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <title>404 Not Found...</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
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
            background-color: #ffffff;
            border: 1px solid #dddddd;
            padding: 20px;
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
            color: #333333;
            text-align: center;
            margin-bottom: 20px;
        }

        .content {
            font-size: 14px;
            line-height: 1.6;
            color: #555555;
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
        <img src="https://upload.wikimedia.org/wikipedia/commons/9/9c/Wix.com_Logo.png" alt="Sample Logo">
    </div>

    <div class="title">인증 코드가 만료되었습니다.</div>

    <div class="content">
        <button type="submit" class="button">돌아가기</button>
    </div>

    <div class="footer">
        도움이 필요하세요? <a href="#">도움말 센터</a> 또는 <a href="#">문의 페이지</a>를 이용하세요.
    </div>
    <div class="info">
        본 이메일은 발신전용입니다.<br>
        <a href="#">개인정보 취급방침</a>
    </div>
</div>
<script>
    $(".button").on('click', function () {
       window.close();
    })
</script>
</body>
</html>