package com.hyewon.library.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Friend {
	private int id;
	private String name;
	private String school;
	private String depart;
	private String cellphoneNum;
	private String email;
}