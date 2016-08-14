package com.easycms.controller;

import java.io.IOException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/l/")
public class CmsLoginController {

	@RequestMapping(value = "login")
	public String toLoginPage(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		return "login/login";
	}

	@RequestMapping(value = "register")
	public String toRegisterPage(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		return "login/register";
	}

	@RequestMapping(value = "register/detail")
	public String toUsesrBasicInfoPage(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();
		if (session != null) {
			Object uid = session.getAttribute("uid");
			if (uid != null) {
				return "login/user_basicinfo";
			}
		}
		return "login/register";

	}

	@RequestMapping(value = "dologin")
	@ResponseBody
	public String login(HttpServletRequest request,
			HttpServletResponse response, Model model) throws IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		JSONObject jsonObject = new JSONObject();
		if (username != null && password != null) {
			if (username.equals(password)) {
				Cookie cookie = new Cookie("login", "success");
				cookie.setMaxAge(24 * 60 * 60);
				cookie.setPath("/");
				response.addCookie(cookie);
				jsonObject.put("result", "success");
				return jsonObject.toString();
			}
		}
		jsonObject.put("result", "fail");
		return jsonObject.toString();
	}

	@RequestMapping(value = "status")
	@ResponseBody
	public String getUserLoginStatus(HttpServletRequest request,
			HttpServletResponse response) {
		Cookie[] cookies = request.getCookies();
		JSONObject jsonObject = new JSONObject();

		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("login")) {
				if (cookie.getValue().equals("success")) {
					jsonObject.append("uid", 1);
					jsonObject.append("username", "zhouw");
					jsonObject.append("status", "login");
					return jsonObject.toString();
				}
			}
		}
		jsonObject.append("status", "unlogin");
		return jsonObject.toString();
	}

}
