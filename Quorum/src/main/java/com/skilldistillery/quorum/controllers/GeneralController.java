package com.skilldistillery.quorum.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GeneralController {

	@GetMapping({"/error", "error.do"})
	public String errorOccured() {
		return "error";
	}
	
	@GetMapping({"/404", "/not-found", "404.do", "notFound.do"})
	public String notFound() {
		return "not-found";
	}
	
	@GetMapping({ "/", "home.do" })
	public String home(Model model) {
		return "home";
	}
}
