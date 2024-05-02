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
import com.hyewon.library.util.Util;
import com.hyewon.library.vo.Friend;
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
	
	@RequestMapping("/user/loan/doReturn")
	@ResponseBody
	public ResultData doReturn(@RequestParam int loanId) {
		loanService.doReturn(loanId);
		loanService.changeStatus(loanId);
	    return ResultData.from("S-1", "반납되었습니다.");
	}
	
	@RequestMapping("/user/loan/searchLoan")
	@ResponseBody
	public ResultData searchLoan(@RequestParam(defaultValue = "") String searchKeywordType,
	        @RequestParam(defaultValue = "") String searchKeyword) {
	    
	    if (Util.empty(searchKeywordType)) {
	        return ResultData.from("F-1", "검색 조건을 설정해주세요");
	    }
	    if (Util.empty(searchKeyword)) {
	        return ResultData.from("F-1", "검색어를 입력해주세요");
	    }
	    
	    List<Loan> loans = null;
	    if ("책 제목".equals(searchKeywordType)) {
	        loans = loanService.getLoanByTitle(searchKeyword);

	    } else if ("대출자".equals(searchKeywordType)) {
	        loans = loanService.getLoanByFriendName(searchKeyword);

	    } else if ("대출일자".equals(searchKeywordType)) {
	        loans = loanService.getLoanByLoanDate(searchKeyword);

	    } else if ("반납일자".equals(searchKeywordType)) {
	        loans = loanService.getLoanByReturnDate(searchKeyword);

	    } else if ("반납예정일".equals(searchKeywordType)) {
	        loans = loanService.getLoanByReturnDueDate(searchKeyword);

	    }
	    
	    if (loans == null || loans.isEmpty()) {
	        return ResultData.from("F-2", "해당 대출 이력이 없습니다");
	    }
	    
	    return ResultData.from("S-1", "", "loans", loans);
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
