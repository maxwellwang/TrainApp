<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%!Response res; %>
<%
	ArrayList<String> customers = new ArrayList();
	String tln = request.getParameter("transitLineName");
	String date = request.getParameter("date");
	if (tln != null && tln.length() > 0) {
		try{
			customers = FAQ.getCustomers(tln, date);
		}catch(Exception e){
			out.print("Error searching");
		}
	}
	
	String tln_ = request.getParameter("tln");
	String tid = request.getParameter("tid");
	String sid = request.getParameter("sid");
	String tln_2 = request.getParameter("tln2");
	String tid2 = request.getParameter("tid2");
	String sid2 = request.getParameter("sid2");
	tln_ = tln_ == null ? "" : tln_;
	tid = tid == null ? "" : tid;
	sid = sid == null ? "" : sid;
	tln_2 = tln_2 == null ? "" : tln_2;
	tid2 = tid2 == null ? "" : tid2;
	sid2 = sid2 == null ? "" : sid2;
	if (tln_.length() > 0 && tid.length() > 0 && sid.length() > 0) {
		try {
			FAQ.updateSched(tln_, tid, sid, tln_2, tid2, sid2);
		} catch (Exception e) {
			out.print("Error updating");
		}
	}
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css"/>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.js"></script>
		<title>Admin</title>
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
	<% if (!(session.getAttribute("account_type") != null && session.getAttribute("account_type").equals("customer_rep"))) {%>
	    response.sendRedirect("index.jsp");	  
	  <% } %>
	<div class="ui menu fixed">
	  <a class="item" href="index.jsp">Home</a>
	  <a class="item" href="schedule.jsp">Schedule</a>
	  <a class="item" href="register.jsp">Tickets</a>
	  <a class="item" href="train.jsp">Train</a>
	  <a class="item" href="station.jsp">Station</a>
	  <div class="right menu">
	     <a class="item">Welcome <%out.print(session.getAttribute("username"));%>!</a>
	     <a class="item" href="signout.jsp">Sign Out</a>
	  </div>
	</div>
	<br/>
	<br/><br/><br/><br/>
		<div class="search-wrapper">
	      <div class="search-box">
	        <form class="ui form" name="search" action="rep2.jsp" method="post">
	          <div class="field">
	            <label>Find customers for transit line</label>
	            <input name="transitLineName"/>
	          </div>
	          <div class="flex-1 pad">
                <div class="field">
                  <label>Date</label>
                  <input type="date" name="date" placeholder="Select Date" />
                </div>
              </div>
	          <button class="ui button blue fluid" type="submit">
	            Search
	          </button>
	        </form>
	      </div>
	    </div>
	
	<table style="width:50%">
	<%
		try {
			if (customers.isEmpty()) {
				out.print("No customers found");
			}
			for (String c : customers) { %>
				<tr>
					<td> <% out.print("Customer: " + c); %> </td>
				</tr> 
			<% }
		} catch (Exception e) {
			out.println("Invalid input!");
		}
	%>
	</table>
	
	<div class="sign-in-wrapper">
      <div class="sign-in-box">
        <h2 style="text-align:center">
          <i name="angle double right" fitted /> Customer Rep Panel
        </h2>
      </div>
    </div>
    
    	<div class="search-wrapper2">
	      <div class="search-box2">
	        <form class="ui form" name="search2" action="rep2.jsp" method="post">
	          <div class="field">
	            <label>Transit Line Name</label>
	            <input name="tln"/>
	          </div>
	          <div class="field">
	            <label>Train ID</label>
	            <input name="tid"/>
	          </div>
	          <div class="field">
	            <label>Stop ID</label>
	            <input name="sid"/>
	          </div>
	          
	          <div class="field">
	            <label>New Transit Line Name</label>
	            <input name="tln2"/>
	          </div>
	          <div class="field">
	            <label>New Train ID</label>
	            <input name="tid2"/>
	          </div>
	          <div class="field">
	            <label>New Stop ID</label>
	            <input name="sid2"/>
	          </div>
	          
	          <button class="ui button blue fluid" type="Update">
	            Search
	          </button>
	        </form>
	      </div>
	    </div>
    
</body>
</html>