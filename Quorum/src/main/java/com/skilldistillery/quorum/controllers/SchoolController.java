package com.skilldistillery.quorum.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.quorum.data.CourseDAO;
import com.skilldistillery.quorum.data.ProfessorDAO;
import com.skilldistillery.quorum.data.SchoolDAO;
import com.skilldistillery.quorum.entities.Course;
import com.skilldistillery.quorum.entities.Professor;
import com.skilldistillery.quorum.entities.School;

import jakarta.servlet.http.HttpSession;

@Controller
public class SchoolController {

	@Autowired
	private SchoolDAO schoolDAO;

	@Autowired
	private ProfessorDAO professorDAO;

	@Autowired
	private CourseDAO courseDAO;

	@GetMapping({ "/school", "/school.do" })
	public ModelAndView viewSchool(@RequestParam(name = "schoolID") int schoolID, HttpSession session) {
		ModelAndView mv = new ModelAndView();

		if (session.getAttribute("loggedUser") != null) {

			School school = schoolDAO.getById(schoolID);
			if (school == null) {
				mv.setViewName("not-found");
			} else {
				List<Course> courses = courseDAO.getCoursesBySchool(schoolID);
				List<Professor> professors = professorDAO.getAllBySchoolId(schoolID);
				mv.addObject("school", school);
				mv.addObject("courses", courses);
				mv.addObject("professors", professors);
				mv.setViewName("school");
			}
		}
		return mv;
	}

}
