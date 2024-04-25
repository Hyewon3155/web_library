package com.hyewon.library.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.hyewon.library.vo.Friend;


@Mapper
public interface FriendRepository {
	
	@Insert("""
			INSERT INTO friends
				SET `name` = #{name},
					school = #{school},
					depart = #{depart},
					cellphoneNum = #{cellphoneNum},
					email = #{email}
			""")
	public int doJoin(String name, String school, String depart, String cellphoneNum, String email);
	
	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();
	
	@Select("""
			SELECT * 
			FROM friends;
			""")
	public List<Friend> getFriends();

	@Update("""
			UPDATE `member`
			   SET  updateDate = NOW(),
			        loginPw = #{loginPw}
			   WHERE id = #{loginedMemberId}
			""")
	public void doPasswordModify(int loginedMemberId, String loginPw);

	@Select("""
			SELECT * 
			FROM friends
			WHERE id = #{id}
			""")
	public Friend getFriendById(int id);

	@Update("""
			UPDATE friends
			   SET `name` = #{name},
			   	    school = #{school},
			   	    depart = #{depart},
			   	    cellphoneNum = #{cellphoneNum},
			   	    email = #{email}
			   WHERE id = #{id}
			   	    
			""")
	public void doModify(int id, String name, String school, String depart, String cellphoneNum, String email);

	@Delete("""
			DELETE FROM friends
			WHERE id = #{id}
			""")
	public void deleteById(int id);

	 @Select("""
	            SELECT * FROM friends
	            WHERE `name` LIKE CONCAT('%', #{searchKeyword}, '%')
	            """)
	public List<Friend> getMemberByName(String searchKeyword);

	 @Select("""
	            SELECT * FROM friends
	            WHERE school LIKE CONCAT('%', #{searchKeyword}, '%')
	            OR depart LIKE CONCAT('%', #{searchKeyword}, '%')
	            OR #{searchKeyword} LIKE CONCAT('%', school, '%')
	            OR #{searchKeyword} LIKE CONCAT('%', depart, '%')
	            """)
	public List<Friend> getMemberBySchool(String searchKeyword);

	 @Select("""
	            SELECT * FROM friends
	            WHERE cellphoneNum LIKE CONCAT('%', #{searchKeyword}, '%')
	            """)
	public List<Friend> getMemberByPhone(String searchKeyword);

	 @Select("""
	            SELECT * FROM friends
	            WHERE email LIKE CONCAT('%', #{searchKeyword}, '%')
	            """)
	public List<Friend> getMemberByEmail(String searchKeyword);

	

	
}
