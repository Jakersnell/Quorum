package com.skilldistillery.quorum.data;

import java.util.List;


import com.skilldistillery.quorum.entities.Professor;
import com.skilldistillery.quorum.entities.ProfessorRating;

public interface ProfessorDAO  {
	Professor getById(int id);
	List<Professor> getAllBySchoolId(int id);
	List<Professor> searchByQuery(String query);
	List<Professor> getAll();
	Professor update(Professor professor);
	double getAverageRating(int professorId);
	List<ProfessorRating> getAllRatingsByProfessorId(int professorId);
}
