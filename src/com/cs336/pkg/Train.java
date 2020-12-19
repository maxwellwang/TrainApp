package com.cs336.pkg;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class Train {
	private String tid;
	private int stop_id;
	private String transit_line_name;
	private int num_stops;
	private int travel_time;
	private float fare;
	private int origin_station;
	private int destination_station;
	private String departure_datetime;
	private String arrival_datetime;
	
	static Connection con;
	static void getConnected() {
		con = new ApplicationDB().getConnection();
	}
	
	public Train(String tid, int stop_id, String transit_line_name, int num_stops, int travel_time, float fare, int origin_station,
			int destination_station, String departure_datetime, String arrival_datetime) {
		super();
		transit_line_name = transit_line_name.trim();
		this.tid = tid;
		this.stop_id = stop_id;
		this.transit_line_name = transit_line_name;
		this.num_stops = num_stops;
		this.travel_time = travel_time;
		this.fare = fare;
		this.origin_station = origin_station;
		this.destination_station = destination_station;
		this.departure_datetime = departure_datetime;
		this.arrival_datetime = arrival_datetime;
	}
	
	public static ArrayList<Train> getStopsByTrainId(String id){
		try {
			if (con == null) {
				con = new ApplicationDB().getConnection();
			}
			String select = "select distinct * from schedule s, stops_at sa where tid = '"+ id +"' AND s.stop_id = sa.stop_id group by s.stop_id";
			
			ArrayList<Train> trains = new ArrayList<>();

			Statement query = con.createStatement();

			ResultSet results = query.executeQuery(select);
			while (results.next()) {
				trains.add(new Train(
						results.getString("tid"), 
						results.getInt("stop_id"), 
						results.getString("transit_line_name"), 
						results.getInt("num_stops"), 
						results.getInt("travel_time"),
						results.getFloat("fare"),
						results.getInt("origin_station"),
						results.getInt("destination_station"),
						results.getString("departure_datetime"),
						results.getString("arrival_datetime")));
			}
			return trains;
		} catch (Exception e) {
			System.out.println(e.toString());
			return new ArrayList<Train>();
		}
	}

	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public int getStop_id() {
		return stop_id;
	}

	public void setStop_id(int stop_id) {
		this.stop_id = stop_id;
	}

	public String getTransit_line_name() {
		return transit_line_name;
	}

	public void setTransit_line_name(String transit_line_name) {
		this.transit_line_name = transit_line_name;
	}

	public int getNum_stops() {
		return num_stops;
	}

	public void setNum_stops(int num_stops) {
		this.num_stops = num_stops;
	}

	public int getTravel_time() {
		return travel_time;
	}

	public void setTravel_time(int travel_time) {
		this.travel_time = travel_time;
	}

	public float getFare() {
		return fare;
	}

	public void setFare(float fare) {
		this.fare = fare;
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
}
