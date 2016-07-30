package com.o.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value={"/login"})
public class LoginController {
	Logger logger = Logger.getLogger(LoginController.class);

	@RequestMapping({"/Login"})
	public String Login() {
		logger.debug("login controller requested");
		return "/login/Login";
	}
	
	@RequestMapping("/Logout")
	public String Logout() {
		return "/login/Logout";
	}
	
	@RequestMapping("/VerifyLogin")
	public String VerifyLogin() {
		return "login/VerifyLogin";
	}

}
