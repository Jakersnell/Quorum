package com.skilldistillery.quorum.data;

import java.util.List;

import org.springframework.stereotype.Service;

import com.skilldistillery.quorum.entities.GroupPost;
import com.skilldistillery.quorum.entities.GroupPostComment;
import com.skilldistillery.quorum.entities.User;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class GroupPostDaoImpl implements GroupPostDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public GroupPost getById(int id) {
		return em.find(GroupPost.class, id);
	}

	@Override
	public List<GroupPost> getAll() {
		String jpql = "SELECT p FROM GroupPost p";
		return em.createQuery(jpql, GroupPost.class).getResultList();
	}

	@Override
	public List<GroupPost> getByUserId(int id) {
		String jpql = """
				SELECT
				    p
				FROM
				    GroupPost p
				WHERE
				    p.user.id = :id
				    AND p.enabled = true
				    AND p.socialGroup.enabled = true
				    AND p.user.enabled = true
				ORDER BY
				    p.lastUpdate DESC
					""";
		return em.createQuery(jpql, GroupPost.class).setParameter("id", id).getResultList();
	}

	@Override
	public List<GroupPost> getByGroupId(int groupId) {
		String jpql = """
				SELECT
				    p
				FROM
				    GroupPost p
				WHERE
				    p.socialGroup.id = :groupId
				    AND p.enabled = true
				    AND p.socialGroup.enabled = true
				    AND p.user.enabled = true
				ORDER BY
				    p.lastUpdate DESC
					""";

		return em.createQuery(jpql, GroupPost.class).setParameter("groupId", groupId).getResultList();
	}

	@Override
	public GroupPost create(GroupPost post) {
		em.persist(post);
		return post;
	}

	@Override
	public boolean update(GroupPost post) {
		boolean success = false;
		GroupPost managed = em.find(GroupPost.class, post.getId());
		if (managed != null) {
			managed.setTitle(post.getTitle());
			managed.setContents(post.getContents());
			managed.setEnabled(post.isEnabled());
			success = true;
		}
		return success;
	}

	@Override
	public List<GroupPost> getUserFeed(int userId) {
		String jpql = """
					SELECT
					    post
					FROM
					    GroupPost post
					WHERE
					    (
					        EXISTS (
					            SELECT
					                1
					            FROM
					                post.user.followers f
					            WHERE
					                f.id = :userId
					                AND post = post
					        )
					        OR EXISTS (
					            SELECT
					                1
					            FROM
					                post.socialGroup.members member
					            WHERE
					                member.id = :userId
					                AND post = post
					        )
					        OR post.user.id = :userId
					    )
					    AND post.enabled = true
					    AND post.user.enabled = true
					    AND post.socialGroup.enabled = true
					ORDER BY
					    post.lastUpdate DESC
				""";
		return em.createQuery(jpql, GroupPost.class).setParameter("userId", userId).getResultList();
	}
	
	@Override
	public List<GroupPost> searchByQuery(String query, User user) {
		query = "%" + query + "%";
		String jpql = """
					SELECT post FROM GroupPost post
					WHERE
					(
						post.title LIKE :query
						OR
						post.contents LIKE :query
					)
				""";
		if (!user.isAdmin()) {
			jpql += """
					AND
						post.enabled = true
					AND 
						post.socialGroup.enabled = true
					AND 
						post.user.enabled = true
					AND 
						post.user.school.id =
					""" + user.getSchool().getId();
		}
		return em.createQuery(jpql, GroupPost.class).setParameter("query", query).getResultList();

	}

	@Override
	public boolean userIsOwner(int postId, int userId) {
		boolean result = false;
		GroupPost post = em.find(GroupPost.class, postId);
		if (post != null) {
			result = post.getUser().getId() == userId;
		}
		return result;
	}

	@Override
	public void setEnabled(int postId, boolean status) {
		GroupPost post = em.find(GroupPost.class, postId);
		if (post != null) {
			post.setEnabled(status);
		}
	}

}
