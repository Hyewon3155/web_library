<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
let calendar;
var date;
var id;
document.addEventListener('DOMContentLoaded', function() {
var calendarEl = document.getElementById('calendar');
calendar = new FullCalendar.Calendar(calendarEl, {
	initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면 (기본 설정: 달)
    locale: 'ko', // 한국어 설정
    expandRows: true, // 화면에 맞게 높이 재설정
    height: '500px', // calendar 높이 설정
    timeZone: 'UTC',
    editable: true,
    dayMaxEvents: true,
    selectable: true,
    droppable: true,
    headerToolbar: {
    	    left: 'prev,next today',
    	    center: 'title',
    	    right: 'dayGridMonth,timeGridWeek,timeGridDay'
      },
    events: [
    	{
        	idx: 0, // extendedProps.idx 접근 가능
            title: '첫번째 일정',
            start: '2023-01-25',
            classNames: [ 'classAddtest' ], // event 영역 class 추가
            backgroundColor: 'red',
            borderColor: 'red',
            textColor: 'black',
      	},
        {
        	title: '두번째 일정',
            start: '2023-01-25',
            end: '2023-01-28',
		},
        {
        	title: '페이지 이동 이벤트 호출',
            url: 'https://naver.com',
            start: '2023-02-01',
		},
	], // 이벤트
	 eventClick: function(info) {
		    $("#modal_changeSchedule").css("display", "block");
		    id = info.event.title;
     },
	
	// 일정 이벤트 클릭 이벤트 callback
	 dateClick: function(info) {
		 $("#modal_addSchedule").css("display", "block");
		 date = info.dateStr;
	 }
	
  });
  calendar.render();
  $("#saveButton").click(function(info) {
	  var id = $("#eventTitle").val();
      var title = $("#eventTitle").val();
      var event = {
        id: id,
        title: title,
        start: date,
        allDay: true
      };
      calendar.addEvent(event);
      $("#modal_addSchedule").css("display", "none");
      
    });
  
    $("#cancelButton").click(function() {
      $("#modal_addSchedule").css("display", "none");
    });
    
      $("#deleteButton").click(function() {
    	  var event = calendar.getEventById(id);// an event object!
    	  event.remove();
          $("#modal_changeSchedule").css("display", "none");
      });
      
});
</script>