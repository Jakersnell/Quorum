package com.skilldistillery.quorum.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class SchoolTest {

    private static EntityManagerFactory emf;
    private EntityManager em;
    private School school;

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
        school = em.find(School.class, 1);
    }

    @AfterEach
    void tearDown() throws Exception {
        em.close();
        school = null;
    }

    @Test
    void test_School_Name() {
        assertNotNull(school);
        assertEquals("Metropolitan Tech", school.getName());
    }

    @Test
    void test_School_Description() {
        assertNotNull(school);
        assertEquals("A leading institution in technology and engineering studies", school.getDescription());
    }

    @Test
    void test_School_FoundedIn() {
        assertNotNull(school);
        assertEquals(1950, school.getFoundedIn());
    }

    @Test
    void test_School_ImageUrl() {
        assertNotNull(school);
        assertEquals("http://example.com/metropolitantech.jpg", school.getImageUrl());
    }

    @Test
    void test_School_Enabled() {
        assertNotNull(school);
        assertTrue(school.isEnabled());
    }

    @Test
    void test_School_CreatedOn() {
        assertNotNull(school);
        assertEquals(LocalDate.of(2023, 1, 12), school.getCreatedOn().toLocalDate());
    }

    @Test
    void test_School_LastUpdate() {
        assertNotNull(school);
        assertEquals(LocalDateTime.of(2023, 4, 7, 0, 0), school.getLastUpdate());
    }

    @Test
    void test_School_User_Relationship() {
        assertNotNull(school);
        assertTrue(school.getUsers().size() > 0);
    }

    @Test
    void test_School_Course_Relationship() {
        assertNotNull(school);
        assertTrue(school.getCourses().size() > 0);
    }

    @Test
    void test_School_Professor_Relationship() {
        assertNotNull(school);
        assertTrue(school.getProfessors().size() > 0);
    }
}
