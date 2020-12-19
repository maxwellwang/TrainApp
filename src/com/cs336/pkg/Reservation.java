package com.cs336.pkg;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;

public class Reservation {
	private int reservation_number;
	private int origin_station;
	private int destination_station;
	private String reservation_date;
	private float total_fare;
	private String departure_datetime;
	private String arrival_datetime;
	private String one_way_or_round_trip;
	private int tid;
	private String transit_line_name;
	private String username;
	static Connection con;

	public Reservation(int reservation_number, int origin_station, int destination_station, String reservation_date,
			float total_fare, String departure_datetime, String arrival_datetime, String one_way_or_round_trip, int tid,
			String transit_line_name, String username) {
		super();
		this.reservation_number = reservation_number;
		this.origin_station = origin_station;
		this.destination_station = destination_station;
		this.reservation_date = reservation_date;
		this.total_fare = total_fare;
		this.departure_datetime = departure_datetime;
		this.arrival_datetime = arrival_datetime;
		this.one_way_or_round_trip = one_way_or_round_trip;
		this.tid = tid;
		this.transit_line_name = transit_line_name;
		this.username = username;
	}

	public int getReservation_number() {
		return reservation_number;
	}

	public void setReservation_number(int reservation_number) {
		this.reservation_number = reservation_number;
	}

	public int getOrigin_station() {
		return origin_station;
	}

	public void setOrigin_station(int origin_station) {
		this.origin_station = origin_station;
	}

	public int getDestination_station() {
		return destination_station;
	}

	public void setDestination_station(int destination_station) {
		this.destination_station = destination_station;
	}

	public String getReservation_date() {
		return reservation_date;
	}

	public void setReservation_date(String reservation_date) {
		this.reservation_date = reservation_date;
	}

	public float getTotal_fare() {
		return total_fare;
	}

	public void setTotal_fare(float total_fare) {
		this.total_fare = total_fare;
	}

	public String getDeparture_datetime() {
		return departure_datetime;
	}

	public void setDeparture_datetime(String departure_datetime) {
		this.departure_datetime = departure_datetime;
	}

	public String getArrival_datetime() {
		return arrival_datetime;
	}

	public void setArrival_datetime(String arrival_datetime) {
		this.arrival_datetime = arrival_datetime;
	}

	public String getOne_way_or_round_trip() {
		return one_way_or_round_trip;
	}

	public void setOne_way_or_round_trip(String one_way_or_round_trip) {
		this.one_way_or_round_trip = one_way_or_round_trip;
	}

	public int getTid() {
		return tid;
	}

	public void setTid(int tid) {
		this.tid = tid;
	}

	public String getTransit_line_name() {
		return transit_line_name;
	}

