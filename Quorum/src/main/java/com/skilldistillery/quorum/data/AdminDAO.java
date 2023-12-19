package com.skilldistillery.quorum.data;

public interface AdminDAO {
	
	public void deleteUser(int id);
	
	public void activateUser(int id);

	public void changeRole(int id, String role);
	
	public void deleteReview(int userID, int profID);

}
