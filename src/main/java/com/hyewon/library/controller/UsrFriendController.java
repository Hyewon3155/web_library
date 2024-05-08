package com.hyewon.library.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.exc.InvalidFormatException;
import com.hyewon.library.service.FriendService;
import com.hyewon.library.service.LoanService;
import com.hyewon.library.util.Util;
import com.hyewon.library.vo.Friend;
import com.hyewon.library.vo.ResultData;

@Controller
public class UsrFriendController {
	
	FriendService friendService;
	LoanService loanService;
	
	
	@Autowired
	public UsrFriendController(FriendService friendService, LoanService loanService) {
		this.friendService = friendService;
		this.loanService = loanService;
	}
	
	@RequestMapping("/user/friend/join")
	public String join() {
		return "user/friend/join";
	}
	
	@RequestMapping("/user/friend/doJoin")
	@ResponseBody
	public String doJoin(String name, String school, String depart, String phone1, String phone2, String phone3, String email) {
	    // 이름, 학교, 학과, 전화번호, 이메일이 비어 있는지 확인
	    if (Util.empty(name)) {
	        return Util.jsHistoryBack("이름을 입력해주세요");
	    }
	    if (Util.empty(school)) {
	        return Util.jsHistoryBack("학교를 입력해주세요");
	    }
	    if (Util.empty(depart)) {
	        return Util.jsHistoryBack("학과를 입력해주세요");
	    }
	    if (Util.empty(phone1) || Util.empty(phone2) || Util.empty(phone3)) {
	        return Util.jsHistoryBack("전화번호를 입력해주세요");
	    }
	    if (Util.empty(email)) {
	        return Util.jsHistoryBack("이메일을 입력해주세요");
	    }
	    
	    String cellphoneNum = phone1 + "-" + phone2 + "-" + phone3;
	    // 프로필 사진이 있는지 확인하고 저장
	    

    // 프로필 정보 저장
	    ResultData<Integer> doJoinRd = friendService.doJoin(name, school, depart, cellphoneNum, email);
    	return Util.jsReplace(doJoinRd.getMsg(), "read");
	}
	
	@RequestMapping("/user/friend/read")
	public String read(Model model) {
	    List<Friend> friends = friendService.getFriends();
	    model.addAttribute("friends", friends);
		return "user/friend/read";
	}
	
	@RequestMapping("/user/friend/modify")
	public String showModify(Model model, int id) {
		Friend friend = friendService.getFriendById(id);
		String[] parts = friend.getCellphoneNum().split("-");
	    String phone1 = parts[0];
	    String phone2 = parts[1];
	    String phone3 = parts[2];
		model.addAttribute("friend", friend);
		model.addAttribute("phone1", phone1);
		model.addAttribute("phone2", phone2);
		model.addAttribute("phone3", phone3);

		return "user/friend/modify";
	}
	
	@RequestMapping("/user/friend/doModify")
	@ResponseBody
	public String doModify(int id, String name, String school, String depart, String phone1, String phone2, String phone3, String email) {
	    // 이름, 학교, 학과, 전화번호, 이메일이 비어 있는지 확인
	    if (Util.empty(name)) {
	        return Util.jsHistoryBack("이름을 입력해주세요");
	    }
	    if (Util.empty(school)) {
	        return Util.jsHistoryBack("학교를 입력해주세요");
	    }
	    if (Util.empty(depart)) {
	        return Util.jsHistoryBack("학과를 입력해주세요");
	    }
	    if (Util.empty(phone1) || Util.empty(phone2) || Util.empty(phone3)) {
	        return Util.jsHistoryBack("전화번호를 입력해주세요");
	    }
	    if (Util.empty(email)) {
	        return Util.jsHistoryBack("이메일을 입력해주세요");
	    }
	    
	    String cellphoneNum = phone1 + "-" + phone2 + "-" + phone3;
	    // 프로필 사진이 있는지 확인하고 저장

	   friendService.doModify(id, name, school, depart, cellphoneNum, email);
		
		return Util.jsReplace(Util.f("%s 친구 정보를 수정했습니다", name), Util.f("detail?id=%d", id));

	}
	
	@RequestMapping("/user/friend/detail")
	public String showDetail(Model model, int id) {

        Friend friend = friendService.getFriendById(id);
        
		model.addAttribute("friend", friend);
	
		return "user/friend/detail";
	}
	
	@RequestMapping("/user/friend/delete")
	@ResponseBody
	public ResultData doDelete(@RequestParam int id) {
        loanService.deleteByFriendId(id);
        friendService.deleteById(id);
	    return ResultData.from("S-1", "삭제되었습니다.");
	}
	
	@RequestMapping("/user/friend/searchFriend")
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
	
	 @RequestMapping(value = "/user/friend/uploadExcel")
	 @ResponseBody
	   public String parseAndInsertExcel(@RequestParam("excelFile") MultipartFile excelFile) throws IOException, InvalidFormatException {
		        try (InputStream inputStream = excelFile.getInputStream()) {
					XSSFWorkbook workbook = new XSSFWorkbook(excelFile.getInputStream());
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
		                String name = row.getCell(1).getStringCellValue();
		                String inputString = row.getCell(2).getStringCellValue();

		             // "대학교" 이전까지의 문자열을 학교 이름으로 저장
		             String school = inputString.substring(0, inputString.indexOf("대학교")).trim();

		             // "학과" 이전까지의 문자열을 학과 이름으로 저장
		             String depart = inputString.substring(inputString.indexOf("대학교") + 3, inputString.indexOf("과")).trim();

		                String cellphoneNum = row.getCell(3).getStringCellValue();
		                String email = row.getCell(4).getStringCellValue();

		                // BookService를 사용하여 데이터베이스에 책을 삽입
		                friendService.doJoin(name, school, depart, cellphoneNum, email);
		            }

		            workbook.close();
		        }
				return Util.jsReplace(Util.f("친구 목록이 업데이트 되었습니다."), Util.f("read"));

		    }


	@RequestMapping("/user/friend/login")
	public String login() {
		return "user/friend/login";
	}
	
	
	
	
	@RequestMapping("/user/friend/checkpassword")
	public String checkpassword() {
		return "user/friend/checkpassword";
	}


	@RequestMapping("/user/friend/passwordModify")
	public String passwordModify() {
		return "user/friend/passwordModify";
	}
	
	@RequestMapping("/user/friend/codeEditor")
	public String showCodeEditor() {
		return "user/friend/codeEditor";
	}

	
	
}



