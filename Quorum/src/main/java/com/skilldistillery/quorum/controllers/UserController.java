package com.skilldistillery.quorum.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.quorum.data.UserDAO;
import com.skilldistillery.quorum.entities.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDao;

	@GetMapping({ "/my-profile", "myProfile.do" })
	private String myProfileGet(HttpSession session) {
		String view = "my-profile";
		if (session.getAttribute("loggedUser") == null) {
			return "redirect:/login.do";
		}
		return view;
	}

	@GetMapping({ "/user-profile", "userProfile.do" })
	private ModelAndView userProfileGet(@RequestParam(name = "userID") int userID, HttpSession session,
			ModelAndView mav) {

		mav.setViewName("not-found");

		User loggedUser = (User) session.getAttribute("loggedUser");
		if (loggedUser != null && userID == loggedUser.getId()) {
			mav.setViewName("redirect:/myProfile.do");
		} else {
			User user = userDao.getUserById(userID);
			if (user != null) {
				mav.addObject("user", user);
				mav.setViewName("user-profile");
			}
		}

		return mav;
	}
}
