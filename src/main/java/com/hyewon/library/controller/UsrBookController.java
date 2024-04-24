package com.hyewon.library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hyewon.library.service.BookService;
import com.hyewon.library.util.Util;

@Controller
public class UsrBookController {
	private BookService bookService;
	
	public UsrBookController(BookService bookService) {
		this.bookService = bookService;
	}
	
	@RequestMapping("/user/book/join")
	public String showJoin() {
		return "user/book/join";
	}
	
	@RequestMapping("/user/book/read")
	public String showRead() {
		return "user/book/read";
	}
	

}

