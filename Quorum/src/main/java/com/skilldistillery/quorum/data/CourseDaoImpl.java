package com.skilldistillery.quorum.data;

import java.util.List;

import org.springframework.stereotype.Service;

import com.skilldistillery.quorum.entities.Course;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class CourseDaoImpl implements CourseDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public Course createCourse(Course course) {
		em.persist(course);
		em.flush();
		return course;
	}

	@Override
	public Course getCourseById(int id) {
		return em.find(Course.class, id);
	}

	@Override
	public List<Course> getAllCourses() {
		String jpql = "SELECT c FROM Course c";
		return em.createQuery(jpql, Course.class).getResultList();
	}

	@Override
	public Course updateCourse(int id, Course course) {
		Course managedCourse = em.find(Course.class, id);
		if (managedCourse != null) {
			managedCourse.setTitle(course.getTitle());
			managedCourse.setDateStart(course.getDateStart());
			managedCourse.setDateEnd(course.getDateEnd());
			managedCourse.setSchool(course.getSchool());
			managedCourse.setProfessor(course.getProfessor());
			managedCourse.setEnabled(course.isEnabled());
			managedCourse.setDaysOfWeek(course.getDaysOfWeek());
		}
		return managedCourse;
	}

	@Override
	public boolean deactivateCourse(int id) {
		Course course = em.find(Course.class, id);
		if (course != null) {
			course.setEnabled(false);
			return true;
		}
		return false;
	}

}
