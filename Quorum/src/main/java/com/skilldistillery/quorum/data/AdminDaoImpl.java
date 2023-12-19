package com.skilldistillery.quorum.data;

import org.springframework.stereotype.Service;

import com.skilldistillery.quorum.entities.ProfessorRating;
import com.skilldistillery.quorum.entities.ProfessorRatingId;
import com.skilldistillery.quorum.entities.User;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class AdminDaoImpl implements AdminDAO {

	@PersistenceContext
	private EntityManager em;

	
	@Override
	public void deleteUser(int id) {
		User managedUser = em.find(User.class, id);
		managedUser.setEnabled(false);;
		em.persist(managedUser);
	}
	
	@Override
	public void activateUser(int id) {
		User managedUser = em.find(User.class, id);
		managedUser.setEnabled(true);;
		em.persist(managedUser);
	}

	@Override
	public void changeRole(int id, String role) {
		User user = em.find(User.class, id);
		user.setRole(role);
	}
	
	@Override
	public void deleteReview(int userID, int profID) {
			ProfessorRatingId id = new ProfessorRatingId(userID, profID);
			ProfessorRating rating = em.find(ProfessorRating.class, id);
			em.remove(rating);
		
	}

	
}
