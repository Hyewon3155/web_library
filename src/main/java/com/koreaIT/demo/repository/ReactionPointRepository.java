package com.koreaIT.demo.repository;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.koreaIT.demo.vo.ReactionPoint;

@Mapper
public interface ReactionPointRepository {

	@Select("""
			SELECT IFNULL(SUM(`point`), 0) AS sumReactionPoint
				FROM reactionPoint
				WHERE memberId = #{loginedMemberId}
				AND relId = #{relId}
				AND relTypeCode = #{relTypeCode}
			""")
	ReactionPoint getReactionPoint(int loginedMemberId, int relId, String relTypeCode);
	// 로그인한 회원의 해당 글에 대한 리액션 정보를 받아옴
	// 만약 리액션한 적이 없으면 0
	// 리액션한 적이 있으면 1 or -1
	// 받아오는 거니까 reactionPoint로 가져와야 함

	@Insert("""
			INSERT INTO reactionPoint
				SET regDate = NOW(),
					updateDate = NOW(),
					memberId = #{loginedMemberId},
					relTypeCode = #{relTypeCode},
					relId = #{relId},
					`point` = #{point}
			""")
	void doInsertReactionPoint(int loginedMemberId, int relId, String relTypeCode, int point);
	// 로그인한 회원이 새로 리액션한 값을 세팅해줌
	// 실행해주는 쿼리이므로 void가 되어야 한다 

	@Delete("""
			DELETE FROM reactionPoint
				WHERE memberId = #{loginedMemberId}
				AND relTypeCode = #{relTypeCode}
				AND relId = #{relId}
			""")
	void doDeleteReactionPoint(int loginedMemberId, int relId, String relTypeCode);
	
}