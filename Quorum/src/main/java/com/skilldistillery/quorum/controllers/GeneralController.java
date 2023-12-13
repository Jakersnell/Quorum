package com.skilldistillery.quorum.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.quorum.data.UserDAO;

@Controller
public class GeneralController {

	@Autowired
	private UserDAO userDao;

	@GetMapping({ "/error", "error.do" })
	public String errorOccured() {
		return "error";
	}

	@GetMapping({ "/404", "/not-found", "404.do", "notFound.do" })
	public String notFound() {
		return "not-found";
	}

	@GetMapping({ "/", "home.do" })
	public String home(Model model) {
		return "home";
	}

	@GetMapping({ "/search", "search.do" })
	public ModelAndView search(@RequestParam(name = "query") String query) {
		ModelAndView mav = new ModelAndView("search");
		return mav;
	}

}
