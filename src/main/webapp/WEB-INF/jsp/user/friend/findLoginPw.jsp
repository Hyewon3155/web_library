<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Find_LoginPw" />
<%@ include file="../common/head.jsp" %>
	<div class="login_bg_img">
	  <div class="card card-compact w-96 bg-base-100 shadow-xl layer">
	    <h1 class="font-semibold text-2xl text-center pt-5">비밀번호 찾기</h1>
	    <div class="card-body">
	     <form action="doFindLoginPw" method="POST">
	      <h1 class="block font-semibold">ID</h1>
	      <input class="input input-bordered w-full" type="text" name="loginId" placeholder="아이디" />
	      <h1 class="block font-semibold">이름</h1>
	      <input class="input input-bordered mb-2 block w-full" type="text" name="name" placeholder="이름">
	      <h1 class="block font-semibold">이메일</h1>
	      <input class="input input-bordered mb-2 block w-full" type="text" name="email" placeholder="이메일">
	       <button class="btn btn-warning items-center w-full mb-2">비밀번호 찾기</button>
	     </form>
	       <span class="flex justify-end"><a class="pl-2 pr-2" href="findLoginId">아이디 찾기</a>
	 <a href="login">로그인</a></span>
	        <div class="btns mt-2">
				<button class="btn-text-link btn btn-active" type="button" onclick="history.back();">뒤로가기</button>
			</div>
	    </div>
	  </div>
	</div>
<%@ include file="../common/foot.jsp" %>
	