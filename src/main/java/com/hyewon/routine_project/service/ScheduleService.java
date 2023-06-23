package com.hyewon.routine_project.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyewon.routine_project.repository.ScheduleRepository;

@Service
public class ScheduleService {
	
	private ScheduleRepository scheduleRepository;
	
	@Autowired
	public ScheduleService(ScheduleRepository scheduleRepository) {
		this.scheduleRepository = scheduleRepository;
	}
	
	
	public void addSchedule(int id, int loginedMemberId, String event_date, String event_name, String event_body, String event_color) {
		scheduleRepository.addSchedule(id, loginedMemberId, event_date, event_name, event_body, event_color);
	}
	
}