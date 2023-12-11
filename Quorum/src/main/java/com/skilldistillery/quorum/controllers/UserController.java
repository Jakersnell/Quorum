package com.skilldistillery.quorum.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.quorum.data.UserDAO;
import com.skilldistillery.quorum.entities.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDao;

	@GetMapping({ "/", "home.do" })
	public String home(Model model) {
		model.addAttribute("SMOKETEST", userDao.authenticateUser("jtest", "jtest"));
		return "home";
	}

	@GetMapping({ "/login", "login.do" })
	public String loginGet(HttpSession session) {
		if (session.getAttribute("loggedUser") != null) {
			return "redirect:/home.do";
		}
		return "login";
	}

	@PostMapping({ "/login", "login.do" })
	public String loginPost(@ModelAttribute User user, HttpSession session) {
		String redirect = "redirect:/home.do";

		if (session.getAttribute("loggedUser") == null) {

			User searchedUser = userDao.authenticateUser(user.getUsername(), user.getPassword());

			if (searchedUser != null) {
				session.setAttribute("loggedUser", searchedUser);
			} else {
				redirect = "redirect:/login.do"; //change to sign-up
			}
			
		}

		return redirect;
	}

}

