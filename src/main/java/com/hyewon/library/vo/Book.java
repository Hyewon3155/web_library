package com.hyewon.library.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Book {
	private int id;
	private String title;
	private String author;
	private String publisher;
	private char status;
	private char type;
}