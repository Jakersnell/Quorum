package com.skilldistillery.quorum.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.quorum.data.CourseDAO;
import com.skilldistillery.quorum.data.ProfessorDAO;
import com.skilldistillery.quorum.data.SchoolDAO;
import com.skilldistillery.quorum.data.UserDAO;
import com.skilldistillery.quorum.entities.Course;
import com.skilldistillery.quorum.entities.Professor;
import com.skilldistillery.quorum.entities.ProfessorRating;
import com.skilldistillery.quorum.entities.School;
import com.skilldistillery.quorum.entities.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class SchoolController {

	@Autowired
	private SchoolDAO schoolDAO;

	@Autowired
	private ProfessorDAO professorDAO;

	@Autowired
	private CourseDAO courseDAO;
	
	@Autowired
	private UserDAO userDAO;

	@GetMapping({ "/school", "school.do" })
	public ModelAndView viewSchool(@RequestParam(name = "schoolID") int schoolID, HttpSession session) {
		ModelAndView mv = new ModelAndView();

		if (session.getAttribute("loggedUser") != null) {

			School school = schoolDAO.getById(schoolID);
			if (school == null) {
				mv.setViewName("redirect:/404.do");
			} else {
				List<Course> courses = courseDAO.getCoursesBySchool(schoolID);

				List<Professor> professors = professorDAO.getAllBySchoolId(schoolID);
				for (Professor professor : professors) {
					double avgRating = professorDAO.getAverageRating(professor.getId());
					professor.setAverageRating(avgRating);
				}

				mv.addObject("school", school);
				mv.addObject("courses", courses);
				mv.addObject("professors", professors);
				mv.setViewName("school");
			}
		}
		return mv;
	}

	@GetMapping({ "/professorview", "professorview.do" }) 
	public ModelAndView viewProfessorReview(@RequestParam(name = "professorId") int professorId, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Professor professor = professorDAO.getById(professorId);
		User loggedUser = (User) session.getAttribute("loggedUser");
		boolean hasRated = false;
		mv.setViewName("redirect:/404.do");

		if (loggedUser != null) {

			if (professor == null) {
				mv.setViewName("redirect:/404.do");
			} else {
				List<ProfessorRating> ratings = professorDAO.getAllRatingsByProfessorId(professorId);
				mv.addObject("ratings", ratings);
				
				for (ProfessorRating professorRating : ratings) {
					if(professorRating.getUser().getId() == loggedUser.getId()) { 
						hasRated = true;
						
					}
				}
				
				double avgRating = professorDAO.getAverageRating(professorId);
				double truncated = Math.floor(avgRating * 100) / 100;
				professor.setAverageRating(truncated);
				mv.addObject("rated", hasRated);
				mv.addObject("professor", professor);
				mv.setViewName("professorview");
			}
		}
		return mv;
	}
	@PostMapping({ "/professorview", "professorview.do" }) 
	public ModelAndView addProfessorReview(@RequestParam(name = "profID") int professorId,
			@RequestParam(name="userID") int userID, @RequestParam(name="rating") int rating,
			@RequestParam(name="content") String content,
			HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		User loggedUser = (User) session.getAttribute("loggedUser");
		if (loggedUser != null) {
			Professor professor = professorDAO.getById(professorId);
			User user = userDAO.getUserById(userID);
			
			if (professor == null || user == null) {
				mv.setViewName("redirect:/404.do");
			} else {
				professorDAO.addRating(userID, professorId, content, true, rating);
				mv.addObject("professorId", professorId);
				mv.setViewName("redirect:/professorview.do?professorID="+professorId);
				}
				
		}
		return mv;
	}

}
