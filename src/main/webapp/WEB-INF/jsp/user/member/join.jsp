<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="JOIN" />
<%@ include file="../common/head.jsp" %>

<script>
	let validLoginId = '';

	function join_submitForm(form) {
		
		form.loginId.value = form.loginId.value.trim();
		if (form.loginId.value.length == 0) {
			alert('아이디를 입력해주세요');
			form.loginId.focus();
			return;
		}
		
		if (form.loginId.value != validLoginId) {
			alert(form.loginId.value + '은(는) 사용할 수 없는 아이디입니다');
			form.loginId.value = '';
			form.loginId.focus();
			return;
		}
		
		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length == 0) {
			alert('비밀번호를 입력해주세요');
			form.loginPw.focus();
			return;
		}
		
		form.loginPwChk.value = form.loginPwChk.value.trim();
		if (form.loginPwChk.value.length == 0) {
			alert('비밀번호 확인을 입력해주세요');
			form.loginPwChk.focus();
			return;
		}
		
		if (form.loginPw.value != form.loginPwChk.value) {
			alert('비밀번호가 일치하지 않습니다');
			form.loginPw.value = '';
			form.loginPwChk.value = '';
			form.loginPw.focus();
			return;
		}
		
		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요');
			form.name.focus();
			return;
		}
		
		form.cellphoneNum.value = form.cellphoneNum.value.trim();
		if (form.cellphoneNum.value.length == 0) {
			alert('전화번호를 입력해주세요');
			form.cellphoneNum.focus();
			return;
		}
		
		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요');
			form.email.focus();
			return;
		}
		
		form.submit();
	}
	
	function loginIdDupCheck(el) {
		let loginIdDupCheckMsg = $('#loginIdDupCheckMsg');

		loginIdDupCheckMsg.empty();
		
		el.value = el.value.trim();
		
		if (el.value.length == 0) {
			loginIdDupCheckMsg.removeClass('text-green-500');
			loginIdDupCheckMsg.addClass('text-red-500');
			loginIdDupCheckMsg.html('<span>아이디는 필수 입력 정보입니다</span>');
			return;
		}
		
		$.get('loginIdDupCheck', {
			loginId : el.value,
		}, function(data) {
			if (data.success) {
				loginIdDupCheckMsg.removeClass('text-red-500');
				loginIdDupCheckMsg.addClass('text-green-500');
				loginIdDupCheckMsg.html(`<span>\${data.data1 }은(는) \${data.msg }</span>`);
				validLoginId = data.data1;
				
			} else {
				loginIdDupCheckMsg.removeClass('text-green-500');
				loginIdDupCheckMsg.addClass('text-red-500');
				loginIdDupCheckMsg.html(`<span>\${data.data1 }은(는) \${data.msg }</span>`);
				validLoginId = '';
			}
			
		}, 'json');
	}
	  

</script>

<section class="mt-5 flex container mx-auto justify-center overflow-hidden">
  <div class="mx-auto">
   <form action="doJoin" method="POST" onsubmit="join_submitForm(this); return false;">
    <h1 class="block font-semibold mb-2">ID</h1>
      <i class="fas fa-user mr-2"></i>
      <input type="text" name="loginId" placeholder="아이디" onblur="loginIdDupCheck(this);" />
      <hr class="mt-2">
      <div id="loginIdDupCheckMsg" class="text-sm mt-2 h-5 text-red-500"></div>
      <h1 class="block font-semibold mb-2">PW</h1>
      <i class="fa-solid fa-user-lock mr-2"></i>
      <input type="text" name="loginPw" placeholder="비밀번호">
      <hr class="mt-2">
      <h1 class="block font-semibold mb-2 mt-2">PW_CHK</h1>
      <i class="fa-solid fa-user-lock mr-2"></i>
      <input type="text" name="loginPwChk" placeholder="비밀번호 확인">
      <hr class="mt-2">
      <h1 class="block font-semibold mb-2 mt-2">NAME</h1>
      <i class="fas fa-user mr-2"></i>
      <input type="text" name="name" placeholder="이름">
      <hr class="mt-2">
      <h1 class="block font-semibold mb-2 mt-2">NICKNAME</h1>
      <i class="fas fa-user mr-2"></i>
      <input type="text" name="nickname" placeholder="닉네임">
      <hr class="mt-2">
      <h1 class="block font-semibold mb-2 mt-2">EMAIL</h1>
      <i class="fa-solid fa-envelope mr-2"></i>
      <input type="email" name="email" placeholder="이메일"/>
      <hr class="mt-2">
      <h1 class="block font-semibold mb-2 mt-2">PHONE</h1>
      <i class="fa-solid fa-mobile-screen mr-2"></i>
      <input type="tel" name="cellphoneNum" placeholder="전화번호">
      <hr class="mt-2">
      <br>
      <button class="btn btn-success w-full">JOIN</button>
    </form>
    <div class="btns mt-2">
		<button class="btn-text-link btn btn-active" type="button" onclick="history.back();">뒤로가기</button>
    </div>
  </div>
</section>
<%@ include file="../common/foot.jsp" %>