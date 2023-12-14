package com.skilldistillery.quorum.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.skilldistillery.quorum.data.GroupPostDAO;
import com.skilldistillery.quorum.data.SocialGroupDAO;
import com.skilldistillery.quorum.entities.GroupPost;
import com.skilldistillery.quorum.entities.SocialGroup;
import com.skilldistillery.quorum.entities.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class PostController {

	@Autowired
	private GroupPostDAO postDao;

	@Autowired
	private SocialGroupDAO groupDao;

	@PostMapping({ "/create-post", "createPost.do" })
	private String createPostPOST(@ModelAttribute GroupPost post, @RequestParam(name = "groupId") int groupId,
			HttpSession session) {
		String redirect;

		User loggedUser = (User) session.getAttribute("loggedUser");
		SocialGroup group = groupDao.getById(groupId);
		if (loggedUser != null && group != null) {
			redirect = "redirect:/userProfile.do?userID=" + loggedUser.getId();
			post.setUser(loggedUser);
			post.setSocialGroup(group);
			postDao.create(post);
		} else if (group == null) {
			redirect = "redirect:/error.do";
		} else {
			redirect = "redirect:/login.do";
		}

		return redirect;
	}
}
