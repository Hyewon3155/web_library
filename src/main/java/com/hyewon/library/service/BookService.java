package com.hyewon.library.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyewon.library.repository.BookRepository;
import com.hyewon.library.vo.Book;
import com.hyewon.library.vo.ResultData;

@Service
public class BookService {
	
	private BookRepository bookRepository;

	@Autowired
	public BookService(BookRepository bookRepository) {
		this.bookRepository = bookRepository;
	}
	
	
	public int getLastInsertId() {
		return bookRepository.getLastInsertId();
	}

	public void doJoin(String title, String author, String publisher, String type) {
		bookRepository.doJoin(title, author, publisher, type);
	}


	public List<Book> getBooks() {
		return bookRepository.getBooks();
	}


	public List<Book> getBookByTitle(String searchKeyword) {
		return bookRepository.getBookByTitle(searchKeyword);
	}
	
	public List<Book> getBookByAuthor(String searchKeyword) {
		return bookRepository.getBookByAuthor(searchKeyword);
	}
	
	public List<Book> getBookByPublisher(String searchKeyword) {
		return bookRepository.getBookByPublisher(searchKeyword);
	}


	public void deleteById(int id) {
		bookRepository.deleteById(id);
	}


	public Book getBookById(int id) {
		return bookRepository.getBookById(id);
	}


	public void doModify(int id, String title, String author, String publisher, String type) {
		bookRepository.doModify(id, title, author, publisher, type);
	}
	

}
