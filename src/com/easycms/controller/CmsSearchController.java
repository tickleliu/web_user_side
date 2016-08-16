package com.easycms.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.easycms.common.FreeMarkerUtils;
import com.easycms.common.Pager;
import com.easycms.entity.CmsArticle;
import com.easycms.service.CmsArticleService;

@Controller
public class CmsSearchController {

	@Resource(name = "cmsArticleServiceImpl")
	private CmsArticleService as;

	private Logger logger = Logger.getLogger(this.getClass());
	
	private static final Map<String, String> CATEGORY_MAP = new HashMap<String, String>();
	static {
		CATEGORY_MAP.put("新闻资讯", "news");
		CATEGORY_MAP.put("政策解读", "policy");
		CATEGORY_MAP.put("技术前沿", "tech");
		CATEGORY_MAP.put("试点信息", "pilot");
		CATEGORY_MAP.put("认证信息", "identy");
		CATEGORY_MAP.put("中心简介", "intro");
		CATEGORY_MAP.put("组织架构", "org");
		CATEGORY_MAP.put("联系我们", "contact");
	}	

	
	/**
	 * 搜索结果列表生成
	 * @throws UnsupportedEncodingException 
	 * */
	@RequestMapping(value = "s_result", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String getSearchResult(HttpServletRequest request,
			HttpServletResponse response, Model model) throws UnsupportedEncodingException {

		response.setContentType("text/json;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");

		Map<String, Object> map = new HashMap<String, Object>();		

		int showPages = 0;
		String pageString = request.getParameter("page");
		if (pageString != null) {
			try {
				showPages = Integer.parseInt(pageString) - 1;
			} catch (NumberFormatException e) {
				// TODO: handle exception
				showPages = 0;
			}
		}

		int pageSize = 10;
		String rowsString = request.getParameter("rows");
		if (rowsString != null) {
			try {
				pageSize = Integer.parseInt(rowsString);
			} catch (NumberFormatException e) {
				// TODO: handle exception
				pageSize = 10;
			}
		}
		
		showPages = showPages * pageSize;

		String keyword = new String(request.getParameter("keyw").getBytes("iso8859-1"),"utf-8");
		
		List<String> keywords = new LinkedList<String>();
		if (keyword != null) {
			StringTokenizer stringTokenizer = new StringTokenizer(keyword,
					" ,\t");
			while (stringTokenizer.hasMoreTokens()) {
				String tokenString = stringTokenizer.nextToken();
				if (tokenString.trim().length() > 0) {
					keywords.add(tokenString.trim());
				}
			}
		}
		if (keywords.size() > 0) {
			map.put("keyw", keywords);
		}

		Pager<CmsArticle> pager = as
				.findArticlesByKey(map, showPages, pageSize);

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("total", pager.getTotal());
		List<HashedMap> articles = new ArrayList<HashedMap>();
		JSONArray jsonArray = new JSONArray();
		jsonObject.put("cate", map.get("cate") );
		jsonObject.put("category", map.get("category"));

		for (CmsArticle article : pager.getPageList()) {
			Map<String, Object> jsonMap = new HashMap<String, Object>();
			jsonMap.put("aid", article.getAid());
			jsonMap.put("author", article.getAuthor());		
			jsonMap.put("cate", CATEGORY_MAP.get(article.getCate()));
			String create_time = DateFormatUtils.format(
					article.getCreate_time(), "yyyy-MM-dd");
			jsonMap.put("create_time", create_time);
			// jsonMap.put("update_time", article.getAid());
			jsonMap.put("title", article.getTitle());
			Document document = Jsoup.parse(article.getContent());
			String content = document.text();
			content = content.replace("　", "");
			content = content.replace("	", "");
			content = content.replace("\t", "");
			if (content.length()>=256) {
				content = content.substring(0, 256);
			}			
			jsonMap.put("content", content);
			jsonArray.put(jsonMap);
		}
		
		jsonObject.put("rows", jsonArray);
		return jsonObject.toString();
	}
	
	@RequestMapping(value = "s_show", produces = "text/html;charset=UTF-8")
	public String showSearchResult(HttpServletRequest request,
			HttpServletResponse response, Model model) {

		response.setContentType("text/json;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String keyw = request.getParameter("keyw");
		model.addAttribute("keyw", "中国");

		return "search_result";
	}
}
