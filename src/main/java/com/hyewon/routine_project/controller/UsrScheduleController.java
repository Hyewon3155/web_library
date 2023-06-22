package com.hyewon.routine_project.controller;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hyewon.routine_project.service.ScheduleService;
import com.hyewon.routine_project.util.Util;
import com.hyewon.routine_project.vo.Rq;

@Controller
public class UsrScheduleController {
	ScheduleService scheduleService;
	
	Rq rq;
	
	@Autowired
	public UsrScheduleController(ScheduleService scheduleService, Rq rq) {
		this.scheduleService = scheduleService;
		this.rq = rq;
	}
	
	@RequestMapping("/user/member/schedule")
	public String showSchedule() {
		return "user/member/schedule";
	}
	
	@RequestMapping("/user/member/addSchedule")
	@ResponseBody
	public String addSchedule(int id,  String event_color, Date event_date, String event_name, String event_body) {
		
		if (Util.empty(event_date)) {
			return Util.jsHistoryBack("response 날짜를 선택해주세요");
		}
		
		if (Util.empty(event_name)) {
			return Util.jsHistoryBack("이벤트 이름을 입력해주세요");
		}
		
		if (Util.empty(event_body)) {
			return Util.jsHistoryBack("이벤트 내용을 입력해주세요");
		}
				
        scheduleService.addSchedule(id, rq.getLoginedMemberId(), event_date, event_name, event_body, event_color);
		
		return Util.jsReplace("일정이 추가되었습니다", "../member/schedule");
		
	}
	
	@RequestMapping("/user/member/schedule-modify")
	public String modifySchedule() {
		return "user/member/schedule-add";
	}
	
	@RequestMapping("/user/member/schedule-delete")
	public String deleteSchedule() {
		return "user/member/schedule-delete";
	}

}
