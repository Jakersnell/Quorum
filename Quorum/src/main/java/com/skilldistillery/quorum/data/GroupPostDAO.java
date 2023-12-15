package com.skilldistillery.quorum.data;

import java.util.List;

import com.skilldistillery.quorum.entities.GroupPost;

public interface GroupPostDAO {
	GroupPost getById(int id);

	List<GroupPost> getByUserId(int userId);

	List<GroupPost> getByGroupId(int groupId);

	GroupPost create(GroupPost post);

	boolean update(GroupPost post);

	List<GroupPost> getUserFeed(int userId);

	List<GroupPost> searchByQuery(String query);

	boolean userIsOwner(int postId, int userId);
	
	void setEnabled(int postId, boolean status);
	
	List<GroupPost> getAll();
	
}
