<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Category List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        table {
            width: 80%;
            margin: 0 auto;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .category-table {
            margin-bottom: 40px;
        }
    </style>
</head>
<body>

    <h1>Categories</h1>

    <div class="category-table">
        <h2>Main Categories</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
            </tr>
            <c:forEach var="category" items="${allCategoryList.mainCategoryList}">
                <tr>
                    <td>${category.id}</td>
                    <td>${category.name}</td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <div class="category-table">
        <h2>Categories</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
            </tr>
            <c:forEach var="category" items="${allCategoryList.categoryList}">
                <tr>
                    <td>${category.id}</td>
                    <td>${category.name}</td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <div class="category-table">
        <h2>Project Categories</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
            </tr>
            <c:forEach var="category" items="${allCategoryList.projectCategoryList}">
                <tr>
                    <td>${category.id}</td>
                    <td>${category.name}</td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <div class="category-table">
        <h2>Qualifications Skills</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
            </tr>
            <c:forEach var="category" items="${allCategoryList.qualificationsSkillList}">
                <tr>
                    <td>${category.id}</td>
                    <td>${category.name}</td>
                </tr>
            </c:forEach>
        </table>
    </div>

</body>
</html>
