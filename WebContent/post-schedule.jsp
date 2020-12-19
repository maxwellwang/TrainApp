<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%! ArrayList<Station> list = Station.getStations();%> 
<%! ArrayList<StopsAt> stops_at;  %>
<%! int i, j; %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"
	integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.js"></script>

<title>LXPress</title>
<style>
.main {
	padding: 60px;
}

.flex-box {
	display: flex;
}

.flex-1 {
	flex: 1;
}

.flex-2 {
	flex: 2;
}

.flex-3 {
	flex: 3;
}

.flex-4 {
	flex: 4;
}
.pad {
        padding: 10px;
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
	<br />
    <main class="main ui container">
      <h1 class="ui header pink" style="text-align: center">Train Schedules</h1>
      <%
         try{
        	String origin = request.getParameter("origin").toLowerCase();
        	String destination = request.getParameter("destination").toLowerCase();
        	String date = request.getParameter("date");
        	int sortby = Integer.parseInt(request.getParameter("sortby"));
        	stops_at = TrainSchedule.getSchedules(origin, destination, date, sortby);
         }catch(Exception ex){
        	 out.print(ex);
        	 out.print("Request Failed");
         }
      %>
      <div class="flex-box">
        <div class="flex-2">
          <form class="ui form" method="POST" action="post-schedule.jsp">
            <div class="flex-box">
              <div class="flex-1 pad">
                <div class="field">
                  <label>Origin</label>
                  <input name="origin" placeholder="Origin" name="origin" value="<%= request.getParameter("origin") %>"/>
                </div>
              </div>
              <div class="flex-1 pad">
                <div class="field">
                  <label>Destination</label>
                  <input
                    name="destination"
                    placeholder="Destination"
                    value="<%= request.getParameter("destination") %>"
                  />
                </div>
              </div>
            </div>
            <div class="flex-box">
              <div class="flex-1 pad">
                <div class="field">
                  <label>Date</label>
                  <input type="date" name="date" placeholder="Select Date" value="<%= request.getParameter("date") %>"/>
                </div>
              </div>
              <div class="flex-1 pad" style="align-self: flex-end">
                <button class="ui button fluid">Search</button>
              </div>
            </div>
            
            <div class="ui form">
			  <div class="inline fields">
			    <label for="fruit">Sort By :</label>
			    <div class="field">
			      <div class="ui radio checkbox">
			        <input type="radio" name="sortby" checked="" value="0" tabindex="0" class="hidden">
			        <label>Arrival Time</label>
			      </div>
			    </div>
			    <div class="field">
			      <div class="ui radio checkbox">
			        <input type="radio" name="sortby" value="1" tabindex="1" class="hidden">
			        <label>Departure Time</label>
			      </div>
			    </div>
			    <div class="field">
			      <div class="ui radio checkbox">
			        <input type="radio" name="sortby" value="2" tabindex="2" class="hidden">
			        <label>Fare</label>
			      </div>
			    </div>
			  </div>
			  </div>
          </form>
          <%for (j = 0; j < stops_at.size(); j++){ %>
          	<div class="ui card fluid">
            <div class="content">
              <div class="header">
                <%= Station.findStationById(list, stops_at.get(j).getTs().getOrigin_station()).getStationName()  %> 
                (<%= StopsAt.getTime(stops_at.get(j).getDeparture_datetime()) %>)
                <i class="arrow right icon"></i>
                <%= Station.findStationById(list, stops_at.get(j).getTs().getDestination_station()).getStationName()  %>
                (
                <%= StopsAt.getTime(stops_at.get(j).getArrival_datetime()) %>
                )
              </div>
              <div class="meta">No of stops : 
              <%= stops_at.get(j).getTs().getNum_stops() %> 
              <div style="float:right">
              	<b> <%= stops_at.get(j).getTs().getTrain_line_name() %></b>
              	# <%= stops_at.get(j).getTs().getTid() %>
              </div>
              </div>
              <div class="description">
              	Price : $ <%= stops_at.get(j).getTs().getFare() %>
                <div style="float: right">
                  <i class="clock outline icon"></i> 
                  <%= stops_at.get(j).getTs().getTravel_time() %> 
                  mins
                </div>
              </div>
            </div>
            <div class="extra content">
                <div class="flex-box">
	                <div class="flex-1"> 	
		                <form action="post-register.jsp" method="POST">
		                	<input type="hidden" name="username" value="<%= session.getAttribute("username")%>"/>
		                	<input type="hidden" name="total_fare" value="<%= stops_at.get(j).getTs().getFare() %>"/>
		                	<input type="hidden" name="origin_station" value="<%= stops_at.get(j).getTs().getOrigin_station() %>"/>
		                	<input type="hidden" name="destination_station" value="<%= stops_at.get(j).getTs().getDestination_station() %>" />
		                	<input type="hidden" name="departure_datetime" value="<%= stops_at.get(j).getDeparture_datetime() %>" />
		                	<input type="hidden" name="arrival_time" value="<%= stops_at.get(j).getArrival_datetime() %>" />
		                	<input type="hidden" name="tid" value="<%= stops_at.get(j).getTs().getTid() %>" />
		                	<input type="hidden" name="transit_line_name" value="<%= stops_at.get(j).getTs().getTrain_line_name() %>" />
		                	<input type="hidden" name="one_way_or_round_trip" value="one_way" />
		                    <button class="ui inverted blue button fluid">One-Way Trip</button>
		                </form>
	                </div>
	                <div class="flex-1">               
	                	<form action="post-register.jsp" method="POST">
		                	<input type="hidden" name="username" value="<%= session.getAttribute("username")%>"/>
		                	<input type="hidden" name="total_fare" value="<%= stops_at.get(j).getTs().getFare() %>"/>
		                	<input type="hidden" name="origin_station" value="<%= stops_at.get(j).getTs().getOrigin_station() %>"/>
		                	<input type="hidden" name="destination_station" value="<%= stops_at.get(j).getTs().getDestination_station() %>" />
		                	<input type="hidden" name="departure_datetime" value="<%= stops_at.get(j).getDeparture_datetime() %>" />
		                	<input type="hidden" name="arrival_time" value="<%= stops_at.get(j).getArrival_datetime() %>" />
		                	<input type="hidden" name="tid" value="<%= stops_at.get(j).getTs().getTid() %>" />
		                	<input type="hidden" name="transit_line_name" value="<%= stops_at.get(j).getTs().getTrain_line_name() %>" />
		                	<input type="hidden" name="one_way_or_round_trip" value="round_trip" />
	                		<button class="ui inverted green button fluid">Round Trip</button>
		                </form> 
	                </div>
                </div>
            </div>
          </div>
          <% } %>
          <% if (stops_at.size() < 1) { %>
			<div class="ui message red">
				<div class="header">
					No Schedules found
				</div>
				<div class="content">
					Please select different origin / destination / date
				</div>
			</div>
		    <% } %>
        </div>

        <div class="flex-1 pad">
          <h3 style="text-align: center">Stations</h3>
          <div class="ui list">
	          <%for (i = 0; i < list.size(); i++){ %>
		       <div class="item">
	              <div class="header"><%= list.get(i).getStationName() %></div>
	              ID : <%= list.get(i).getId()  %><br>
	              City : <%= list.get(i).getCity() %><br>
	              State : <%= list.get(i).getState() %>
            </div>
		      <%}%>
          </div>
        </div>
      </div>
    </main>
    <script>
	$('.ui.radio.checkbox')
	.checkbox()
	;
	</script>
</body>
</html>