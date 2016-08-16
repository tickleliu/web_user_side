package com.easycms.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.easycms.common.CaptchaUtil;
import com.easycms.entity.user.CmsUserLoginInfo;

@Controller
@RequestMapping("/u")
public class CmsUserController1 {
	private static final Logger logger = Logger
			.getLogger(CmsUserController1.class);

	@RequestMapping("/check")
	@ResponseBody
	public String isUserNameExists(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession(true);
		String username = request.getParameter("username");
		String keyCode = request.getParameter("key");


		session.setAttribute("register_status", "fail");

		JSONObject jsonObject = new JSONObject();
		if (keyCode != null) {
			String keyCodeSession = (String) session.getAttribute("key_code");
			System.out.println("session" + keyCodeSession);
			System.out.println("param" + keyCode);
			if (keyCodeSession != null
					&& keyCodeSession.toLowerCase().equals(
							keyCode.toLowerCase())) {
			} else {
				jsonObject.put("result", "key");
				return jsonObject.toString();
			}
		} else {
			jsonObject.put("result", "key");
			return jsonObject.toString();
		}

		if (username == null || username.equals("zhouw")) {

			jsonObject.put("result", "username");
			return jsonObject.toString();
		}

		jsonObject.put("result", "success");
		session.setAttribute("register_status", "success");
		return jsonObject.toString();
	}

	@RequestMapping("/key")
	@ResponseBody
	public void getKeyImage(HttpServletRequest request,
			HttpServletResponse response) {
		Long id = 0L;
		String idString = request.getParameter("id");
		try {
			id = Long.parseLong(idString);
		} catch (NumberFormatException e) {
			// TODO: handle exception
			id = 0L;
		}
		
		try {
			HttpSession session = request.getSession(true);
			String keyCodeString = CaptchaUtil.outputCaptcha(id, request, response);
			session.setAttribute("key_code", keyCodeString);
			System.out.println("register:" + keyCodeString);
			System.out.println("id:" + id);
		} catch (ServletException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/register")
	@ResponseBody
	public String registerSubmitResult(HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result", "success");
			Cookie cookie = new Cookie("login", "success");
					cookie.setMaxAge(24 * 60 * 60 * 30);
					cookie.setPath("/");
					response.addCookie(cookie);
		return jsonObject.toString();
	}
}
