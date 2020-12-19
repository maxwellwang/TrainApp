package com.cs336.pkg;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class Station {
	private int id;
	private String stationName;
	private String city;
	private String state;
	static Connection con;

	public Station(int id, String stationName, String city, String state) {
		super();
		this.id = id;
		this.stationName = stationName;
		this.city = city;
		this.state = state;
	}
	
	
	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getStationName() {
		return stationName;
	}


	public void setStationName(String stationName) {
		this.stationName = stationName;
	}


	public String getCity() {
		return city;
	}


	public void setCity(String city) {
		this.city = city;
	}


	public String getState() {
		return state;
	}


	public void setState(String state) {
		this.state = state;
	}


	static void getConnected() {
		con = new ApplicationDB().getConnection();
	}
	

	public static ArrayList<Station> getStations() {
		try {
			if (con == null) {
				con = new ApplicationDB().getConnection();
			}
			ArrayList<Station> list = new ArrayList<>();
			String select = "SELECT * FROM station";
			Statement stmt = con.createStatement();
			ResultSet results = stmt.executeQuery(select);
			while (results.next()) {
				list.add(new Station(Integer.parseInt(results.getString("sid")), 
						results.getString("name").substring(0,1).toUpperCase() + results.getString("name").substring(1), 
						results.getString("city"),
						results.getString("state")));
			}
			return list;
		} catch (Exception e) {
			return new ArrayList<Station>();
		}
	}
	
	public static Station findStationById(ArrayList<Station> stations, int id) {
		Station station = new Station(0,"","","");
		for(int i = 0 ; i < stations.size(); i++) {
			if(stations.get(i).getId() == id) {
				station = stations.get(i);
			}
		}
		
		return station;
	}
	
	public static ArrayList<Train> findStationByNameAndOrigin(String name, String type) {
		try {
			if (con == null) {
				con = new ApplicationDB().getConnection();
			}
			ArrayList<Station> stations = getStations();
			Station s = null;
			for(Station station : stations) {
				if(station.getStationName().equalsIgnoreCase(name)) {
					s = station;
				}
			}
			String select = "select distinct * from schedule s, stops_at sa where "
							+(type.equals("origin")?"origin_station=":"destination_station=")
							+ s.getId()
							+" AND s.stop_id = sa.stop_id group by s.stop_id";
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
		}catch(Exception e) {
			return new ArrayList<Train>();
		}
	}
}
