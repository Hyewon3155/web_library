<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>schedule</title>
<%@ include file="../common/head.jsp" %>
<%@ include file="main_head.jsp" %>
<%@ include file="../common/fullcalendarLib.jsp" %>
  <div id="calendar"></div>
   <div id="modal_addSchedule">
    <h3 class="flex justify-center">이벤트 추가하기</h3>
    <h2 class="text-semibold flex mt-2">일정</h2>
    <input type="text" id="eventTitle" class="input input-bordered w-full" placeholder="일정 이름을 입력하세요" />
    <div class="flex justify-between mt-2">
      <button id="saveButton" class="flex justify-between btn btn-success">Save</button>
      <button id="cancelButton" class="btn btn-success">Cancel</button>
    </div>
   </div>
   
   <div id="modal_changeSchedule">
    <h3 class="flex justify-center">이벤트 변경하기</h3>
    <div class="flex justify-between mt-2">
      <button id="updateButton" class="flex justify-between btn btn-success">수정</button>
      <button id="deleteButton" class="btn btn-success">삭제</button>
    </div>
   </div>
   
   

<%@ include file="../common/foot.jsp" %>

  