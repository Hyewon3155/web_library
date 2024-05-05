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


	public void doModify(int id, int book_id, int friend_id, String loanDate, String returnDate, String returnDueDate) {
	    try {
	        loanRepository.doModify(id, book_id, friend_id, loanDate, returnDate, returnDueDate);
	    } catch (Exception e) {
	        // DB 쿼리 실행 중 예외가 발생했을 때
	        e.printStackTrace();
	        // 예외 처리 방법에 따라 적절한 처리를 해줍니다.
	        // 여기서는 예외를 다시 호출자에게 던지도록 설정할 수 있습니다.
	        throw new RuntimeException("대출 이력 정보 수정 중 오류가 발생했습니다. 다시 시도해주세요.", e);
	    }
	}


	public void deleteByFriendId(int id) {
		loanRepository.deleteByFriendId(id);
		
	}

	
}