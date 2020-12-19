<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%! ArrayList<Station> list = Station.getStations();%> 
<%! int i; %>

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
      <div class="flex-box">
        <div class="flex-2">
          <form class="ui form" method="POST" action="post-schedule.jsp">
            <div class="flex-box">
              <div class="flex-1 pad">
                <div class="field">
                  <label>Origin</label>
                  <input name="origin" placeholder="Origin" name="origin"/>
                </div>
              </div>
              <div class="flex-1 pad">
                <div class="field">
                  <label>Destination</label>
                  <input
                    name="destination"
                    placeholder="Destination"
                  />
                </div>
              </div>
            </div>
            <div class="flex-box">
              <div class="flex-1 pad">
                <div class="field">
                  <label>Date</label>
                  <input type="date" name="date" placeholder="Select Date" />
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
