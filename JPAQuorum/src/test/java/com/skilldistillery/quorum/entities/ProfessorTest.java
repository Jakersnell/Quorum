package com.skilldistillery.quorum.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.time.Month;
import java.util.List;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class ProfessorTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Professor professor;

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
		professor = em.find(Professor.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		professor = null;
	}

	@Test
	void test_firstName() {
		assertNotNull(professor);
		assertEquals("Elizabeth", professor.getFirstName());
	}

	@Test
	void test_lastName() {
		assertNotNull(professor);
		assertEquals("Jones", professor.getLastName());
	}

	@Test
	void test_enabled() {
		assertNotNull(professor);
		assertTrue(professor.isEnabled());
	}

	@Test
	void test_school() {
		assertNotNull(professor);
		assertEquals(professor.getSchool().getId(), 1);
	}

	@Test
	void test_createdOn() {
		assertNotNull(professor);
		assertEquals(professor.getCreatedOn().getMonth(), Month.FEBRUARY);
		assertEquals(professor.getCreatedOn().getYear(), 2023);
	}

	@Test
	void test_lastUpdate() {
		assertNotNull(professor);
		assertEquals(professor.getLastUpdate().getMonth(), Month.JUNE);
		assertEquals(professor.getLastUpdate().getYear(), 2023);
	}

	@Test
	void test_courses() {
		assertNotNull(professor);
		List<Course> courses = professor.getCourses();
		assertNotNull(courses);
		assertTrue(0 < courses.size());
	}
	
	@Test 
	void test_ratings() {
		assertNotNull(professor);
		List<ProfessorRating> ratings = professor.getRatings();
		assertNotNull(ratings);
		assertTrue(0 < ratings.size());
	}
}
