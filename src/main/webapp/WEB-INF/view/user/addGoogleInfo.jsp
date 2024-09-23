<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>

<style>
.body--bg{
    background-color: #fff;
}
</style>

<h2>구글 회원가입시 추가 정보 필요</h2>
<form action="/user/addGoogleInfo" method="post" enctype="multipart/form-data">
    <p>
        성별 <span>&#42;</span>
    </p>
    <div class="custom-control custom-radio custom-control-inline">
        <input type="radio" class="custom-control-input" id="male"
            name="userGender" value="남성"> <label
            class="custom-control-label" for="male">남성</label>
    </div>
    <div class="custom-control custom-radio custom-control-inline">
        <input type="radio" class="custom-control-input" id="female"
            name="userGender" value="여성"> <label
            class="custom-control-label" for="female">여성</label>
    </div>
    <div class="form-group">
        <label for="userBirth">생년월일:</label> <input type="date"
            class="form-control" id="userBirth" name="userBirth" required>
    </div>
    <div class="form-group">
        <label for="userTel">전화번호:</label> <input type="tel"
            class="form-control" pattern="[0-9]{3}-[0-9]{3,4}-[0-9]{4}" title="000-0000-0000 형식으로 입력해 주세요." placeholder="전화번호를 입력해주세요."  id="userTel" name="userTel">
    </div>
    <div class="form-group">
        <label for="userNickname">별명:</label> <input type="text"
            class="form-control" placeholder="닉네임을 입력해주세요." id="userNickname"
            name="userNickname">
    </div>
   <div class="form-group form-check">
				<label class="form-check-label"> 
				<input class="form-check-input" type="checkbox" name="remember">
					Remember me
				</label>
				</div>
    <br>
        <button type="submit" class="btn btn-primary">가입하기</button>
</form>

<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/layout/darkFooter.jsp"%>