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

class SocialGroupTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private SocialGroup socialGroup;

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
		socialGroup = em.find(SocialGroup.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		socialGroup = null;
	}

//    @Test
//    void test_CreatedOn() {
//        assertNotNull(socialGroup);
//        assertEquals(2023, socialGroup.getCreatedOn().getYear());
//        assertEquals(Month.JANUARY, socialGroup.getCreatedOn().getMonth());
//    }

//    @Test
//    void test_LastUpdate() {
//        assertNotNull(socialGroup);
//        assertEquals(2023, socialGroup.getLastUpdate().getYear());
//        assertEquals(Month.APRIL, socialGroup.getLastUpdate().getMonth());
//    }

	@Test
	void testGettersAndSetters() {
		assertNotNull(socialGroup);
		assertEquals("Theatre Troupe", socialGroup.getName());
		assertEquals("An acting group for staging plays and developing theatrical skills.", socialGroup.getDescription());
	}

	@Test
	void testToString() {
		assertNotNull(socialGroup);
		String toStringResult = socialGroup.toString();
		assertTrue(toStringResult.contains("Theatre Troupe"));
	}
}
