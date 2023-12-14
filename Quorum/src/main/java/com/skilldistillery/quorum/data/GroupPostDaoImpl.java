package com.skilldistillery.quorum.data;

import java.util.List;

import org.springframework.stereotype.Service;

import com.skilldistillery.quorum.entities.GroupPost;

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
	public List<GroupPost> getByUserId(int id) {
		String jpql = """
				SELECT p 
				FROM GroupPost p 
				WHERE p.user.id = :id
				""";
		return em.createQuery(jpql, GroupPost.class).setParameter("id", id).getResultList();
	}

	@Override
	public List<GroupPost> getByGroupId(int groupId) {
		String jpql = """
			    SELECT p 
			    FROM GroupPost p 
			    WHERE p.socialGroup.id = :groupId
			    """;

		return em.createQuery(jpql, GroupPost.class).setParameter("groupId", groupId).getResultList();
	}

	@Override
	public GroupPost create(GroupPost post) {
		em.persist(post);
		return post;
	}

	@Override
	public GroupPost update(GroupPost post) {
		GroupPost managed = em.find(GroupPost.class, post.getId());
		managed.setTitle(post.getTitle());
		managed.setContents(post.getContents());
		managed.setEnabled(post.isEnabled());
		return managed;
	}

	@Override
	public List<GroupPost> getUserFeed(int userId) {
		String jpql = """
				SELECT post
				FROM GroupPost post
				WHERE EXISTS (
				    SELECT 1
				    FROM post.user.followers f
				    WHERE f.id = :userId AND post = post
				) OR EXISTS (
				    SELECT 1
				    FROM post.socialGroup.members member
				    WHERE member.id = :userId AND post = post
				)
				""";
		return em.createQuery(jpql, GroupPost.class).setParameter("userId", userId).getResultList();
	}
}
