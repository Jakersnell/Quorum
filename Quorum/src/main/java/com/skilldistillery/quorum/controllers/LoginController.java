package com.skilldistillery.quorum.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.quorum.data.SchoolDAO;
import com.skilldistillery.quorum.data.SocialGroupDAO;
import com.skilldistillery.quorum.data.UserDAO;
import com.skilldistillery.quorum.entities.School;
import com.skilldistillery.quorum.entities.SocialGroup;
import com.skilldistillery.quorum.entities.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

	@Autowired
	private UserDAO userDao;

	@Autowired
	private SchoolDAO schoolDao;


	@GetMapping({ "/login", "login.do" })
	public String loginGet(HttpSession session) {
		return (session.getAttribute("loggedUser") == null) ? "login" : "redirect:/home.do";
	}

	@PostMapping({ "/login", "login.do" })
	public String loginPost(@ModelAttribute User user, HttpSession session, RedirectAttributes redirectAttributes) {
		String redirect = "redirect:/home.do";

		if (session.getAttribute("loggedUser") == null) {

			User searchedUser = userDao.authenticateUserLogin(user.getUsername(), user.getPassword());

			if (searchedUser != null) {
				if (searchedUser.isEnabled() == false) {
					session.setAttribute("userID", searchedUser.getId());
					redirect = "reactivate";

				} else {
					session.setAttribute("loggedUser", searchedUser);
				}

			} else {
				redirectAttributes.addFlashAttribute("msg", "Sorry! Incorrect username/password!");
				redirect = "redirect:/login.do";
			}

		}

		return redirect;
	}

	@GetMapping({ "/signup", "signup.do" })
	public ModelAndView signupGet(HttpSession session, ModelAndView model) {
		model.setViewName("signup");
		if (session.getAttribute("loggedUser") != null) {
			model.setViewName("redirect:/home.do");
		}

		List<School> school = schoolDao.getAll();
		model.addObject("school", school);
		return model;
	}

	@PostMapping({ "/signup", "signup.do" })
	public String signupPost(@ModelAttribute User user, HttpSession session,
			@RequestParam(name = "schoolID") int schoolID) {
		String redirect = "redirect:/signup.do";

		if (session.getAttribute("loggedUser") == null) {

			School selectedSchool = schoolDao.getById(schoolID);
			user.setSchool(selectedSchool);
			user.setRole("student");

			User createdUser = userDao.createUser(user);
			session.setAttribute("loggedUser", createdUser);
			redirect = "redirect:/home.do";
		}

		return redirect;
	}

	@GetMapping({ "/logout", "logout.do" })
	public ModelAndView logout(HttpSession session, ModelAndView model) {
		session.removeAttribute("loggedUser");
		String msg = "Thanks for coming!";
		session.invalidate();
		model.setViewName("redirect:/home.do");
		model.addObject("msg", msg);
		return model;
	}

	@GetMapping({ "/reactivate", "reactivate.do" })
	public ModelAndView logout(@RequestParam(name = "userID") int userID, HttpSession session, ModelAndView mv) {
		String msg = "Success!";
		session.invalidate();
		userDao.activateUser(userID);
		mv.setViewName("redirect:/login.do");
		mv.addObject("msg", msg);
		return mv;
	}
}
