<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Pw_modify" />
<%@ include file="../common/head.jsp" %>
	<div class="login_bg_img">
	  <div class="card card-compact w-96 bg-base-100 shadow-xl layer">
	    <h1 class="font-semibold text-2xl text-center pt-5">CheckPassword</h1>
	    <div class="card-body">
	    <form action="doPasswordModify" method="POST">
	      <h1 class="block font-semibold">새 비밀번호</h1>
	      <input class="input input-bordered mb-2 block w-full" type="text" name="loginPw" placeholder="비밀번호"/>
	      <h1 class="block font-semibold">새 비밀번호 확인</h1>
	      <input class="input input-bordered mb-2 block w-full" type="text" name="loginPwChk" placeholder="비밀번호">
	       <button class="btn btn-warning items-center w-full mb-2">확인</button>
	     </form>
	        <div class="btns mt-2">
				<button class="btn-text-link btn btn-active" type="button" onclick="history.back();">뒤로가기</button>
			</div>
	    </div>
	  </div>
	</div>
<%@ include file="../common/foot.jsp" %>

