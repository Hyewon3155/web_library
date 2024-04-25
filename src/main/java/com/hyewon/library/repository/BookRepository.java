package com.hyewon.library.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.hyewon.library.vo.ResultData;

@Mapper
public interface BookRepository {
	@Insert("""
			INSERT INTO books
				SET title = #{title},
					author = #{author},
					publisher = #{publisher},
			        `type` = #{type}
			        
			""")
	public void doJoin(String title, String author, String publisher, String type);
	
	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();

	


	
}
