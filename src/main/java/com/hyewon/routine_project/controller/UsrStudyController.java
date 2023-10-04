package com.hyewon.routine_project.controller;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hyewon.routine_project.service.StudyService;
import com.hyewon.routine_project.util.Util;
import com.hyewon.routine_project.vo.Rq;

@Controller
public class UsrStudyController {
	private StudyService studyService;
	private Rq rq;
	
	public UsrStudyController(StudyService studyService, Rq rq) {
		this.studyService = studyService;
		this.rq = rq;
	}
	
	@RequestMapping("/user/group/create")
	public String showGroupPage() {
		return "user/group/create";
	}
	
	@RequestMapping("/user/group/doWrite")
	@ResponseBody
	public String doWrite(int headCount, int status, String name, String body, String pw) {
		if (Util.empty(name)) {
			return Util.jsHistoryBack("그룹 이름을 입력해주세요");
		}

		if (Util.empty(body)) {
			return Util.jsHistoryBack("내용을 입력해주세요");
		}
		
	    studyService.createGroup(rq.getLoginedMember().getLoginId(), headCount, status, name, body, Util.sha256(pw));
		
	    int id = studyService.getLastInsertId();

		return Util.jsReplace(Util.f("%d번 그룹이 생성되었습니다", id), "/");
	}

}

