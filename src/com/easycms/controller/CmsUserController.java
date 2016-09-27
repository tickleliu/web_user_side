package com.easycms.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
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
import com.easycms.common.Pager;
import com.easycms.entity.user.CmsOrgUser;
import com.easycms.entity.user.CmsUserBasicInfo;
import com.easycms.entity.user.CmsUserLoginInfo;
import com.easycms.entity.user.CmsUserRoleInfo;
import com.easycms.service.impl.user.CmsOrgUserServiceImpl;
import com.easycms.service.impl.user.CmsUserBasicInfoServiceImpl;
import com.easycms.service.impl.user.CmsUserLoginInfoServiceImpl;
import com.easycms.service.impl.user.CmsUserRoleServiceImpl;

@Controller
@RequestMapping("/u")
public class CmsUserController {

	private static final Logger logger = Logger
			.getLogger(CmsUserController.class);

	@Resource(name = "cmsUserLoginInfoServiceImpl")
	private CmsUserLoginInfoServiceImpl userLoginInfoService;

	@Resource(name = "cmsUserRoleServiceImpl")
	private CmsUserRoleServiceImpl userRoleService;

	@Resource(name = "cmsUserBasicInfoServiceImpl")
	private CmsUserBasicInfoServiceImpl userBasicInfoService;
	
	@Resource(name = "cmsOrgUserServiceImpl")
	private CmsOrgUserServiceImpl orgUserService;

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

		if (username == null) {

			jsonObject.put("result", "username");
			return jsonObject.toString();
		} else {
			Map<String, Object> map = new HashMap<>();

			map.put("username", username);
			Pager<CmsUserLoginInfo> pager = userLoginInfoService
					.findUserLoginInfoByKey(map, 0, 1);
			if (pager.getPageList() != null && pager.getTotal() > 0) {
				jsonObject.put("result", "username");
				return jsonObject.toString();
			}
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
			String keyCodeString = CaptchaUtil.outputCaptcha(id, request,
					response);
			session.setAttribute("key_code", keyCodeString);
			System.out.println("register:" + keyCodeString);
			System.out.println("id:" + id);
		} catch (ServletException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * realname=fadsf&idcard=230903198704191413&education=fasdf&+major=fasdf&
	 * work=fasdfsda&position=sdfafd&
	 * phone=13269198593&email=liuminglu19870420%40163.
	 * com&usertype=1&sex=man&username=null&password=null
	 * */
	@RequestMapping(value = "/register")
	@ResponseBody
	public String registerSubmitResult(HttpServletRequest request,
			HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject();
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		if (username == null || username.length() < 6  || password == null) {
			jsonObject.put("result", "fail");
			return jsonObject.toString();
		}

		CmsUserLoginInfo cmsUserLoginInfo = new CmsUserLoginInfo();
		cmsUserLoginInfo.setUsername(username);
		cmsUserLoginInfo.setPassword(password);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("username", username);
		Pager<CmsUserLoginInfo> pager = userLoginInfoService
				.findUserLoginInfoByKey(map, 0, 1);
		if (pager != null && pager.getPageList().size() != 0) {
			jsonObject.put("result", "fail");
		} else {
			userLoginInfoService.save(cmsUserLoginInfo);
		}
		

		String usertype = request.getParameter("usertype");
		if (usertype == null) {
			jsonObject.put("result", "fail");
			return jsonObject.toString();
		} else if (usertype.equals("1")) {

			String realname = request.getParameter("realname");
			String idcard = request.getParameter("idcard");
			String education = request.getParameter("education");
			String major = request.getParameter("major");
			String work = request.getParameter("work");
			String position = request.getParameter("position");
			String phone = request.getParameter("phone");
			String email = request.getParameter("email");
			String sex = request.getParameter("sex");

			CmsUserRoleInfo cmsUserRoleInfo = new CmsUserRoleInfo();
			cmsUserRoleInfo.setUid(cmsUserLoginInfo.getUid());
			userRoleService.save(cmsUserRoleInfo);

			CmsUserBasicInfo cmsUserBasicInfo = new CmsUserBasicInfo();
			cmsUserBasicInfo.setUid(cmsUserLoginInfo.getUid());
			cmsUserBasicInfo.setRealname(realname);
			cmsUserBasicInfo.setIdcard_number(idcard);
			cmsUserBasicInfo.setDegree(education);
			cmsUserBasicInfo.setSpecialty(major);
			cmsUserBasicInfo.setWork_unit(work);
			cmsUserBasicInfo.setPosition_level(position);
			cmsUserBasicInfo.setPhone(phone);
			cmsUserBasicInfo.setEmail(email);
			if (sex != null && sex.equals("woman")) {
				cmsUserBasicInfo.setSex(2);
			} else {
				cmsUserBasicInfo.setSex(1);
			}

			userBasicInfoService.save(cmsUserBasicInfo);
			

		} else if (usertype.equals("2")) {

			String orgname = request.getParameter("orgname");
			String president = request.getParameter("president");
			String region = request.getParameter("region");
			String contact_name = request.getParameter("contact_name");
			String contact_position = request.getParameter("contact_position");
			String phone = request.getParameter("phone");
			String email = request.getParameter("email");
			String address = request.getParameter("address");
			String zipcode = request.getParameter("zipcode");
			
			CmsUserRoleInfo cmsUserRoleInfo = new CmsUserRoleInfo();
			cmsUserRoleInfo.setUid(cmsUserLoginInfo.getUid());
			cmsUserRoleInfo.setIsorg(1);
			userRoleService.save(cmsUserRoleInfo);

			CmsOrgUser cmsOrgUser = new CmsOrgUser();
			cmsOrgUser.setUid(cmsUserLoginInfo.getUid());
			cmsOrgUser.setEnterprise_name(orgname);
			cmsOrgUser.setLegal_representative(president);
			cmsOrgUser.setRegion(region);
			cmsOrgUser.setContact_name(contact_name);
			cmsOrgUser.setContact_position(contact_position);
			cmsOrgUser.setPhone(phone);
			cmsOrgUser.setEmail(email);
			cmsOrgUser.setAddress(address);
			cmsOrgUser.setZip_code(zipcode);
			orgUserService.save(cmsOrgUser);
			
		}

		jsonObject.put("result", "success");
		JSONObject cookieJsonObject = new JSONObject();

		cookieJsonObject.put("username", username);
		cookieJsonObject.put("password", password);
		cookieJsonObject.put("uid", cmsUserLoginInfo.getUid().toString());
		cookieJsonObject.put("wechatid", cmsUserLoginInfo.getUwechatid());
		String cookieString = cookieJsonObject.toString();

		Cookie cookie = new Cookie("login", cookieString);
		cookie.setMaxAge(24 * 60 * 60 * 30);
		cookie.setPath("/");
		response.addCookie(cookie);
		return jsonObject.toString();
	}
}
