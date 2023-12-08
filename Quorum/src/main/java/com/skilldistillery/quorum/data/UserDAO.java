package com.skilldistillery.quorum.data;

import com.skilldistillery.quorum.entities.User;

public interface UserDAO {
	
	User authenticateUser (String username, String password);

}
