package com.koreaIT.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreaIT.demo.service.ReactionPointService;
import com.koreaIT.demo.util.Util;
import com.koreaIT.demo.vo.ReactionPoint;
import com.koreaIT.demo.vo.ResultData;
import com.koreaIT.demo.vo.Rq;

@Controller
public class UsrReactionPointController {

	private ReactionPointService reactionPointService;
	private Rq rq;

	@Autowired
	public UsrReactionPointController(ReactionPointService reactionPointService, Rq rq) {
		this.reactionPointService = reactionPointService;
		this.rq = rq;
	}
	
	@RequestMapping("/usr/reactionPoint/getReactionPoint")
	@ResponseBody
	public ResultData<ReactionPoint> getReactionPoint(int relId, String relTypeCode) {
		
		ReactionPoint reactionPoint = reactionPointService.getReactionPoint(rq.getLoginedMemberId(), relId, relTypeCode);
		// reactionPointService로 로그인한 회원의 정보와 게시글의 번호, 게시글의 종류를 넘겨줌
		// 그래서 로그인한 회원이 해당 게시글에 좋아요 or 싫어요를 하였다면 해당 객체를 받아옴
		return ResultData.from("S-1", "리액션 정보 조회 성공", "reactionPoint", reactionPoint);
		// 객체를 받아오면 로그인한 회원의 아이디, 좋아요한 시간, 좋아요인지 싫어요인지 나옴
	}
	
	@RequestMapping("/usr/reactionPoint/doInsertReactionPoint")
	@ResponseBody
	public String doInsertReactionPoint(int relId, String relTypeCode, int point) {
		
		ReactionPoint reactionPoint = reactionPointService.getReactionPoint(rq.getLoginedMemberId(), relId, relTypeCode);
		
		if (reactionPoint.getSumReactionPoint()!= 0) {
			// 만약에 reactionPoint에 있는 sumReactionPoint의 값이 0이 아니라면
			// --> 이 말은 좋아요나 싫어요를 이미 표시한 경우 
			// --> 좋아요를 눌렀으면 반드시 sumReactionPoint = 1
			// --> 싫어요를 눌렀으면 반드시 sumReactionPoint = -1
			// getter(private한 변수를 불러올 때)를 사용할 때는 get+가져오고 싶은 변수명+()
			reactionPointService.doDeleteReactionPoint(rq.getLoginedMemberId(), relId, relTypeCode);
			// 이미 좋아요나 싫어요를 클릭하였으므로, 원래 좋아요나 싫어요를 지워줌 
		}
		
		reactionPointService.doInsertReactionPoint(rq.getLoginedMemberId(), relId, relTypeCode, point);
		// 좋아요나 싫어요를 클릭한 경우를 체크했으므로, 새로 표시한 좋아요나 싫어요를 넣어줌
		
		if (point == 1) {
			return Util.jsReplace(Util.f("%d번 글에 좋아요", relId), Util.f("../article/detail?id=%d", relId));
		 // point == 1 --> 좋아요를 한 경우, 어떤 글에 좋아요를 했는지 알려주고
		 // 해당 글로 다시 돌아옴(HistroyBack은 불가) --> HistoryBack은 바로 전으로 돌아옴(값을 잃어버림)
		 // 그러므로 replace로 돌아와서 해당 값을 저장한 상태에서 다시 보여줌 
		} else {
			return Util.jsReplace(Util.f("%d번 글에 싫어요", relId), Util.f("../article/detail?id=%d", relId));
		// point == -1 --> 싫어요를 한 경우
		}
		
		// 0인 경우를 체크하지 않는 경우
		//  --> 반드시 좋아요나 싫어요를 누른 경우에만 조건문을 탈 수 있으므로
		// 0이 아닌 경우에는 원래의 값을 지우고 새로운 값을 넣어주고,
		// 0인 경우에는 바로 새로운 값을 넣어주므로 0일 수 없다
	}
	
	@RequestMapping("/usr/reactionPoint/doDeleteReactionPoint")
	@ResponseBody
	public String doDeleteReactionPoint(int relId, String relTypeCode, int point) {
		
		reactionPointService.doDeleteReactionPoint(rq.getLoginedMemberId(), relId, relTypeCode);
		
		if (point == 1) {
			return Util.jsReplace(Util.f("%d번 글에 좋아요 취소", relId), Util.f("../article/detail?id=%d", relId));
		} else {
			return Util.jsReplace(Util.f("%d번 글에 싫어요 취소", relId), Util.f("../article/detail?id=%d", relId));
		}
	}
	
}