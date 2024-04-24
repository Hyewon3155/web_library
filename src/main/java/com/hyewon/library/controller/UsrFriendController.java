package com.hyewon.library.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hyewon.library.service.FriendService;
import com.hyewon.library.util.Util;
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
	
	@RequestMapping("/user/friend/read")
	public String read() {
		return "user/friend/read";
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



