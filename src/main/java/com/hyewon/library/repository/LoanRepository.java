package com.hyewon.library.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

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

	@Update("""
			UPDATE loans
				SET returnDate = NOW()
			WHERE id = #{loanId}
			""")
	public void doReturn(int loanId);

	@Update("""
			UPDATE books b
            INNER JOIN loans l ON b.id = l.book_id
            SET b.status = "0"
            WHERE l.id = #{loanId}
			""")
	public void changeStatus(int loanId);

	@Select("""
			SELECT loans.*, friends.name AS friendName, books.title AS title
			FROM loans
			JOIN friends ON loans.friend_id = friends.id
			JOIN books ON loans.book_id = books.id
			WHERE books.title LIKE CONCAT('%', #{searchKeyword}, '%')
			""")
	public List<Loan> getLoanByTitle(String searchKeyword);

	@Select("""
			SELECT loans.*, friends.name AS friendName, books.title AS title
			FROM loans
			JOIN friends ON loans.friend_id = friends.id
			JOIN books ON loans.book_id = books.id
			WHERE friends.name LIKE CONCAT('%', #{searchKeyword}, '%')
			""")
	public List<Loan> getLoanByFriendName(String searchKeyword);

	@Select("""
			SELECT loans.*, friends.name AS friendName, books.title AS title
			FROM loans
			JOIN friends ON loans.friend_id = friends.id
			JOIN books ON loans.book_id = books.id
			WHERE loans.loanDate LIKE CONCAT('%', #{searchKeyword}, '%')
			""")
	public List<Loan> getLoanByLoanDate(String searchKeyword);

	@Select("""
			SELECT loans.*, friends.name AS friendName, books.title AS title
			FROM loans
			JOIN friends ON loans.friend_id = friends.id
			JOIN books ON loans.book_id = books.id
			WHERE loans.returnDate LIKE CONCAT('%', #{searchKeyword}, '%')
			""")
	public List<Loan> getLoanByReturnDate(String searchKeyword);
	
	@Select("""
			SELECT loans.*, friends.name AS friendName, books.title AS title
			FROM loans
			JOIN friends ON loans.friend_id = friends.id
			JOIN books ON loans.book_id = books.id
			WHERE loans.returnDueDate LIKE CONCAT('%', #{searchKeyword}, '%')
			""")
	public List<Loan> getLoanByReturnDueDate(String searchKeyword);


	
}
