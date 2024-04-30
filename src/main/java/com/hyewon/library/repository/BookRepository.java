package com.hyewon.library.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.hyewon.library.vo.Book;

@Mapper
public interface BookRepository {
	@Insert("""
			INSERT INTO books
				SET title = #{title},
					author = #{author},
					publisher = #{publisher},
			        `type` = #{type}
			        
			""")
	public void doJoin(String title, String author, String publisher, String type);
	
	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();

	@Select("""
			SELECT *
			FROM books
			""")
	public List<Book> getBooks();

	@Select("""
			SELECT *
			FROM books
			WHERE title LIKE CONCAT('%', #{searchKeyword}, '%')
			""")
	public List<Book> getBookByTitle(String searchKeyword);
	
	@Select("""
			SELECT *
			FROM books
			WHERE author LIKE CONCAT('%', #{searchKeyword}, '%')
			""")
	public List<Book> getBookByAuthor(String searchKeyword);
	
	@Select("""
			SELECT *
			FROM books
			WHERE publisher LIKE CONCAT('%', #{searchKeyword}, '%')
			""")
	public List<Book> getBookByPublisher(String searchKeyword);

	@Delete("""
			DELETE FROM books
			WHERE id = #{id}
			""")
	public void deleteById(int id);

	@Select("""
			SELECT * 
			FROM books
			WHERE id = #{id}
			""")
	public Book getBookById(int id);

	@Update("""
			UPDATE books
				SET title = #{title},
					author = #{author},
					publisher = #{publisher},
			        `type` = #{type}
			 WHERE id = #{id}
			        
			""")
	public void doModify(int id, String title, String author, String publisher, String type);

	@Update("""
			UPDATE books
				SET `status` = "1"
			 WHERE id = #{bookId}
			        
			""")
	public void doLoan(int bookId);

	


	
}
