package com.cs336.pkg;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.time.LocalDate;

public class TrainSchedule {
	private String train_line_name;
	private int num_stops;
	private int travel_time;
	private int origin_station;
	private int destination_station;
	private String tid;
	private float fare;
	static Connection con;
	
	public TrainSchedule(String train_line_name, int num_stops, int travel_time, int origin_station,
			int destination_station, float fare, String tid) {
		super();
		train_line_name = train_line_name.trim();
		this.train_line_name = train_line_name;
		this.num_stops = num_stops;
		this.travel_time = travel_time;
		this.origin_station = origin_station;
		this.destination_station = destination_station;
		this.fare = fare;
		this.tid = tid;
	}
	public String getTrain_line_name() {
		return train_line_name;
	}
	public void setTrain_line_name(String train_line_name) {
		this.train_line_name = train_line_name;
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
	public float getFare() {
		return fare;
	}
	public void setFare(float fare) {
		this.fare = fare;
	}
	
	
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public static ArrayList<StopsAt> getSchedules(String origin, String dest, String date, int sortby) {
		try {
			if (con == null) {
				con = new ApplicationDB().getConnection();
			}
			ArrayList<Station> stations = Station.getStations();
			
			int origin_id = 0;
			int dest_id = 0;
			
			for(Station station : stations) {
				if(station.getStationName().equalsIgnoreCase(origin)) {
					origin_id = station.getId();
				}
				if(station.getStationName().equalsIgnoreCase(dest)) {
					dest_id = station.getId();
				}
			}
			String select;
			Statement stmt = con.createStatement();
			ResultSet results;
			
			String[] dates = date.split("-");
			LocalDate start_time = LocalDate.of(Integer.parseInt(dates[0]), Integer.parseInt(dates[1]), Integer.parseInt(dates[2]));
			LocalDate end_time = start_time.plusDays(1);
			select = "select * from stops_at sa, schedule s where sa.stop_id = s.stop_id AND sa.origin_station = "+origin_id +" AND sa.destination_station = "+dest_id
					+" AND departure_datetime >= '" + start_time.toString().replaceAll("-", "")
					 +"' AND departure_datetime < '"+ end_time.toString().replaceAll("-", "") +"'";
			stmt = con.createStatement();
			results = stmt.executeQuery(select);
			
			ArrayList<StopsAt> stops_at = new ArrayList<>();
			while (results.next()) {
				stops_at.add(new StopsAt(
						new TrainSchedule(results.getString("transit_line_name"),results.getInt("num_stops"),results.getInt("travel_time"),
								results.getInt("origin_station"),results.getInt("destination_station"),results.getFloat("fare"), results.getString("tid")),
						results.getInt("stop_id"),
						results.getInt("origin_station"),
						results.getInt("destination_station"),
						results.getString("departure_datetime"),
						results.getString("arrival_datetime")
						)
					);
			}
			if(stops_at.size() < 1) {
				return stops_at;
			}
			
			if(sortby == 0) {				
				stops_at.sort((a,b)->a.getArrival_datetime().compareTo(b.getArrival_datetime()));
			}else if(sortby == 1) {
				stops_at.sort((a,b)->a.getDeparture_datetime().compareTo(b.getDeparture_datetime()));
			}else {
				stops_at.sort((a,b)->Float.compare(a.getTs().getFare() , b.getTs().getFare()));
			}
			
			return stops_at;
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<StopsAt>();
		}
	}
}
