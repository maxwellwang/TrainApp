package com.cs336.pkg;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class StopsAt{
	private int stop_id;
	private int origin_station;
	private int destination_station;
	private String departure_datetime;
	private String arrival_datetime;
	private TrainSchedule ts;
	static Connection con;
	
	
	public StopsAt(TrainSchedule ts, int stop_id, int origin_station, int destination_station, String departure_datetime,
			String arrival_datetime) {
		super();
		this.ts = ts;
		this.stop_id = stop_id;
		this.origin_station = origin_station;
		this.destination_station = destination_station;
		this.departure_datetime = departure_datetime;
		this.arrival_datetime = arrival_datetime;
	}


	public int getStop_id() {
		return stop_id;
	}


	public void setStop_id(int stop_id) {
		this.stop_id = stop_id;
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


	static void getConnected() {
		con = new ApplicationDB().getConnection();
	}


	public TrainSchedule getTs() {
		return ts;
	}


	public void setTs(TrainSchedule ts) {
		this.ts = ts;
	}


	public static String getTime(String date) {
		String time = date.split(" ")[1];
		String[] times = time.split(":");
		if(times.length < 3) {
			return "Error";
		}
		boolean isAM = Integer.parseInt(times[0]) < 12;
		time = (isAM ? Integer.parseInt(times[0]) : Integer.parseInt(times[0]) - 12) + ":" + times[1] + (isAM ? "AM":"PM");
		return time;
	}
	
}
