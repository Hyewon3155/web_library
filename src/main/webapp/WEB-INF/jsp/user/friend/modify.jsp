<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="친구 수정" />
<%@ include file="../common/head.jsp" %>
<script>
      
      function validateEmail(email) {
    	    // 이메일 형식을 검사하는 정규 표현식
    	    var re = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    	    return re.test(email);
    	}
      
      function join_submitForm(form) {
    	
  		form.name.value = form.name.value.trim();
  		if (form.name.value.length == 0) {
  			alert('이름을 입력해주세요');
  			form.name.focus();
  			return;
  		}
  		
  		form.school.value = form.school.value.trim();
  		if (form.school.value.length == 0) {
  			alert('학교를 입력해주세요');
  			form.school.focus();
  			return;
  		}
  		
  		form.depart.value = form.depart.value.trim();
  		if (form.depart.value.length == 0) {
  			alert('학과를 입력해주세요');
  			form.depart.focus();
  			return;
  		}
  		
  		form.phone1.value = form.phone1.value.trim();
  		form.phone2.value = form.phone2.value.trim();
  		form.phone3.value = form.phone3.value.trim();
  		

  		if (form.phone1.value.length == 0 || form.phone2.value.length == 0 || form.phone3.value.length == 0) {
  			alert('전화번호를 입력해주세요');
  			form.phone1.focus();
  			return;
  		}
  		

  		form.email.value = form.email.value.trim();
  		if (form.email.value.length == 0) {
  			alert('이메일을 입력해주세요');
  			form.email.focus();
  			return;
  		}
  		
  		 if (!validateEmail(form.email.value)) {
  	        alert('올바른 이메일 형식이 아닙니다');
  	        form.email.focus();
  	        return;
  	    }

  		
  		form.submit();
  	}
</script>
<style>
	body {
		height: 100%;
	}
</style>
<nav class="bg-gray-200 py-20">
    <div class="max-w-2xl mx-auto bg-white p-10 rounded-lg shadow-md">
        <h1 class="text-2xl mb-10">친구 수정</h1>
           <form action="doModify" method="POST" onsubmit="join_submitForm(this); return false;">
           <input type="hidden" name="id" value="${friend.id }"/>
            <label for="name" class="block mb-2 text-xl font-bold"><i class="bi bi-person-plus mr-2 text-xl"></i>이름</label>
            <input type="text" name="name" class="input input-bordered w-full p-2 mb-10 border rounded" placeholder="이름을 입력해주세요" value="${friend.name }">

            <label for="schoool" class="block mb-2 text-base font-bold text-xl"><i class="bi bi-mortarboard mr-2 text-xl"></i>소속</label>
            <input class="input input-bordered w-20 mb-10 border rounded" type="text" name="school" value="${friend.school }"/> 대학교 <input class="input input-bordered w-32 ml-2" type="text" name="depart" value="${friend.depart }"/> 과
            <!-- 설명 -->
            <label for="cellphoneNum" class="block mb-2 text-base font-bold text-xl"><i class="bi bi-telephone-plus mr-2 text-xl"></i>전화번호</label>
            <input class="input input-bordered mb-10 w-24" type="text" name="phone1" value="${phone1 }"/>-<input class="input input-bordered w-24" type="text" name="phone2" value="${phone2 }"/>-<input class="input input-bordered w-24" type="text" name="phone3" value="${phone3 }"/>
         <label for="email" class="block mb-2 text-base font-bold text-xl"><i class="bi bi-envelope-plus mr-2 text-xl"></i>이메일</label>
            <input type="text" name="email" class="input input-bordered w-full p-2 mb-4 border rounded" placeholder="이메일을 입력해주세요" value="${friend.email }">
      <button class="btn w-full p-2 border rounded btn-success font-bold text-base mt-10 text-white">친구 수정</button> 
      </form>    
</div>
</nav>
<%@ include file="../common/foot.jsp" %>