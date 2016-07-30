package com.o.dao;

import java.util.List;

import com.o.bean.Article;
import com.mongodb.DBObject;

public interface AbstractArticleRepository {
	
	public void insert(Article article);
	public Article findOne(String id);
//	public List<Article> findAll();
	public List<Article> findAll(int skip, int limit);
	public List<Article> findAll(DBObject object, int skip, int limit);
	public void removeOne(String id);
	public void removeAll();
	public void update(Article article);

}
