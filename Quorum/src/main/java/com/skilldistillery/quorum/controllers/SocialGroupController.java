package com.skilldistillery.quorum.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.quorum.data.SocialGroupDAO;
import com.skilldistillery.quorum.entities.SocialGroup;

import jakarta.servlet.http.HttpSession;

@Controller
public class SocialGroupController {

	@Autowired
	private SocialGroupDAO groupDao;

	@GetMapping({ "/group", "group.do" })
	public ModelAndView getSocialGroup(@RequestParam(name = "groupID") int groupID, HttpSession session,
			ModelAndView mav) {
		String viewName;

		if (session.getAttribute("loggedUser") != null) {
			SocialGroup group = groupDao.getById(groupID);
			if (group != null) {
				viewName = "socialGroup";
				mav.addObject("group", group);
			} else {
				viewName = "redirect:/404.do";
			}
		} else {
			viewName = "redirect:/login.do";
		}

		mav.setViewName(viewName);

		return mav;
	}
}
