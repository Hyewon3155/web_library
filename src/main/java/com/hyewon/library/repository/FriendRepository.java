package com.hyewon.library.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;


@Mapper
public interface FriendRepository {
	
	@Insert("""
			INSERT INTO `member`
				SET regDate = NOW(),
					updateDate = NOW(),
					loginId = #{loginId},
					loginPw = #{loginPw},
					`name` = #{name},
					nickname = #{nickname},
					email = #{email},
					cellphoneNum = #{cellphoneNum}
			""")
	public void doJoin(String loginId, String loginPw, String name, String nickname, String email, String cellphoneNum);
	
	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();

	@Update("""
			UPDATE `member`
				SET updateDate = NOW(),
					name = #{name},
					nickname = #{nickname},
					cellphoneNum = #{cellphoneNum},
					email = #{email}
				WHERE id = #{loginedMemberId}
			""")
	public void doModify(int loginedMemberId, String name, String nickname, String cellphoneNum, String email);
	
	@Update("""
			UPDATE `member`
			   SET  updateDate = NOW(),
			        loginPw = #{loginPw}
			   WHERE id = #{loginedMemberId}
			""")
	public void doPasswordModify(int loginedMemberId, String loginPw);

	
}
