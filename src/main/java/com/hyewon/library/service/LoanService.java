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


	public void doReturn(int loanId) {
		loanRepository.doReturn(loanId);

		
	}


	public void changeStatus(int loanId) {
		loanRepository.changeStatus(loanId);
		
	}


	public List<Loan> getLoanByTitle(String searchKeyword) {
		return loanRepository.getLoanByTitle(searchKeyword);
	}


	public List<Loan> getLoanByFriendName(String searchKeyword) {
		return loanRepository.getLoanByFriendName(searchKeyword);
	}


	public List<Loan> getLoanByLoanDate(String searchKeyword) {
		return loanRepository.getLoanByLoanDate(searchKeyword);
	}


	public List<Loan> getLoanByReturnDate(String searchKeyword) {
		return loanRepository.getLoanByReturnDate(searchKeyword);
	}
	
	public List<Loan> getLoanByReturnDueDate(String searchKeyword) {
		return loanRepository.getLoanByReturnDueDate(searchKeyword);
	}


	public void deleteByLoanId(int id) {
		loanRepository.deleteByLoanId(id);
		
	}


	public Loan getLoanById(int id) {
		return loanRepository.getLoanById(id);
	}


	public void doModify(int id, int book_id, int friend_id, String loanDate,
			String returnDate, String returnDueDate) {
			loanRepository.doModify(id, book_id, friend_id, loanDate, returnDate, returnDueDate);
	}
	
}