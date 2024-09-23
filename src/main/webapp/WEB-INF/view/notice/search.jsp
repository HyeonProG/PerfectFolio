<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- header.jsp 포함 -->
<c:choose>
    <c:when test="${admin != null}">
        <%@ include file="/WEB-INF/view/adminLayout/header.jsp"%>
    </c:when>
    <c:otherwise>
        <%@ include file="/WEB-INF/view/layout/darkHeader.jsp"%>
    </c:otherwise>
</c:choose>

<form action="/notice/search" method="get">
    <h2>공지사항 검색 결과</h2>
    
    <!-- 검색 필드 -->
    <div>
        <select name="searchType">
            <option value="title" <c:if test="${param.searchType == 'title'}">selected</c:if>>제목</option>
            <option value="content" <c:if test="${param.searchType == 'content'}">selected</c:if>>제목 + 내용</option>
            <option value="categories" <c:if test="${param.searchType == 'categories'}">selected</c:if>>카테고리</option>
        </select>
        <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어를 입력하세요" />
        <button type="submit">검색</button>
    </div>
    
    <!-- 검색 결과 테이블 -->
    <table class="table">
        <thead>
            <tr>
                <th>카테고리</th>
                <th>제목</th>
                <th>내용</th>
                <th>작성일</th>
                <th>조회수</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="notice" items="${noticeList}">
                <tr onclick="location.href='/notice/detail?id=${notice.id}'">
                    <td>${notice.categories}</td>
                    <td>${notice.title}</td>
                    <td>${notice.content}</td>
                    <td><fmt:formatDate value="${notice.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                    <td>${notice.views}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <!-- 페이지네이션 -->
    <div class="d-flex justify-content-center">
        <ul class="pagination">
            <!-- 이전 페이지 -->
            <li class="page-item <c:if test='${currentPage == 1}'> disabled </c:if>">
                <a class="page-link" href="?searchType=${param.searchType}&keyword=${param.keyword}&page=${currentPage - 1}&size=${pageSize}">이전</a>
            </li>

            <!-- 페이지 번호 -->
            <c:forEach begin="1" end="${totalPages}" var="page">
                <li class="page-item <c:if test='${page == currentPage}'> active </c:if>">
                    <a class="page-link" href="?searchType=${param.searchType}&keyword=${param.keyword}&page=${page}&size=${pageSize}">${page}</a>
                </li>
            </c:forEach>
            
            <!-- 다음 페이지 -->
            <li class="page-item <c:if test='${currentPage == totalPages}'> disabled </c:if>">
                <a class="page-link" href="?searchType=${param.searchType}&keyword=${param.keyword}&page=${currentPage + 1}&size=${pageSize}">다음</a>
            </li>
        </ul>
    </div>
    
    <c:if test="${admin != null}">
    <!-- 관리자 추가 버튼 -->
    <a href="/notice/create">추가</a>
    </c:if>
</form>

<!-- footer.jsp 포함 -->
<%@ include file="/WEB-INF/view/layout/darkFooter.jsp"%>
