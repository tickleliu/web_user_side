package com.o.test;

import javax.annotation.Resource;

import junit.framework.Assert;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.o.bean.Article;
import com.o.dao.ArticleRepository;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:resource/spring/spring-mongo.xml")
public class MongoTest extends org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests{

	@Resource
	private ArticleRepository articleRepository;

	@Test
	public void getTest() {
		try{
		Article article = articleRepository.findOne("566408d6322ad212c0f7eea2");
		Assert.assertNotNull(article);
		System.out.println(article);
		} catch (Exception e) {
			// TODO: handle exception
//			fail
		}
		
	}

}
