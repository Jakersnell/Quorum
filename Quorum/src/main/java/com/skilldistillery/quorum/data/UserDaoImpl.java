package com.skilldistillery.quorum.data;

import org.springframework.stereotype.Service;

import com.skilldistillery.quorum.entities.User;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class UserDaoImpl implements UserDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public User authenticateUser(String username, String password) {
		String jpql = "SELECT u FROM User u WHERE username = :username AND password = :password AND u.enabled = true";
		User user = null;

		try {
			user = em.createQuery(jpql, User.class).setParameter("username", username)
					.setParameter("password", password).getSingleResult();
			user.getFollowing().size();
			user.getSentMessages().size();
			user.getReceivedMessages().size();
			user.getItems().size();
		} catch (Exception e) {
			System.err.print("Invalid user: " + username + "\n");
			e.printStackTrace();
		}

		return user;
	}

	@Override
	public User createUser(User user) {
		em.persist(user);

		return user;
	}

	@Override
	public User getUserById(int id) {
		return em.find(User.class, id);
	}

	@Override
	public User getUserByUsername(String username) {
		String jpql = "SELECT u FROM User u WHERE username = :username";
		User user = null;
		try {
			user = em.createQuery(jpql, User.class).setParameter("username", username)
					.setParameter("username", username).getSingleResult();
		} catch (Exception e) {
			System.err.print("Invalid user: " + username);
			e.printStackTrace();
		}
		return user;
	}

}
