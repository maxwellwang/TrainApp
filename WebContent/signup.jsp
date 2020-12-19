<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css"/>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.js"></script>
	<title>Sign Up</title>
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
	
	<br><br><br><br><br>
	<div class="sign-in-wrapper">
      <div class="sign-in-box">
        <h2 style="text-align:center">
          <i name="angle double right" fitted /> LXPress
        </h2>
        <form class="ui form" action="post-signup.jsp" method="post">
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
            <label>Person Type (Default, Child, Senior, or Disabled)</label>
            <input name="personType" />
          </div>
          <div class="field">
            <label>Username</label>
            <input name="username" />
          </div>
          <div class="field">
            <label>Email Address</label>
            <input type="email" name="email" />
          </div>
          <div class="field">
            <label>Password</label>
            <input type="password" name="password" />
          </div>
          <div class="field">
            <label>Confirm Password</label>
            <input type="password" name="confirmPassword" />
          </div>
          <div class="field">
            <label>SSN (Employees Only)</label>
            <input name="ssn" />
          </div>
          <button type="submit" class="ui button fluid red">
            Sign Up
          </button>
        </form>
      </div>
    </div>
    
</body>
</html>