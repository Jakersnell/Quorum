package com.skilldistillery.quorum.data;

import java.util.List;

import org.springframework.stereotype.Service;

import com.skilldistillery.quorum.entities.SocialGroup;
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
		String jpql = "SELECT u FROM User u WHERE username = :username AND password = :password and enabled = true";
		User user = null;

		try {
			user = em.createQuery(jpql, User.class).setParameter("username", username)
					.setParameter("password", password).getSingleResult();
		} catch (Exception e) {
			System.err.print("Invalid user: " + username + "\n");
			e.printStackTrace();
		}

		return user;
	}

	@Override
	public User createUser(User user) {
		if (authenticateUser(user.getUsername(), user.getPassword()) == null) {
			em.persist(user);
		} else {
			user = null;
		}
		return user;
	}

	@Override
	public User getUserById(int id) {
		return getUserById(id, false);
	}

	@Override
	public User getUserById(int id, boolean loadFollows) {
		User user = em.find(User.class, id);

		if (loadFollows) {
			user.getFollowers().size();
			user.getFollowing().size();
		}

		return user;
	}

	@Override
	public User getUserByUsername(String username) {
		String jpql = "SELECT u FROM User u WHERE username = :username AND u.enabled = true";
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

	@Override
	public void updateUser(int id, User user) {
		User managedUser = em.find(User.class, id);
		managedUser = user;
		em.persist(managedUser);
	}

	@Override
	public void deleteUser(int id) {
		User managedUser = em.find(User.class, id);
		managedUser.setEnabled(false);
		;
		em.persist(managedUser);
	}

	@Override
	public void activateUser(int id) {
		User managedUser = em.find(User.class, id);
		managedUser.setEnabled(true);
		;
		em.persist(managedUser);
	}

	@Override
	public User update(User user) {

		// "the code can't hurt you.."

		// the code:

		User managed = em.find(User.class, user.getId());

		managed.setFirstName(user.getFirstName());
		managed.setLastName(user.getLastName());
		managed.setBiography(user.getBiography());
		managed.setEmail(user.getEmail());
		managed.setPassword(user.getPassword());
		managed.setEnabled(user.isEnabled());
		managed.setProfileImageUrl(user.getProfileImageUrl());
		managed.setUsername(user.getUsername());

		return user;
	}

	public boolean removeFollower(int userId, int followerId) {
		boolean success = false;
		User user = em.find(User.class, userId);
		User follower = em.find(User.class, followerId);
		if (user.getFollowers().contains(follower)) {
			user.getFollowers().remove(follower);
			if (follower.getFollowing().contains(follower)) {
				follower.getFollowing().remove(follower);
			}
			success = true;
		}
		return success;
	}

	public boolean removeFollowing(int userId, int followingId) {
		boolean success = false;
		User user = em.find(User.class, userId);
		User following = em.find(User.class, followingId);
		if (user.getFollowing().contains(following)) {
			user.getFollowing().remove(following);
			if (following.getFollowers().contains(following)) {
				following.getFollowers().remove(following);
			}
			success = true;
		}
		return success;
	}

	public boolean addFollowing(int userId, int followingId) {
		boolean success = false;
		User user = em.find(User.class, userId);
		User following = em.find(User.class, followingId);
		if (!user.getFollowing().contains(following)) {
			user.getFollowing().add(following);
			if (!following.getFollowers().contains(user)) {
				following.getFollowers().add(user);
			}
			success = true;
		}
		return success;
	}

	@Override
	public void setEnabled(int id, boolean status) {
		User user = em.find(User.class, id);
		user.setEnabled(status);
	}

	@Override
	public void changeRole(int id, String role) {
		User user = em.find(User.class, id);
		user.setRole(role);
	}


	@Override
	public List<User> searchByQuery(String query, User user) {
		query = "%" + query + "%";
		String jpql = """
					SELECT
					    u
					FROM
					    User u
					WHERE
					    (
					        (u.username LIKE :query)
					    OR
					        (u.firstName LIKE :query)
					    OR
					    	(u.lastName LIKE :query)
					    )
				""";

		if (!user.isAdmin()) {
			jpql += """
					AND
					    u.enabled = true
					AND
						u.role <> 'admin'
					AND
						u.school.id =
					""" + user.getSchool().getId();
		}

		return em.createQuery(jpql, User.class).setParameter("query", query).getResultList();
	}

	@Override
	public List<User> getByGroupId(int groupId) {
		SocialGroup group = em.find(SocialGroup.class, groupId);
		return group.getMembers();
	}

	@Override
	public boolean userIsFollowing(User followed, User following) {
		return followed.getFollowers().contains(following);
	}

}
