package com.hyewon.library.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface BookRepository {
	
	@Insert("""
			INSERT INTO study
				SET regDate = NOW(),
					updateDate = NOW(),
					`host` = #{host},
					`status` = #{status},
					`name` = #{name},
			        `body` = #{body},
			        headCount = #{headCount},
			        pw = #{pw}
			        
			""")
	public void createGroup(String host, int headCount, int status, String name, String body, String pw);
	
	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();


	
}
