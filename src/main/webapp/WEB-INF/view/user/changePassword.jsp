<%--
  Created by IntelliJ IDEA.
  User: pth
  Date: 8/28/24
  Time: 09:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f4f4f4;
        }

        .container {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            text-align: center;
            width: 400px;
        }

        .logo {
            font-size: 30px;
            margin-bottom: 20px;
            color: #6c63ff;
            font-weight: bold;
        }

        h1 {
            font-size: 24px;
            margin: 10px 0;
            color: #333;
        }

        p {
            color: #555;
            line-height: 1.5;
            margin-bottom: 20px;
        }

        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #45a049;
        }

        .footer {
            margin-top: 20px;
            color: #777;
            font-size: 12px;
        }

        .footer a {
            color: #1a73e8;
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
  <h1>비밀번호 변경</h1>

  <form action="/user/changePassword" method="post">
    <div class="form-group">
      <label for="userId">아이디</label>
      <input type="password" class="form-control" id="userId"
             placeholder="아이디를 입력하세요." name="userId" required>
    </div>

    <div class="form-group">
          <label for="newPassword">새로운 비밀번호</label>
          <input type="password" class="form-control" id="newPassword"
                 placeholder="비밀번호를 입력하세요." name="newPassword" required>
    </div>

    <div class="form-group">
      <label for="checkPassword">비밀번호 확인</label>
      <input type="password" class="form-control" id="checkPassword"
             placeholder="비밀번호를 입력하세요." name="checkPassword" required>
    </div>
        <div class="form-group">
          <button type="submit" class="form-control" id="changePassword">변경</button>
      </div>

  </form>
<script>


</script>
</body>
</html>
