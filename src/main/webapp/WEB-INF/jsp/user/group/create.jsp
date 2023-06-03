<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>Memer_main</title>
<%@ include file="../common/head.jsp" %>
 <script>
      function previewImage(event) {
        var reader = new FileReader();
        reader.onload = function() {
          var preview = document.getElementById("preview-image");
          preview.src = reader.result;
        }
        reader.readAsDataURL(event.target.files[0]);
      }
 </script>
  <div class="text-sm m-10 flex justify-center">
    <form action="upload.php" method="POST" enctype="multipart/form-data">
      <img id="preview-image" src="https://i0.wp.com/adventure.co.kr/wp-content/uploads/2020/09/no-image.jpg" alt="프로필 사진 미리보기" class="mx-auto w-1/5 mt-3 mb-2 border-2 rounded-full border-none">
      <div class="flex text-white font-semibold items-center justify-evenly">
        <label for="file" class="flex text-center p-1 ">
          <div class="flex cursor-pointer border-2 items-center rounded bg-yellow-400 border-yellow-400 p-1"><i class="bi bi-image pr-1"></i>사진 선택</div>
        </label>
        <input type="file" id="file" name="profile-photo" class="hidden" accept="image/*" onchange="previewImage(event)">
        <label for="submit" class="flex text-center">
          <div class="flex cursor-pointer border-2 items-center rounded p-1 bg-green-400 border-green-400 "><i class="bi bi-upload pr-2"></i>Upload</div>
        </label>
        <input type="submit" id="submit" class="hidden">
      </div>
    </form>
  </div>
  </div>
  <form action="doWrite" method="POST" onsubmit="submitForm(this); return false;">
  </ul>
</div> 
  <form>
    <div class="flex justify-center items-center">
    <h1 class="font-semibold">인원</h1>
    <input type="number" class="input input-bordered w-1/10 mx-2 mb-2" placeholder="인원수를 선택하세요"/>명
    </div>
    <input type="hidden" name="body" />
    <div class="flex justify-center items-center">
      <h1 class="font-semibold">제목</h1>
      <input class="input input-bordered w-2/4 ml-2" type="text" name="title" placeholder="제목을 입력해주세요" />
    </div>
    <div class="w-3/4 mx-auto">
      <h1 class="font-semibold">본문</h1>
      <div class="toast-ui-editor bg-white">
        <script type="text/x-template"></script>
      </div>
    </div>
  </form>
    <div class="btns mt-2">
				<button class="btn-text-link btn btn-active ml-1" type="button" onclick="history.back();">뒤로가기</button>
			</div>
<%@ include file="../common/foot.jsp" %>