package com.hyewon.routine_project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hyewon.routine_project.service.MemberService;
import com.hyewon.routine_project.util.Util;
import com.hyewon.routine_project.vo.Member;
import com.hyewon.routine_project.vo.ResultData;
import com.hyewon.routine_project.vo.Rq;

@Controller
public class UsrMemberController {
	
	MemberService memberService;
	
	Rq rq;
	
	@Autowired
	public UsrMemberController(MemberService memberService, Rq rq) {
		this.memberService = memberService;
		this.rq = rq;
	}
	
	@RequestMapping("/user/member/join")
	public String join() {
		return "user/member/join";
	}
	
	@RequestMapping("/user/member/doJoin")
	@ResponseBody
	public String doJoin(String loginId, String loginPw, String name, String nickname, String email, String cellphoneNum) {

		if (Util.empty(loginId)) {
			return Util.jsHistoryBack("아이디를 입력해주세요");
		}
		if (Util.empty(loginPw)) {
			return Util.jsHistoryBack("비밀번호를 입력해주세요");
		}
		if (Util.empty(name)) {
			return Util.jsHistoryBack("이름을 입력해주세요");
		}
		if (Util.empty(nickname)) {
			return Util.jsHistoryBack("닉네임을 입력해주세요");
		}
		
		if (Util.empty(email)) {
			return Util.jsHistoryBack("이메일을 입력해주세요");
		}
		
		if (Util.empty(cellphoneNum)) {
			return Util.jsHistoryBack("전화번호를 입력해주세요");
		}
		
		ResultData<Integer> doJoinRd = memberService.doJoin(loginId, Util.sha256(loginPw), name, nickname, email, cellphoneNum);
		
		if (doJoinRd.isFail()) {
			return Util.jsHistoryBack(doJoinRd.getMsg());
		}
		
		return Util.jsReplace(doJoinRd.getMsg(), "/");
	}
	
	@RequestMapping("/user/member/loginIdDupCheck")
	@ResponseBody
	public ResultData loginIdDupCheck(String loginId) {
		
		if (Util.empty(loginId)) {
			return ResultData.from("F-1", "아이디를 입력해주세요");
		}
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member != null) {
			return ResultData.from("F-2", "이미 사용중인 아이디입니다", "loginId", loginId);
		}
		
