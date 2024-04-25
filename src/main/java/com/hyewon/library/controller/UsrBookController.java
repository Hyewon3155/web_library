package com.hyewon.library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hyewon.library.service.BookService;
import com.hyewon.library.util.Util;
import com.hyewon.library.vo.ResultData;

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
	
	@RequestMapping("/user/book/doJoin")
	@ResponseBody
	public String doJoin(String title, String author, String publisher, String type) {
	    // 이름, 학교, 학과, 전화번호, 이메일이 비어 있는지 확인
	    if (Util.empty(title)) {
	        return Util.jsHistoryBack("도서명을 입력해주세요");
	    }
	    if (Util.empty(author)) {
	        return Util.jsHistoryBack("저자를 입력해주세요");
	    }
	    if (Util.empty(publisher)) {
	        return Util.jsHistoryBack("출판사를 입력해주세요");
	    }
	    if (Util.empty(type)) {
	        return Util.jsHistoryBack("전공 여부를 선택해주세요");
	    }
	    
	    

	   bookService.doJoin(title, author, publisher, type);
		return Util.jsReplace(Util.f("책이 등록되었습니다"), Util.f("read"));

	}
	
	@RequestMapping("/user/book/read")
	public String showRead() {
		return "user/book/read";
	}
	

}

