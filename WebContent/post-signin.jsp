<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%!Response res; %>
<%
	String username = "";
	try{
		username = request.getParameter("username");
		String password = request.getParameter("password");
		res = Customer.signin(username, password);
		// if user not found in customer, check in employee for user instead
		if (res.getMessage().equals("User not found.")) {
			res = Employee.signin(username, password);
			if (res.getStatus().equals("SUCCESS")) {
				session.setAttribute("account_type", res.getMessage());
				session.setAttribute("person_type", "Default");
			}
		} else { // a customer
			session.setAttribute("account_type", "customer");
			session.setAttribute("person_type", res.getMessage());
		}
	}catch(Exception e){
		out.print("d");
	}
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css"/>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.js"></script><title>Sign In</title>
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
	
	
	<% if (res.getStatus().equals("ERROR")) { %>
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
	<div class="sign-in-wrapper">
      <div class="sign-in-box">
        <h2 style="text-align:center">
          <i class="angle double right fitted">LXPress</i>
        </h2>
        <form class="ui form" name="signin" action="post-signin.jsp" method="post">
	         <div class="ui message red"><div class="header">Error</div><p><% out.print(res.getMessage());%></p></div>
          <div class="field">
            <label>Username</label>
            <input name="username"/>
          </div>
          <div class="field">
            <label>Password</label>
            <input type="password" name="password"/>
          </div>
          <button class="ui button blue fluid" type="submit">
            Sign In
          </button>
        </form>
      </div>
    </div>
    <% } else { %>
    	<div class="ui menu fixed">
	  <a class="item" href="index.jsp">Home</a>
	  <a class="item" href="schedule.jsp">Schedule</a>
	  <% String accType = session.getAttribute("account_type").toString() == null ? "customer" : session.getAttribute("account_type").toString();
	  	if (accType.equals("admin")) {%>
	    <a class="item" href="admin.jsp">Admin</a>	  
	  <% } else if (accType.equals("customer_rep")) { %>
	  	<a class="item" href="rep.jsp">Rep</a>
	  <% } %>
	  <div class="right menu">
	     <a class="item">Welcome <%=username%>!</a>
	      <% 
	      session.setAttribute("username", username);
	      %>
	      <a class="item" href="signout.jsp">Sign Out</a>
	  </div>
	</div>
	<br/>
        <h1 style="text-align:center">WELCOME TO LXPRESS, <%=username%>!</h1>
     <% } %>
</body>
</html>