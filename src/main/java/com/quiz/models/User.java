package com.quiz.models;

// User.java
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User implements UserDetails{
    @Id
    private String userId; // Prefixed UUID with 56 char length
    @Column(name="username")
    private String name;
    private String email;
    private String passwordHash;
    private String role;
    
    @Column(name = "created_at")
    @CreationTimestamp
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    @UpdateTimestamp
    private LocalDateTime updatedAt;
    
    @OneToMany(mappedBy = "user")
    private List<CourseEnrollment> enrollments = new ArrayList<>();
    
    @OneToMany(mappedBy = "user")
    private List<QuizSubmission> submissions = new ArrayList<>();
    
    @OneToMany(mappedBy = "user")
    private List<Achievement> achievements = new ArrayList<>();
    
    @OneToMany(mappedBy = "user")
    private List<CourseAccessLog> accessLogs = new ArrayList<>();
    
    @OneToMany(mappedBy = "user")
    private List<AdminAccessLog> adminLogs = new ArrayList<>();
    
    @OneToMany(mappedBy = "user")
    private List<UserModuleProgress> moduleProgresses = new ArrayList<>();
    
    @OneToMany(mappedBy = "user")
    private List<CourseProgressSummary> progressSummaries = new ArrayList<>();

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return List.of(new SimpleGrantedAuthority("ROLE_" + role));
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return passwordHash;
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return email;
	}
}