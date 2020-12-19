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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.js"></script><title>Admin</title>
	<style>
		.sign-in-wrapper{
			 width: 100%;
			  height: 100%;
			  position: relative;
			  background: linear-gradient(#bbbb, #fffb));
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
	<div align="center">
		<h1>Admin Page</h1>
	</div>
	<div class="sign-in-wrapper">
      <div class="sign-in-box">
        <h2 style="text-align:center">
          <i name="angle double right" fitted /> Customer Rep Management
        </h2>
        <form class="ui form" action="post-addrep.jsp" method="post">
		<%
	         try{
	        	String username = request.getParameter("username");
	     		String firstName = request.getParameter("firstName");
	     		String lastName = request.getParameter("lastName");
	     		String password = request.getParameter("password");
	     		String ssn = request.getParameter("ssn");
	     		String action = request.getParameter("action");
	     		Response r = Employee.do_action(firstName, lastName, ssn, username, password, action);
	     		if(r.getStatus().equals("ERROR")){
	     			out.print("<div class=\"ui message red\"><div class=\"header\">Error</div><p>"+ r.getMessage() +"</p></div>");
	     		}else{
	     			out.print("<div class=\"ui message green\"><div class=\"header\">Change successful</div></div>");
	     		}
	         }catch(Exception ex){
	        	 out.print(ex);
	        	 out.print("Request Failed");
	         }
	      %>
          <div class="fields equal width">
            <div class="field">
              <label>First Name</label>
              <input name="firstName" />
            </div>
            <div class="field">
              <label>Last Name</label>
              <input name="lastName" />
            </div>
          </div>
          <div class="field">
            <label>SSN</label>
            <input name="ssn" />
          </div>
          <div class="field">
            <label>Username</label>
            <input name="username" />
          </div>
          <div class="field">
            <label>Password</label>
            <input type="password" name="password" />
          </div>
          <div class="field">
            <label>Action (add, edit, delete) Note: delete only needs username filled in and edit changes employee with same username</label>
            <input name="action">
          </div>
          <button type="submit" class="ui button fluid green">
            Do Action
          </button>
        </form>
      </div>
    </div>
	<div align="center">
	    <h1>Monthly Sales Report</h1>
	    <%
	    	ArrayList<Double> monthly_fares = Reservation.get_monthly_fares();
	    %>
	    <table style="font-size: 14px; font-weight: 400" class="ui celled table compact mini center aligned">
		  	<thead>
		  	<tr>
			    <th>Month</th>
			    <th>Revenue ($)</th>
		  	</tr>
		  	</thead>
		  	<tbody>
		  	<%for (int i = 0; i < 12; i++) {%>
			  	<tr>
				    <td data-label="Month"><%=i+1 %></td>
				    <td data-label="Monthly Fare"><%=monthly_fares.get(i) %></td>
			  	</tr>
		  	<%} %>
		  	</tbody>
		</table>
    </div>
    <div class="sign-in-wrapper">
	    <div class="sign-in-box">
		    <div class="fields equal width">
		    	<div class="field">
			    	<h1>Get Reservations by Transit Line Name</h1>
			    	Options: <%=Reservation.getTransitLineNames().toString()%>
			    	<form class="ui form" action="searchTLN.jsp" method="post">
			          <div class="field">
			            <label>Transit Line Name</label>
			            <input name="transitLineName" />
			          </div>
			          <button type="submit" class="ui button fluid blue">
			            Search
			          </button>
			        </form>
		        </div>
		    	<div class="field">
			    	<h1>Get Reservations by Customer Username</h1>
			    	Options: <%=Reservation.getCustomerUsernames().toString()%>
			    	<form class="ui form" action="searchCU.jsp" method="post">
			          <div class="field">
			            <label>Customer Username</label>
			            <input name="customerUsername" />
			          </div>
			          <button type="submit" class="ui button fluid red">
			            Search
			          </button>
			        </form>
				</div>
		    </div>
	    </div>
    </div>
    <div align="center">
    	<h1>Best Customer (highest revenue):</h1>
    	<%Reservation.CustomerResult cr = Reservation.get_best_customer(); %>
    	<table  style="font-size: 14px; font-weight: 400" class="ui celled table compact mini center aligned">
		  	<thead>
		  	<tr>
		  		<th>Username</th>
			    <th>Total Revenue From Customer ($)</th>
		  	</tr>
		  	</thead>
		  	<tbody>
		  	<tr>
			    <td data-label="Username"><%=cr.username%></td>
			    <td data-label="Total Revenue From Customer"><%=cr.max%></td>
		  	</tr>
		  	</tbody>
		</table>
    </div>
    <br><br><br>
    <div align="center">
    	<%
    	Reservation.Top5Result t = Reservation.get_top5();
    	%>
    	<h1>Top 5 Most Active Transit Lines By Average Number of Reservations per Month</h1>
    	<table  style="font-size: 14px; font-weight: 400" class="ui celled table compact mini center aligned">
		  	<thead>
		  	<tr>
		  		<th>Place</th>
			    <th>Transit Line Name</th>
			    <th>Average Number of Reservations per Month</th>
		  	</tr>
		  	</thead>
		  	<tbody>
		  	<%for (int i = 0; i < t.top5.size(); i++) {%>
			  	<tr>
				    <td data-label="Place"><%=i+1 %></td>
				    <td data-label="Transit Line Name"><%=t.top5.get(i) %></td>
				    <td data-label="Average Number of Reservations per Month"><%=t.counts.get(i) %></td>
			  	</tr>
		  	<%} %>
		  	</tbody>
		</table>
    </div>
    <div align="center">
    	<%
    	for (int i = 0; i < 12; i++) {
    	Reservation.Top5ByMonthResult tb = Reservation.get_top5_by_month(i+1);
    	%>
    	<h1>Top 5 Most Active Transit Lines for Month <%=i+1 %></h1>
    	<table  style="font-size: 14px; font-weight: 400" class="ui celled table compact mini center aligned">
		  	<thead>
		  	<tr>
		  		<th>Place</th>
			    <th>Transit Line Name</th>
			    <th>Number of Reservations in month <%=i+1 %></th>
		  	</tr>
		  	</thead>
		  	<tbody>
		  	<%for (int j = 0; j < t.top5.size(); j++) {%>
			  	<tr>
				    <td data-label="Place"><%=j+1 %></td>
				    <td data-label="Transit Line Name"><%=tb.top5.get(j) %></td>
				    <td data-label="Average Number of Reservations per Month"><%=tb.counts.get(j) %></td>
			  	</tr>
		  	<%} %>
		  	</tbody>
		</table>
    	<%} %>
    </div>
</body>
</html>