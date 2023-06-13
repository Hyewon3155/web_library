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
		 $("#calendar").evoCalendar();
		
		//addCalendarEvent
		
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
		  
		});
 </script>
 <%@ include file="../common/foot.jsp" %>
 
 
 
  
  