package com.skilldistillery.quorum.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.time.LocalDate;
import java.time.Month;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class ProfessorRatingTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private ProfessorRating professorRating;

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
		ProfessorRatingId id = new ProfessorRatingId(1, 1);

		professorRating = em.find(ProfessorRating.class, id);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		professorRating = null;
	}

	@Test
	void test_user() {
		assertNotNull(professorRating);
		User user = professorRating.getUser();
		assertNotNull(user);
		assertEquals(user.getId(), 1);

	}

	@Test
	void test_professor() {
		assertNotNull(professorRating);
		Professor professor = professorRating.getProfessor();
		assertNotNull(professor);
		assertEquals(professor.getId(), 1);
	}

	@Test
	void test_rating() {
		assertNotNull(professorRating);
		assertEquals(professorRating.getRating(), 4);
	}

	@Test
	void test_content() {
		assertNotNull(professorRating);
		assertTrue(!professorRating.getContent().isEmpty());
	}

	@Test
	void test_createdOn_date() {
		assertNotNull(professorRating);
		assertEquals(Month.APRIL, professorRating.getCreatedOn().getMonth());
		assertEquals(2023, professorRating.getCreatedOn().getYear());
	}

	@Test
	void test_lastUpdate_date() {
		assertNotNull(professorRating);
		assertEquals(Month.APRIL, professorRating.getLastUpdate().getMonth());
		assertEquals(2023, professorRating.getLastUpdate().getYear());
	}

	@Test
	void test_enabled() {
		assertNotNull(professorRating);
		assertTrue(professorRating.isEnabled());
	}

}
