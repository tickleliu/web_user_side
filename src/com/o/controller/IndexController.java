package com.o.controller;

import org.apache.log4j.Logger;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {

	Logger logger = Logger.getLogger(IndexController.class);
	
	@RequestMapping(value={"/", "index"})
	@CachePut(value="user", key="getIndexPage")
	@Cacheable(value = "user", key="getIndexPage")
	String getIndexPage() {
		logger.debug("index page request");
		return "index";
	}
}
