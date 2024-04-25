package com.hyewon.library.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hyewon.library.service.FriendService;
import com.hyewon.library.util.Util;
import com.hyewon.library.vo.Friend;
import com.hyewon.library.vo.ResultData;

@Controller
public class UsrFriendController {
	
	FriendService friendService;
	
	
	@Autowired
	public UsrFriendController(FriendService friendService) {
		this.friendService = friendService;
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
	public String delete(int id) {

        friendService.deleteById(id);
        	
		return Util.jsReplace("삭제되었습니다", "read");

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



