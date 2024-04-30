package com.hyewon.library.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyewon.library.repository.LoanRepository;
import com.hyewon.library.vo.Loan;

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


	public void doLoan(int bookId, int friendId) {
		loanRepository.doLoan(bookId, friendId);
		
	}


	public void deleteByBookId(int id) {
		loanRepository.deleteByBookId(id);
		
	}


	public List<Loan> getLoans() {
		return loanRepository.getLoans();
	}
	
}