package com.easycms.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping(value="register/")
public class CmsRegisterController {
	
	@RequestMapping(value ="t")
	@ResponseBody
	public String isUserNameExists(HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result", "unused");
	return jsonObject.toString();
	}
	
	@RequestMapping(value="r")
	public String registerUser(HttpServletRequest request, HttpServletResponse response) {
	return "login/loginResult";	
	}

}
