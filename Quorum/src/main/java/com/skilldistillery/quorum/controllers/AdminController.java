package com.skilldistillery.quorum.controllers;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.quorum.data.MessageDAO;
import com.skilldistillery.quorum.data.UserDAO;
import com.skilldistillery.quorum.entities.Message;
import com.skilldistillery.quorum.entities.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

	@Autowired
	private MessageDAO messageDao;
	
	@Autowired
	private UserDAO userDao;


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
	
	@PostMapping({ "/profile", "delete.do" })
	public String messagePost(@RequestParam(name="userID")int userID, HttpSession session) {
		String redirect = "redirect:/error.do";
		
		User loggedUser = (User) session.getAttribute("loggedUser");

		if (loggedUser != null && loggedUser.getId() == userID) {
			userDao.deleteUser(userID);
			redirect = "redirect:/search.do?userID="+userID;
		}

		return redirect;
	}

	@GetMapping({ "/admin", "activate.do" })
	public ModelAndView messagesGet(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		User loggedUser = (User) session.getAttribute("loggedUser");
		mv.setViewName("error");
		if(loggedUser != null) {
			HashSet<User> messagees = messageDao.getMessagees(loggedUser);
			session.setAttribute("messagees", messagees);
			mv.setViewName("messages");
		}
		
		return mv;
	}
}
