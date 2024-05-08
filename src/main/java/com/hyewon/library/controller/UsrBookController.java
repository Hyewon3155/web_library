package com.hyewon.library.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.exc.InvalidFormatException;
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
	
	 @RequestMapping(value = "/user/book/uploadExcel", method = RequestMethod.POST)
	 @ResponseBody
	    public String uploadExcel(@RequestParam("excelFile") MultipartFile excelFile, RedirectAttributes redirectAttributes) {
	        try {
	            // 엑셀 파일을 읽고 데이터베이스에 삽입
	            parseAndInsertExcel(excelFile);

	            // 업로드 성공 메시지 설정
	            redirectAttributes.addFlashAttribute("successMessage", "Excel 파일 업로드 및 처리가 완료되었습니다.");
	        } catch (IOException e) {
	            e.printStackTrace();
	            // 업로드 또는 파싱 중 오류 발생 시 처리
	            redirectAttributes.addFlashAttribute("errorMessage", "Excel 파일 업로드 또는 처리 중 오류가 발생했습니다.");
	        }
	        return "redirect:/"; // 업로드 후 리다이렉트
	    }

	    // 엑셀 파일을 읽고 데이터베이스에 삽입하는 메서드
	    public void parseAndInsertExcel(MultipartFile excelFile) throws IOException, InvalidFormatException {
	        try (InputStream inputStream = excelFile.getInputStream()) {
	            Workbook workbook = WorkbookFactory.create(inputStream);
	            Sheet sheet = workbook.getSheetAt(0); // 첫 번째 시트를 가져옴

	            // 첫 번째 행은 데이터가 아니므로 건너뜀
	            boolean firstRowSkipped = false;

	            // 각 행을 반복하여 데이터베이스에 삽입
	            for (Row row : sheet) {
	                if (!firstRowSkipped) {
	                    firstRowSkipped = true;
	                    continue; // 첫 번째 행은 건너뜁니다.
	                }

	                // 셀에서 데이터 추출하여 변수에 저장
	                String title = row.getCell(0).getStringCellValue();
	                String author = row.getCell(1).getStringCellValue();
	                String publisher = row.getCell(2).getStringCellValue();
	                String typeString = row.getCell(3).getStringCellValue();
	                String statusString = row.getCell(4).getStringCellValue();

	                // type을 숫자로 변환하여 저장
	                int type;
	                if ("전공".equals(typeString)) {
	                    type = 1;
	                } else {
	                    type = 0;
	                }

	                // status를 숫자로 변환하여 저장
	                int status;
	                if ("대출 가능".equals(statusString)) {
	                    status = 0;
	                } else {
	                    status = 1;
	                }

	                // BookService를 사용하여 데이터베이스에 책을 삽입
	                bookService.doExcelJoin(title, author, publisher, type, status);
	            }

	            workbook.close();
	        }
	    }

	

}

