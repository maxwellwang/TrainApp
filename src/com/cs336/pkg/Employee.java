package com.cs336.pkg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.stream.Collectors;

public class Employee {
	static Connection con;
	static void getConnected() {
		con = new ApplicationDB().getConnection();
	}
	
	public static Response do_action(String firstName, String lastName, String ssn, String username, String password, String action) {
		try {
			firstName = firstName.trim();
			lastName = lastName.trim();
			ssn = ssn.trim();
			username = username.trim();
			action = action.trim();
			ArrayList<String> valid_actions = new ArrayList<>(Arrays.asList("add", "edit", "delete"));
			if (!valid_actions.contains(action)) {
				return new Response("ERROR","Action must be add, edit, or delete");
			}
			if(con == null) {
				con = new ApplicationDB().getConnection();
			}
			if (action.equals("add")) {
				ArrayList<String> fields = new ArrayList<>();
				if(firstName == "") fields.add("First Name");
				if(lastName == "") fields.add("Last Name");
				if(ssn == "") fields.add("SSN");
				if(username == "") fields.add("Username");
				if(password == "") fields.add("Password");
				if(action == "") fields.add("Action");
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
	     		select = "select username, ssn from employee";
	     		results = stmt.executeQuery(select);
	     		ArrayList<String> employee_usernames = new ArrayList<String>();
	     		while(results.next()){
	     			if (results.getString("ssn").equals(ssn)) {
	     				// should not match existing ssn, throw error
		     			return new Response("ERROR","User already exists with the ssn");
	     			}
	     			employee_usernames.add(results.getString("username"));
	     		}
	     		if (employee_usernames.contains(username)) {
	     			return new Response("ERROR","User already exists with the username");
	     		}
	     		if(foundUsers.size() > 0) {
	     			return new Response("ERROR","User already exists with the username");
	     		}else {
	     			String sql = "INSERT INTO employee VALUES ('"+ssn+"','"+username+"','"+password+"','"+firstName+"','"+lastName+"','customer_rep')";
	     			Statement query = con.createStatement();
	     			query.executeUpdate(sql);
	     			return new Response("SUCCESS","Successful add");
	     		}
			} else if (action.equals("edit")) {
				ArrayList<String> fields = new ArrayList<>();
				if(firstName == "") fields.add("First Name");
				if(lastName == "") fields.add("Last Name");
				if(ssn == "") fields.add("SSN");
				if(username == "") fields.add("Username");
				if(password == "") fields.add("Password");
				if(action == "") fields.add("Action");
				if(fields.size() > 0) return new Response("ERROR", fields.stream().map(Object::toString)
		                .collect(Collectors.joining(", ")) + " cannot be empty.");
				ArrayList<String> usernames = new ArrayList<String>();
				String select = "select username, ssn, account_type from employee";
				Statement stmt = con.createStatement();
				ResultSet results = stmt.executeQuery(select);
				while (results.next()) {
	     			usernames.add(results.getString("username"));
	     			if (results.getString("username").equals(username) && results.getString("account_type").equals("admin")) {
		     			return new Response("ERROR","Cannot edit admin account");
	     			}
	     			if (results.getString("ssn").equals(ssn) && !results.getString("username").equals(username)) {
		     			return new Response("ERROR","User already exists with the ssn");
	     			}
	     			
				}
				if (!usernames.contains(username)) {
					return new Response("ERROR","Username not found in employee table");
				}
				String update = "UPDATE employee set ssn='"+ssn+"', password='"+password+"', first_name='"+firstName+"', last_name='"+lastName+"' where username='"+username+"'";
				stmt.executeUpdate(update);
				return new Response("SUCCESS", "Successful edit");
			} else { // delete
				ArrayList<String> usernames = new ArrayList<String>();
				String select = "select username, account_type from employee";
				Statement stmt = con.createStatement();
				ResultSet results = stmt.executeQuery(select);
				while (results.next()) {
	     			usernames.add(results.getString("username"));
	     			if (results.getString("username").equals(username) && results.getString("account_type").equals("admin")) {
		     			return new Response("ERROR","Cannot delete admin account");
	     			}
				}
				if (!usernames.contains(username)) {
					return new Response("ERROR","Username not found in employee table");
				}
				String delete = "delete from employee where username='"+username+"'";
				stmt.executeUpdate(delete);
				return new Response("SUCCESS", "Successful deletion");
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
			String sql = "SELECT password, username, account_type FROM employee WHERE username = '"+username+"'";
			Statement stmt = con.createStatement();
			ResultSet results = stmt.executeQuery(sql);
     		ArrayList<String> foundUsers = new ArrayList<String>();
     		ArrayList<String> account_types = new ArrayList<String>();
     		while(results.next()){
     			foundUsers.add(results.getString("password"));
     			account_types.add(results.getString("account_type"));
     		}
     		if(foundUsers.size() < 1) {
     			return new Response("ERROR","User not found.");
     		}
     		if(foundUsers.get(0).equals(password)) {
     			return new Response("SUCCESS", account_types.get(0)); // return account_type: admin or customer_rep
     		} else {
     			return new Response("ERROR", "Password does not match");
     		} 
		} catch(Exception e) {
			return new Response("ERROR", "Cannot connect to the server. "+e.toString());
		} 
	}
		
}
