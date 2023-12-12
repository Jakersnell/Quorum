package com.skilldistillery.quorum.data;

import java.util.List;

import com.skilldistillery.quorum.entities.User;

public interface UserDAO {

	User authenticateUser(String username, String password);

	User createUser(User user);

	public User getUserById(int id);

	User getUserByUsername(String username);

	List<User> getUserFollowers(User user);
	
	List<User> getUserFollowing(User user);

}
