package com.skilldistillery.quorum.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.quorum.data.SchoolDAO;
import com.skilldistillery.quorum.entities.School;

import jakarta.servlet.http.HttpSession;

@Controller
public class SchoolController {

	@Autowired
	private SchoolDAO schoolDAO;

	@GetMapping({ "/school", "/school.do" })
	public ModelAndView viewSchool(@RequestParam(name = "schoolID") int schoolID, HttpSession session) {
		ModelAndView mv = new ModelAndView();

		if (session.getAttribute("loggedUser") == null) {
			mv.setViewName("redirect:/login");
			return mv;
		}

		School school = schoolDAO.getById(schoolID);
		mv.addObject("school", school);
		mv.setViewName("school/view");
		return mv;
	}

}
