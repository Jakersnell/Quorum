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

class GroupPostCommentTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private GroupPostComment groupPostComment;

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
		groupPostComment = em.find(GroupPostComment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		groupPostComment = null;
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
		assertNotNull(groupPostComment);
		assertEquals("This is going to be so exciting!", groupPostComment.getContents());
	}

	@Test
	void testToString() {
		assertNotNull(groupPostComment);
		String toStringResult = groupPostComment.toString();
		assertTrue(toStringResult.contains("This is going to be so exciting!"));
	}
}
