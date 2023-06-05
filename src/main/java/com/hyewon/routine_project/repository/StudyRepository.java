package com.hyewon.routine_project.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface StudyRepository {
	
	@Insert("""
			INSERT INTO study
				SET regDate = NOW(),
					updateDate = NOW(),
					`host` = #{host},
					`status` = #{status},
					`name` = #{name},
			        `body` = #{body},
			        headCount = #{headCount},
			        file_savedPath = #{file_savedPath}
			        
			""")
	public void createGroup(String host, int headCount, int status, String name, String body, String file_savedPath);
	
	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();


	
}
