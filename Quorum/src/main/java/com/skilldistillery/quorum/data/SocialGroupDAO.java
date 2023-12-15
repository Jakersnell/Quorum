package com.skilldistillery.quorum.data;

import java.util.List;

import com.skilldistillery.quorum.entities.SocialGroup;

public interface SocialGroupDAO {
	SocialGroup create(SocialGroup group);

	SocialGroup getById(int id);

	List<SocialGroup> getByUserId(int id);

	List<SocialGroup> getAll();

	boolean addUser(int socialGroupId, int userId);

	boolean removeUser(int socialGroupId, int userId);

	boolean update(SocialGroup group);
	
	List<SocialGroup> searchByQuery(String query);
}
