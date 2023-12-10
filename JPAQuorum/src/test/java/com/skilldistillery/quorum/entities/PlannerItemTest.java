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

class PlannerItemTest {

    private static EntityManagerFactory emf;
    private EntityManager em;
    private PlannerItem item;

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
        item = em.find(PlannerItem.class, 1);
    }

    @AfterEach
    void tearDown() throws Exception {
        em.close();
        item = null;
    }

    @Test
    void test_PlannerItem_Name() {
        assertNotNull(item);
        assertEquals("Study Group", item.getTitle());
        assertEquals("Meeting up with the study group for a review session.", item.getDescription());
        assertEquals(2023, item.getStartTime().getYear());
        assertEquals(Month.OCTOBER, item.getStartTime().getMonth());
        assertEquals(18, item.getStartTime().getDayOfMonth());
    }
    
    @Test
    void test_PlannerItem_User_Relationship() {
    	assertNotNull(item);
    	assertEquals("John", item.getUser().getFirstName());
    }

}

