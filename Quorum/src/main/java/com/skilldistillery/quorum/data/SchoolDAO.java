package com.skilldistillery.quorum.data;

import java.util.List;

import com.skilldistillery.quorum.entities.Course;
import com.skilldistillery.quorum.entities.Professor;
import com.skilldistillery.quorum.entities.School;

public interface SchoolDAO {

	List<School> getAll();
	School getById(int id);
	public School createSchool(School school);
	public School updateSchool(int id, School updatedSchool);
	public boolean deactivateSchool(int id);
	public School getSchoolByName(String name);
	public List<Course> getCoursesBySchool(int schoolId);
	public List<Professor> getProfessorsBySchool(int schoolId);
	
}
