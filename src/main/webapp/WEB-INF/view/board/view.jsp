<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<link rel="stylesheet" href="/css/notice.css">
<link rel="stylesheet" href="/css/custom-detail.css"> <!-- 커스텀 스타일 파일 추가 -->

<div class="sub--banner">
	<h1>문의사항</h1>
</div>

<!-- 컨테이너 영역 -->
<div class="container detail-container">
	<!-- 페이지 제목 -->
	<div class="detail-header">
		<h2 class="font_18 detail-title">문의사항 상세보기</h2>
		<div class="btn-group detail-btn-group" role="group" aria-label="Basic example">
			<a href="/board/listPage"><button class="btn btn-light">돌아가기</button></a>
			<a href="/board/write"><button class="btn btn-primary">글쓰기</button></a>
		</div>
	</div>

	<!-- 문의사항 상세 내용 -->
	<div class="detail-content">
		<c:choose>
			<c:when test="${board != null}">
				<table class="table table-bordered table-hover detail-table">
					<tbody>
						<tr>
							<th>제목</th>
							<td>${board.title }</td>
						</tr>
						<tr>
							<th>카테고리</th>
							<td>${board.categories}</td>
						</tr>
						<tr>
							<th>작성자</th>
							<td>${board.writer}</td>
						</tr>
						<tr>
							<th>작성일</th>
							<td>${board.createdAt}</td>
						</tr>
						<tr>
							<th>문의내용</th>
							<td class="detail-content-cell">${board.content}</td>
						</tr>
					</tbody>
				</table>
			</c:when>
			<c:otherwise>
				<p class="text-danger">오류가 발생했습니다. 다시 시도해 주세요.</p>
			</c:otherwise>
		</c:choose>
	</div>

	<!-- 수정, 삭제 버튼 (로그인 유저일 때만 표시) -->
	<c:if test="${not empty checkSameUser}">
		<div class="btn-group detail-btn-group" role="group" aria-label="Basic example">
			<a href="/board/update/${board.id}" type="button" class="btn btn-warning">수정</a>
			<a href="/board/delete/${board.id}" type="button" class="btn btn-outline-danger">삭제</a>
		</div>
	</c:if>
</div>

<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/layout/darkFooter.jsp"%>
