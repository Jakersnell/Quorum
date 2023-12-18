package com.skilldistillery.quorum.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.quorum.data.AdminDAO;
import com.skilldistillery.quorum.data.UserDAO;
import com.skilldistillery.quorum.entities.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

	@Autowired
	private AdminDAO adminDao;
	

	@GetMapping({ "/admin", "admin.do" })
	public ModelAndView adminGet(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		User loggedUser = (User) session.getAttribute("loggedUser");
		mv.setViewName("error");
		
		if(loggedUser != null && loggedUser.getRole().equals("admin")) {
			mv.setViewName("admin");
		}
		
		return mv;
		
	}
	
	@GetMapping({ "/activate", "activate.do" })
	public String activateGet(@RequestParam(name="userID")int userID, HttpSession session) {
		String redirect = "redirect:/error.do";
		
		User loggedUser = (User) session.getAttribute("loggedUser");
		
		if (loggedUser.getRole().equals("admin")) {
			adminDao.activateUser(userID);
			redirect = "redirect:/admin.do";
		}
		
		return redirect;
	}

	
}
