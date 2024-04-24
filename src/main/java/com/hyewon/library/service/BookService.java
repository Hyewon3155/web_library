package com.hyewon.library.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyewon.library.repository.BookRepository;

@Service
public class BookService {
	
	private BookRepository bookRepository;

	@Autowired
	public BookService(BookRepository bookRepository) {
		this.bookRepository = bookRepository;
	}
	
	public void createGroup(String host, int headCount, int status, String name, String body, String pw) {
		bookRepository.createGroup(host, headCount, status, name, body, pw);
	}
	
	public int getLastInsertId() {
		return bookRepository.getLastInsertId();
	}
	

}
