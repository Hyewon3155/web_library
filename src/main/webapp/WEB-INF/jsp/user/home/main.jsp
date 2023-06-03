<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>Main</title>
<%@ include file="../common/head.jsp" %>
	<div class="main_bg_img">
	        <div class="content">
	          <h1>새로운 루틴을 찾아보세요</h1>
	          <button class="btn btn-outline"><i class="fas fa-search mx-2" style="color: #5c98ff"></i>Go to search</button>
	          
	        </div>
	        <div class="img-cover slide-in"></div>
	        <div class="h-20 absolute flex container text-2xl text-white z-10">
	          	<a href="/" class="pl-10 flex items-center text-3xl text-bold"><span>Routine</span></a>
	          <div class="flex-grow"></div>
	          <ul class="flex ">
	              <li><a class="h-full items-center flex pr-10 hover:underline" href="/user/member/login">Login</a>
	              <li><a class="h-full items-center flex pr-10 hover:underline" href="/user/member/join">Join</a>
	              <div class="li-underline"></div>
	          </ul>
	        </div>
	 </div>