	public void setTransit_line_name(String transit_line_name) {
		this.transit_line_name = transit_line_name;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	static void getConnected() {
		con = new ApplicationDB().getConnection();
	}

	public static ArrayList<Reservation> registerTicket(String username, String total_fare, String origin_station,
			String destination_station, String departure_datetime, String arrival_datetime, String tid,
			String transit_line_name, String one_way_or_round_trip) {
		username = username.trim();
		transit_line_name = transit_line_name.trim();
		try {
			if (con == null) {
				con = new ApplicationDB().getConnection();
			}
			String random_id = String.valueOf((int) (Math.random() * 100000));
			LocalDateTime now = LocalDateTime.now();
			String sql = "INSERT INTO reservation VALUES ('" + random_id + "','" + origin_station + "','"
					+ destination_station + "','" + getDateToString(now) + "'," + total_fare + ",'" + departure_datetime
					+ "','" + arrival_datetime + "','" + one_way_or_round_trip + "'," + tid + ",'" + transit_line_name
					+ "','" + username + "')";
			Statement query = con.createStatement();
			query.executeUpdate(sql);
			String select = "SELECT * FROM reservation WHERE username='" + username + "'";
			ResultSet results = query.executeQuery(select);
			ArrayList<Reservation> reservations = new ArrayList<>();
			while (results.next()) {
				reservations.add(new Reservation(results.getInt("reservation_number"),
						Integer.parseInt(results.getString("origin_station")),
						Integer.parseInt(results.getString("destination_station")),
						results.getString("reservation_date"), results.getFloat("total_fare"),
						results.getString("departure_datetime"), results.getString("arrival_datetime"),
						results.getString("one_way_or_round_trip"), results.getInt("tid"),
						results.getString("transit_line_name"), results.getString("username")));
			}
			return reservations;
		} catch (Exception e) {
			return new ArrayList<Reservation>();
		}
	}

	public static String getDateToString(LocalDateTime date) {
		return date.getYear() + "-" + date.getMonthValue() + "-" + date.getDayOfMonth();
	}

	public static ArrayList<Double> get_monthly_fares() {
		try {
			if (con == null) {
				con = new ApplicationDB().getConnection();
			}
			String select = "SELECT reservation_date, total_fare FROM reservation";
			Statement stmt = con.createStatement();
			ResultSet results = stmt.executeQuery(select);
			ArrayList<Double> monthly_fares = new ArrayList<Double>(12);
			for (int i = 0; i < 12; i++)
				monthly_fares.add(0.0);
			while (results.next()) {
				// for each reservation, add fare to correct month spot
				String date_string = results.getString("reservation_date");
				int month = Integer.parseInt(date_string.substring(5, 7)); // 1 to 12
				double fare = results.getDouble("total_fare");
				monthly_fares.set(month - 1, fare + monthly_fares.get(month - 1));
			}
			return monthly_fares;
		} catch (Exception e) {
			System.out.println(e.toString());
			return new ArrayList<Double>();
		}
	}

	public static ArrayList<Reservation> search_TLN(String tln) {
		try {
			tln = tln.trim();
			if (con == null) {
				con = new ApplicationDB().getConnection();
			}
			String select = "SELECT * FROM reservation WHERE transit_line_name='" + tln + "'";
			Statement stmt = con.createStatement();
			ResultSet results = stmt.executeQuery(select);
			ArrayList<Reservation> reservations = new ArrayList<Reservation>();
			while (results.next()) {
				// for each reservation, get all info and append to arraylist
				Reservation r = new Reservation(results.getInt("reservation_number"), results.getInt("origin_station"),
						results.getInt("destination_station"), results.getString("reservation_date"),
						results.getFloat("total_fare"), results.getString("departure_datetime"),
						results.getString("arrival_datetime"), results.getString("one_way_or_round_trip"),
						results.getInt("tid"), results.getString("transit_line_name"), results.getString("username"));
				reservations.add(r);
			}
			return reservations;
		} catch (Exception e) {
			System.out.println(e.toString());
			return new ArrayList<Reservation>();
		}
	}

	public static ArrayList<Reservation> searchCU(String cu) {
		try {
			cu = cu.trim();
			if (con == null) {
				con = new ApplicationDB().getConnection();
			}
			String select = "SELECT * FROM reservation WHERE username='" + cu + "'";
			Statement stmt = con.createStatement();
			ResultSet results = stmt.executeQuery(select);
			ArrayList<Reservation> reservations = new ArrayList<Reservation>();
			while (results.next()) {
				// for each reservation, get all info and append to arraylist
				Reservation r = new Reservation(results.getInt("reservation_number"), results.getInt("origin_station"),
						results.getInt("destination_station"), results.getString("reservation_date"),
						results.getFloat("total_fare"), results.getString("departure_datetime"),
						results.getString("arrival_datetime"), results.getString("one_way_or_round_trip"),
						results.getInt("tid"), results.getString("transit_line_name"), results.getString("username"));
				reservations.add(r);
			}
			return reservations;
		} catch (Exception e) {
			System.out.println(e.toString());
			return new ArrayList<Reservation>();
		}
	}
	
	public static class CustomerResult {
		public String username;
		public String max;
	}
	
	public static CustomerResult get_best_customer() {
		try {
			if (con == null) {
				con = new ApplicationDB().getConnection();
			}
			String select = "SELECT username, sum(total_fare) revenue FROM reservation GROUP BY username";
	 		Statement stmt = con.createStatement();
			ResultSet results = stmt.executeQuery(select);
			String username = "";
			double revenue = 0;
			while (results.next()) {
				double current = results.getDouble("revenue");
				if (current > revenue) {
					username = results.getString("username");
					revenue = current;
				}
			}
			CustomerResult temp = new CustomerResult();
			temp.username = username;
			temp.max = Double.toString(revenue);
			return temp;
		} catch (Exception e) {
			System.out.println(e.toString());
			return new CustomerResult();
		}
	}

	public static ArrayList<Reservation> getTickets(String username) {
		try {
			username = username.trim();
			if (con == null) {
				con = new ApplicationDB().getConnection();
			}
			Statement query = con.createStatement();
			String select = "SELECT * FROM reservation WHERE username='" + username + "'";
			ResultSet results = query.executeQuery(select);
			ArrayList<Reservation> reservations = new ArrayList<>();
			while (results.next()) {
						reservations.add(new Reservation(results.getInt("reservation_number"),
						Integer.parseInt(results.getString("origin_station")),
						Integer.parseInt(results.getString("destination_station")),
						results.getString("reservation_date"), results.getFloat("total_fare"),
						results.getString("departure_datetime"), results.getString("arrival_datetime"),
						results.getString("one_way_or_round_trip"), results.getInt("tid"),
						results.getString("transit_line_name"), results.getString("username")));
			}
			return reservations;
		} catch (Exception e) {
			return new ArrayList<Reservation>();
		}
	}
	
	public static float calculatePrice(String price, String person_type, String is_roundtrip) {
		person_type = person_type.trim();
		
		float p = Float.parseFloat(price);
		switch(person_type) {
			case "Child":
				return (float) (p * (is_roundtrip.equals("round_trip") ? 2 : 1) * 0.75);
			case "Senior":
				return (float) (p * (is_roundtrip.equals("round_trip") ? 2 : 1) * 0.65);
			case "Disabled":
				return (float) (p * (is_roundtrip.equals("round_trip") ? 2 : 1) * 0.5);
			default:			
				return  p * (is_roundtrip.equals("round_trip") ? 2 : 1);
		}
	}	
		
	public static int min_index(ArrayList<Double> counts) {
		int ret = 0;
		for (int i = 0; i < counts.size(); i++) {
			if (counts.get(i) < counts.get(ret)) {
				ret = i;
			}
		}
		return ret;
	}
	
	public static int max_index(ArrayList<Double> counts) {
		int ret = 0;
		for (int i = 0; i < counts.size(); i++) {
			if (counts.get(i) > counts.get(ret)) {
				ret = i;
			}
		}
		return ret;
	}
	
	public static int min_index_ints(ArrayList<Integer> counts) {
		int ret = 0;
		for (int i = 0; i < counts.size(); i++) {
			if (counts.get(i) < counts.get(ret)) {
				ret = i;
			}
		}
		return ret;
	}
	
	public static int max_index_ints(ArrayList<Integer> counts) {
		int ret = 0;
		for (int i = 0; i < counts.size(); i++) {
			if (counts.get(i) > counts.get(ret)) {
				ret = i;
			}
		}
		return ret;
	}
	
	public static class Top5Result {
		public ArrayList<String> top5;
		public ArrayList<Double> counts;
	}
	
	public static Top5Result get_top5() {
		try {
			if (con == null) {
				con = new ApplicationDB().getConnection();
			}
			Statement query = con.createStatement();
			// get average reservations per month
			String select = "SELECT distinct transit_line_name FROM trains.reservation;";
			ResultSet results = query.executeQuery(select);
			HashMap<String, ArrayList<Integer>> map = new HashMap<String, ArrayList<Integer>>();
			while (results.next()) {
				map.put(results.getString("transit_line_name"), new ArrayList<Integer>(12));
			}
			for (ArrayList<Integer> values : map.values()) {
				for (int i = 0; i < 12; i++) {
					values.add(0);
				}
			}

			select = "select transit_line_name, reservation_date from trains.reservation";
			results = query.executeQuery(select);
			while(results.next()) {
				int month = Integer.parseInt(results.getString("reservation_date").substring(5, 7)); // 1 to 12
				String tln = results.getString("transit_line_name");
				map.get(tln).set(month-1, 1 + map.get(tln).get(month-1)); // add 1 reservation to that line's count for that month
			}
			ArrayList<String> top5candidates = new ArrayList<String>();
			top5candidates.addAll(map.keySet());
			ArrayList<Double> counts = new ArrayList<Double>();
			for (String tln : map.keySet()) {
				ArrayList<Integer> values = map.get(tln);
				double sum = 0;
				for (int i = 0; i < values.size(); i++) {
					sum += values.get(i);
				}
				double average = sum / values.size();
				counts.add(average);
			}
			
			// remove from top5 until there's only 5 or less
			while (top5candidates.size() > 5) {
				int min_index = min_index(counts);
				counts.remove(min_index);
				top5candidates.remove(min_index);		
			}
			// sort top5 candidates
			ArrayList<Double> temp_counts = new ArrayList<Double>();
			temp_counts.addAll(counts);
			counts = new ArrayList<Double>();
			ArrayList<String> top5 = new ArrayList<String>();
			while (!top5candidates.isEmpty()) {
				int max_index = max_index(temp_counts);
				counts.add(temp_counts.remove(max_index));
				top5.add(top5candidates.remove(max_index));
			}
			Top5Result t = new Top5Result();
			t.top5 = top5;
			t.counts = counts;
			return t;
		} catch (Exception e) {
			System.out.println(e.toString());
			return new Top5Result();
		}
	}
	
	public static class Top5ByMonthResult {
		public ArrayList<String> top5;
		public ArrayList<Integer> counts;
	}
	
	public static Top5ByMonthResult get_top5_by_month(int month_for) {
		try {
			if (con == null) {
				con = new ApplicationDB().getConnection();
			}
			Statement query = con.createStatement();
			// get average reservations per month
			String select = "SELECT distinct transit_line_name FROM trains.reservation;";
			ResultSet results = query.executeQuery(select);
			HashMap<String, ArrayList<Integer>> map = new HashMap<String, ArrayList<Integer>>();
			while (results.next()) {
				map.put(results.getString("transit_line_name"), new ArrayList<Integer>(12));
			}
			for (ArrayList<Integer> values : map.values()) {
				for (int i = 0; i < 12; i++) {
					values.add(0);
				}
			}

			select = "select transit_line_name, reservation_date from trains.reservation";
			results = query.executeQuery(select);
			while(results.next()) {
				int month = Integer.parseInt(results.getString("reservation_date").substring(5, 7)); // 1 to 12
				String tln = results.getString("transit_line_name");
				map.get(tln).set(month-1, 1 + map.get(tln).get(month-1)); // add 1 reservation to that line's count for that month
			}
			ArrayList<String> top5candidates = new ArrayList<String>();
			top5candidates.addAll(map.keySet());
			ArrayList<Integer> counts = new ArrayList<Integer>();
			for (String tln : map.keySet()) {
				ArrayList<Integer> values = map.get(tln);
				counts.add(values.get(month_for - 1));
			}
			
			// remove from top5 until there's only 5 or less
			while (top5candidates.size() > 5) {
				int min_index = min_index_ints(counts);
				counts.remove(min_index);
				top5candidates.remove(min_index);		
			}
			// sort top5 candidates
			ArrayList<Integer> temp_counts = new ArrayList<Integer>();
			temp_counts.addAll(counts);
			counts = new ArrayList<Integer>();
			ArrayList<String> top5 = new ArrayList<String>();
			while (!top5candidates.isEmpty()) {
				int max_index = max_index_ints(temp_counts);
				counts.add(temp_counts.remove(max_index));
				top5.add(top5candidates.remove(max_index));
			}
			Top5ByMonthResult t = new Top5ByMonthResult();
			t.top5 = top5;
			t.counts = counts;
			return t;
		} catch (Exception e) {
			System.out.println(e.toString());
			return new Top5ByMonthResult();
		}
	}
	
	public static ArrayList<Reservation> deleteById(String id, String username){
		try {
			id = id.trim();
			username = username.trim();
			if (con == null) {
				con = new ApplicationDB().getConnection();
			}
			String sql = "DELETE FROM reservation WHERE reservation_number = '"+id+"'";
			Statement query = con.createStatement();
			query.executeUpdate(sql);

			String select = "SELECT * FROM reservation WHERE username='" + username + "'";
			ResultSet results = query.executeQuery(select);
			ArrayList<Reservation> reservations = new ArrayList<>();
			while (results.next()) {
				reservations.add(new Reservation(results.getInt("reservation_number"),
						Integer.parseInt(results.getString("origin_station")),
						Integer.parseInt(results.getString("destination_station")),
						results.getString("reservation_date"), results.getFloat("total_fare"),
						results.getString("departure_datetime"), results.getString("arrival_datetime"),
						results.getString("one_way_or_round_trip"), results.getInt("tid"),
						results.getString("transit_line_name"), results.getString("username")));
			}
			return reservations;
		} catch (Exception e) {
			System.out.println(e.toString());
			return new ArrayList<Reservation>();
		}
	}
	
	public static ArrayList<String> getTransitLineNames() {
		try {
			if (con == null) {
				con = new ApplicationDB().getConnection();
			}
			String sql = "select distinct transit_line_name from reservation";
			Statement query = con.createStatement();
			query.executeQuery(sql);
			ResultSet results = query.executeQuery(sql);
			ArrayList<String> transit_line_names = new ArrayList<>();
			while (results.next()) {
				transit_line_names.add(results.getString("transit_line_name"));
			}
			return transit_line_names;
		} catch (Exception e) {
			System.out.println(e.toString());
			return new ArrayList<String>();
		}
	}
	
	public static ArrayList<String> getCustomerUsernames() {
		try {
			if (con == null) {
				con = new ApplicationDB().getConnection();
			}
			String sql = "select distinct username from reservation";
			Statement query = con.createStatement();
			query.executeQuery(sql);
			ResultSet results = query.executeQuery(sql);
			ArrayList<String> usernames = new ArrayList<>();
			while (results.next()) {
				usernames.add(results.getString("username"));
			}
			return usernames;
		} catch (Exception e) {
			System.out.println(e.toString());
			return new ArrayList<String>();
		}
	}
}
