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
public class CmsInfoController {

	@Resource(name = "cmsArticleServiceImpl")
	private CmsArticleService as;

	private static final Long CENTERINTRO_ID = 100L;
	private static final Long ORGINTRO_ID = 200L;
	private static final Long CONTACT_ID = 300L;
	private static final String[] CategoryStrings = { "新闻资讯", "政策解读", "技术前沿",
			"试点信息", "认证信息", "中心简介", "组织架构", "联系我们" };
	private static final String[] CategoryStringsE = { "news", "policy", "tech",
			"pilot", "identy", "intro", "org", "contact" };
	private static final Map<String, Integer> CATEGORINDEX_MAP = new HashMap<String, Integer>();
	private static final Map<Integer, String> CATEGORINDEX_MAP_R = new HashMap<Integer, String>();

	private Logger logger = Logger.getLogger(this.getClass());

	static {
		int i = 0;
		CATEGORINDEX_MAP.put("news", i);
		CATEGORINDEX_MAP_R.put(i, "news");
		i++;
		CATEGORINDEX_MAP.put("policy", i);
		CATEGORINDEX_MAP_R.put(i, "policy");
		i++;
		CATEGORINDEX_MAP.put("tech", i);
		CATEGORINDEX_MAP_R.put(i, "tech");
		i++;
		CATEGORINDEX_MAP.put("pilot", i);
		CATEGORINDEX_MAP_R.put(i, "pilot");
		i++;
		CATEGORINDEX_MAP.put("identy", i);
		CATEGORINDEX_MAP_R.put(i, "identy");
		i++;
		CATEGORINDEX_MAP.put("intro", i);
		CATEGORINDEX_MAP_R.put(i, "intro");
		i++;
		CATEGORINDEX_MAP.put("org", i);
		CATEGORINDEX_MAP_R.put(i, "org");
		i++;
		CATEGORINDEX_MAP.put("contact", i);
		CATEGORINDEX_MAP_R.put(i, "contact");
		i++;
	}

	/**
	 * 信息处理页跳转
	 * */
	@RequestMapping(value = "/g/{type}/{aid}")
	public String getInfoPage(@PathVariable String type,
			@PathVariable String aid, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		model.addAttribute("type", type);
		model.addAttribute("aid", aid);
		model.addAttribute("banner_image", type);
		return "get_news";
	}

	/**
	 * 信息获取
	 */
	@RequestMapping(value = "/i/{type}/{aid}", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String getInfo(@PathVariable String type, @PathVariable String aid,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {

		JSONObject resultObject = new JSONObject();
		CmsArticle article = null;// 当前基本情况的信息，如果已经有了，那么使用它初始化文本编辑器

		if (!CATEGORINDEX_MAP.keySet().contains(type)) {
			resultObject.put("result", "error");
			return resultObject.toString();
		}

		Long aidL = null;
		try {
			aidL = Long.parseLong(aid);
		} catch (NumberFormatException e) {
			// TODO: handle exception
			resultObject.put("result", "error");
			return resultObject.toString();
		}

		article = as.findArticleById(aidL);
		if (article == null) {
			resultObject.put("result", "error");
			return resultObject.toString();
		}

		resultObject.put("result", "success");
		resultObject.put("aid", article.getAid());
		resultObject.put("title", article.getTitle());
		resultObject.put("content", article.getContent());
		resultObject.put("author", article.getAuthor());

		resultObject
				.put("create_time", DateFormatUtils.format(
						article.getCreate_time(), "yyyy年MM月dd日"));
		resultObject.put("category", article.getCate());
		resultObject.put("cate", type);

		return resultObject.toString();
	}

	@RequestMapping(value = "/info/list/{type}")
	public String showInfo(@PathVariable String type, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		model.addAttribute("categories", CategoryStrings);
		Integer cateIndex = CATEGORINDEX_MAP.get(type);
		model.addAttribute("cateIndex", cateIndex + 1);
		model.addAttribute("banner_image", type);
		return "list_article";
	}

	private String reformatDateString(String dateString) {
		if (dateString != null && dateString.split("-").length == 3) {
			String[] dateStrings = dateString.split("-");
			return dateStrings[0] + "-" + dateStrings[1] + "-" + dateStrings[2];
		}
		return null;
	}

	private String removeIllegalChar(String old) {
		// String set = "\"'";
		String newString = "";
		newString = old.replace("'", " ");
		newString = newString.replace("\"", " ");
		return newString;
	}

	/**
	 * 新闻管理列表生成 增加了中文数据处理
	 * */
	@RequestMapping(value = "/info/get", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String getInfo(HttpServletRequest request,
			HttpServletResponse response, Model model) {

		response.setContentType("text/json;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");

		Map<String, Object> map = new HashMap<String, Object>();
		String datefrom = reformatDateString(request.getParameter("datefrom"));
		if (datefrom != null) {
			map.put("datefrom", datefrom);
		}
		String dateto = reformatDateString(request.getParameter("dateto"));
		if (dateto != null) {
			map.put("dateto", dateto);
		}

		String categoryString = request.getParameter("ct");
		int category = 0;
		try {
			category = Integer.parseInt(categoryString);
			if (category > 0 && category <= CategoryStrings.length) {
				map.put("category", CategoryStrings[category - 1]);
				map.put("cate", CategoryStringsE[category - 1]);
			}
		} catch (NumberFormatException e) {
			// TODO: handle exception
		}

		String author = request.getParameter("author");
		if (author != null) {
			map.put("author", author);
		}

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

		String keyword = request.getParameter("keyw");

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
			String create_time = DateFormatUtils.format(
					article.getCreate_time(), "yyyy-MM-dd");
			jsonMap.put("create_time", create_time);
			// jsonMap.put("update_time", article.getAid());
			jsonMap.put("title", article.getTitle());
			jsonArray.put(jsonMap);
		}
		jsonObject.put("rows", jsonArray);
		return jsonObject.toString();
	}

	@RequestMapping(value = "static")
	@ResponseBody
	public String staticText(HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		ServletContext context = request.getServletContext();
		String template = "admin/pages/template";
		FreeMarkerUtils.initConfig(context, template);
		Map<String, String> dataMap = new HashMap<String, String>();
		dataMap.put("content", "this is the content");
		dataMap.put("basePath", "http://localhost:8000/");
		FreeMarkerUtils.processTemplate("center_intro.ftl", dataMap,
				"F://test.html");
		return "success";
	}

}
