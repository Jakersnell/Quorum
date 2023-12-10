package com.skilldistillery.quorum.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.time.DayOfWeek;
import java.time.Month;
import java.util.Arrays;
import java.util.HashSet;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class CourseTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Course course;

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
		course = em.find(Course.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		course = null;
	}

	@Test
	void test_Course_title() {
		assertNotNull(course);
		assertEquals("Introduction to Computer Science", course.getTitle());
	}

	@Test
	void test_Course_createdOn() {
		assertNotNull(course);
		assertEquals(course.getCreatedOn().getYear(), 2023);
		assertEquals(course.getCreatedOn().getMonth(), Month.FEBRUARY);
	}

	@Test
	void test_Course_lastUpdate() {
		assertNotNull(course);
		assertEquals(course.getLastUpdate().getYear(), 2023);
		assertEquals(course.getLastUpdate().getMonth(), Month.JUNE);
	}

	@Test
	void test_Course_dateStart() {
		assertNotNull(course);
		assertEquals(course.getDateStart().getYear(), 2023);
		assertEquals(course.getDateStart().getMonth(), Month.FEBRUARY);
	}

	@Test
	void test_Course_dateEnd() {
		assertNotNull(course);
		assertEquals(course.getDateEnd().getYear(), 2023);
		assertEquals(course.getDateEnd().getMonth(), Month.MAY);
	}

	@Test
	void test_Course_school() {
		assertNotNull(course);
		assertEquals(1, course.getSchool().getId());
	}

	@Test
	void test_Course_professor() {
		assertNotNull(course);
		assertEquals(1, course.getProfessor().getId());
	}

	@Test
	void test_Course_enabled() {
		assertNotNull(course);
		assertTrue(course.isEnabled());
	}

	@Test
	void test_Course_daysOfWeek() {
		assertNotNull(course);
		HashSet<DayOfWeek> expectedDays = new HashSet<>(
				Arrays.asList(DayOfWeek.MONDAY, DayOfWeek.TUESDAY, DayOfWeek.THURSDAY, DayOfWeek.FRIDAY));
		assertEquals(expectedDays, course.getDaysOfWeek());
	}
}
