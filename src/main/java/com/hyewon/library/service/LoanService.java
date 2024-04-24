package com.hyewon.library.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyewon.library.repository.LoanRepository;

@Service
public class LoanService {
	
	private LoanRepository loanRepository;
	
	@Autowired
	public LoanService(LoanRepository loanRepository) {
		this.loanRepository = loanRepository;
	}
	
	
	public void addSchedule(int id, int loginedMemberId, String event_date, String event_name, String event_body, String event_color) {
		loanRepository.addSchedule(id, loginedMemberId, event_date, event_name, event_body, event_color);
	}
	
}