package com.o.dao;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.bson.types.ObjectId;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.document.mongodb.MongoTemplate;
import org.springframework.stereotype.Component;

import com.o.bean.Article;
import com.o.dao.AbstractArticleRepository;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;


@Component("articleRepository")
public class ArticleRepository implements AbstractArticleRepository {
	
	@Resource
	private MongoTemplate mongoTemplate;

	private String articleCollectionName = "tcoll";

	public String getArticleCollectionName() {
		return articleCollectionName;
	}

	public void setArticleCollectionName(String articleCollectionName) {
		this.articleCollectionName = articleCollectionName;
	}

	public MongoTemplate getMongoTemplate() {
		return mongoTemplate;
	}

	public void setMongoTemplate(MongoTemplate mongoTemplate) {
		this.mongoTemplate = mongoTemplate;
	}

	@Override
	public void insert(Article article) {
		// TODO Auto-generated method stub
		DBObject object = toDBObject(article);
		getMongoTemplate().getCollection(articleCollectionName).insert(object);
	}

	private Article fromJson(DBObject json) {
		Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation()
				.create();
		Article article = gson.fromJson(json.toString(), Article.class);
		article.setId((ObjectId) json.get("_id"));
		return article;
	}

	@Override
	public Article findOne(String id) {
		// TODO Auto-generated method stub
		DBObject queryObject = new BasicDBObject();
		queryObject.put("_id", new ObjectId(id));
		DBObject resultObject = getMongoTemplate().getCollection(
				this.articleCollectionName).findOne(queryObject);
		if (resultObject == null) {
			return null;
		}
		return fromJson(resultObject);
	}

	// @Override
	// public List<Article> findAll() {
	// // TODO Auto-generated method stub
	//
	// return getMongoTemplate().find(new Query(), Article.class);
	// }

	@Override
	public void removeOne(String id) {
		// TODO Auto-generated method stub
		DBObject object = new BasicDBObject("_id", new ObjectId(id));
		getMongoTemplate().getCollection("tcoll").remove(object);
	}

	@Override
	public void removeAll() {
		// TODO Auto-generated method stub
		throw new UnsupportedOperationException(
				"can not remove all article, be careful!");
	}

	private DBObject toDBObject(Article article) {
		DBObject dbObject = new BasicDBObject();
		Field[] fields = article.getClass().getDeclaredFields();
		for (Field field : fields) {
			String fieldName = field.getName();
			if (fieldName.equals("_id")) {
				continue;
			}
			if (fieldName.startsWith("_")) {
				fieldName = fieldName.substring(1);
			}
			String methodName = "get" + fieldName.substring(0, 1).toUpperCase()
					+ fieldName.substring(1);
			try {

				Method method = Article.class.getMethod(methodName);
				Object object = method.invoke(article);
				dbObject.put(fieldName, object);

			} catch (SecurityException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (NoSuchMethodException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			;
			// dbObject.put(field.getName(),

		}
		// dbObject.put(, article)

		return dbObject;
	}

	@Override
	public void update(Article article) {
		// TODO Auto-generated method stub
		DBObject query = new BasicDBObject("_id", article.getId());
		DBObject update = toDBObject(article);
		getMongoTemplate().getCollection(articleCollectionName).update(query,
				update);
	}

	@Override
	public List<Article> findAll(int skip, int limit) {
		// TODO Auto-generated method stub
		DBCursor resultCursor = getMongoTemplate()
				.getCollection(this.articleCollectionName).find()
				.sort(new BasicDBObject("create_time", 1)).skip(skip)
				.limit(limit);
		List<Article> resultList = new LinkedList<Article>();
		while (resultCursor.hasNext()) {
			Article article = fromJson(resultCursor.next());
			resultList.add(article);
		}
		return resultList;
	}

	@Override
	public List<Article> findAll(DBObject object, int skip, int limit) {
		// TODO Auto-generated method stub
		DBCursor resultCursor = getMongoTemplate()
				.getCollection(this.articleCollectionName).find(object)
				.sort(new BasicDBObject("create_time", 1)).skip(skip)
				.limit(limit);

		List<Article> resultList = new LinkedList<Article>();
		while (resultCursor.hasNext()) {
			Article article = fromJson(resultCursor.next());
			resultList.add(article);
		}
		return resultList;
	}

}
