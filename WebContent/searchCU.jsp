<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css"/>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.js"></script><title>Search by Customer Username</title>
	<style>
		.sign-in-wrapper{
			 width: 100%;
			  height: 100%;
			  position: relative;
			  background: linear-gradient(#bbbb, #fffb), url('https://cdn.discordapp.com/attachments/750402672468951213/775968846808612874/train-ok.gif');
			  background-size: cover;
		}
		
	  .sign-in-box {
	    z-index: 2;
	    position: absolute;
	    width: 100%;
	    max-width: 580px;
	    top: 42%;
	    left: 50%;
	    padding: 20px;
	    transform: translate(-50%, -50%);
	    box-shadow: 1px 1px 5px rgba(0, 0, 0, 0.2);
	    border: 1.5px solid #aaa;
	    border-radius: 5px;
	    background-color: white;
	  }
	</style>
</head>
<body>
	<br><br><br><br><br>
	<div class="ui menu fixed">
	  <a class="item" href="index.jsp">Home</a>
	  <a class="item" href="schedule.jsp">Schedule</a>
	  <a class="item" href="register.jsp">Tickets</a>
	  <a class="item" href="train.jsp">Train</a>
	  <a class="item" href="station.jsp">Station</a>
	  <% if (session.getAttribute("account_type") != null && session.getAttribute("account_type").equals("admin")) {%>
	    <a class="item" href="admin.jsp">Admin</a>	  
	  <% } %>
	  <div class="right menu">
	     <a class="item">Welcome <%out.print(session.getAttribute("username"));%>!</a>
	     <a class="item" href="signout.jsp">Sign Out</a>
	  </div>
	</div>
	<br/>
	<div>
		<%
		String cu = request.getParameter("customerUsername");
		if (!Reservation.getCustomerUsernames().contains(cu)) {
			// invalid cu
			%><h1><%=cu %> is an invalid customer username.</h1><%
		} else {
		ArrayList<Reservation> reservations = Reservation.searchCU(cu);
		%>
		<h1>Reservations by <%=cu%></h1>
		<table style="font-size: 14px; font-weight: 400" class="ui celled table compact mini center aligned">
		  	<thead>
		  	<tr>
			    <th>reservation_number</th>
			    <th>origin_station</th>
			    <th>destination_station</th>
			    <th>reservation_date</th>
			    <th>total_fare ($)</th>
			    <th>departure_datetime</th>
			    <th>arrival_datetime</th>
			    <th>one_way_or_round_trip</th>
			    <th>tid</th>
			    <th>transit_line_name</th>
			    <th>username</th>
		  	</tr>
		  	</thead>
		  	<tbody>
		  	<%		  	double total_revenue = 0;
			for (Reservation r : reservations) {%>
			  	<tr>
				    <td data-label="Reservation Number"><%=r.getReservation_number()%></td>
				    <td data-label="Origin Station"><%=r.getOrigin_station()%></td>
				    <td data-label="Destination Station"><%=r.getDestination_station()%></td>
				    <td data-label="Reservation Date"><%=r.getReservation_date()%></td>
				    <td data-label="Total Fare"><%=r.getTotal_fare()%></td>
				    <td data-label="Departure Datetime"><%=r.getDeparture_datetime()%></td>
				    <td data-label="Arrival Datetime"><%=r.getArrival_datetime()%></td>
				    <td data-label="One Way or Round Trip"><%=r.getOne_way_or_round_trip()%></td>
				    <td data-label="TID"><%=r.getTid()%></td>
				    <td data-label="Transit Line Name"><%=r.getTransit_line_name()%></td>
				    <td data-label="Username"><%=r.getUsername()%></td>
			  	</tr>
			  	<%total_revenue += r.getTotal_fare();%>
		  	<%} %>
		  	</tbody>
		</table>
		Total Revenue from <%=cu %>: $<%=total_revenue %>
		<%}%>
	</div>
</body>
</html>