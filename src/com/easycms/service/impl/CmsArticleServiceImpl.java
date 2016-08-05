package com.easycms.service.impl;

import java.util.List;
import java.util.Map;

import javax.validation.constraints.Size;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import com.easycms.base.AbstractBaseDao;
import com.easycms.common.Pager;
import com.easycms.entity.CmsArticle;
import com.easycms.service.CmsArticleService;

@Service
public class CmsArticleServiceImpl extends AbstractBaseDao<CmsArticle, Long> implements
		CmsArticleService {


	@Override
	public void saveArticle(CmsArticle article) {
		// TODO Auto-generated method stub
		save(article);

	}

	@Override
	public CmsArticle findArticleById(long id) {
		// TODO Auto-generated method stub
		CmsArticle cArticle = findById(id);
		return cArticle;
	}

	@Override
	public void updateArticle(CmsArticle article) {
		// TODO Auto-generated method stub
		update(article);
	}

	@Override
	public Pager<CmsArticle> findArticlesByKey(Map<String, Object> map,
			int showPages, int pageSize) {
		// TODO Auto-generated method stub
		map.put("showPages", showPages);
		map.put("pageSize", pageSize);
		return findByKey(map, ".findByKey");
	}

	@Override
	public void deleteArticleById(long id) {
		// TODO Auto-generated method stub
		delete(id);
	}
}
