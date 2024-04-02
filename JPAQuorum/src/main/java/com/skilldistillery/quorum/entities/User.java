package com.skilldistillery.quorum.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;

@Entity
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(unique = true, nullable = false)
	private String username;

	@Column(nullable = false)
	private String password;

	@Column(name = "created_on", nullable = false)
	@CreationTimestamp
	private LocalDateTime createdOn;

	private String email;

	@Column(name = "last_update", nullable = false)
	@UpdateTimestamp
	private LocalDateTime lastUpdate;

	private boolean enabled = true;

	private String role;

	@Column(name = "first_name")
	private String firstName;

	@Column(name = "last_name")
	private String lastName;

	private String biography;

	@Column(name = "date_of_birth")
	private LocalDateTime dateOfBirth;

	@Column(name = "profile_image_url")
	private String profileImageUrl;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "school_id")
	private School school;

	@ManyToMany
	@JoinTable(name = "user_follow", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "following_id"))
	private List<User> following;

	@ManyToMany
	@JoinTable(name = "user_follow", joinColumns = @JoinColumn(name = "following_id"), inverseJoinColumns = @JoinColumn(name = "user_id"))
	private List<User> followers;

	@OneToMany(mappedBy = "user")
	private List<PlannerItem> items;

	@OneToMany(mappedBy = "sender")
	private List<Message> sentMessages;

	@OneToMany(mappedBy = "receiver")
	private List<Message> receivedMessages;

	@ManyToMany
	@JoinTable(name = "social_group_member", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "group_id"))
	private List<SocialGroup> groups;

	public boolean isAdmin() {
		return role.equals("admin");
	}

	@ManyToMany (fetch = FetchType.EAGER)
	@JoinTable(name = "course_schedule", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "course_id"))
	private List<Course> courses;

	public User() {
		enabled = true;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public LocalDateTime getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(LocalDateTime createdOn) {
		this.createdOn = createdOn;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getBiography() {
		return biography;
	}

	public void setBiography(String biography) {
		this.biography = biography;
	}

	public LocalDateTime getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(LocalDateTime dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getProfileImageUrl() {
		return profileImageUrl;
	}

	public void setProfileImageUrl(String profileImageUrl) {
		this.profileImageUrl = profileImageUrl;
	}

	public School getSchool() {
		return school;
	}

	public void setSchool(School school) {
		this.school = school;
	}

	public List<User> getFollowing() {
		return following;
	}

	public void setFollowing(List<User> following) {
		this.following = following;
	}

	public List<PlannerItem> getItems() {
		return items;
	}

	public List<User> getFollowers() {
		return followers;
	}

	public void setFollowers(List<User> followers) {
		this.followers = followers;
	}

	public void setItems(List<PlannerItem> items) {
		this.items = items;
	}

	public List<Message> getSentMessages() {
		return sentMessages;
	}

	public void setSentMessages(List<Message> sentMessages) {
		this.sentMessages = sentMessages;
	}

	public List<Message> getReceivedMessages() {
		return receivedMessages;
	}

	public void setReceivedMessages(List<Message> receivedMessages) {
		this.receivedMessages = receivedMessages;
	}

	public List<SocialGroup> getGroups() {
		return groups;
	}

	public void setGroups(List<SocialGroup> groups) {
		this.groups = groups;
	}

	public List<Course> getCourses() {
		return courses;
	}

	public void setCourses(List<Course> courses) {
		this.courses = courses;
	}

	public void addGroup(SocialGroup group) {
		if (groups == null) {
			groups = new ArrayList<>();
		}
		if (!groups.contains(group)) {
			groups.add(group);
		}
	}

	public void removeGroup(SocialGroup group) {
		if (groups != null && !groups.contains(group)) {
			groups.remove(group);
		}
	}

	@Override
	public int hashCode() {
		return id;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", createdOn=" + createdOn
				+ ", email=" + email + ", lastUpdate=" + lastUpdate + ", enabled=" + enabled + ", role=" + role
				+ ", firstName=" + firstName + ", lastName=" + lastName + ", biography=" + biography + ", dateOfBirth="
				+ dateOfBirth + ", profileImageUrl=" + profileImageUrl + "]";
	}

}
