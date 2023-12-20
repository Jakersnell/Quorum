package com.skilldistillery.quorum.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.quorum.data.GroupPostDAO;
import com.skilldistillery.quorum.data.SocialGroupDAO;
import com.skilldistillery.quorum.data.UserDAO;
import com.skilldistillery.quorum.entities.SocialGroup;
import com.skilldistillery.quorum.entities.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class SocialGroupController {

	private static String REDIRECT_404 = "redirect:/404.do";
	private static String REDIRECT_LOGIN = "redirect:/login.do";
	private static String REDIRECT_ERROR = "redirect:/error.do";
	private static String REDIRECT_GROUP = "redirect:/group.do?groupID=";

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
		SocialGroup group = groupDao.getById(groupID);

		if (session.getAttribute("loggedUser") == null) {

			viewName = REDIRECT_LOGIN;

		} else if (!groupDao.groupIsAccessable(groupID, ((User) session.getAttribute("loggedUser")).getId())) {

			viewName = REDIRECT_404;

		} else {

			viewName = "socialGroup";
			mav.addObject("group", group);
			mav.addObject("members", userDao.getByGroupId(groupID));
			mav.addObject("userHasEditAuth", userHasEditAuth(groupID, session));
			mav.addObject("userIsMember", userIsMember(groupID, session));
			mav.addObject("feed", postDao.getByGroupId(groupID));

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
				redirect = REDIRECT_GROUP + groupId;
			} else {
				redirect = REDIRECT_ERROR;
			}
		}
		return redirect;
	}

	@PostMapping({ "/leave-group", "leaveGroup.do" })
	public String leaveSocialGroup(@RequestParam(name = "groupID") int groupId, HttpSession session, ModelAndView mav) {
		String redirect = "redirect:/login.do";
		User user = (User) session.getAttribute("loggedUser");
		if (user != null) {
			if (groupDao.removeUser(groupId, user.getId())) {
				user.getGroups().remove(groupDao.getById(groupId));
				redirect = "redirect:/group.do?groupID=" + groupId;
			} else {
				redirect = REDIRECT_ERROR;
			}
		}
		return redirect;
	}

	@GetMapping({ "/create-group", "createGroup.do" })
	public String createSocialGroup(HttpSession session) {
		User loggedUser = (User) session.getAttribute("loggedUser");
		return loggedUser == null || loggedUser.getRole().equals("admin") ? "redirect:/home.do" : "createGroup";
	}

	@PostMapping({ "/create-group", "createGroup.do" })
	public String createSocialGroupPOST(@ModelAttribute SocialGroup group, HttpSession session) {
		String redirect;
		User loggedUser = (User) session.getAttribute("loggedUser");
		if (loggedUser == null || loggedUser.getRole().equals("admin")) {
			redirect = REDIRECT_ERROR;
		} else {
			loggedUser.getGroups().add(group);
			group = groupDao.create(group, loggedUser.getId());
			redirect = "redirect:/group.do?groupID=" + group.getId();
		}

		return redirect;
	}

	@PostMapping({ "/update-group", "updateGroup.do" })
	public String updateSocialGroup(@ModelAttribute SocialGroup group, HttpSession session) {
		String redirect = REDIRECT_ERROR;

		if (userHasEditAuth(group.getId(), session)) {
			groupDao.update(group);
			redirect = "redirect:/group.do?groupID=" + group.getId();
		}

		return redirect;
	}

	@PostMapping({ "deleteGroup.do" })
	public String deleteSocialGroup(@RequestParam(name = "groupID") int groupId, HttpSession session,
			RedirectAttributes redirectAttributes) {
		String redirect = REDIRECT_ERROR;
		User loggedUser = (User) session.getAttribute("loggedUser");
		if (userHasEditAuth(groupId, session)) {
			groupDao.setEnabled(groupId, false);
			groupDao.removeUser(groupId, loggedUser.getId());
			loggedUser.getGroups().remove(groupDao.getById(groupId));
			redirectAttributes.addFlashAttribute("msg", "Your group was successfully deleted.");
			redirect = "redirect:/home.do";
		}
		return redirect;
	}
	
	@PostMapping({"reactivateGroup.do"}) 
	public String reactivateSocialGroupAsAdmin(@RequestParam(name = "groupID") int groupId, HttpSession session) {
		String redirect;
		
		User loggedUser = (User) session.getAttribute("loggedUser");
		
		if (loggedUser.isAdmin()) {
			groupDao.setEnabled(groupId, true);
			redirect = "redirect:/group.do?groupID=" + groupId;
		} else {
			redirect = REDIRECT_404;
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
