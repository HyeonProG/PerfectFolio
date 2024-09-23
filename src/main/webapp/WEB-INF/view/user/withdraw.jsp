<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/withdraw.css">


<div class="withdraw--container">
	<p>탈퇴사유를 선택해주세요</p>
	<form action="/user/withdraw" method="post">
		<div class="form-check">
			<label class="form-check-label"> <input type="checkbox"
				class="form-check-input" name="reason" value="새 계정을 만들고 싶어요.">
				새 계정을 만들고 싶어요.
			</label>
		</div>
		<div class="form-check">
			<label class="form-check-label"> <input type="checkbox"
				class="form-check-input" name="reason" value="사이트를 자주 방문하지 않아요.">사이트를
				자주 방문하지 않아요.
			</label>
		</div>
		<div class="form-check">
			<label class="form-check-label"> <input type="checkbox"
				class="form-check-input" name="reason" value="멤버십이 마음에 들지 않아요.">멤버십이
				마음에 들지 않아요.
			</label>
		</div>
		<div class="form-check">
			<label class="form-check-label"> <input type="checkbox"
				class="form-check-input" name="reason" value="가격이 비싸요.">가격이
				비싸요.
			</label>
		</div>

		<!-- 기타 사유 체크박스 및 textarea -->
		<!-- 체크박스가 선택된 값을 배열 형태로 서버로 전송하도록 수정 -->
		<div class="form-check">
			<label class="form-check-label"> <input type="checkbox"
				id="otherReasonCheckbox" class="form-check-input" name="reason"
				value="기타 사유"> 기타 사유
			</label>
		</div>
		<div class="form-group">
			<label for="comment">탈퇴 사유를 입력해주세요.</label>
			<textarea class="form-control" rows="5" id="comment"
				name="reasonDetail" maxlength="255" disabled></textarea>
			<div class="count-container">
				글자수: <span id="charCount">0</span> / 255
			</div>
		</div>

		<button type="submit" class="btn btn-primary" style="color: red">탈퇴하기</button>
	</form>
</div>

<script>

		// checkbox 선택 시 다른 모든 checkbox 비활성화
        document.addEventListener('DOMContentLoaded', function() {
            const checkboxes = document.querySelectorAll('.form-check-input');
            
            checkboxes.forEach(checkbox => {
                checkbox.addEventListener('change', function() {
                    if (this.checked) {
                        checkboxes.forEach(cb => {
                            if (cb !== this) {
                                cb.disabled = true;
                            }
                        });
                    } else {
                        checkboxes.forEach(cb => {
                            cb.disabled = false;
                        });
                    }
                });
            });

            // 탈퇴 사유 textarea checkbox 활성화/비활성화
            // 비활성화 시 text 내용 초기화
            document.getElementById('otherReasonCheckbox').addEventListener('change', function() {
                const textarea = document.getElementById('comment');
                textarea.disabled = !this.checked;
                if (!this.checked) {
                    textarea.value = '';
                }
            });
        });
        
			// 탈퇴하기 버튼 누를 경우 alert 창 1번 띄운 후 취소/ 확인 버튼 생성
			// 확인 버튼 누르면 alert 창 1번 더 띄운 후 취소/ 탈퇴하기 버튼 생성
           document.querySelector('button[type="submit"]').addEventListener('click', function(event) {
				event.preventDefault(); // 새로고침 방지
				
				// 탈퇴 사유 체크
				const reasonCheckboxes = document.querySelectorAll('.form-check-input');
				let isChecked = false;
				
				// 체크박스 중 하나라도 선택되어 있는지 확인
				reasonCheckboxes.forEach(checkbox => {
					if(checkbox.checked) {
						isChecked = true;
					}
				});
				
				if(!isChecked) {
					alert('탈퇴 사유를 선택해주세요.');
					return;
				}
				
				
				// 첫번째 경고창
				if(confirm('정말로 탈퇴하시겠습니까?')) {
					// 확인 버튼 클릭 시 
					if(confirm('탈퇴 시 이러저러한 혜택을 받을 수 없습니다.\n정말로 탈퇴하시겠습니까?')){
						// 두번째 경고창 확인 버튼 클릭 시 탈퇴 처리
						this.closest('form').submit();
						alert('성공적으로 탈퇴되었습니다.');
					} else {
						// 두번째 경고창 취소 버튼 클릭 시 
						alert('탈퇴가 최소되었습니다.');
					}
				} else {
					// 첫번째 경고창 취소 버튼 클릭 시 
					alert('탈퇴가 취소되었습니다.');
				}
           });
			
			// 글자수 표시
			document.addEventListener('DOMContentLoaded', function() {
            	const textarea = document.getElementById('comment');
            	const charCount = document.getElementById('charCount');
			
				// 텍스트 영역의 입력 이벤트를 감지하여 글자 수를 업데이트
				 textarea.addEventListener('input', function() {
                	charCount.textContent = textarea.value.length;
				});
			});
    </script>
    
<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightFooter.jsp"%>