package com.skilldistillery.quorum.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.quorum.data.MessageDAO;
import com.skilldistillery.quorum.data.UserDAO;
import com.skilldistillery.quorum.entities.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class MessageController {

	@Autowired
	private MessageDAO messageDao;
	
	@Autowired
	private UserDAO userDao;


	@GetMapping({ "/message", "message.do" })
	public ModelAndView messageGet(@RequestParam(name="userID")int userID, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		User receiver = userDao.getUserById(userID);
		
		mv.addObject("user", receiver);
		mv.setViewName("message");
		
		return mv;
		
	}
	
	@PostMapping({ "/message", "message.do" })
	public String messagePost(@RequestParam(name="senderID")int senderID, @RequestParam(name="receiverID") int receiverID,@RequestParam(name="message") String msg,
			 HttpSession session) {
		String redirect = "redirect:/home.do";
		
		User loggedUser = (User) session.getAttribute("loggedUser");
		
		

		if (loggedUser != null && loggedUser.getId() == senderID) {
			messageDao.sendMessage(senderID, receiverID, msg);
			redirect = "redirect:/message.do?userID="+receiverID;
		}

		return redirect;
	}

}
