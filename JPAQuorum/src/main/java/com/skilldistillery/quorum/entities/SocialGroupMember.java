package com.skilldistillery.quorum.entities;

import java.util.Objects;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "social_group_member")
public class SocialGroupMember {

	@Id
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	@Id
	@ManyToOne
	@JoinColumn(name = "group_id")
	private SocialGroup group;

	public SocialGroupMember() {
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public SocialGroup getGroup() {
		return group;
	}

	public void setGroup(SocialGroup group) {
		this.group = group;
	}

	@Override
	public String toString() {
		return "SocialGroupMember [user=" + user + ", group=" + group + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(user);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		SocialGroupMember other = (SocialGroupMember) obj;
		return Objects.equals(user, other.user);
	}

}
