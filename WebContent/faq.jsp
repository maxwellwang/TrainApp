<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%!Response res; %>
<%
	String question = request.getParameter("question"); 
	String answer = request.getParameter("answer");
	String id = request.getParameter("idfaq");
	if (question != null && question.length() > 0) {
		try{
			res = FAQ.addQuestion(question);
		}catch(Exception e){
			out.print("Error adding question");
		}
	}
	if (id != null && id.length() > 0 && answer != null && answer.length() > 0) {
		try{
			res = FAQ.addAnswer(answer, Integer.parseInt(id));
		}catch(Exception e){
			out.print("Error answering question");
		}
	}
	HashMap<Integer, String[]> faqContent = new HashMap();
	try {
		faqContent = FAQ.getFAQ(request.getParameter("search"));
	} catch (Exception e) {
		out.print("Error retrieving FAQ");
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
	<% if (session.getAttribute("account_type") == null) response.sendRedirect("signin.jsp"); %>
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
	        <form class="ui form" name="search" action="faq.jsp" method="post">
	          <div class="field">
	            <label>Search</label>
	            <input name="search"/>
	          </div>
	          <button class="ui button blue fluid" type="submit">
	            Search
	          </button>
	        </form>
	      </div>
	    </div>
	<% if (session.getAttribute("account_type") != null && session.getAttribute("account_type").equals("customer_rep")) {%>
		<div class="submit-ans-wrapper">
	      <div class="submit-ans-box">
	        <form class="ui form" name="submit-ans" action="faq.jsp" method="post">
	          <div class="field">
	            <label>Question ID</label>
	            <input name="idfaq"/>
	          </div>
	          <div class="field">
	            <label>Answer</label>
	            <input name="answer"/>
	          </div>
	          <button class="ui button blue fluid" type="submit">
	            Answer Question
	          </button>
	        </form>
	      </div>
	    </div>
    <% } else { %>
	    <div class="submit-faq-wrapper">
	      <div class="submit-faq-box">
	        <form class="ui form" name="submit-faq" action="faq.jsp" method="post">
	          <div class="field">
	            <label>Question</label>
	            <input name="question"/>
	          </div>
	          <button class="ui button blue fluid" type="submit">
	            Ask Question
	          </button>
	        </form>
	      </div>
	    </div>
    <% } %>
	
	
	<table style="width:50%">
	<%
		try {
			if (faqContent.isEmpty()) {
				out.print("No questions found");
			}
			for (Map.Entry<Integer, String[]> entry : faqContent.entrySet()) { %>
				<tr>
					<td> <% out.print("Q: " + entry.getValue()[0]); %> </td>
					<td> <% out.print("A: " + entry.getValue()[1]); %> </td>
					<td> <% out.print("ID: " + entry.getKey()); %> </td>
				</tr> 
			<% }
		} catch (Exception e) {
			out.println("FAQ is currently broken");
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
    
</body>
</html>