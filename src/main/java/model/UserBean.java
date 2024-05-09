package model;

import java.io.Serializable;

public class UserBean implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String username;
	private String email;
	private String password;
	private String name;
	private String address;
	private String role;
	
	
	public String toString() {
		return "[" + username + ", " + email + ", " + name + ", " + address + "]";
	}


	public String getUsername() {
		return username;
	}


	public void setUsername(String username) {
		this.username = username;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}
	
	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getRole() {
		return role;
	}


	public void setRole(String role) {
		this.role = role;
	}
	
}
