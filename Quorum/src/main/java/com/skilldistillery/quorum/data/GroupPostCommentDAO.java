package com.skilldistillery.quorum.data;

import com.skilldistillery.quorum.entities.GroupPostComment;

public interface GroupPostCommentDAO {
	GroupPostComment create(GroupPostComment comment);
	
	void update(GroupPostComment comment);
	
	GroupPostComment getById(int id);
	
	void updateEnabledStatus(GroupPostComment comment);
}
