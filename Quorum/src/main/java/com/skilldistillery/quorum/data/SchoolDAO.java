package com.skilldistillery.quorum.data;

import java.util.List;

import com.skilldistillery.quorum.entities.School;

public interface SchoolDAO {
	List<School> getAll();

	School getById(int id);
}
