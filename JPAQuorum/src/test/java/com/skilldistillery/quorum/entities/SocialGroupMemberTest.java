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

class SocialGroupMemberTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private SocialGroupMember socialGroupMember;

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
		socialGroupMember = em.find(SocialGroupMember.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		socialGroupMember = null;
	}

//    @Test
//    void test_CreatedOn() {
//        assertNotNull(socialGroupMember);
//        assertEquals(2023, socialGroupMember.getCreatedOn().getYear());
//        assertEquals(Month.JANUARY, socialGroupMember.getCreatedOn().getMonth());
//    }

//    @Test
//    void test_LastUpdate() {
//        assertNotNull(socialGroupMember);
//        assertEquals(2023, socialGroupMember.getLastUpdate().getYear());
//        assertEquals(Month.APRIL, socialGroupMember.getLastUpdate().getMonth());
//    }
	
	
	
}
