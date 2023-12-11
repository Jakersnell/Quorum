package com.skilldistillery.quorum.data;

import java.util.List;

import org.springframework.stereotype.Service;

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

}
