package com.skilldistillery.quorum.data;

import com.skilldistillery.quorum.entities.User;

public interface UserDAO {
	
	User authenticateUser (String username, String password);
	
	User createUser (User user);
	
	public User getUserById(int id);
	
	User getUserByUsername(String username);

}
