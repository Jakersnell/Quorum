package com.skilldistillery.quorum.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.quorum.data.GroupPostDAO;
import com.skilldistillery.quorum.data.SocialGroupDAO;
import com.skilldistillery.quorum.data.UserDAO;
import com.skilldistillery.quorum.entities.SocialGroup;
import com.skilldistillery.quorum.entities.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class SocialGroupController {

	@Autowired
	private UserDAO userDao;

	@Autowired
	private SocialGroupDAO groupDao;

	@Autowired
	private GroupPostDAO postDao;

	@GetMapping({ "/group", "group.do" })
	public ModelAndView getSocialGroup(@RequestParam(name = "groupID") int groupID, HttpSession session,
			ModelAndView mav) {
		String viewName;
		SocialGroup group;
		if (session.getAttribute("loggedUser") != null) {
			group = groupDao.getById(groupID);
			if (group != null) {
				viewName = "socialGroup";
				mav.addObject("group", group);
				if (userIsMember(groupID, session)) {
					mav.addObject("userIsMember", true);
					mav.addObject("members", userDao.getByGroupId(groupID));
					mav.addObject("feed", postDao.getByGroupId(groupID));
					mav.addObject("userHasEditAuth", userHasEditAuth(groupID, session));
				}
			} else {
				viewName = "redirect:/404.do";
			}
		} else {
			viewName = "redirect:/login.do";
		}

		mav.setViewName(viewName);

		return mav;
	}

	@PostMapping({ "/join-group", "joinGroup.do" })
	public String joinSocialGroup(@RequestParam(name = "groupID") int groupId, HttpSession session, ModelAndView mav) {
		String redirect = "redirect:/login.do";
		User user = (User) session.getAttribute("loggedUser");
		if (user != null) {
			if (groupDao.addUser(groupId, user.getId())) {
				user.addGroup(groupDao.getById(groupId));
				redirect = "redirect:/group.do?groupID=" + groupId;
			} else {
				redirect = "redirect:/error.do";
			}
		}
		return redirect;
	}
	
	@PostMapping({ "/leave-group", "leaveGroup.do" })
	public String leaveSocialGroup(@RequestParam(name = "groupID") int groupId, HttpSession session, ModelAndView mav) {
		String redirect = "redirect:/login.do";
		User user = (User) session.getAttribute("loggedUser");
		if (user != null) {
			user.removeGroup(groupDao.getById(groupId));
			if (groupDao.removeUser(groupId, user.getId())) {
				redirect = "redirect:/group.do?groupID=" + groupId;
			} else {
				redirect = "redirect:/error.do";
			}
		}
		return redirect;
	}

	private boolean userHasEditAuth(int groupID, HttpSession session) {
		User loggedUser = (User) session.getAttribute("loggedUser");
		return groupDao.userIsOwner(groupID, loggedUser.getId()) || loggedUser.getRole().equals("admin");
	}

	private boolean userIsMember(int groupID, HttpSession session) {
		User user = (User) session.getAttribute("loggedUser");
		return user != null && (groupDao.userIsInGroup(groupID, user.getId()) || user.getRole().equals("admin"));

	}

}
