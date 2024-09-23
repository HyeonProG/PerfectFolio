<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/myInfo.css">
<style>
    /* CSS 스타일 수정 */


</style>
<section class="user--section">
    <!-- side bar -->
    <aside class="personal--bar">
        <div class="bar--items">
            <p>내 정보</p>
            <a href="#" class="bar--selected">계정관리</a> <a
                href="/user/my-subscribe">구독 내역</a>
            <a href="/user/mySkillPage">스킬스택 관리</a>

        </div>
        <div class="bar--items">
            <p>포트폴리오</p>
            <a href="/user/my-portfolio">포트폴리오</a>
        </div>
    </aside>
</section>


<div class="container">
    <h2>사용자 정보 수정</h2>
    <form action="/user/updateUserInfo" method="POST">
        <!-- 사용자 이름 -->
        <div class="form-group">
            <label for="username">사용자 이름</label>
            <input type="text" id="username" name="username" value = "${user.username}" placeholder="이름을 입력" required>
        </div>

        <!-- 닉네임 -->
        <div class="form-group">
            <label for="nickName">닉네임</label>
            <input type="text" id="nickName" name="nickName" value = "${user.userNickname}"placeholder="닉네임 입력" required>
        </div>

        <!-- 이메일 -->
        <div class="form-group">
            <label for="email">이메일</label>
            <input type="email" id="email" name="email" value = "${user.userEmail}" placeholder="이메일 입력" required>
            <button type="button" onclick="sendValidateCode()" id="sendValidateBtn">발송</button>
            <button type="button" class="check--btn" onclick="checkValidate()" id="checkValidateBtn"
                    disabled="disabled" style="cursor: pointer;">인증 확인</button>
        </div>


        <!-- 전화번호 -->
        <div class="form-group">
            <label for="tel">전화번호</label>
            <input type="tel" id="tel" name="tel" value ="${user.userTel}" placeholder="전화번호 입력" required>
        </div>

        <!-- 수정 버튼 -->
        <button type="submit" class="btn" id="updateBtn" disabled="disabled">정보 수정</button>
    </form>
</div>
<script>
    function sendValidateCode() {
        const email = document.getElementById('email').value;
        fetch('http://perfecfolio.jinnymo.com/send-mail/email?email=' + email)
            .then(response => {
                if (!response.ok) {
                    return response.json().then(data => {
                        throw new Error(data.message || '알 수 없는 에러가 발생했습니다.');
                    });
                }
                // 응답을 JSON 형식으로 변환
                return response.json();
            })
            .then(data => {
                alert(data.message);
                const sendValidateBtn = document.getElementById('sendValidateBtn');
                const checkValidateBtn = document.getElementById('checkValidateBtn');
                checkValidateBtn.disabled = false;
                sendValidateBtn.disabled = true;

            })
            .catch(error =>  {
                alert(error.message);
            });
    }

    function checkValidate() {
        fetch('http://perfecfolio.jinnymo.com/send-mail/checkValidate')
            .then(response => {
                if (!response.ok) {
                    return response.json().then(data => {
                        throw new Error(data.message || '알 수 없는 에러가 발생했습니다.');
                    });
                }
                return response.json();  // 응답을 JSON 형식으로 변환
            })
            .then(data => {
                // 서버로부터 받은 응답 데이터를 처리
                console.log('Success:', data);
                // 서버에서 보낸 메시지를 alert으로 표시
                alert(data.message);
                const updateBtn = document.getElementById('updateBtn');
                updateBtn.disabled = false;
            })
            .catch(error => {
                console.log('Error:', error);
                // 에러 메시지를 alert으로 표시
                alert(error.message);
            });
    }
</script>
</body>
</html>
