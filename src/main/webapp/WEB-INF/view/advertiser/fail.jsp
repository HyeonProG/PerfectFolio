<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>등록 실패 안내</title>
</head>
<body>
    <h1>결제에 실패하였습니다.</h1>
    <div>
        <label>실패 코드: </label>
        <label>${code}</label>
    </div>
    <div>
        <label>실패 사유: </label>
        <label>${message}</label>
    </div>
</body>
</html>
