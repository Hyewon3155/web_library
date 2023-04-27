package com.koreaIT.demo.vo;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreaIT.demo.util.Util;

import lombok.Getter;

public class Rq {
	
	@Getter
	private int loginedMemberId;
	private HttpServletRequest req;
	private HttpServletResponse resp;
	private HttpSession httpSession;

	public Rq(HttpServletRequest req, HttpServletResponse resp) {
		
		this.req = req;
		this.resp = resp;
		this.httpSession = req.getSession();
		
		int loginedMemberId = 0;

		if (httpSession.getAttribute("loginedMemberId") != null) {
			loginedMemberId = (int) httpSession.getAttribute("loginedMemberId");
		}
		// 세션에 있는 loginedMemberId가 널이 아닌 경우 --> 로그인을 한 상태인 경우
		// 세션으로부터 loginedMemberId를 가져와서 loginedMemberId 변수에 넣어줌
		// 세션에서는 Object이기 때문에 형변환은 필수 
		
		this.loginedMemberId = loginedMemberId;
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
		// 멤버의 아이디를 로그인한 아이디로 지정
	}

	public void logout() {
		httpSession.removeAttribute("loginedMemberId");
		// 세션에 있는 정보를 지움 
	}

	public String jsturnOnView(String msg, boolean isHistoryBack) {
		req.setAttribute("msg", msg);
		req.setAttribute("isHistoryBack", isHistoryBack);
		
		return "usr/common/js";
	}
	
}