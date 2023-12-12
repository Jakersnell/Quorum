package com.skilldistillery.quorum.controllers;

import java.util.HashMap;
import java.util.List;

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

	@GetMapping({ "/account", "account.do" })
	private String myProfileGet(HttpSession session) {
		String view = "account";
		if (session.getAttribute("loggedUser") == null) {
			return "redirect:/login.do";
		}
		return view;
	}

	@GetMapping({ "/profile", "userProfile.do" })
	private ModelAndView userProfileGet(@RequestParam(name = "userID") int userID, HttpSession session,
			ModelAndView mv) {

		mv.setViewName("not-found");

		Boolean edit = false;

		User loggedUser = (User) session.getAttribute("loggedUser");
		if (loggedUser != null && userID == loggedUser.getId()) {
			edit = true;
			mv.addObject("user", loggedUser);
			mv.addObject("userEditAuth", edit);
			mv.setViewName("profile");
		} else {
			User user = userDao.getUserById(userID);
			if (user != null) {
				mv.addObject("user", user);
				mv.addObject("userEditAuth", edit);
				mv.setViewName("profile");
			}
		}

		return mv;
	}

	@GetMapping({ "/follow", "getFollow.do" })
	private ModelAndView userProfileGetFollow(@RequestParam(name = "userID") int userID, HttpSession session,
			ModelAndView mv) {

		mv.setViewName("follow");

		User user = userDao.getUserById(userID);
		User loggedUser = (User) session.getAttribute("loggedUser");
		
		if (user == null) {
			mv.setViewName("not-found");
		} else {
			userDao.loadFollowDetails(user);
		}

		HashMap<String, List<User>> followDetails = new HashMap<>();
		followDetails.put("Followers", user.getFollowers());
		followDetails.put("Following", user.getFollowing());

		mv.addObject("user", user);
		mv.addObject("followDetails", followDetails);
		mv.addObject("userEditAuth", loggedUser != null && userID == user.getId());

		return mv;
	}
}
