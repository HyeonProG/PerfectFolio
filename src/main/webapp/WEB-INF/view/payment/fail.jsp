<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/darkHeader.jsp"%>

    <h2>결제에 실패하였습니다.</h2>
    <p><%= request.getAttribute("failMessage") %></p>
    <a href="/payment">다시 시도하기</a>

<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/layout/darkFooter.jsp"%>
