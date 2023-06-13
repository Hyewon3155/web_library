<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Modify" />
<%@ include file="../common/head.jsp" %>
<h1 class="font-semibold text-2xl text-center pt-5">MODIFY</h1>


<section class="mt-5 flex container mx-auto justify-center">
  <div class="mx-auto">
   <form action="doModify" method="POST">
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
      <h1 class="block font-semibold mb-2 mt-2">NAME</h1>
      <i class="fas fa-user mr-2"></i>
      <input type="text" name="name" placeholder="이름">
      <hr class="mt-2">
      <h1 class="block font-semibold mb-2 mt-2">NICKNAME</h1>
      <i class="fas fa-user mr-2"></i>
      <input type="text" name="nickname" placeholder="닉네임">
      <hr class="mt-2">
      <h1 class="block font-semibold mb-2 mt-2">PHONE</h1>
      <i class="fa-solid fa-mobile-screen mr-2"></i>
      <input type="text" name="cellphoneNum" placeholder="전화번호">
      <hr class="mt-2">
      <h1 class="block font-semibold mb-2 mt-2">EMAIL</h1>
      <i class="fa-solid fa-envelope mr-2"></i>
      <input type="text" name="email" placeholder="이메일">
      <hr class="mt-2">
      <br>
    <div class="btns mt-2 flex justify-between">
	  <button class="btn-text-link btn btn-active mr-2" type="button" onclick="history.back();">뒤로가기</button>
	  <div>
			<a class="btn btn-warning" href="passwordModify">비밀번호 변경</a>
			<button class="btn btn-success">수정</button>
	  </div>
    </div>
   </form>
  </div>
</section>
<%@ include file="../common/foot.jsp" %>