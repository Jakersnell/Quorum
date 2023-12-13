package com.skilldistillery.quorum.data;

import com.skilldistillery.quorum.entities.Message;

public interface MessageDAO {
	
	Message sendMessage(int senderId, int receiverId, String message);
	
	
}
