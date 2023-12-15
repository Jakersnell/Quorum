package com.skilldistillery.quorum.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.quorum.data.CourseDAO;
import com.skilldistillery.quorum.data.UserDAO;
import com.skilldistillery.quorum.entities.Course;
import com.skilldistillery.quorum.entities.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDao;
	
	@Autowired
	private CourseDAO courseDao;

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


		if (hasAuth(userID, session)) {
			edit = true;
			mv.addObject("user", userDao.getUserById(userID));
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
		
		List<Course> courses = courseDao.getCoursesByUser(userID);
        mv.addObject("courses", courses);
        mv.setViewName("profile");
		return mv;
	}

	@GetMapping({ "/follow", "getFollow.do" })
	private ModelAndView userProfileGetFollow(@RequestParam(name = "userID") int userID, HttpSession session,
			ModelAndView mv) {

		mv.setViewName("follow");

		User user = userDao.getUserById(userID, true);

		if (user == null) {
			mv.setViewName("not-found");
		}

		mv.addObject("user", user);
		mv.addObject("userEditAuth", hasAuth(userID, session));

		return mv;
	}

	@GetMapping({ "/editProfile", "editProfile.do" })
	private ModelAndView userEditProfileGet(@RequestParam(name = "userID") int userID, HttpSession session,
			ModelAndView mv) {
		mv.setViewName("redirect:/home");

		User loggedUser = (User) session.getAttribute("loggedUser");

		if (loggedUser != null) {
			if (hasAuth(userID, session)) {
				User accEdit = userDao.getUserById(userID);

				mv.addObject("user", accEdit);
				mv.setViewName("editProfile");

			}
		}

		return mv;
	}

	@GetMapping({ "/update", "update.do" })
	private ModelAndView userEditProfilePOST(@ModelAttribute User user, HttpSession session, ModelAndView mv) {

		mv.setViewName("redirect:/error.do");

		if (hasAuth(user.getId(), session)) {

			mv.setViewName("redirect:/profile?userID=" + user.getId());
			user = userDao.update(user);
		}
		return mv;
	}

	@PostMapping({ "/removeFollower", "removeFollower.do" })
	private String userRemoveFollower(@RequestParam(name = "userID") int userID,
			@RequestParam(name = "removeID") int removeID, HttpSession session) {
		String redirect = "redirect:/error.do";
		if (hasAuth(userID, session)) {
			userDao.removeFollower(userID, removeID);
			redirect = "redirect:/getFollow.do?userID=" + userID;
		}
		return redirect;
	}

	@PostMapping({ "/removeFollowing", "removeFollowing.do" })
	private String userRemoveFollowing(@RequestParam(name = "userID") int userID,
			@RequestParam(name = "removeID") int removeID, HttpSession session) {
		String redirect = "redirect:/error.do";
		if (hasAuth(userID, session)) {
			userDao.removeFollowing(userID, removeID);
			redirect = "redirect:/getFollow.do?userID=" + userID;
		}
		return redirect;
	}

	private boolean hasAuth(int accessUserId, HttpSession session) {
		User user = (User) session.getAttribute("loggedUser");
		return user != null && (accessUserId == user.getId() || user.getRole().equals("admin"));
	}
}
