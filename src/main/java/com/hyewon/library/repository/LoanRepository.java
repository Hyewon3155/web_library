package com.hyewon.library.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.hyewon.library.vo.Loan;

@Mapper
public interface LoanRepository {
	
	@Insert("""
			INSERT INTO `schedule`
				SET id = #{id},
				    event_member = #{event_member},
				    event_date = #{event_date},
					event_name = #{event_name},
					event_body = #{event_body},
					event_color = #{event_color}
			        
			""")
	public void addSchedule(int id, int event_member, String event_date, String event_name, String event_body, String event_color);
	
	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();

	@Insert("""
			INSERT INTO loans
				SET book_id = #{bookId},
					friend_id = #{friendId},
					loanDate = NOW()
			""")
	public void doLoan(int bookId, int friendId);

	@Delete("""
			DELETE FROM loans
			WHERE book_id = #{id}
			""")
	public void deleteByBookId(int id);

	@Select("""
			SELECT loans.*, friends.name AS friendName, books.title AS title
			FROM loans
			JOIN friends ON loans.friend_id = friends.id
			JOIN books ON loans.book_id = books.id;

			""")
	public List<Loan> getLoans();


	
}
