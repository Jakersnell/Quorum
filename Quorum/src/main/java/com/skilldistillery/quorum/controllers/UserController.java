package com.skilldistillery.quorum.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.quorum.data.SchoolDAO;
import com.skilldistillery.quorum.data.UserDAO;
import com.skilldistillery.quorum.entities.School;
import com.skilldistillery.quorum.entities.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDao;

	@Autowired
	private SchoolDAO schoolDao;

	@GetMapping({ "/", "home.do" })
	public String home(Model model) {
		return "home";
	}

	@GetMapping({ "/login", "login.do" })
	public String loginGet(HttpSession session) {
		return (session.getAttribute("loggedUser") == null) ? "login" : "redirect:/home.do";
	}

	@PostMapping({ "/login", "login.do" })
	public String loginPost(@ModelAttribute User user, HttpSession session) {
		String redirect = "redirect:/home.do";

		if (session.getAttribute("loggedUser") == null) {

			User searchedUser = userDao.authenticateUser(user.getUsername(), user.getPassword());

			if (searchedUser != null) {
				session.setAttribute("loggedUser", searchedUser);
			} else {
				redirect = "redirect:/login.do";
			}

		}

		return redirect;
	}

	@GetMapping({ "/signup", "signup.do" })
	public ModelAndView signupGet(HttpSession session, ModelAndView model) {
		model.setViewName("signup");
		if (session.getAttribute("loggedUser") == null) {
			model.setViewName("redirect:/home.do");
		}

		List<School> school = schoolDao.getAll();
		model.addObject("school", school);
		return model;
	}

	@PostMapping({ "/signup", "signup.do" })
	public String signupPost(@ModelAttribute User user, HttpSession session) {
		String redirect = "redirect:/signup.do";

		if (session.getAttribute("loggedUser") == null) {
			
			School selectedSchool = schoolDao.getById(user.getSchool().getId());
			user.setSchool(selectedSchool);
			
			User createdUser = userDao.createUser(user);
			session.setAttribute("loggedUser", createdUser);
			redirect = "redirect:/home.do";
		}

		return redirect;
	}
}
