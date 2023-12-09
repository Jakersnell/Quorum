package com.skilldistillery.quorum.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.time.Month;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class UserTest {

    private static EntityManagerFactory emf;
    private EntityManager em;
    private User user;

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
        user = em.find(User.class, 1);
    }

    @AfterEach
    void tearDown() throws Exception {
        em.close();
        user = null;
    }

    @Test
    void test_Username() {
        assertNotNull(user);
        assertEquals("johnsmith", user.getUsername());
    }

    @Test
    void test_Password() {
        assertNotNull(user);
        assertEquals("password123", user.getPassword());
    }

    @Test
    void test_CreatedOn() {
        assertNotNull(user);
        assertEquals(2023, user.getCreatedOn().getYear());
        assertEquals(Month.JANUARY, user.getCreatedOn().getMonth());
    }

    @Test
    void test_Email() {
        assertNotNull(user);
        assertEquals("john.smith@email.com", user.getEmail());
    }

    @Test
    void test_LastUpdate() {
        assertNotNull(user);
        assertEquals(2023, user.getLastUpdate().getYear());
        assertEquals(Month.APRIL, user.getLastUpdate().getMonth());
    }

    @Test
    void test_Enabled() {
        assertNotNull(user);
        assertEquals(true, user.isEnabled());
    }

    @Test
    void test_Role() {
        assertNotNull(user);
        assertEquals("student", user.getRole());
    }

    @Test
    void test_FirstName() {
        assertNotNull(user);
        assertEquals("John", user.getFirstName());
    }

    @Test
    void test_LastName() {
        assertNotNull(user);
        assertEquals("Smith", user.getLastName());
    }

    @Test
    void test_Biography() {
        assertNotNull(user);
        assertEquals("Biography of John \nSmith", user.getBiography());
    }

    @Test
    void test_DateOfBirth() {
        assertNotNull(user);
        assertEquals(2001, user.getDateOfBirth().getYear());
        assertEquals(Month.MAY, user.getDateOfBirth().getMonth());
    }

    @Test
    void test_ProfileImageUrl() {
        assertNotNull(user);
        assertEquals("", user.getProfileImageUrl());
    }
}

