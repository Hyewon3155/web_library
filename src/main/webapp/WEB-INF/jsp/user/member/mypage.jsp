<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="My_page" />
<%@ include file="../common/head.jsp" %>
<h1 class="font-semibold text-2xl text-center pt-5">MYPAGE</h1>


<section class="mt-5 flex container mx-auto justify-center">
  <div class="mx-auto">
    <h1 class="block font-semibold mb-2">ID</h1>
      <i class="fas fa-user mr-2"></i>
      <span>${rq.loginedMember.loginId }</span>
      <hr class="mt-2">
      <h1 class="block font-semibold mb-2">가입일</h1>
      <i class="fa-solid fa-user-lock mr-2"></i>
      <span>${rq.loginedMember.regDate}</span>
      <hr class="mt-2">
      <h1 class="block font-semibold mb-2">그룹</h1>
      <i class="fa-solid fa-people-group mr-2"></i>
      <c:if test="${rq.loginedMember.study_group == null  }"/>
        <span>가입한 그룹이 없습니다.</span>
      <span>${rq.loginedMember.study_group }</span>
      <hr class="mt-2">
      <h1 class="block font-semibold mb-2 mt-2">이름</h1>
      <i class="fas fa-user mr-2"></i>
      <span>${rq.loginedMember.name }</span>
      <hr class="mt-2">
      <h1 class="block font-semibold mb-2 mt-2">닉네임</h1>
      <i class="fas fa-user mr-2"></i>
      <span>${rq.loginedMember.nickname }</span>
      <hr class="mt-2">
      <h1 class="block font-semibold mb-2 mt-2">이메일</h1>
      <i class="fa-solid fa-envelope mr-2"></i>
      <span>${rq.loginedMember.email }</span>
      <hr class="mt-2">
      <h1 class="block font-semibold mb-2 mt-2">전화번호</h1>
      <i class="fa-solid fa-mobile-screen mr-2"></i>
      <span>${rq.loginedMember.cellphoneNum }</span>
      <hr class="mt-2">
      <br>
    <div class="btns mt-2 flex justify-between">
	  <button class="btn-text-link btn btn-active mr-2" type="button" onclick="history.back();">뒤로가기</button>
	  <a class="btn btn-success btn-wide" href="checkpassword">회원정보 수정</a>
				<!-- 현재의 요청은 /usr/member/myPage이고, 회원정보 수정 또한 member의 기능이기 때문에 상위 폴더로 갈 필요 X-->
				<!-- 요청이 checkPassword로 넘어감, checkPassWord로 요청이 넘어가고, -->
				<!-- checkPassword.jsp 화면이 그려짐 -->
    </div>
  </div>
</section>
<%@ include file="../common/foot.jsp" %>