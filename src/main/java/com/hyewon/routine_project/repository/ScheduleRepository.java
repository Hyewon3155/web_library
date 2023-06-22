package com.hyewon.routine_project.repository;

import java.util.Date;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ScheduleRepository {
	
	@Insert("""
			INSERT INTO `schedule`
				SET id = #{id},
				    event_member = #{event_member},
				    event_date = #{event_date},
					event_name = #{event_name},
					event_body = #{evnet_body},
					event_color = #{event_color}
			        
			""")
	public void addSchedule(int id, int event_member, Date event_date, String event_name, String event_body, String event_color);
	
	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();


	
}
