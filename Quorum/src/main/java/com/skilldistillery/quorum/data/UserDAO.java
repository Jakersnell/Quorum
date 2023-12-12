package com.skilldistillery.quorum.data;

import com.skilldistillery.quorum.entities.User;

public interface UserDAO {

	User authenticateUser(String username, String password);

	User createUser(User user);

	User getUserById(int id);

	User getUserById(int id, boolean loadFollows);

	User getUserByUsername(String username);

}
