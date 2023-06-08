<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>Memer_main</title>
<%@ include file="../common/head.jsp" %>
<div class="navbar bg-base-100">
  <div class="navbar-start">
    <div class="dropdown">
      <label tabindex="0" class="btn btn-ghost btn-circle">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h7" /></svg>
      </label>
      <ul tabindex="0" class="menu menu-compact dropdown-content mt-3 p-2 shadow bg-base-100 rounded-box w-52">
        <li><a href="/user/member/mypage">마이페이지</a></li>
        <li><a href="/user/member/doLogout">로그아웃</a></li>
        <li><a href="/user/group/create">루틴 생성하기</a></li>
        <li><a href="/user/member/schedule">내 스케줄보기</a>
      </ul>
    </div>
  </div>
  <div class="navbar-center">
    <a class="btn btn-ghost text-2xl">${rq.loginedMember.nickname } 님의 홈</a>
  </div>
  <div class="navbar-end">
      <a class="mr-2" href="/user/member/doLogout">로그아웃</a>
      <a class="mr-2" href="/user/member/mypage">마이페이지</a>
  </div>
</div>
<%@ include file="../common/foot.jsp" %>
    