package com.hyewon.library.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hyewon.library.service.BookService;
import com.hyewon.library.service.LoanService;
import com.hyewon.library.vo.Loan;
import com.hyewon.library.vo.ResultData;

@Controller
public class UsrLoanController {
	LoanService loanService;
	BookService bookService;
	
	@Autowired
	public UsrLoanController(LoanService loanService, BookService bookService) {
		this.loanService = loanService;
		this.bookService = bookService;
	}
	
	@RequestMapping("/user/book/loanBook")
	@ResponseBody
	public ResultData loanBook(@RequestParam int bookId,
	        @RequestParam int friendId) {
		bookService.doLoan(bookId);
		loanService.doLoan(bookId, friendId);
	    
	    return ResultData.from("S-1", "대출되었습니다.");
	}
	
	@RequestMapping("/user/loan/read")
	public String showRead(Model model) {
		List<Loan> loans = loanService.getLoans();
		model.addAttribute("loans", loans);
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
