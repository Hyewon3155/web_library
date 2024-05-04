package com.hyewon.library.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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
import com.hyewon.library.vo.Loan;
import com.hyewon.library.vo.ResultData;

@Controller
public class UsrLoanController {
	LoanService loanService;
	BookService bookService;
	FriendService friendService;
	
	@Autowired
	public UsrLoanController(LoanService loanService, BookService bookService, FriendService friendService) {
		this.loanService = loanService;
		this.bookService = bookService;
		this.friendService = friendService;
	}
	
	@RequestMapping("/user/book/loanBook")
	@ResponseBody
	public ResultData loanBook(@RequestParam int bookId,
	        @RequestParam int friendId) {
		bookService.doLoan(bookId);
		loanService.doLoan(bookId, friendId);
	    
	    return ResultData.from("S-1", "대출되었습니다.");
	}
	
	@RequestMapping("/user/loan/read")
	public String showRead(Model model) {
		List<Loan> loans = loanService.getLoans();
		model.addAttribute("loans", loans);
		return "user/loan/read";
	}
	
	@RequestMapping("/user/loan/doReturn")
	@ResponseBody
	public ResultData doReturn(@RequestParam int loanId) {
		loanService.doReturn(loanId);
		loanService.changeStatus(loanId);
	    return ResultData.from("S-1", "반납되었습니다.");
	}
	
	@RequestMapping("/user/loan/searchLoan")
	@ResponseBody
	public ResultData searchLoan(@RequestParam(defaultValue = "") String searchKeywordType,
	        @RequestParam(defaultValue = "") String searchKeyword) {
	    
	    if (Util.empty(searchKeywordType)) {
	        return ResultData.from("F-1", "검색 조건을 설정해주세요");
	    }
	    if (Util.empty(searchKeyword)) {
	        return ResultData.from("F-1", "검색어를 입력해주세요");
	    }
	    
	    List<Loan> loans = null;
	    if ("도서명".equals(searchKeywordType)) {
	        loans = loanService.getLoanByTitle(searchKeyword);

	    } else if ("대출자".equals(searchKeywordType)) {
	        loans = loanService.getLoanByFriendName(searchKeyword);

	    } else if ("대출일자".equals(searchKeywordType)) {
	        loans = loanService.getLoanByLoanDate(searchKeyword);

	    } else if ("반납일자".equals(searchKeywordType)) {
	        loans = loanService.getLoanByReturnDate(searchKeyword);

	    } else if ("반납예정일".equals(searchKeywordType)) {
	        loans = loanService.getLoanByReturnDueDate(searchKeyword);

	    }
	    
	    if (loans == null || loans.isEmpty()) {
	        return ResultData.from("F-2", "해당 대출 이력이 없습니다");
	    }
	    
	    return ResultData.from("S-1", "", "loans", loans);
	}

	@RequestMapping("/user/loan/delete")
	@ResponseBody
	public String delete(int id) {
        loanService.deleteByLoanId(id);
         return Util.jsReplace("삭제되었습니다", "read");

	}
	
	@RequestMapping("/user/loan/manage")
	public String showManage() {
		return "user/loan/manage";
	}
	
	@RequestMapping("/user/loan/modify")
	public String showModify(Model model, int id) {
	    Loan loan = loanService.getLoanById(id);
	    List<Book> books = bookService.getBooks();
	    List<Friend> friends = friendService.getFriends();
	    
	    model.addAttribute("loan", loan);
	    model.addAttribute("books", books);
	    model.addAttribute("friends", friends);
 		return "user/loan/modify";
	}
	
	@RequestMapping("/user/loan/doModify")
	@ResponseBody
	public String doModify(int id, int book_id, int friend_id, String loanDate, @RequestParam(required = false) String returnDate, String returnDueDate) {
	    // 이름, 학교, 학과, 전화번호, 이메일이 비어 있는지 확인
	    if (Util.empty(loanDate)) {
	        return Util.jsHistoryBack("대출일자를 선택해주세요");
	    }
	    if (Util.empty(returnDueDate)) {
	        return Util.jsHistoryBack("반납 예정일을 선택해주세요");
	    }
	    
	    
	    loanService.doModify(id, book_id, friend_id, loanDate, returnDate, returnDueDate);
	    return Util.jsReplace(Util.f("대출 이력 정보가 수정되었습니다"), Util.f("read"));
	}


	@RequestMapping("/user/loan/searchBook")
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
	
	@RequestMapping("/user/loan/searchFriend")
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
	@RequestMapping("/user/loan/schedule-modify")
	public String modifySchedule() {
		return "user/loan/schedule-add";
	}
	
	@RequestMapping("/user/loan/schedule-delete")
	public String deleteSchedule() {
		return "user/loan/schedule-delete";
	}

}
