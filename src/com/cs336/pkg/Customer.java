package com.cs336.pkg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.stream.Collectors;

public class Customer {
	static Connection con;
	static void getConnected() {
		con = new ApplicationDB().getConnection();
	}
	
	public static Response signup(String firstName, String lastName, String personType, String username, String email, String password, String confirmPassword) {
		try {
			firstName = firstName.trim();
			lastName = lastName.trim();
			personType = personType.trim();
			username = username.trim();
			email = email.trim();
			if(con == null) {
				con = new ApplicationDB().getConnection();
			}
			if(!password.equals(confirmPassword)) {
				return new Response("ERROR","Password and confirm password do not match!");
			} 
			ArrayList<String> valid_person_types = new ArrayList<>(Arrays.asList("Default", "Child", "Senior", "Disabled"));
			if(!valid_person_types.contains(personType)) {
				return new Response("ERROR","Invalid type; person type must be Default, Child, Senior, or Disabled!");
			} 
			ArrayList<String> fields = new ArrayList<>();
			if(firstName == "") fields.add("First Name");
			if(lastName == "") fields.add("Last Name");
			if(personType == "") fields.add("Person Type");
			if(username == "") fields.add("Username");
			if(email == "") fields.add("Email");
			if(password == "") fields.add("Password");
			if(confirmPassword == "") fields.add("Confirm Password");
			if(fields.size() > 0) return new Response("ERROR", fields.stream().map(Object::toString)
	                .collect(Collectors.joining(", ")) + " cannot be empty.");
			String select = "SELECT username FROM customer WHERE username='"+username+"'";
     		Statement stmt = con.createStatement();
			ResultSet results = stmt.executeQuery(select);
     		ArrayList<String> foundUsers = new ArrayList<String>();
     		while(results.next()){
     			foundUsers.add(results.getString("username"));
     		}
     		// check employee table for dupe
     		select = "select username from employee";
     		results = stmt.executeQuery(select);
     		ArrayList<String> employee_usernames = new ArrayList<String>();
     		while(results.next()){
     			employee_usernames.add(results.getString("username"));
     		}
     		if (employee_usernames.contains(username)) {
     			return new Response("ERROR","User already exists with the username");
     		}
     		if(foundUsers.size() > 0) {
     			return new Response("ERROR","User already exists with the username");
     		}else {
     			String sql = "INSERT INTO customer VALUES ('"+username+"','"+password+"','"+firstName+"','"+lastName+"','"+email+"','"+personType+"')";
     			Statement query = con.createStatement();
     			query.executeUpdate(sql);
     			return new Response("SUCCESS","Succeeded!");
     		}

		}catch(Exception e) {
			return new Response("ERROR", "Cannot connect to the server. "+e.toString());
		}
	}
	
	public static Response signin(String username, String password) {
		try {
			username = username.trim();
			if(con == null) {
				con = new ApplicationDB().getConnection();
			}
			if(password.equals("")) return new Response("ERROR", "Password cannot be empty");
			String sql = "SELECT email, password, username, person_type FROM customer WHERE username = '"+username+"'";
			Statement stmt = con.createStatement();
			ResultSet results = stmt.executeQuery(sql);
     		ArrayList<String> foundUsers = new ArrayList<String>();
     		ArrayList<String> person_types = new ArrayList<String>();
     		while(results.next()){
     			foundUsers.add(results.getString("password"));
     			person_types.add(results.getString("person_type"));
     		}
     		if(foundUsers.size() < 1) {
     			return new Response("ERROR","User not found.");
     		}
     		if(foundUsers.get(0).equals(password)) {
     			return new Response("SUCCESS", person_types.get(0)); // returns person type: Default, Child, Senior, Disabled
     		} else {
     			return new Response("ERROR", "Password does not match");
     		} 
		} catch(Exception e) {
			return new Response("ERROR", "Cannot connect to the server. "+e.toString());
		} 
	}
		
}
