package com.skilldistillery.quorum.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

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
    void test_School_User_Relationship() {
    	assertNotNull(school);
    	assertTrue(school.getUsers().size() > 0);
    }

}

