package com.hyewon.library.repository;

import java.util.Date;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface LoanRepository {
	
	@Insert("""
			INSERT INTO `schedule`
				SET id = #{id},
				    event_member = #{event_member},
				    event_date = #{event_date},
					event_name = #{event_name},
					event_body = #{event_body},
					event_color = #{event_color}
			        
			""")
	public void addSchedule(int id, int event_member, String event_date, String event_name, String event_body, String event_color);
	
	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();


	
}
