package com.skilldistillery.quorum.data;

import java.util.List;

import org.springframework.stereotype.Service;

import com.skilldistillery.quorum.entities.Course;
import com.skilldistillery.quorum.entities.Professor;
import com.skilldistillery.quorum.entities.School;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class SchoolDAOImpl implements SchoolDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public List<School> getAll() {
		return em.createQuery("SELECT s FROM School s", School.class).getResultList();
	}

	@Override
	public School getById(int id) {
		return em.find(School.class, id);
	}

	@Override
	public School createSchool(School school) {
		em.persist(school);
        em.flush();
        return school;
	}

	@Override
	public School updateSchool(int id, School updatedSchool) {
		School school = em.find(School.class, id);
		
		if(school != null) {
			school.setName(updatedSchool.getName());
            school.setDescription(updatedSchool.getDescription());
            school.setFoundedIn(updatedSchool.getFoundedIn());
            school.setImageUrl(updatedSchool.getImageUrl());
            return school;
		}
		return null;
	}

	@Override
	public boolean deactivateSchool(int id) {
		School school = em.find(School.class, id);
		
		if(school != null) {
			school.setEnabled(false);
			return true;
		}
		return false;
	}

	@Override
	public School getSchoolByName(String name) {
		String jpql = "SELECT s FROM School s WHERE s.name = :name AND s.enabled = true";
        return em.createQuery(jpql, School.class)
                 .setParameter("name", name)
                 .getSingleResult();
	}

	@Override
	public List<Course> getCoursesBySchool(int schoolId) {
		//To get every course for each school returned from the initial query.
		String jpql = "SELECT c FROM Course c WHERE c.school.id = :schoolId";
		return em.createQuery(jpql, Course.class)
                .setParameter("schoolId", schoolId)
                .getResultList();
	}

	@Override
	public List<Professor> getProfessorsBySchool(int schoolId) {
		//To get every professor for each school returned from the initial query.
		String jpql = "SELECT p FROM Professor p WHERE p.school.id = :schoolId";
        return em.createQuery(jpql, Professor.class)
                 .setParameter("schoolId", schoolId)
                 .getResultList();
	}

}
