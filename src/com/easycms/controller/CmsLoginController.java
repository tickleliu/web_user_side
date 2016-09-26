package com.easycms.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.easycms.common.MD5;
import com.easycms.common.Pager;
import com.easycms.entity.user.CmsUserLoginInfo;
import com.easycms.service.impl.user.CmsUserLoginInfoServiceImpl;
import com.sun.org.apache.bcel.internal.generic.IF_ACMPEQ;

@Controller
@RequestMapping(value = "/l/")
public class CmsLoginController {

	@Resource(name = "cmsUserLoginInfoServiceImpl")
	private CmsUserLoginInfoServiceImpl userLoginInfo;

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

				String cookieString = cookie.getValue();
				JSONObject cookieJsonObject = new JSONObject(cookieString);
				if (cookieJsonObject.has("username")
						&& cookieJsonObject.has("password") &&cookieJsonObject.has("uid")) {
					UsernamePasswordToken token = new UsernamePasswordToken(
							cookieJsonObject.getString("username"),
							cookieJsonObject.getString("password")
									.toCharArray(), false);
					Subject subject = SecurityUtils.getSubject();
					try {
						subject.login(token);
					} catch (AuthenticationException e) {
						// TODO: handle exception
						jsonObject.put("result", "failed");
						return jsonObject.toString();
					}
					jsonObject.put("uid", cookieJsonObject.getString("uid"));
					jsonObject.put("username",
							cookieJsonObject.getString("username"));
					jsonObject.put("status", "login");
					jsonObject.put("result", "success");
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
			password = MD5.MD5Encode(password);
			UsernamePasswordToken token = new UsernamePasswordToken(username,
					password.toCharArray(), false);
			Subject subject = SecurityUtils.getSubject();
			try {
				subject.login(token);
			} catch (AuthenticationException e) {
				// TODO: handle exception
				jsonObject.put("result", "failed");
				return jsonObject.toString();
			}

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("username", username);
			Pager<CmsUserLoginInfo> userPager = userLoginInfo
					.findUserLoginInfoByKey(map, 0, 1);
			CmsUserLoginInfo cmsUserLoginInfo = userPager.getPageList().get(0);
			JSONObject cookieJsonObject = new JSONObject();

			cookieJsonObject.put("username", username);
			cookieJsonObject.put("password", password);
			cookieJsonObject.put("uid", cmsUserLoginInfo.getUid().toString());
			cookieJsonObject
					.put("wechatid", cmsUserLoginInfo.getUwechatid());
			String cookieString = cookieJsonObject.toString();

			String rememberMeString = request.getParameter("rember_me");

			if (rememberMeString != null
					&& (rememberMeString.equals("checked") || rememberMeString
							.equals("on"))) {

				Cookie cookie = new Cookie("login", cookieString);
				cookie.setMaxAge(24 * 60 * 60 * 30);
				cookie.setPath("/");
				response.addCookie(cookie);
			} else {
				Cookie cookie = new Cookie("login", cookieString);
				cookie.setPath("/");
				response.addCookie(cookie);
			}
			jsonObject.put("result", "success");
			return jsonObject.toString();
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

				String cookieString = cookie.getValue();
				JSONObject cookieJsonObject = new JSONObject(cookieString);
				UsernamePasswordToken token = new UsernamePasswordToken(
						cookieJsonObject.getString("username"),
						cookieJsonObject.getString("password").toCharArray(),
						false);
				Subject subject = SecurityUtils.getSubject();
				try {
					subject.login(token);
				} catch (AuthenticationException e) {
					// TODO: handle exception
					jsonObject.put("result", "failed");
					return jsonObject.toString();
				}
				jsonObject.put("uid", jsonObject.getString("uid"));
				jsonObject.put("username", jsonObject.getString("username"));
				jsonObject.put("status", "login");
				return jsonObject.toString();
			}
		}
		jsonObject.append("status", "unlogin");
		return jsonObject.toString();
	}
}
