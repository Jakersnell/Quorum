package com.skilldistillery.quorum.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.skilldistillery.quorum.data.CourseDAO;

@Controller
public class CourseController {

	@Autowired
	private CourseDAO courseDAO;

//	@GetMapping({ "/school", "/school.do" })
//	public ModelAndView viewSchool(@RequestParam(name = "schoolID") int schoolID, HttpSession session) {
//		ModelAndView mv = new ModelAndView();
//
//		if (session.getAttribute("loggedUser") == null) {
//			mv.setViewName("redirect:/login");
//			return mv;
//		}
//
//		School school = schoolDAO.getById(schoolID);
//		mv.addObject("school", school);
//		mv.setViewName("school");
//		return mv;
//	}
	
	

}
