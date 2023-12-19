package com.skilldistillery.quorum.data;

import org.springframework.stereotype.Service;

import com.skilldistillery.quorum.entities.GroupPostComment;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class GroupPostCommentDaoImpl implements GroupPostCommentDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public GroupPostComment create(GroupPostComment comment) {
		em.persist(comment);
		return comment;
	}

	@Override
	public void update(GroupPostComment comment) {
		GroupPostComment managed = em.find(GroupPostComment.class, comment.getId());
		managed.setContents(comment.getContents());
	}

	@Override
	public GroupPostComment getById(int id) {
		return em.find(GroupPostComment.class, id);
	}

	@Override
	public void updateEnabledStatus(GroupPostComment comment) {
		GroupPostComment managed = em.find(GroupPostComment.class, comment.getId());
		managed.setEnabled(comment.isEnabled());
	}

}
