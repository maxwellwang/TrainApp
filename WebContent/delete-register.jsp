<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.util.stream.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%! ArrayList<Reservation> reservations; %>
<%! ArrayList<Station> stations; %>
<%!ArrayList<Reservation> past_reservations;%>
<%!ArrayList<Reservation> future_reservations;%>
<%! int i; %>
<%! int j; %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css"/>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.js"></script>
		<title>LXPress</title>	
		<style>
			main{
				padding: 30px 0;
			}
		</style>
	</head>
<body>
	<div class="ui menu fixed">
	  <a class="item" href="index.jsp">Home</a>
	  <a class="item" href="schedule.jsp">Schedule</a>
	  <% if (session.getAttribute("username") != null) {%>
	  	<a class="item" href="register.jsp">Tickets</a>
	  <% } %>
	  <a class="item" href="train.jsp">Train</a>
	  <a class="item" href="station.jsp">Station</a>
	  <div class="right menu">
	  	<% if (session.getAttribute("username") == null) {%>
	    <a class="item" href="signup.jsp">Sign Up</a>	  
	    <a class="item" href="signin.jsp">Sign In</a>
	    <% } else { %>
	     <a class="item">Welcome <%out.print(session.getAttribute("username"));%>!</a>
	     <a class="item" href="signout.jsp">Sign Out</a>
	      <% } %>
	  </div>
	</div>
	<br/>
	<%
		String username = request.getParameter("username");
		String id = request.getParameter("id");
		reservations = Reservation.deleteById(id, username);
		stations = Station.getStations();
		i = 0;
		past_reservations = new ArrayList<Reservation>();
		future_reservations = new ArrayList<Reservation>();
		stations = Station.getStations();
		for(i = 0; i < reservations.size(); i++){
			if(LocalDateTime.parse(reservations.get(i).getDeparture_datetime().replace(" ","T")).compareTo(LocalDateTime.now()) < 0){
				past_reservations.add(reservations.get(i));
			} else {
				future_reservations.add(reservations.get(i));
			}
		}
		i = 0;
		j = 0;
		
	%>
	<h1 style="text-align:center">
		<main>
			<div class="ui container">
			<h1>Reservations</h1>
			<table style="font-size: 14px; font-weight: 400"
				class="ui celled table compact mini center aligned">
				<thead>
					<tr>
						<th>Reservation Number</th>
						<th>Train #</th>
						<th>Transit Line Name</th>
						<th>From</th>
						<th>To</th>
						<th>Reserved on</th>
						<th>Total Fare</th>
						<th>Departure DateTime</th>
						<th>Arrival DateTime</th>
						<th>One Way/Round Trip</th>
						<th style="color: red">Cancel</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (; i < future_reservations.size(); i++) {
					%>
					<tr>
						<td data-label="Reservation Name"><%=future_reservations.get(i).getReservation_number()%></td>
						<td data-label="Train #"><%=future_reservations.get(i).getTid() + ""%></td>
						<td data-label="Transit Line Name"><%=future_reservations.get(i).getTransit_line_name()%></td>
						<td data-label="From"><%=Station.findStationById(stations, future_reservations.get(i).getOrigin_station()).getStationName()%></td>
						<td data-label="To"><%=Station.findStationById(stations, future_reservations.get(i).getDestination_station()).getStationName()%></td>
						<td data-label="Reserved on"><%=future_reservations.get(i).getReservation_date()%></td>
						<td data-label="Total Fare"><%=future_reservations.get(i).getTotal_fare() + ""%></td>
						<td data-label="Departure Datetime"><%=future_reservations.get(i).getDeparture_datetime()%></td>
						<td data-label="Arrival Datetime"><%=future_reservations.get(i).getArrival_datetime()%></td>
						<td data-label="One Way / Round Trip"><%=future_reservations.get(i).getOne_way_or_round_trip()%></td>
						<td data-label="Delete">
							<form action="delete-register.jsp" method="DELETE">
								<input type="hidden" name="id" value="<%=future_reservations.get(i).getReservation_number() + ""%>"/>
								<input type="hidden" name="username" value="<%=session.getAttribute("username")%>"/>
								<button class="ui icon button">
									<i class="trash icon"></i>
								</button>
							</form>
						</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<br>
			<h1>Past Reservations</h1>
			<table style="font-size: 14px; font-weight: 400"
				class="ui celled table compact mini center aligned">
				<thead>
					<tr>
						<th>Reservation Number</th>
						<th>Train #</th>
						<th>Transit Line Name</th>
						<th>From</th>
						<th>To</th>
						<th>Reserved on</th>
						<th>Total Fare</th>
						<th>Departure DateTime</th>
						<th>Arrival DateTime</th>
						<th>One Way/Round Trip</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (; j < past_reservations.size(); j++) {
					%>
					<tr>
						<td data-label="Reservation Name"><%=past_reservations.get(j).getReservation_number()%></td>
						<td data-label="Train #"><%=past_reservations.get(j).getTid() + ""%></td>
						<td data-label="Transit Line Name"><%=past_reservations.get(j).getTransit_line_name()%></td>
						<td data-label="From"><%=Station.findStationById(stations, past_reservations.get(j).getOrigin_station()).getStationName()%></td>
						<td data-label="To"><%=Station.findStationById(stations, past_reservations.get(j).getDestination_station()).getStationName()%></td>
						<td data-label="Reserved on"><%=past_reservations.get(j).getReservation_date()%></td>
						<td data-label="Total Fare"><%=past_reservations.get(j).getTotal_fare() + ""%></td>
						<td data-label="Departure Datetime"><%=past_reservations.get(j).getDeparture_datetime()%></td>
						<td data-label="Arrival Datetime"><%=past_reservations.get(j).getArrival_datetime()%></td>
						<td data-label="One Way / Round Trip"><%=past_reservations.get(j).getOne_way_or_round_trip()%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
		</main>
	</h1>
</body>
</html>