		return ResultData.from("S-1", "사용 가능한 아이디입니다", "loginId", loginId);
	}
	

	@RequestMapping("/user/member/login")
	public String login() {
		return "user/member/login";
	}
	

	@RequestMapping("/user/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw) {
		
		if (rq.getLoginedMemberId() != 0) {
			return Util.jsHistoryBack("로그아웃 후 이용해주세요");
		}
		
		if (Util.empty(loginId)) {
			return Util.jsHistoryBack("아이디를 입력해주세요");
		}
		if (Util.empty(loginPw)) {
			return Util.jsHistoryBack("비밀번호를 입력해주세요");
		}
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member == null) {
			return Util.jsHistoryBack(Util.f("%s은(는) 존재하지 않는 아이디입니다", loginId));
		}
		
		if (member.getLoginPw().equals(Util.sha256(loginPw)) == false) {
			return Util.jsHistoryBack("비밀번호가 일치하지 않습니다");
		}

		rq.login(member);
		
		return Util.jsReplace(Util.f("%s 회원님 환영합니다~!", member.getNickname()), "main_head");
	}
	
	@RequestMapping("user/member/main_head")
	public String main() {
		return "user/member/main_head";
	}
	
	@RequestMapping("/user/member/doLogout")
	@ResponseBody
	public String doLogout() {
		
		rq.logout();
		
		return Util.jsReplace("정상적으로 로그아웃 되었습니다", "/");
	}
	
	@RequestMapping("/user/member/mypage")
	public String showmypage() {
		return "user/member/mypage";
	}
	
	@RequestMapping("/user/member/checkpassword")
	public String checkpassword() {
		return "user/member/checkpassword";
	}
	
	@RequestMapping("/user/member/doCheckPassword")
	public String doCheckPassword(String loginPw) {
		
		if (Util.empty(loginPw)) {
			return rq.jsReturnOnView("비밀번호를 입력해주세요", true);
		}
		
		if (rq.getLoginedMember().getLoginPw().equals(Util.sha256(loginPw)) == false) {
			return rq.jsReturnOnView("비밀번호가 일치하지 않습니다", true);
		}
		
		return "user/member/modify";
	}
	
	@RequestMapping("/user/member/doModify")
	@ResponseBody
	public String doModify(String name, String nickname, String cellphoneNum, String email_name, String email_domain) {
		
		if (Util.empty(name)) {
			return Util.jsHistoryBack("이름을 입력해주세요");
		}
		
		if (Util.empty(nickname)) {
			return Util.jsHistoryBack("닉네임을 입력해주세요");
		}
		
		if (Util.empty(cellphoneNum)) {
			return Util.jsHistoryBack("전화번호를 입력해주세요");
		}
		
		String email = email_name + "@" + email_domain;
		
		memberService.doModify(rq.getLoginedMemberId(), name, nickname, cellphoneNum, email);
		
		return Util.jsReplace("회원정보가 수정되었습니다", "mypage");
	}
	@RequestMapping("/user/member/passwordModify")
	public String passwordModify() {
		return "user/member/passwordModify";
	}
	
	@RequestMapping("/user/member/doPasswordModify")
	@ResponseBody
	public String doPasswordModify(String loginPw, String loginPwChk) {
		
		if (Util.empty(loginPw)) {
			return Util.jsHistoryBack("새 비밀번호를 입력해주세요");
		}
		
		if (Util.empty(loginPwChk)) {
			return Util.jsHistoryBack("새 비밀번호 확인을 입력해주세요");
		}
		
		if (loginPw.equals(loginPwChk) == false) {
			return Util.jsHistoryBack("비밀번호가 일치하지 않습니다");
		}
		
		memberService.doPasswordModify(rq.getLoginedMemberId(), Util.sha256(loginPw));
		
		return Util.jsReplace("비밀번호가 수정되었습니다", "mypage");
	}
	
	@RequestMapping("/user/member/findLoginId")
	public String findLoginId() {
		return "user/member/findLoginId";
	}
	
	@RequestMapping("/user/member/findLoginPw")
	public String findLoginPw() {
		return "user/member/findLoginPw";
	}
	
	@RequestMapping("/user/member/doFindLoginId")
	@ResponseBody
	public String doFindLoginId(String name, String email) {
		
		if (Util.empty(name)) {
			return Util.jsHistoryBack("닉네임을 입력해주세요");
		}
		
		if (Util.empty(email)) {
			return Util.jsHistoryBack("이메일을 입력해주세요");
		}
		
		Member member = memberService.getMemberByNameAndEmail(name, email);
		
		if (member == null) {
			return Util.jsHistoryBack("입력하신 정보와 일치하는 회원이 없습니다");
		}
		
		return Util.jsReplace(Util.f("회원님의 아이디는 [ %s ] 입니다", member.getLoginId()), "login");
	}
	
	@RequestMapping("/user/member/doFindLoginPw")
	@ResponseBody
	public String doFindLoginPw(String loginId, String name, String email) {
		
		if (Util.empty(loginId)) {
			return Util.jsHistoryBack("아이디를 입력해주세요");
		}
		
		if (Util.empty(name)) {
			return Util.jsHistoryBack("이름을 입력해주세요");
		}
		
		if (Util.empty(email)) {
			return Util.jsHistoryBack("이메일을 입력해주세요");
		}
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member == null) {
			return Util.jsHistoryBack("입력하신 정보와 일치하는 회원이 없습니다");
		}
		
		if (member.getName().equals(name) == false) {
			return Util.jsHistoryBack("이름이 일치하지 않습니다");
		}
		
		if (member.getEmail().equals(email) == false) {
			return Util.jsHistoryBack("이메일이 일치하지 않습니다");
		}
		
		ResultData notifyTempLoginPwByEmailRd = memberService.notifyTempLoginPwByEmail(member);
		
		return Util.jsReplace(notifyTempLoginPwByEmailRd.getMsg(), "login");
	}
	
	@RequestMapping("/user/member/schedule")
	public String showSchedule() {
		return "user/member/schedule";
	}


}
