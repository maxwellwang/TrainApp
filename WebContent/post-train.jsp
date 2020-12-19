<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%! ArrayList<Train> trains; %>
<%! ArrayList<Station> stations; %>
<%! int i; %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css"/>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.js"></script>
		<title>Train</title>	
		<style>
			main{
				margin-top: 50px;
			}
		</style>
	</head>
<body>
	<div class="ui menu fixed">
	  <a class="item" href="index.jsp">Home</a>
	  <a class="item" href="schedule.jsp">Schedule</a>
	  <a class="item" href="register.jsp">Tickets</a>
	  <a class="item" href="train.jsp">Train</a>
	  <a class="item" href="station.jsp">Station</a>
	  <% if (session.getAttribute("account_type") != null && session.getAttribute("account_type").equals("admin")) {%>
	    <a class="item" href="admin.jsp">Admin</a>	  
	  <% } %>
	  <a class="item" href="faq.jsp">FAQ</a>
	  <% if (session.getAttribute("account_type") != null && session.getAttribute("account_type").equals("customer_rep")) {%>
	  	  <a class="item" href="rep.jsp">Rep</a>
	  <% } %>
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
		String no = request.getParameter("no")+"";
		trains = Train.getStopsByTrainId(no);
		stations = Station.getStations();
		i = 0;
	%>
	<main>
		<h1 style="text-align:center">WELCOME TO LXPRESS!</h1>
		<div class="ui container">
			<form class="ui form" action="post-train.jsp" method="POST">
			  <div class="field">
			    <label>Train #</label>
			    <input type="text" name="no" placeholder="Enter train #">
			  </div>
			  <div>Train ID : [1111, 2222, 3333, 4444, 5555, 6666]</div>
			  <button class="ui button fluid" type="submit">Submit</button>
			</form>
			<h1 style="text-align:center">Train : <%= request.getParameter("no") %></h1>
			<table style="font-size: 14px; font-weight: 400"
				class="ui celled table compact mini center aligned">
				<thead>
					<tr>
						<th>Stop ID</th>
						<th>Transit Line Name</th>
						<th>No Stops</th>
						<th>Travel Time</th>
						<th>Fare</th>
						<th>Origin Station</th>
						<th>Destination Station</th>
						<th>Departure Datetime</th>
						<th>Arrival Datetime</th>
					</tr>
				</thead>
				<tbody>
				<%for (i = 0; i < trains.size(); i++){ %>
					<tr>
						<td><%= trains.get(i).getStop_id() %></td>
						<td><%= trains.get(i).getTransit_line_name()%></td>
						<td><%= trains.get(i).getNum_stops()%></td>
						<td><%= trains.get(i).getTravel_time()%></td>
						<td><%= trains.get(i).getFare()%></td>
						<td><%= Station.findStationById(stations, trains.get(i).getOrigin_station()).getStationName() %></td>
						<td><%= Station.findStationById(stations, trains.get(i).getDestination_station()).getStationName() %></td>
						<td><%= trains.get(i).getDeparture_datetime()%></td>
						<td><%= trains.get(i).getArrival_datetime()%></td>
					</tr>
				<% } %>
				</tbody>
			</table>
		</div>
	</main>
</body>
</html>