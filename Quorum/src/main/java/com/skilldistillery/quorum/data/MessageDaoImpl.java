package com.skilldistillery.quorum.data;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Service;

import com.skilldistillery.quorum.entities.Message;
import com.skilldistillery.quorum.entities.User;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class MessageDaoImpl implements MessageDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public Message sendMessage(int senderId, int receiverId, String message) {
		String msg = message;
		User sender = em.find(User.class, senderId);
		User receiver = em.find(User.class, receiverId);
		Message newMessage = new Message(msg, sender, receiver);
		System.out.println(newMessage);
		em.persist(newMessage);
		System.out.println(newMessage);
		return newMessage;
	}
	
	public List<Message> getMessages(User sender, User receiver){
	String jpql = "SELECT m FROM Message m WHERE sender = :senderID AND receiver = :receiverID "
			+ "OR sender = :receiverID AND receiver = :senderID";
	
	
	List<Message> messages = em.createQuery(jpql, Message.class)
			.setParameter("senderID", sender)
			.setParameter("receiverID", receiver)
			.getResultList();
	
	System.out.println(messages);
	
		return messages;
	}
}