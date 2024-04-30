package com.hyewon.library.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Loan {
	private int id;
	private String title;
	private String friendName;
	private String loanDate;
	private String returnDate;
	private String returnDueDate;
	private int friend_id;
	private int book_id;
}