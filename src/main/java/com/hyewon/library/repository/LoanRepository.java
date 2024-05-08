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

	@Delete("""
			DELETE FROM loans
			WHERE id = #{id}
			""")
	public void deleteByLoanId(int id);

	@Select("""
		    SELECT 
		        friends.name AS friendName, 
		        books.title AS title,
		        loans.friend_id,
		        loans.book_id,
		        SUBSTRING(loans.loanDate, 1, 10) AS loanDate, 
		        SUBSTRING(loans.returnDate, 1, 10) AS returnDate,
		        SUBSTRING(loans.returnDueDate, 1, 10) AS returnDueDate
		    FROM loans
		    JOIN friends ON loans.friend_id = friends.id
		    JOIN books ON loans.book_id = books.id
		    WHERE loans.id = #{id}
		""")
	public Loan getLoanById(int id);

	@Update("""
			UPDATE loans
				SET book_id = #{book_id},
					friend_id = #{friend_id},
					loanDate = #{loanDate},
					returnDate = #{returnDate},
					returnDueDate = #{returnDueDate}
			WHERE id = #{id}
					
			""")
	public void doModify(int id, int book_id, int friend_id, String loanDate,
			String returnDate, String returnDueDate);

	@Delete("""
			DELETE FROM loans
			WHERE friend_id = #{id}
			""")
	public void deleteByFriendId(int id);

	@Select("""
		SELECT 
		    friends.name AS friendName, 
		    books.title AS title,
		    loans.friend_id,
		    loans.book_id,
		    SUBSTRING(loans.loanDate, 1, 10) AS loanDate, 
		    SUBSTRING(loans.returnDate, 1, 10) AS returnDate,
		    SUBSTRING(loans.returnDueDate, 1, 10) AS returnDueDate,
		    TIMESTAMPDIFF(DAY, loans.returnDueDate, loans.returnDate) AS overdueDays
		FROM loans
		JOIN friends ON loans.friend_id = friends.id
		JOIN books ON loans.book_id = books.id
		WHERE loans.returnDate > loans.returnDueDate;


		""")
	public List<Loan> getOldLoans();

	@Select("""
			SELECT loans.*, friends.name AS friendName, books.title AS title, 		    
			TIMESTAMPDIFF(DAY, loans.returnDueDate, loans.returnDate) AS overdueDays
			FROM loans
			JOIN friends ON loans.friend_id = friends.id
			JOIN books ON loans.book_id = books.id
			WHERE books.title LIKE CONCAT('%', #{searchKeyword}, '%')
			AND loans.returnDate > loans.returnDueDate;
			""")
	public List<Loan> getOldLoanByTitle(String searchKeyword);

	@Select("""
			SELECT loans.*, friends.name AS friendName, books.title AS title, 		    
			TIMESTAMPDIFF(DAY, loans.returnDueDate, loans.returnDate) AS overdueDays
			FROM loans
			JOIN friends ON loans.friend_id = friends.id
			JOIN books ON loans.book_id = books.id
			WHERE friends.name LIKE CONCAT('%', #{searchKeyword}, '%')
			AND loans.returnDate > loans.returnDueDate;
			""")
	public List<Loan> getOldLoanByFriendName(String searchKeyword);

	@Select("""
			SELECT loans.*, friends.name AS friendName, books.title AS title, 		    
			TIMESTAMPDIFF(DAY, loans.returnDueDate, loans.returnDate) AS overdueDays
			FROM loans
			JOIN friends ON loans.friend_id = friends.id
			JOIN books ON loans.book_id = books.id
			WHERE loans.loanDate LIKE CONCAT('%', #{searchKeyword}, '%')
			AND loans.returnDate > loans.returnDueDate;
			""")
	public List<Loan> getOldLoanByLoanDate(String searchKeyword);
	
	@Select("""
			SELECT loans.*, friends.name AS friendName, books.title AS title, 		    
			TIMESTAMPDIFF(DAY, loans.returnDueDate, loans.returnDate) AS overdueDays
			FROM loans
			JOIN friends ON loans.friend_id = friends.id
			JOIN books ON loans.book_id = books.id
			WHERE loans.returnDate LIKE CONCAT('%', #{searchKeyword}, '%')
			AND loans.returnDate > loans.returnDueDate;
			""")
	public List<Loan> getOldLoanByReturnDate(String searchKeyword);
	
	@Select("""
			SELECT loans.*, friends.name AS friendName, books.title AS title, 		    
			TIMESTAMPDIFF(DAY, loans.returnDueDate, loans.returnDate) AS overdueDays
			FROM loans
			JOIN friends ON loans.friend_id = friends.id
			JOIN books ON loans.book_id = books.id
			WHERE loans.returnDueDate LIKE CONCAT('%', #{searchKeyword}, '%')
			AND loans.returnDAte > loans.returnDueDate;
			""")
	public List<Loan> getOldLoanByReturnDueDate(String searchKeyword);
	
	



	
}
