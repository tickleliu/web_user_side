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
			HttpSession session = request.getSession(true);
		session.setAttribute("register_status", "fail");
		return "login/register";
	}

	@RequestMapping(value = "register/detail")
	public String toUsesrBasicInfoPage(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		HttpSession session = request.getSession(true);
		String status = (String) session.getAttribute("register_status");
		if (status != null && status.equals("success")) {
			return "login/user_basicinfo";
		}
		return "redirect:http://localhost:8000/o/l/register";

	}
	

	@RequestMapping(value = "cc")
	@ResponseBody
	public String checkCookie(HttpServletRequest request,
			HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject();
		Cookie[] cookies = request.getCookies();
		HttpSession session = request.getSession(true);
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("login")) {
				if (cookie.getValue().equals("success")) {
					jsonObject.put("result", "success");
					jsonObject.put("uid", "123");
					jsonObject.put("username", "zhouw");
					return jsonObject.toString();
				}
			}
		}
		jsonObject.put("result", "fail");
		return jsonObject.toString();
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
				String rememberMeString = request.getParameter("rember_me");
				if (rememberMeString != null
						&& (rememberMeString.equals("checked") || rememberMeString
								.equals("on"))) {
					Cookie cookie = new Cookie("login", "success");
					cookie.setMaxAge(24 * 60 * 60 * 30);
					cookie.setPath("/");
					response.addCookie(cookie);
				} else {
					Cookie cookie = new Cookie("login", "success");
					cookie.setPath("/");
					response.addCookie(cookie);
				}
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
