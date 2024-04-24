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
	      <input class="input input-bordered join-item mr-2" name="searchKeyword"  placeholder="이름"/>
			  <select class="select select-bordered join-item mr-2"  name="searchKeywordType">
			    <option disabled selected>부서명</option>
			   <option value="인사부">인사부</option>
			  <option value="재무부">재무부</option>
			  <option value="운영부">운영부</option>
			    <option value="마케팅부">마케팅부</option>
			    <option value="영업부">영업부</option>
			    <option value="IT부">IT부</option>
			    <option value="연구개발부">연구개발부</option>
			    <option value="생산부">생산부</option>
			    <option value="고객관리부">고객관리부</option>    
			  </select>
			    <button class="btn join-item" id="insertHtml" onclick="searchWork();">Search</button>
	        <div class="btns mt-2">
				<button class="btn-text-link btn btn-active" type="button" onclick="history.back();">뒤로가기</button>
			</div>
			</form>
	    </div>
	  </div>
	</div>
<%@ include file="../common/foot.jsp" %>

