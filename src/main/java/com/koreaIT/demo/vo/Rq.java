package com.koreaIT.demo.vo;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import com.koreaIT.demo.util.Util;

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

	public Rq(HttpServletRequest req, HttpServletResponse resp) {
		
		this.req = req;
		this.resp = resp;
		this.httpSession = req.getSession();
		
		int loginedMemberId = 0;
		Member loginedMember = null;
		// 세션으로부터 닉네임을 가져오기 위해 
		// member의 객체를 생성해줌 
		
		if (httpSession.getAttribute("loginedMemberId") != null) {
			loginedMemberId = (int) httpSession.getAttribute("loginedMemberId");
			loginedMember = (Member) httpSession.getAttribute("loginedMember");
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
		httpSession.setAttribute("loginedMember", member);
		// 세션에 있는 멤버를 가져와서 
		// 로그인된 회원의 정보를 가져옴
	}

	public void logout() {
		httpSession.removeAttribute("loginedMemberId");
		httpSession.removeAttribute("loginedMember");
	}

	public String jsReturnOnView(String msg, boolean isHistoryBack) {
		
		req.setAttribute("msg", msg);
		req.setAttribute("isHistoryBack", isHistoryBack);
		
		return "usr/common/js";
	}

	public void initRq() {
		
	}
	
}