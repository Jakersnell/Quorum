package com.skilldistillery.quorum.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.quorum.data.CourseDAO;
import com.skilldistillery.quorum.entities.Course;
import com.skilldistillery.quorum.entities.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class CourseController {

	@Autowired
	private CourseDAO courseDao;

	private static String REDIRECT = "redirect:/";
	private static String REDIRECT_LOGIN = REDIRECT + "login.do";
	private static String REDIRECT_404 = REDIRECT + "404.do";
	private static String REDIRECT_ERROR = REDIRECT + "error.do";

	@GetMapping({ "/editCourse", "editCourse.do" })
	public ModelAndView showEditCoursePage(@RequestParam(name = "schoolID") int schoolID, HttpSession session,
			ModelAndView mv) {
		User loggedUser = (User) session.getAttribute("loggedUser");
		if (loggedUser == null) {
			mv.setViewName(REDIRECT_LOGIN);
			return mv;
		}

		List<Course> courses = courseDao.getCoursesBySchool(schoolID);
		
		mv.addObject("courses", courses);
		mv.setViewName("editCourse");
		return mv;
	}

	@PostMapping({ "/addCourse", "addCourse.do" })
	private String addCourseToUser(@RequestParam(name = "courseID") int courseID, @RequestParam(name = "studentID") int studentID, HttpSession session) {
		User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser == null) {
            return REDIRECT_LOGIN;
        }

        Course course = courseDao.getCourseById(courseID);
        if (course == null) {
            return REDIRECT_404;
        }

        boolean success = courseDao.addCourseToUser(studentID, courseID);
        if (success) {
            return "redirect:/profile?userID=" + loggedUser.getId();
        } else {
            return REDIRECT_ERROR;
        }
	}
	
	@PostMapping({ "/unenrollCourse", "unenrollCourse.do" })
    public String unenrollCourse(@RequestParam(name = "courseID") int courseID, HttpSession session) {
        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser == null) {
            return REDIRECT_LOGIN;
        }

        Course course = courseDao.getCourseById(courseID);
        if (course == null) {
            return REDIRECT_404;
        }

        boolean success = courseDao.removeCourseFromUser(loggedUser.getId(), courseID);
        if (success) {
            return "redirect:/profile?userID=" + loggedUser.getId();
        } else {
            return REDIRECT_ERROR;
        }
    }

}
