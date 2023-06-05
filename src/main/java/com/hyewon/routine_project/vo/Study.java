package com.hyewon.routine_project.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Study {
	private int id;
	private String regDate;
	private String updateDate;
	private String name;
	private String body;
	private String host;
	private int status;
	private int headCount;
	private String pw;
	private String file_savedPath;

}