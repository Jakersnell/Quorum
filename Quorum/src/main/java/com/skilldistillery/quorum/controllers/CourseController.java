package com.skilldistillery.quorum.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
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

	//Method to get courses for a specific school
//	@GetMapping({ "/school", "/school.do" })
//    public ModelAndView getCoursesForSchool(@RequestParam(name = "schoolID") int schoolID, HttpSession session) {
//        ModelAndView mv = new ModelAndView();
//
//        if (session.getAttribute("loggedUser") == null) {
//            mv.setViewName("redirect:/login");
//            return mv;
//        }
//
//        List<Course> courses = courseDao.getCoursesBySchool(schoolID);
//        mv.addObject("courses", courses);
//        mv.setViewName("school"); // JSP to display the courses for a school
//        return mv;
//    }
	
	//Method to get courses for a specific user
	@GetMapping({ "/profile", "/profile.do" })
    public ModelAndView getCoursesForUser(@RequestParam(name = "userID") int userID, HttpSession session) {
        ModelAndView mv = new ModelAndView();

        //If not logged in redirct
        if (session.getAttribute("loggedUser") == null) {
            mv.setViewName("redirect:/login");
            return mv;
        }

        //Check for logged user
        User user = (User) session.getAttribute("loggedUser");
        if (user.getId() != userID && !user.getRole().equalsIgnoreCase("admin")) {
            mv.setViewName("redirect:/error");
            return mv;
        }

        List<Course> courses = courseDao.getCoursesByUser(userID);
        mv.addObject("courses", courses);
        mv.setViewName("profile"); // JSP to display the courses for a user
        return mv;
    }

}
