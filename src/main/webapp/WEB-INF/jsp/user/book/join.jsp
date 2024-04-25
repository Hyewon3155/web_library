<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="도서 등록" />
<%@ include file="../common/head.jsp" %>
<script>
      
      function join_submitForm(form) {
    	  form.title.value = form.title.value.trim();
	  	  if (form.title.value.length == 0) {
	  			alert('도서명을 입력해주세요');
	  			form.title.focus();
	  			return;
	      }
    	
  		form.author.value = form.author.value.trim();
  		if (form.author.value.length == 0) {
  			alert('저자명을 입력해주세요');
  			form.author.focus();
  			return;
  		}
  		
  		form.publisher.value = form.publisher.value.trim();
  		if (form.publisher.value.length == 0) {
  			alert('출판사를 입력해주세요');
  			form.publisher.focus();
  			return;
  		}
  		
  		let type = $('#type').val();

        if(!type){
            alert("전공 여부를 선택해주세요.");
            $('#type').focus();
            return false;
        }
  		
  		
  		form.submit();
  	}
</script>
<style>
	nav {
		height: 93%;
	}
</style>
<nav class="bg-gray-200 py-20">
    <div class="max-w-2xl mx-auto bg-white p-10 rounded-lg shadow-md">
        <h1 class="text-2xl mb-4">도서 등록</h1>
           <form action="doJoin" method="POST" onsubmit="join_submitForm(this); return false;">
            <label for="title" class="block mb-2 text-base font-bold text-xl">도서명</label>
            <input type="text" name="title" class="input input-bordered w-full p-2 mb-10 border rounded" placeholder="도서명을 입력해주세요">

            <label for="author" class="block mb-2 text-base font-bold text-xl">저자</label>
            <input type="text" name="author" class="input input-bordered w-full p-2 mb-10 border rounded" placeholder="저자를 입력해주세요">
            
            <!-- 설명 -->
            <label for="publisher" class="block mb-2 text-base font-bold text-xl">출판사</label>
            <input type="text" name="publisher" class="input input-bordered w-full p-2 mb-10 border rounded" placeholder="출판사를 입력해주세요">
         
          <label for="type" class="block mb-2 text-base font-bold text-xl">전공 여부</label>
         <select class="input input-bordered w-full p-2 mb-10 border rounded select" name="type" id="type"> <!-- 너비와 높이를 지정합니다. -->
                        <option disabled selected value="">전공 여부</option>
                        <option value="1">전공</option>
                       <option value="0">비전공</option>
         </select>
      <button class="btn w-full p-2 border rounded btn-success font-bold text-base mt-10 text-white">도서 등록</button> 
      </form>    
</div>
</nav>
<%@ include file="../common/foot.jsp" %>