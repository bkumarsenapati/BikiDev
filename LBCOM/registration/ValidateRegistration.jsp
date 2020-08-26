<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp"%>
<%
String password="";
%>

<%
	password=request.getParameter("pwd");

	if(password.equals("hotschools"))
	{
		response.sendRedirect("main.jsp?status=1");
	}
	else
	{
		out.println("Sorry! You have entered a wrong password. Please try once again.");
%>
			<%@ include file="index.html"%>
<%
	}
%>
