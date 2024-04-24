package com.hyewon.library;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import lombok.Data;

@SpringBootApplication
public class DemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}

}
@Data
//@data 친 다음에 Ctrl+space --> lombock의 Data로 들어가기
// 필요한 것들을 자동 세팅해줌 
class Article {
	int id;
	String title;
}
