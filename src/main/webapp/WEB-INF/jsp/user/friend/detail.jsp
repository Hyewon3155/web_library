<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="친구 상세 정보 조회" />
<%@ include file="../common/head.jsp" %>
<style>
	nav {
		height: 93%;
	}
</style>
<nav class="bg-gray-200 py-20">
    <div class="max-w-2xl mx-auto bg-white p-10 rounded-lg shadow-md">
        <h1 class="text-2xl mb-10">친구 상세 정보 조회</h1>
            <label for="name" class="block mb-2 text-xl font-bold"><i class="bi bi-person-fill mr-2"></i>이름</label>
            <span>${friend.name }</span>
            <hr class="mb-10">
            <label for="schoool" class="block mb-2 text-base font-bold text-xl"><i class="bi bi-building-fill mr-2"></i>소속</label>
            <span>${friend.school }대학교 ${friend.depart }과</span>
            <hr class="mb-10">
            <label for="cellphoneNum" class="block mb-2 text-base font-bold text-xl"><i class="bi bi-phone-fill mr-2"></i>전화번호</label>
			 <span>${friend.cellphoneNum}</span>
             <hr class="mb-10">
             <label for="email" class="block mb-2 text-base font-bold text-xl"><i class="bi bi-envelope-at-fill mr-2"></i>이메일</label>
             <span>${friend.email }</span>
             <hr class="mb-10">
      <a href="read"  class="btn w-full p-2 border rounded btn-success font-bold text-base mt-10 text-white"><button>뒤로 가기</button></a>
</div>
</nav>
<%@ include file="../common/foot.jsp" %>