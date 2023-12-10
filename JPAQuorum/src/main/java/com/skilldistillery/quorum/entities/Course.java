package com.skilldistillery.quorum.entities;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Objects;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Convert;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class Course {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String title;

	@Column(name = "created_on")
	@CreationTimestamp
	private LocalDateTime createdOn;

	@Column(name = "last_update")
	@UpdateTimestamp
	private LocalDateTime lastUpdate;

	@Column(name = "date_start")
	private LocalDate dateStart;

	@Column(name = "date_end")
	private LocalDate dateEnd;

	@ManyToOne
	@JoinColumn(name = "school_id")
	private School school;

	@ManyToOne
	@JoinColumn(name = "professor_id")
	private Professor professor;

	private boolean enabled;

	@Column(name = "days_of_week")
	@Convert(converter = DayOfWeekConverter.class)
	private HashSet<DayOfWeek> daysOfWeek;

	public Course() {

	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Course other = (Course) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Course [id=" + id + ", title=" + title + ", createdOn=" + createdOn + ", lastUpdate=" + lastUpdate
				+ ", dateStart=" + dateStart + ", dateEnd=" + dateEnd + ", school.getId()=" + school.getId()
				+ ", professor.getId()=" + professor.getId() + ", enabled=" + enabled + ", daysOfWeek=" + daysOfWeek
				+ "]";
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public LocalDateTime getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(LocalDateTime createdOn) {
		this.createdOn = createdOn;
	}

	public LocalDateTime getLastUpdate() {
		return lastUpdate;
	}

	public void setLastUpdate(LocalDateTime lastUpdate) {
		this.lastUpdate = lastUpdate;
	}

	public LocalDate getDateStart() {
		return dateStart;
	}

	public void setDateStart(LocalDate dateStart) {
		this.dateStart = dateStart;
	}

	public LocalDate getDateEnd() {
		return dateEnd;
	}

	public void setDateEnd(LocalDate dateEnd) {
		this.dateEnd = dateEnd;
	}

	public School getSchool() {
		return school;
	}

	public void setSchool(School school) {
		this.school = school;
	}

	public Professor getProfessor() {
		return professor;
	}

	public void setProfessor(Professor professor) {
		this.professor = professor;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public HashSet<DayOfWeek> getDaysOfWeek() {
		return daysOfWeek;
	}

	public void setDaysOfWeek(HashSet<DayOfWeek> daysOfWeek) {
		this.daysOfWeek = daysOfWeek;
	}

}
