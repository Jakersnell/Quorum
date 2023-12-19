package com.skilldistillery.quorum.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;

@Entity
@Table(name = "professor_rating")
public class ProfessorRating {

	@EmbeddedId
	private ProfessorRatingId id;

	@ManyToOne
	@JoinColumn(name = "user_id")
	@MapsId(value = "userId")
	private User user;

	@ManyToOne
	@JoinColumn(name = "professor_id")
	@MapsId(value = "professorId")
	private Professor professor;

	private int rating;
	
	private String content;

	@Column(name = "created_on")
	@CreationTimestamp
	private LocalDateTime createdOn;

	@Column(name = "last_update")
	@UpdateTimestamp
	private LocalDateTime lastUpdate;

	private boolean enabled;

	public ProfessorRating() {

	}
	
	

	public ProfessorRating(ProfessorRatingId id, User user, Professor professor, int rating, String content, boolean enabled) {
		super();
		this.id = id;
		this.user = user;
		this.professor = professor;
		this.rating = rating;
		this.content = content;
		this.enabled = enabled;
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
		ProfessorRating other = (ProfessorRating) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "ProfessorRating [ id=" + id + ", user.getId()=" + user.getId() + ", professor.getId()="
				+ professor.getId() + ", rating=" + rating + ", content=" + content + ", createdOn=" + createdOn
				+ ", lastUpdate=" + lastUpdate + ", enabled=" + enabled + "]";
	}

	public ProfessorRatingId getId() {
		return id;
	}

	public void setId(ProfessorRatingId id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Professor getProfessor() {
		return professor;
	}

	public void setProfessor(Professor professor) {
		this.professor = professor;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

}
