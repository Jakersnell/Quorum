package com.skilldistillery.quorum.data;

import com.skilldistillery.quorum.entities.School;

public interface SchoolDAO {
	School getAll();
	School getById(int id);
}
