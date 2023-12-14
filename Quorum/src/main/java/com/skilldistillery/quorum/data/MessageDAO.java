package com.skilldistillery.quorum.data;

import java.util.HashSet;
import java.util.List;

import com.skilldistillery.quorum.entities.Message;
import com.skilldistillery.quorum.entities.User;

public interface MessageDAO {
	
	Message sendMessage(int senderId, int receiverId, String message);
	
	List<Message> getMessages(User sender, User receiver);
	
	HashSet<User> getMessagees(User user);
	
	
}
