package com.skilldistillery.quorum.entities;

import java.io.Serializable;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

@Embeddable
public class ProfessorRatingId implements Serializable {
	private static final long serialVersionUID = -533170265228870499L;

	@Column(name = "user_id")
	private int userId;

	@Column(name = "professor_id")
	private int professorId;

	public ProfessorRatingId() {
		super();
	}

	public ProfessorRatingId(int userId, int professorId) {
		super();
		this.userId = userId;
		this.professorId = professorId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getProfessorId() {
		return professorId;
	}

	public void setProfessorId(int professorId) {
		this.professorId = professorId;
	}

	@Override
	public int hashCode() {
		return Objects.hash(professorId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ProfessorRatingId other = (ProfessorRatingId) obj;
		return professorId == other.professorId && userId == other.userId;
	}

	@Override
	public String toString() {
		return "ProfessorRatingId [userId=" + userId + ", professorId=" + professorId + "]";
	}

}
