package com.hyewon.routine_project.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Schedule {
	private int id;
	private int event_member;
	private Date event_date;
	private String event_name;
	private String event_body;
	private String event_color;
}