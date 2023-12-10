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

class GroupPostTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private GroupPost groupPost;

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
		groupPost = em.find(GroupPost.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		groupPost = null;
	}

//    @Test
//    void test_CreatedOn() {
//        assertNotNull(groupPost);
//        assertEquals(2023, groupPost.getCreatedOn().getYear());
//        assertEquals(Month.JANUARY, groupPost.getCreatedOn().getMonth());
//    }

//    @Test
//    void test_LastUpdate() {
//        assertNotNull(groupPost);
//        assertEquals(2023, groupPost.getLastUpdate().getYear());
//        assertEquals(Month.APRIL, groupPost.getLastUpdate().getMonth());
//    }

	@Test
	void testGettersAndSetters() {
		assertNotNull(groupPost);
		assertEquals("New Play Auditions", groupPost.getTitle());
		assertEquals("Auditions for our upcoming play are next week!", groupPost.getContents());
	}

	@Test
	void testToString() {
		assertNotNull(groupPost);
		String toStringResult = groupPost.toString();
		assertTrue(toStringResult.contains("New Play Auditions"));
	}
}
