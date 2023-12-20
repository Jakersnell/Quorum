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

	@GetMapping({ "account.do" })
	private String myProfileGet(HttpSession session) {
		String view = "account";
		if (session.getAttribute("loggedUser") == null) {
			return REDIRECT_LOGIN;
		}
		return view;
	}

	@GetMapping({ "userProfile.do" })
	private ModelAndView userProfileGet(@RequestParam(name = "userID") int userID, HttpSession session,
			ModelAndView mv) {
		String viewName;

		User loggedUser = (User) session.getAttribute("loggedUser");
		User profileUser = userDao.getUserById(userID);

		if (loggedUser == null) {
			viewName = REDIRECT_LOGIN;
		} else if (profileUser == null) {
			viewName = REDIRECT_404;
		} else {
			viewName = "profile";
			mv.addObject("user", profileUser);
			mv.addObject("feed", postDao.getByUserId(userID));
			mv.addObject("courses", courseDao.getCoursesByUser(userID));
			mv.addObject("userEditAuth", hasAuth(userID, loggedUser));
			mv.addObject("userIsFollowingUser", userDao.userIsFollowing(profileUser, loggedUser));
			mv.addObject("fromUrl", "userProfile.do?userID=" + userID);
		}
		mv.setViewName(viewName);

		return mv;
	}

	@GetMapping({ "editProfile.do" })
	private ModelAndView userEditProfileGet(@RequestParam(name = "userID") int userID, HttpSession session,
			ModelAndView mv) {

		String viewName;
		User loggedUser = (User) session.getAttribute("loggedUser");
		User userToEdit = userDao.getUserById(userID);

		if (loggedUser == null) {
			viewName = REDIRECT_LOGIN;
		} else if (userToEdit == null || !hasAuth(userID, loggedUser)) {
			viewName = REDIRECT_ERROR;
		} else {
			viewName = "editProfile";
			mv.addObject("user", userToEdit);
		}

		mv.setViewName(viewName);
		return mv;
	}

	@GetMapping({ "getFollow.do" })
	private ModelAndView userProfileGetFollow(@RequestParam(name = "userID") int userID, HttpSession session,
			ModelAndView mv) {
		String viewName;

		User loggedUser = (User) session.getAttribute("loggedUser");
		User profileUser = userDao.getUserById(userID, true);

		if (loggedUser == null) {
			viewName = REDIRECT_LOGIN;
		} else if (profileUser != null && !hasAuth(userID, loggedUser)) {
			viewName = REDIRECT_404;
		} else {
			mv.addObject("user", profileUser);
			viewName = "follow";
		}

		mv.setViewName(viewName);

		return mv;
	}

	@GetMapping({ "update.do" })
	private ModelAndView userEditProfilePOST(@ModelAttribute User user, HttpSession session, ModelAndView mv) {

		mv.setViewName(REDIRECT_ERROR);

		if (hasAuth(user.getId(), session)) {

			mv.setViewName("redirect:/userProfile.do?userID=" + user.getId());
			user = userDao.update(user);
		}
		return mv;
	}

	@GetMapping({ "delete.do" })
	private ModelAndView userEditProfilePOST(@RequestParam(name = "userID") int userID, HttpSession session,
			ModelAndView mv) {

		mv.setViewName(REDIRECT_ERROR);

		User user = (User) session.getAttribute("loggedUser");

		if (user.getId() == userID || user.getRole().equals("admin")) {
			userDao.setEnabled(userID, false);
			mv.setViewName("redirect:/userProfile.do?userID=" + user.getId());
			if (user.getId() == userID) {
				session.invalidate();
			}
		}
		return mv;
	}

	@PostMapping({ "removeFollower.do" })
	private String userRemoveFollower(@RequestParam(name = "userID") int userID,
			@RequestParam(name = "removeID") int removeID, HttpSession session) {
		String redirect = REDIRECT_ERROR;
		if (hasAuth(userID, session)) {
			userDao.removeFollower(userID, removeID);
			redirect = "redirect:/getFollow.do?userID=" + userID;
		}
		return redirect;
	}

	@PostMapping({ "removeFollowing.do" })
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

	@PostMapping({ "addFollowing.do" })
	private String userAddFollowing(@RequestParam(name = "userID") int userID,
			@RequestParam(name = "followID") int followID, HttpSession session) {
		String redirect = "redirect:/userProfile.do?userID=" + followID;
		User loggedUser = (User) session.getAttribute("loggedUser");
		if (hasAuth(userID, session)) {
			userDao.addFollowing(userID, followID);
			User user = userDao.getUserById(followID);
		}
		return redirect;
	}

	private boolean hasAuth(int targetUserId, User user) {
		return user != null && (targetUserId == user.getId() || user.getRole().equals("admin"));
	}
	
	private boolean hasAuth(int targetUserId, HttpSession session) {
		User loggedUser = (User) session.getAttribute("loggedUser");
		return hasAuth(targetUserId, loggedUser);
	}


}
