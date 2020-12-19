<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
session.setAttribute("username", null);
session.setAttribute("account_type", null);
session.setAttribute("person_type", null);
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css"/>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.js"></script>
		<title>LXPress</title>	
	</head>
<body>
	<div class="ui menu fixed">
	  <a class="item" href="index.jsp">Home</a>
	  <a class="item" href="schedule.jsp">Schedule</a>
	  <a class="item" href="register.jsp">Tickets</a>
	  <a class="item" href="train.jsp">Train</a>
	  <a class="item" href="station.jsp">Station</a>
	  <div class="right menu">
	    <a class="item" href="signup.jsp">Sign Up</a>	  
	    <a class="item" href="signin.jsp">Sign In</a>
	  </div>
	</div>
	<br/>
	<h1 style="text-align:center">Signed out.</h1>
</body>
</html>