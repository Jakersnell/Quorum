package com.skilldistillery.quorum.data;

import java.util.List;

import com.skilldistillery.quorum.entities.Professor;
import com.skilldistillery.quorum.entities.ProfessorRating;
import com.skilldistillery.quorum.entities.User;

public interface ProfessorDAO  {
	Professor getById(int id);
	List<Professor> getAllBySchoolId(int id);
	List<Professor> searchByQuery(String query, User user);
	List<Professor> getAll();
	Professor update(Professor professor);
	double getAverageRating(int professorId);
	List<ProfessorRating> getAllRatingsByProfessorId(int professorId);
}
