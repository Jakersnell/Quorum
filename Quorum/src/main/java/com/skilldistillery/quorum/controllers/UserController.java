package com.skilldistillery.quorum.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.quorum.data.CourseDAO;
import com.skilldistillery.quorum.data.GroupPostDAO;
import com.skilldistillery.quorum.data.UserDAO;
import com.skilldistillery.quorum.entities.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {
	
	private static String REDIRECT = "redirect:/";
	private static String REDIRECT_LOGIN = REDIRECT + "login.do";
	private static String REDIRECT_404 = REDIRECT + "404.do";
	private static String REDIRECT_ERROR = REDIRECT + "error.do";

	@Autowired
	private UserDAO userDao;

	@Autowired
	private CourseDAO courseDao;

	@Autowired
	private GroupPostDAO postDao;

	@GetMapping({ "/account", "account.do" })
	private String myProfileGet(HttpSession session) {
		String view = "account";
		if (session.getAttribute("loggedUser") == null) {
			return REDIRECT_LOGIN;
		}
		return view;
	}

	@GetMapping({ "/profile", "userProfile.do" })
	private ModelAndView userProfileGet(@RequestParam(name = "userID") int userID, HttpSession session,
			ModelAndView mv) {
		String viewName;

		User logged = (User) session.getAttribute("loggedUser");
		User user = userDao.getUserById(userID);

		if (!isLoggedIn(session)) {
			viewName = REDIRECT_LOGIN;
		} else if (user == null) {
			viewName = REDIRECT_404;
		} else {
			viewName = "profile";
			mv.addObject("user", user);
			mv.addObject("feed", postDao.getByUserId(userID));
			mv.addObject("courses", courseDao.getCoursesByUser(userID));
			mv.addObject("userEditAuth", hasAuth(userID, session));
			mv.addObject("userIsFollowingUser", userDao.userIsFollowing(user, logged));
			mv.addObject("fromUrl", "userProfile.do?userID=" + userID);
		}

		mv.setViewName(viewName);

		return mv;
	}

	@GetMapping({ "/editProfile", "editProfile.do" })
	private ModelAndView userEditProfileGet(@RequestParam(name = "userID") int userID, HttpSession session,
			ModelAndView mv) {
		mv.setViewName(REDIRECT_LOGIN);

		if (hasAuth(userID, session)) {
			User accEdit = userDao.getUserById(userID);
			mv.addObject("user", accEdit);
			mv.setViewName("editProfile");
		} else {
			mv.setViewName(REDIRECT_ERROR);
		}

		return mv;
	}

	@GetMapping({ "/follow", "getFollow.do" })
	private ModelAndView userProfileGetFollow(@RequestParam(name = "userID") int userID, HttpSession session,
			ModelAndView mv) {

		mv.setViewName("follow");

		if (hasAuth(userID, session)) {
			mv.addObject("user", userDao.getUserById(userID, true));
		} else {
			mv.setViewName("redirect:/notFound.do");
		}

		return mv;
	}

	@GetMapping({ "/update", "update.do" })
	private ModelAndView userEditProfilePOST(@ModelAttribute User user, HttpSession session, ModelAndView mv) {

		mv.setViewName(REDIRECT_ERROR);

		if (hasAuth(user.getId(), session)) {

			mv.setViewName("redirect:/profile?userID=" + user.getId());
			user = userDao.update(user);
		}
		return mv;
	}

	@GetMapping({ "/delete", "delete.do" })
	private ModelAndView userEditProfilePOST(@RequestParam(name = "userID") int userID, HttpSession session,
			ModelAndView mv) {

		mv.setViewName(REDIRECT_ERROR);

		User user = (User) session.getAttribute("loggedUser");

		if (user.getId() == userID || user.getRole().equals("admin")) {
			userDao.setEnabled(userID, false);
			mv.setViewName("redirect:/profile?userID=" + user.getId());
			if (user.getId() == userID) {
				session.invalidate();
			}
		}
		return mv;
	}

	@PostMapping({ "/removeFollower", "removeFollower.do" })
	private String userRemoveFollower(@RequestParam(name = "userID") int userID,
			@RequestParam(name = "removeID") int removeID, HttpSession session) {
		String redirect = REDIRECT_ERROR;
		if (hasAuth(userID, session)) {
			userDao.removeFollower(userID, removeID);
			redirect = "redirect:/getFollow.do?userID=" + userID;
		}
		return redirect;
	}

	@PostMapping({ "/removeFollowing", "removeFollowing.do" })
	private String userRemoveFollowing(@RequestParam(name = "userID") int userID,
			@RequestParam(name = "removeID") int removeID, HttpSession session,
			@RequestParam(name = "fromProfile", required = false) Boolean fromProfile) {
		String redirect = REDIRECT_ERROR;
		if (hasAuth(userID, session)) {
			userDao.removeFollowing(userID, removeID);

			redirect = (fromProfile == null ? "redirect:/getFollow.do?userID=" + userID
					: "redirect:/userProfile.do?userID=" + removeID);
		}
		return redirect;
	}

	@PostMapping({ "/addFollowing", "addFollowing.do" })
	private String userAddFollowing(@RequestParam(name = "userID") int userID,
			@RequestParam(name = "followID") int followID, HttpSession session) {
		String redirect = "redirect:/userProfile.do?userID=" + followID;
		if (hasAuth(userID, session)) {
			userDao.addFollowing(userID, followID);
		}
		return redirect;
	}

	private boolean hasAuth(int accessUserId, HttpSession session) {
		User user = (User) session.getAttribute("loggedUser");
		return user != null && (accessUserId == user.getId() || user.getRole().equals("admin"));
	}

	private boolean isLoggedIn(HttpSession session) {
		return session.getAttribute("loggedUser") != null;
	}

}
