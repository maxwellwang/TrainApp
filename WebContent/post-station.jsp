<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%!ArrayList<Train> trains;%>
<%!ArrayList<Station> stations;%>
<%!int i;%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css" />
<script src="https://code.jquery.com/jquery-3.1.1.min.js"
	integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.js"></script>
<title>Train</title>
<style>
			main{
				margin-top: 50px;
			}
			.flex-box{ display : flex; }
			.flex-1 { flex: 1; }
			.flex-2 { flex: 2; }
</style>
</head>
<body>
	<div class="ui menu fixed">
		<a class="item" href="index.jsp">Home</a> <a class="item"
			href="schedule.jsp">Schedule</a> <a class="item" href="register.jsp">Tickets</a>
		<a class="item" href="train.jsp">Train</a> <a class="item"
			href="station.jsp">Station</a>
		<%
			if (session.getAttribute("account_type") != null && session.getAttribute("account_type").equals("admin")) {
		%>
		<a class="item" href="admin.jsp">Admin</a>
		<%
			}
		%>
		<a class="item" href="faq.jsp">FAQ</a>
		<%
			if (session.getAttribute("account_type") != null && session.getAttribute("account_type").equals("customer_rep")) {
		%>
		<a class="item" href="rep.jsp">Rep</a>
		<%
			}
		%>
		<div class="right menu">

			<%
				if (session.getAttribute("username") == null) {
			%>
			<a class="item" href="signup.jsp">Sign Up</a> <a class="item"
				href="signin.jsp">Sign In</a>
			<%
				} else {
			%>
			<a class="item">Welcome <%
				out.print(session.getAttribute("username"));
			%>!
			</a> <a class="item" href="signout.jsp">Sign Out</a>
			<%
				}
			%>
		</div>
	</div>
	<br />
	<%
		String name = request.getParameter("no") + "";
	String type = request.getParameter("type") + "";
	trains = Station.findStationByNameAndOrigin(name, type);
	stations = Station.getStations();
	i = 0;
	%>
	<main>
	<div class="ui container">
		<div class="flex-box">
			<div class="flex-2">
				<h1 style="text-align: center">WELCOME TO LXPRESS!</h1>
				<form class="ui form" action="post-station.jsp" method="POST">
					<div class="field">
						<label>Station Name</label> <input type="text" name="no"
							placeholder="Enter Station Name">
					</div>
					<div class="inline fields">
						<label for="fruit">Select as Origin / Destination:</label>
						<div class="field">
							<div class="ui radio checkbox">
								<input type="radio" name="type" checked="" tabindex="0"
									value="origin" class="hidden"> <label>Origin</label>
							</div>
						</div>
						<div class="field">
							<div class="ui radio checkbox">
								<input type="radio" name="type" tabindex="1" value="dest"
									class="hidden"> <label>Destination</label>
							</div>
						</div>
					</div>

					<button class="ui button blue fluid" type="submit">Submit</button>
				</form>
				<div>
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
							<%
								for (i = 0; i < trains.size(); i++) {
							%>
							<tr>
								<td><%=trains.get(i).getStop_id()%></td>
								<td><%=trains.get(i).getTransit_line_name()%></td>
								<td><%=trains.get(i).getNum_stops()%></td>
								<td><%=trains.get(i).getTravel_time()%></td>
								<td><%=trains.get(i).getFare()%></td>
								<td><%=Station.findStationById(stations, trains.get(i).getOrigin_station()).getStationName()%></td>
								<td><%=Station.findStationById(stations, trains.get(i).getDestination_station()).getStationName()%></td>
								<td><%=trains.get(i).getDeparture_datetime()%></td>
								<td><%=trains.get(i).getArrival_datetime()%></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>

				</div>
			</div>
			<div class="flex-1" style="padding: 0 20px">
				<h3 style="text-align: center">Stations</h3>
				<div class="ui list">
					<%for (i = 0; i < stations.size(); i++){ %>
					<div class="item">
						<div class="header"><%= stations.get(i).getStationName() %></div>
						ID :
						<%= stations.get(i).getId()  %><br> City :
						<%= stations.get(i).getCity() %><br> State :
						<%= stations.get(i).getState() %>
					</div>
					<%}%>
				</div>
			</div>
		</div>
	</div>
	</main>
	<script>
		$('.ui.radio.checkbox').checkbox();
	</script>
</body>
</html>