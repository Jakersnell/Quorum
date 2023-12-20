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
	
	@Autowired
	private UserDAO userDao;
	

	@GetMapping({ "/admin", "admin.do" })
	public ModelAndView adminGet(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		User loggedUser = (User) session.getAttribute("loggedUser");
		mv.setViewName("error");
		
		if(loggedUser != null && loggedUser.getRole().equals("admin")) {
			mv.setViewName("home");
		}
		
		return mv;
		
	}
	
	@GetMapping({ "/activate", "activate.do" })
	public String activateGet(@RequestParam(name="userID")int userID, @RequestParam(name="query") String query, HttpSession session) {
		String redirect = "redirect:/error.do";
		
		User loggedUser = (User) session.getAttribute("loggedUser");
		
		if (loggedUser.getRole().equals("admin")) {
			adminDao.activateUser(userID);
			redirect = "redirect:/search.do?query="+query;
		}
		
		return redirect;
	}
	
	@GetMapping({ "deactivate.do" })
	private ModelAndView userEditProfilePOST(@RequestParam(name = "userID") int userID,@RequestParam(name="query") String query, HttpSession session,
			ModelAndView mv) {
		mv.setViewName("redirect:/error.do");
		User user = (User) session.getAttribute("loggedUser");

		if (user.getId() == userID || user.getRole().equals("admin")) {
			userDao.setEnabled(userID, false);
			mv.setViewName("redirect:/search.do?query="+query);
		}
		return mv;
	}
	
	@GetMapping({ "/deleteReview", "deleteReview.do" })
	public String deleteReviewGet(
			@RequestParam(name="userID")int userID,
			@RequestParam(name="professorId") int profID,
			HttpSession session) {
		String redirect = "redirect:/error.do";
		
		User loggedUser = (User) session.getAttribute("loggedUser");
		
		if (loggedUser.getRole().equals("admin")) {
			adminDao.deleteReview(userID, profID);
			redirect = "redirect:/professorview.do?professorId="+ profID;
		}
		
		return redirect;
	}

	
}
