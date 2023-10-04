package com.hyewon.routine_project.vo;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import com.hyewon.routine_project.service.MemberService;
import com.hyewon.routine_project.util.Util;

import lombok.Getter;

@Component
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class Rq {
	
	@Getter
	private int loginedMemberId;
	@Getter
	private Member loginedMember;
	private HttpServletRequest req;
	private HttpServletResponse resp;
	private HttpSession httpSession;

	public Rq(HttpServletRequest req, HttpServletResponse resp, MemberService memberService) {
		
		this.req = req;
		this.resp = resp;
		this.httpSession = req.getSession();
		
		int loginedMemberId = 0;
		Member loginedMember = null;
		
		if (httpSession.getAttribute("loginedMemberId") != null) {
			loginedMemberId = (int) httpSession.getAttribute("loginedMemberId");
			// 그냥 httpSession.getAttribute("loginedMember") 이렇게 넣으면
			// 원래의 로그인했을 당시의 정보만을 담고 있어
			// 회원이 정보를 수정해도 바로 수정되지 않고,
			// 다시 로그인을 해야지만 수정이 된다
			// memberService로부터 가져오면, 매번 Id를 통해 가져오기 때문에
			// 수정한 로그인 정보가 바로 적용된다 
		    loginedMember = memberService.getMemberById(loginedMemberId);
		}
		
		this.loginedMemberId = loginedMemberId;
		this.loginedMember = loginedMember;
		
		this.req.setAttribute("rq", this);
	}

	public void jsPrintHistoryBack(String msg) {
		resp.setContentType("text/html; charset=UTF-8;");
		
		print(Util.jsHistoryBack(msg));
	}

	private void print(String str) {
		try {
			resp.getWriter().append(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	

	public void login(Member member) {
		httpSession.setAttribute("loginedMemberId", member.getId());
	}

	public void logout() {
		httpSession.removeAttribute("loginedMemberId");
	}

	public String jsReturnOnView(String msg, boolean isHistoryBack) {
		
		req.setAttribute("msg", msg);
		req.setAttribute("isHistoryBack", isHistoryBack);
		
		return "user/common/js";
	}

	public void initRq() {
		
	}
	
}