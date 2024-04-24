package com.hyewon.library.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hyewon.library.service.LoanService;
import com.hyewon.library.util.Util;

@Controller
public class UsrLoanController {
	LoanService loanService;
	
	@Autowired
	public UsrLoanController(LoanService loanService) {
		this.loanService = loanService;
	}
	
	@RequestMapping("/user/loan/read")
	public String showRead() {
		return "user/loan/read";
	}

	@RequestMapping("/user/loan/manage")
	public String showManage() {
		return "user/loan/manage";
	}

	
	@RequestMapping("/user/loan/schedule-modify")
	public String modifySchedule() {
		return "user/loan/schedule-add";
	}
	
	@RequestMapping("/user/loan/schedule-delete")
	public String deleteSchedule() {
		return "user/loan/schedule-delete";
	}

}
