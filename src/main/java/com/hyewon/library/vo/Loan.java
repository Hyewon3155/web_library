package com.hyewon.library.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Loan {
	private int id;
	private String loandDate;
	private String returnDate;
	private String returnDueDate;
	private int friend_id;
	private int book_id;
}