package com.hyewon.library.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hyewon.library.service.BookService;
import com.hyewon.library.service.FriendService;
import com.hyewon.library.service.LoanService;
import com.hyewon.library.util.Util;
import com.hyewon.library.vo.Book;
import com.hyewon.library.vo.Friend;
import com.hyewon.library.vo.ResultData;

@Controller
public class UsrBookController {
	private BookService bookService;
	private FriendService friendService;
	private LoanService loanService;
	
	public UsrBookController(BookService bookService, FriendService friendService, LoanService loanService) {
		this.bookService = bookService;
		this.friendService = friendService;
		this.loanService = loanService;
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
	public String showRead(Model model) {
		List<Book> books = bookService.getBooks();
		List<Friend> friends = friendService.getFriends();
		model.addAttribute("books", books);
		model.addAttribute("friends", friends);
		return "user/book/read";
	}
	
	@RequestMapping("/user/book/searchBook")
	@ResponseBody
	public ResultData searchBook(@RequestParam(defaultValue = "") String searchKeywordType,
	        @RequestParam(defaultValue = "") String searchKeyword) {
	    
	    if (Util.empty(searchKeywordType)) {
	        return ResultData.from("F-1", "검색 조건을 설정해주세요");
	    }
	    if (Util.empty(searchKeyword)) {
	        return ResultData.from("F-1", "검색어를 입력해주세요");
	    }
	    
	    List<Book> books = null;
	    if ("제목".equals(searchKeywordType)) {
	        books = bookService.getBookByTitle(searchKeyword);

	    } else if ("저자".equals(searchKeywordType)) {
	    	books = bookService.getBookByAuthor(searchKeyword);
	    	
	    } else if ("출판사".equals(searchKeywordType)) {
	    	books = bookService.getBookByPublisher(searchKeyword);

	    }
	    if (books == null || books.isEmpty()) {
	        return ResultData.from("F-2", "존재하지 않는 책입니다");
	    }
	    
	    return ResultData.from("S-1", "", "books", books);
	}
	
	@RequestMapping("/user/book/delete")
	@ResponseBody
	public ResultData doDelete(@RequestParam int id) {
		loanService.deleteByBookId(id);
        bookService.deleteById(id);	    
        return ResultData.from("S-1", "삭제되었습니다.");
	}
	
	@RequestMapping("/user/book/modify")
	public String showModify(Model model, int id) {
	    Book book = bookService.getBookById(id);
		model.addAttribute("book", book);

		return "user/book/modify";
	}
	
	@RequestMapping("/user/book/doModify")
	@ResponseBody
	public String doModify(int id, String title, String author, String publisher, String type) {
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
	    
	   bookService.doModify(id, title, author, publisher, type);
		return Util.jsReplace(Util.f("%s 도서 정보가 수정되었습니다", title), Util.f("detail?id=%d", id));

	}
	
	@RequestMapping("/user/book/detail")
	public String showDetail(Model model, int id) {
	    Book book = bookService.getBookById(id);
		model.addAttribute("book", book);

		return "user/book/detail";
	}
	
	@RequestMapping("/user/book/searchFriend")
	@ResponseBody
	public ResultData searchFriend(@RequestParam(defaultValue = "") String searchKeywordType,
	        @RequestParam(defaultValue = "") String searchKeyword) {
	    
	    if (Util.empty(searchKeywordType)) {
	        return ResultData.from("F-1", "검색 조건을 설정해주세요");
	    }
	    if (Util.empty(searchKeyword)) {
	        return ResultData.from("F-1", "검색어를 입력해주세요");
	    }
	    
	    List<Friend> friends = null;
	    if ("이름".equals(searchKeywordType)) {
	        friends = friendService.getMemberByName(searchKeyword);

	    } else if ("소속".equals(searchKeywordType)) {
	        friends = friendService.getMemberBySchool(searchKeyword);

	    } else if ("전화번호".equals(searchKeywordType)) {
	        friends = friendService.getMemberByPhone(searchKeyword);

	    } else if ("이메일".equals(searchKeywordType)) {
	        friends = friendService.getMemberByEmail(searchKeyword);

	    }
	    
	    if (friends == null || friends.isEmpty()) {
	        return ResultData.from("F-2", "존재하지 않는 회원입니다");
	    }
	    
	    return ResultData.from("S-1", "", "friends", friends);
	}

	

}

