package com.skilldistillery.quorum.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.time.Month;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class MessageTest {

    private static EntityManagerFactory emf;
    private EntityManager em;
    private Message message;

    @BeforeAll
    static void setUpBeforeClass() throws Exception {
        emf = Persistence.createEntityManagerFactory("JPAQuorum");
    }

    @AfterAll
    static void tearDownAfterClass() throws Exception {
        emf.close();
    }

    @BeforeEach
    void setUp() throws Exception {
        em = emf.createEntityManager();
        message = em.find(Message.class, 1);
    }

    @AfterEach
    void tearDown() throws Exception {
        em.close();
        message = null;
    }

    @Test
    void test_Message_mapping() {
        assertNotNull(message);
        assertEquals("Can you send me the notes from today's lecture?", message.getContents());
        assertEquals(2023, message.getCreatedOn().getYear());
        assertEquals(Month.AUGUST, message.getCreatedOn().getMonth());
        assertEquals(31, message.getCreatedOn().getDayOfMonth());
    }
    
    @Test
    void test_Message_Sender_Relationship() {
    	assertNotNull(message);
    	assertEquals("Liam", message.getSender().getFirstName());
    }
    
    @Test
    void test_Message_Reciever_Relationship() {
    	assertNotNull(message);
    	assertEquals("Ryan", message.getReceiver().getFirstName());
    }

}