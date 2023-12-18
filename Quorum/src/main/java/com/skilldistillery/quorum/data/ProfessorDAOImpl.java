package com.skilldistillery.quorum.data;

import java.util.List;

import org.springframework.stereotype.Service;

import com.skilldistillery.quorum.entities.Professor;
import com.skilldistillery.quorum.entities.ProfessorRating;
import com.skilldistillery.quorum.entities.User;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class ProfessorDAOImpl implements ProfessorDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public Professor getById(int id) {
		return em.find(Professor.class, id);
	}

	@Override
	public List<Professor> getAllBySchoolId(int id) {
		String jpql = "SELECT p FROM Professor p WHERE school.id = :id";
		return em.createQuery(jpql, Professor.class).setParameter("id", id).getResultList();
	}

	@Override
	public List<Professor> searchByQuery(String query, User user) {
		query = "%" + query + "%";
		String jpql = """
				SELECT
				    p
				FROM
				    Professor p
				WHERE
				    (
				        (firstName LIKE :query)
				        OR (lastName LIKE :query)
				    )
				""";
		if (!user.isAdmin()) {
			jpql += """
				AND 
					p.enabled = true
				AND
					p.school.enabled = true
				AND
					p.school.id = 
				""" + user.getSchool().getId();
		}
		return em.createQuery(jpql, Professor.class).setParameter("query", query).getResultList();
	}

	@Override
	public List<Professor> getAll() {
		return em.createQuery("SELECT p FROM Professor p", Professor.class).getResultList();
	}

	@Override
	public Professor update(Professor professor) {
		Professor managed = em.find(Professor.class, professor.getId());
		managed.setFirstName(professor.getFirstName());
		managed.setLastName(professor.getFirstName());
		managed.setSchool(professor.getSchool());
		managed.setEnabled(professor.isEnabled());
		return professor;
	}

	@Override
	public double getAverageRating(int professorId) {
		String query = "SELECT AVG(r.rating) FROM ProfessorRating r WHERE r.professor.id = :profId";
		Double average = em.createQuery(query, Double.class).setParameter("profId", professorId).getSingleResult();
		return average != null ? average : 0.0;
	}

	@Override
	public List<ProfessorRating> getAllRatingsByProfessorId(int professorId) {
		String jpql = "SELECT r FROM ProfessorRating r WHERE r.professor.id = :profId AND r.enabled = true";
		List<ProfessorRating> ratings = em.createQuery(jpql, ProfessorRating.class).setParameter("profId", professorId)
				.getResultList();
		return ratings;
	}

}
