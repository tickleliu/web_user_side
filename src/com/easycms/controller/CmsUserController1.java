package com.easycms.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.easycms.common.CaptchaUtil;

@Controller
@RequestMapping("/u")
public class CmsUserController1 {
	private static final Logger logger = Logger.getLogger(CmsUserController1.class);
	
	@RequestMapping("/check")
	@ResponseBody
	public String isUserNameExists(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(true);
		session.setAttribute("uid", "password");
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result", "success");
		return jsonObject.toString();
	}

	@RequestMapping("/key")
	@ResponseBody
	public void getKeyImage(HttpServletRequest request, HttpServletResponse response) {
		try {
			HttpSession session = request.getSession(true);
			String keyCodeString = CaptchaUtil.outputCaptcha(request, response);
			System.out.println(keyCodeString);
			session.setAttribute("key_code", keyCodeString);
		} catch (ServletException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
