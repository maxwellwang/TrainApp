package com.cs336.pkg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.stream.Collectors;

public class FAQ {
	static int nextID = (int) (System.currentTimeMillis()/10 % (2 << 30));
	static Connection con;
	static void getConnected() {
		con = new ApplicationDB().getConnection();
	}
	
	public static ArrayList<String> getCustomers(String s, String date) {
		try {
			if(con == null) {
				con = new ApplicationDB().getConnection();
			}
			s = s == null ? "" : s;
			//select * from customer where username in (select username from reservation where reservation_date = "2020-12-16" and transit_line_name = "pascack valley line" group by username)
			String select = "select * from customer where username in (select username from reservation where reservation_date = \"" + date +"\" and transit_line_name = \"" + s + "\" group by username)";
			System.out.println(select);
     		Statement stmt = con.createStatement();
			ResultSet results = stmt.executeQuery(select);
     		ArrayList<String> cust = new ArrayList<String>();
     		while(results.next()){
     			cust.add(results.getString("first_name") + " " + results.getString("last_name"));
     		}
 			return cust;
		}catch(Exception e) {
			System.out.println("OOF");
			System.out.println(e.getStackTrace());
			return null;
		}
	}
	
	public static HashMap<Integer, String[]> getFAQ(String s) {
		try {
			if(con == null) {
				con = new ApplicationDB().getConnection();
			}
			s = s == null ? "" : s;
			String select = "SELECT * FROM faq WHERE question LIKE \"%" + s + "%\" OR answer LIKE \"%" + s + "%\"";
     		Statement stmt = con.createStatement();
			ResultSet results = stmt.executeQuery(select);
     		HashMap<Integer, String[]> map = new HashMap<>();
     		while(results.next()){
     			map.put(results.getInt("idfaq"), new String[]{results.getString("question"), results.getString("answer")});
     		}
 			return map;
		}catch(Exception e) {
			System.out.println(e.getStackTrace());
			return null;
		}
	}
	
	public static Response addQuestion(String question) {
		try {
			if(con == null) {
				con = new ApplicationDB().getConnection();
			}
			String sql = "INSERT INTO faq(idfaq, question, answer) VALUES (" + nextID++ + ", \"" + question + "\", \"\")";
			Statement stmt = con.createStatement();
			int results = stmt.executeUpdate(sql);
 			return new Response("SUCCESS","Succeeded!");
		} catch(Exception e) {
			return new Response("ERROR", "Cannot connect to the server. "+e.toString());
		} 
	}
	
	public static Response addAnswer(String answer, int id) {
		try {
			if(con == null) {
				con = new ApplicationDB().getConnection();
			}
			String sql = "UPDATE faq SET answer = \"" + answer + "\" where idfaq = " + id;
			Statement stmt = con.createStatement();
			int results = stmt.executeUpdate(sql);
 			return new Response("SUCCESS","Succeeded!");
		} catch(Exception e) {
			return new Response("ERROR", "Cannot connect to the server. "+e.toString());
		} 
	}
	
	public static void updateSched(String tln, String tid, String sid, String tln2, String tid2, String sid2) {
		try {
			if(con == null) {
				con = new ApplicationDB().getConnection();
			}
			if (tln2.length() == 0 && tid2.length() == 0 && sid2.length() == 0) {
				// Delete
				//delete from schedule where tid=1112 and stop_id=1101 and transit_line_name="Pascack Valley Line";
				String sql = "delete from schedule where tid=" + tid + " and stop_id=" + sid +"  and transit_line_name=\"" + tln + "\"";
				Statement stmt = con.createStatement();
				int results = stmt.executeUpdate(sql);
				
			} else {
				// update update schedule set tid=1112, transit_line_name="Pascack Valley Line2" where tid=1111 and stop_id=1101 and transit_line_name="Pascack Valley Line";

				String sql = "update schedule set tid=" + tid2 + ", transit_line_name=\"" + tln2 + "\" where tid=" + tid + " and stop_id=" + sid +"  and transit_line_name=\"" + tln + "\"";
				System.out.println(sql);
				Statement stmt = con.createStatement();
				int results = stmt.executeUpdate(sql);
			}
		} catch(Exception e) {
			return;
		} 

	}
	
		
}
