<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="도서 정보 상세 조회" />
<%@ include file="../common/head.jsp" %>
<style>
	body {
		height: 100%;
	}
</style>
<nav class="bg-gray-200 py-20">
    <div class="max-w-2xl mx-auto bg-white p-10 rounded-lg shadow-md">
        <h1 class="text-2xl mb-4">도서 정보 상세 조회</h1>
            <label for="title" class="block mb-2 text-base font-bold text-xl">도서명</label>
            <span>${book.title }</span>
           <hr class="mb-10">
            <label for="author" class="block mb-2 text-base font-bold text-xl">저자</label>
             <span>${book.author }</span>
            <hr class="mb-10">
            <!-- 설명 -->
            <label for="publisher" class="block mb-2 text-base font-bold text-xl">출판사</label>
            <span>${book.publisher }</span>
            <hr class="mb-10">
          <label for="type" class="block mb-2 text-base font-bold text-xl">전공 여부</label>
          <c:if test="${book.type eq 0}">
				 <span>비전공</span>
		  </c:if>
		  <c:if test="${book.type eq 1}">
				 <span>전공</span>
		  </c:if>
           <hr class="mb-10">
      <a href="read"  class="btn w-full p-2 border rounded btn-success font-bold text-base mt-10 text-white"><button>뒤로 가기</button></a>
</div>
</nav>
<%@ include file="../common/foot.jsp" %>