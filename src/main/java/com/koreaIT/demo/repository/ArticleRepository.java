package com.koreaIT.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.koreaIT.demo.vo.Article;

@Mapper

// DB와 연동하여 실제 기능을 수행하는 Repository
// -->  ex) DB를 통해 특정 게시물 삭제
// 구현부를 갖을 필요가 없어서 인터페이스로 바뀜
//다중 상속 가능
//-> 인터페이스는 껍데기만 존재하여 클래스 상속 시 발생했던 모호함 X --> 다중 상속 가능

//추상 메서드와 상수만 사용 가능
//-> 인터페이스에는 구현 소스를 생성 X --> 상수와 추상 메서드만 가질 수 O

//생성자 사용 불가
//-> 인터페이스 객체가 아니므로 생성자를 사용할 수 X

//메서드 오버라이딩 필수
//-> 자식클래스는 부모 인터페이스의 추상 메서드를 모두 오버라이딩
public interface ArticleRepository {
	
	public Article writeArticle(String title, String body);

	public Article getArticleById(int id);
	
	public List<Article> getArticles();

	public void modifyArticle(int id, String title, String body);

	public void deleteArticle(int id);

	public int getLastInsertId();
	
}