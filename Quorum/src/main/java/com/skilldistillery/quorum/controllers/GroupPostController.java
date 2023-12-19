package com.skilldistillery.quorum.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.quorum.data.GroupPostCommentDAO;
import com.skilldistillery.quorum.data.GroupPostDAO;
import com.skilldistillery.quorum.data.SocialGroupDAO;
import com.skilldistillery.quorum.entities.GroupPost;
import com.skilldistillery.quorum.entities.GroupPostComment;
import com.skilldistillery.quorum.entities.SocialGroup;
import com.skilldistillery.quorum.entities.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class GroupPostController {
	private static String REDIRECT = "redirect:/";
	private static String REDIRECT_LOGIN = REDIRECT + "login.do";
	private static String REDIRECT_404 = REDIRECT + "404.do";
	private static String REDIRECT_ERROR = REDIRECT + "error.do";

	@Autowired
	private GroupPostDAO postDao;

	@Autowired
	private SocialGroupDAO groupDao;

	@Autowired
	private GroupPostCommentDAO commentDao;

	@PostMapping({ "/create-post", "createPost.do" })
	public String createPostPOST(@ModelAttribute GroupPost post, @RequestParam(name = "groupId") int groupId,
			HttpSession session) {
		String redirect;

		User loggedUser = (User) session.getAttribute("loggedUser");
		SocialGroup group = groupDao.getById(groupId);
		if (loggedUser != null && group != null) {
			post.setUser(loggedUser);
			post.setSocialGroup(group);
			post = postDao.create(post);
			redirect = "redirect:/post.do?postID=" + post.getId();
		} else if (group == null) {
			redirect = REDIRECT_ERROR;
		} else {
			redirect = REDIRECT_LOGIN;
		}

		return redirect;
	}

	@GetMapping({ "/edit-post", "editPost.do" })
	public ModelAndView postEditGET(@RequestParam(name = "postID") int postId, ModelAndView mav, HttpSession session) {
		GroupPost post = postDao.getById(postId);
		if (post == null) {
			mav.setViewName(REDIRECT_ERROR);
		} else if (!hasAuth(post.getUser().getId(), session)) {
			mav.setViewName(REDIRECT_LOGIN);
		} else {
			mav.setViewName("editPost");
			mav.addObject("post", post);
		}

		return mav;
	}

	@PostMapping({ "/edit-post", "editPost.do" })
	public String postEditPOST(@RequestParam(value = "fromUrl", required = false) final String fromUrl,
			@ModelAttribute GroupPost post, HttpSession session) {
		String redirect;
		if (session.getAttribute("loggedUser") == null) {
			redirect = REDIRECT_LOGIN;
		} else if (post != null && hasEditAuth(post.getId(), session) && postDao.update(post)) {
			redirect = "redirect:post.do?postID=" + post.getId();
		} else {
			redirect = REDIRECT_ERROR;
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
			redirect = REDIRECT_ERROR;
		}

		return redirect;
	}

	@GetMapping({ "/post", "post.do" })
	public ModelAndView postDetailView(@RequestParam(name = "postID") int postId, HttpSession session,
			ModelAndView mav) {
		String viewName;
		GroupPost post = postDao.getById(postId);
		User loggedUser = (User) session.getAttribute("loggedUser");

		if (loggedUser == null) {
			viewName = REDIRECT_LOGIN;
		} else if (post == null) {
			viewName = REDIRECT_ERROR;
		} else {
			viewName = "post";
			mav.addObject("post", post);
			mav.addObject("userIsInGroup", groupDao.userIsInGroup(post.getSocialGroup().getId(), loggedUser.getId()));
		}

		mav.setViewName(viewName);

		return mav;
	}

	@PostMapping({ "comment.do" })
	private String makeCommentPOST(@ModelAttribute GroupPostComment comment, @RequestParam(name = "postID") int postId,
			HttpSession session) {
		String redirect;
		User loggedUser = (User) session.getAttribute("loggedUser");
		GroupPost post = postDao.getById(postId);
		if (loggedUser == null) {
			redirect = REDIRECT_LOGIN;
		} else if (post == null || !groupDao.userIsInGroup(post.getSocialGroup().getId(), loggedUser.getId())) {
			redirect = REDIRECT_404;
		} else {
			comment.setUser(loggedUser);
			comment.setGroupPost(post);
			if (comment.getId() == 0) {
				commentDao.create(comment);
			} else {
				commentDao.update(comment);
			}
			redirect = "redirect:/post.do?postID=" + postId;
		}

		return redirect;
	}

	@PostMapping({ "setCommentStatus.do" })
	private String setCommentEnabledStatus(@RequestParam(name = "commentID") int commentId,
			@RequestParam(name = "status") boolean status, HttpSession session) {
		String redirect;
		GroupPostComment comment = commentDao.getById(commentId);
		User loggedUser = (User) session.getAttribute("loggedUser");
		if (loggedUser == null) {
			redirect = REDIRECT_LOGIN;
		} else if (comment == null) {
			redirect = REDIRECT_ERROR;
		} else {
			status = loggedUser.isAdmin() ? status : false;
			redirect = "redirect:/post.do?postID=" + comment.getGroupPost().getId();
			comment.setEnabled(status);
			commentDao.updateEnabledStatus(comment);
		}
		return redirect;
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
