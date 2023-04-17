package com.koreaIT.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.koreaIT.demo.vo.Article;

@Mapper

// DB와 연동하여 실제 기능을 수행하는 Repository
// -->  ex) DB를 통해 특정 게시물 삭제
// 구현부를 갖을 필요가 없어서 인터페이스로 바뀜

public interface ArticleRepository {
	
	public Article writeArticle(String title, String body);

	public Article getArticleById(int id);
	
	public List<Article> getArticles();

	public void modifyArticle(int id, String title, String body);

	public void deleteArticle(int id);
	
}