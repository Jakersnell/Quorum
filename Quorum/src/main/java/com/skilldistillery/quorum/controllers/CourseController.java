package com.skilldistillery.quorum.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.skilldistillery.quorum.data.CourseDAO;

@Controller
public class CourseController {

	@Autowired
	private CourseDAO courseDao;


}
