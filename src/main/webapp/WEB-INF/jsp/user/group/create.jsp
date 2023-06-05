<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>루틴 그룹 생성</title>
<%@ include file="../common/head.jsp" %>
<%@ include file="../member/main.jsp" %>
<%@ include file="../common/toastUiEditorLib.jsp" %>
 <script>
      function previewImage(event) {
        var reader = new FileReader();
        reader.onload = function() {
          var preview = document.getElementById("preview-image");
          preview.src = reader.result;
        }
        reader.readAsDataURL(event.target.files[0]);
      }
      

      function submitForm(form) {
    	  
        form.file.value = form.file.value.trim();
    		if (form.file.value.length == 0) {
    			alert('공개 여부를 설정해주세요');
    			form.file.focus();
    			return;
        }
  		
  		form.status.value = form.status.value.trim();
  		if (form.status.value.length == 0) {
  			alert('공개 여부를 설정해주세요');
  			form.status.focus();
  			return;
  		}
  		
  		form.headCount.value = form.headCount.value.trim();
  		if (form.headCount.value.length == 0) {
  			alert('정원을 설정해주세요');
  			form.headCount.focus();
  			return;
  		}
  		if(form.headCount.value <= 1){
  			alert('정원은 2명부터 가능합니다');
  		    form.headCount.focus();
  		}
  		
  		form.name.value = form.name.value.trim();
  		if (form.name.value != form.name.value) {
  			alert('그룹 이름을 입력해주세요');
  			form.name.focus();
  			return;
  		}
  		
  		form.name.value = form.name.value.trim();
  		if (form.name.value.length == 0) {
  			alert('이름을 입력해주세요');
  			form.name.focus();
  			return;
  		}
  		
  		form.body.value = form.body.value.trim();
  		if (form.body.value.length == 0) {
  			alert('소개글을 입력해주세요');
  			form.body.focus();
  			return;
  		}
  		
  		form.submit();
  	}
  	
 </script>

  <form action="doWrite"  method="POST" enctype="multipart/form-data" onsubmit="submitForm(this); return false;">
     <div class="flex justify-center">
      <img id="preview-image" src="https://i0.wp.com/adventure.co.kr/wp-content/uploads/2020/09/no-image.jpg" alt="프로필 사진 미리보기" class="w-1/5 mt-3 mb-2 border-2 rounded-full border-none">
     </div>
      <div class="flex font-semibold items-center justify-center mb-5">
        <label for="file" class="flex text-center p-1 cursor-pointer border-2 items-center rounded border-yellow-400 text-yellow-400">
         <i class="bi bi-image pr-1"></i>사진 선택
         <input type="file" id="file" name="file" class="hidden" onchange="previewImage(event)"> 
        </label>
      </div>
     <div class="flex justify-center mb-3 mt-3">
      <h1 class="font-semibold mr-3">공개여부</h1>
      <input type="radio" name="status" value="1"/>
		&nbsp;공개
	    &nbsp;&nbsp;
	   <input type="radio" name="status" value="2"/>
		&nbsp;비공개
	</div>
    <div class="flex justify-center items-center">
    <h1 class="font-semibold">인원</h1>
    <input type="number" name="headCount" class="input input-bordered w-1/10 mx-2 mb-2" placeholder="인원수를 선택하세요"/>명
    </div>
    <input type="hidden" name="body" />
    <div class="flex justify-center items-center">
      <h1 class="font-semibold">이름</h1>
      <input class="input input-bordered w-2/4 ml-2" type="text" name="name" placeholder="루틴 이름을 입력해주세요" />
    </div>
    <div class="w-3/4 mx-auto">
      <h1 class="font-semibold">소개글</h1>
      <div class="toast-ui-editor bg-white">
        <script type="text/x-template"></script>
      </div>
    </div>
    <div class="mt-2 mx-auto text-center w-3/4">
       <button type="submit" class="p-1 cursor-pointer border-2 rounded bg-yellow-400 border-yellow-400 w-full">업로드</button>
    </div>
  </form>
  <div class="mt-2 w-3/4 mx-auto">
    <div class="flex jusify-evenly btns">
	    <button class="btn-text-link btn btn-active " type="button" onclick="history.back();">뒤로가기</button>
    </div>
  </div>
<%@ include file="../common/foot.jsp" %>