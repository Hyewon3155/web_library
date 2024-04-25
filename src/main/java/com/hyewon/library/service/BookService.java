package com.hyewon.library.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyewon.library.repository.BookRepository;
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
	

}
