<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="SCHEDULE" />
<%@ include file="../common/head.jsp" %>
 <script src="https://cdn.jsdelivr.net/npm/jquery@3.4.1/dist/jquery.min.js"></script>
<!-- Add the evo-calendar.js for.. obviously, functionality! -->
<script src="https://cdn.jsdelivr.net/npm/evo-calendar@1.1.2/evo-calendar/js/evo-calendar.min.js"></script>
<div id="calendar"></div>
 <script>
         var i = 0;

		 $("#calendar").evoCalendar();
		
		var active_date = $('#calendar').evoCalendar('getActiveDate');
		
		$('#calendar').evoCalendar('selectDate', active_date);
		
		$('#calendar').evoCalendar('addCalendarEvent', {
		   id: 'kNybja6',
		   name: 'Mom\'s Birthday',
		   description: 'Lorem ipsum dolor sit..',
		   date: active_date,
		   type: 'birthday'
		});
		
		
		$('#calendar').evoCalendar('toggleEventList');
		
		$('#calendar').on('selectDate', function(event, newDate, oldDate) {
			alert(active_date);
			$('.layer-bg').show();
			$('.layer_change').show();
			$('.close-btn').click(function(){
				$('.layer-bg').hide();
				$('.layer_change').hide();
//				$('.layer-bg, .layer').css('display', 'none');
			})
			$('.close-x-btn').click(function(){
				$('.layer-bg').hide();
				$('.layer_change').hide();
//				$('.layer-bg, .layer').css('display', 'none');
			})
			$('.add-back-btn').click(function(){
				$('.layer_add').hide();
//				$('.layer-bg, .layer').css('display', 'none');
			})
			$('.add-close-x-btn').click(function(){
				$('.layer_add').hide();
//				$('.layer-bg, .layer').css('display', 'none');
			})
			$('.modify-back-btn').click(function(){
				$('.layer_modify').hide();
//				$('.layer-bg, .layer').css('display', 'none');
			})
			$('.modify-close-x-btn').click(function(){
				$('.layer_modify').hide();
//				$('.layer-bg, .layer').css('display', 'none');
			})
			$('.delete-back-btn').click(function(){
				$('.layer_delete').hide();
//				$('.layer-bg, .layer').css('display', 'none');
			})
			$('.delete-close-x-btn').click(function(){
				$('.layer_delete').hide();
//				$('.layer-bg, .layer').css('display', 'none');
			})
			
			
			$('#add').click(function(){
				$('.layer_add').show();
		    })
		    $('#modify').click(function(){
				$('.layer_modify').show();
		    })
		    $('#delete').click(function(){
				$('.layer_delete').show();
		    })
			
			
		});
		 var new_date = '';
		 var rand_id = Math.floor(Math.random() * 1001);
		 var event_name = '';
		 var event_body = '';
		 function add(form){
			    var str = new Date(form.event_date.value);
			    var month = str.getMonth()+1;
			    var day = str.getDate();
			    var year = str.getFullYear();
			    var options = { month: 'long'};
			    var real_month = new Intl.DateTimeFormat('en-US', options).format(str).substr(0,3);
			    new_date = real_month + ' ' + day + ', ' + year;
			    event_name = form.event_name.value.trim();
			    event_body = form.event_body.value.trim();
			    if(  new_date == null ){
			    	alert('날짜를 선택해주세요');
			    	form.event_date.focus();
			    	return;
			    }
			    if( event_name.length == 0 ){
			        alert('일정 이름을 입력해주세요');
			        form.event_name.focus();
			        return;
			    }
			    if( event_body.length == 0 ){
			    	alert('일정 내용을 입력해주세요');
			    	form.event_body.focus();
			    	return;
			    }
			    i = 1;
			    form.event_color.value = "#63d867";
			    form.id.value = rand_id;
			    form.submit();
		 }
		 
			$('#calendar').evoCalendar('addCalendarEvent', {
		           id: rand_id,
				   name: event_name,
				   description: event_body,
				   date: new_date,
				   color: "#63d867"
		    });
		
	
 </script>
    <div class="layer-bg"></div>
	<div class="layer_change">
		<h1 class="text-gray-400">일정 변경</h1>
		<span class="close-x-btn">&times;</span>
		<div class="flex justify-center">
		     <button class="btn btn-info w-full text-white mt-8" id="add">추가</button>
		</div>
		<div class="flex justify-center">
		     <button class="btn btn-success w-full text-white" id="modify">수정</button>
		</div>
		<div class="flex justify-center">
		     <button class="btn btn-error w-full text-white" id="delete">삭제</button>				
		</div>
		<button class="close-btn btn btn-active" id="close">CLOSE</button>				
    </div>
    <div class="layer_add">	
        <h1 class="text-gray-400">일정 추가</h1>
		<span class="add-close-x-btn">&times;</span> 
		<form action="addSchedule" method="POST" onsubmit="add(this); return false;">
		<input type="text" name="id" class="hidden"/>
		<input type="text" name="event_color" class="hidden"/>
		<div class="flex text-black items-center text-sm mt-7">
		   <h1>이벤트 날짜</h1>
		</div>
			<div class="flex justify-center text-black">
			   <input type="date" name="event_date" class="input input-bordered"/>
			</div>
			<h1 class="text-black mt-5 text-sm">일정제목</h1>
			<div class="flex justify-center text-black">
			   <input type="text" name="event_name" class="input input-bordered w-full" placeholder="일정 제목을 입력해주세요"/>		   
			</div>
			<h1 class="text-black mt-5 text-sm">일정내용</h1>
			<div class="flex justify-center text-black">
			   <input type="text" name="event_body" class="input input-bordered w-full" placeholder="일정 내용을 입력해주세요"/>		   
			</div>
			<button class="btn btn-active">추가하기</button>
		</form>
	    <button class="add-back-btn btn btn-active" id="close">뒤로가기</button>					
    </div>
    <div class="layer_modify">	
        <h1 class="text-gray-400">일정 수정</h1>
		<span class="modify-close-x-btn">&times;</span> 
		<form method="POST" onsubmit="add(this); return false;">
		<div class="flex text-black items-center text-sm mt-7">
		   <h1>이벤트 날짜</h1>
		</div>
			<div class="flex justify-center text-black">
			   <input type="date" name="modify_date" class="input input-bordered"/>
			</div>
			<h1 class="text-black mt-5 text-sm">일정제목</h1>
			<div class="flex justify-center text-black">
			   <input type="text" name="modify_schedule_name" class="input input-bordered w-full" placeholder="일정 제목을 입력해주세요"/>		   
			</div>
			<h1 class="text-black mt-5 text-sm">일정내용</h1>
			<div class="flex justify-center text-black">
			   <input type="text" name="modify_schedule_body" class="input input-bordered w-full" placeholder="일정 내용을 입력해주세요"/>		   
			</div>
			<button class="btn btn-active">수정하기</button>
		</form>
	    <button class="modify-back-btn btn btn-active" id="close">뒤로가기</button>					
    </div>
    <div class="layer_delete">	
        <h1 class="text-gray-400">일정 삭제</h1>
		<span class="delete-close-x-btn">&times;</span> 
		<form method="POST" onsubmit="add(this); return false;">
		<div class="flex text-black items-center text-sm mt-7">
		   <h1>이벤트 날짜</h1>
		</div>
			<div class="flex justify-center text-black">
			   <input type="date" name="delete_date" class="input input-bordered"/>
			</div>
			<h1 class="text-black mt-5 text-sm">일정제목</h1>
			<div class="flex justify-center text-black">
			   <input type="text" name="delete_schedule_name" class="input input-bordered w-full" placeholder="일정 제목을 입력해주세요"/>		   
			</div>
			<h1 class="text-black mt-5 text-sm">일정내용</h1>
			<div class="flex justify-center text-black">
			   <input type="text" name="delete_schedule_body" class="input input-bordered w-full" placeholder="일정 내용을 입력해주세요"/>		   
			</div>
			<button class="btn btn-active">추가하기</button>
		</form>
	    <button class="delete-back-btn btn btn-active" id="close">뒤로가기</button>					
    </div>
 <%@ include file="../common/foot.jsp" %>
 
 
 
  
  