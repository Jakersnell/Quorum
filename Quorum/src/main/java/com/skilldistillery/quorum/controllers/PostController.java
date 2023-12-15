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
	public String createPostPOST(@ModelAttribute GroupPost post, @RequestParam(name = "groupId") int groupId,
			HttpSession session) {
		String redirect;

		User loggedUser = (User) session.getAttribute("loggedUser");
		SocialGroup group = groupDao.getById(groupId);
		if (loggedUser != null && group != null) {
			post.setUser(loggedUser);
			post.setSocialGroup(group);
			redirect = "redirect:/post.do?postID=" + postDao.create(post).getId();
		} else if (group == null) {
			redirect = "redirect:/error.do";
		} else {
			redirect = "redirect:/login.do";
		}

		return redirect;
	}

	@GetMapping({ "/post", "post.do" })
	public ModelAndView postDetailGET(@RequestParam(name = "postID") int postId, ModelAndView mav,
			HttpSession session) {
		GroupPost post = postDao.getById(postId);

		if (!userIsLoggedIn(session)) {
			mav.setViewName("redirect:/login.do");
		} else if (post == null) {
			mav.setViewName("redirect:/error.do");
		} else {
			mav.setViewName("post");
			mav.addObject("post", post);
			mav.addObject("userEditAuth", hasAuth(post.getUser().getId(), session));
		}

		return mav;
	}

	@GetMapping({ "/edit-post", "editPost.do" })
	public ModelAndView postEditGET(@RequestParam(name = "postID") int postId, ModelAndView mav, HttpSession session) {
		GroupPost post = postDao.getById(postId);
		if (post == null || !hasAuth(post.getUser().getId(), session)) {
			mav.setViewName("redirect:/error.do");
		} else {
			mav.setViewName("editPost");
			mav.addObject("post", post);
		}

		return mav;
	}

	@PostMapping({ "/edit-post", "editPost.do" })
	public String postEditPOST(@ModelAttribute GroupPost post, HttpSession session) {
		String redirect;
		if (session.getAttribute("loggedUser") == null) {
			redirect = "redirect:/login.do";
		} else if (post != null && hasEditAuth(post.getId(), session) && postDao.update(post)) {
			redirect = "redirect:/post.do?postID=" + post.getId();
		} else {
			redirect = "redirect:/error.do";
		}

		return redirect;
	}

	@PostMapping({ "/delete-post", "deletePost.do" })
	public String postDelete(@RequestParam(name = "postID") int postId, HttpSession session, RedirectAttributes attr) {
		String redirect;

		if (hasEditAuth(postId, session)) {
			redirect = "redirect:/home.do";
			postDao.setEnabled(postId, false);
			attr.addFlashAttribute("msg", "Your post has been deleted!");
		} else {
			redirect = "redirect:/error.do";
		}

		return redirect;
	}

	private boolean userIsLoggedIn(HttpSession session) {
		return session.getAttribute("loggedUser") != null;
	}

	private boolean hasAuth(int accessUserId, HttpSession session) {
		User user = (User) session.getAttribute("loggedUser");
		return user != null && (accessUserId == user.getId() || user.getRole().equals("admin"));
	}

	private boolean hasEditAuth(int postId, HttpSession session) {
		User user = (User) session.getAttribute("loggedUser");
		GroupPost post = postDao.getById(postId);
		return user != null && post != null
				&& (postDao.userIsOwner(postId, user.getId()) || user.getRole().equals("admin"));
	}
}
