<%@ page language="java" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ page import = "java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<%
	String password="",adminid="",sessid="";
	adminid=request.getParameter("userid");
	password=request.getParameter("pwd");
	if(adminid.equals("hsadmin") && password.equals("1q2w3e4r"))
	{
		session.setAttribute("sessid",sessid);
		response.sendRedirect("slist.jsp");
	}
	else
	{
		//System.out.println("The username and password are not correct");
		response.sendRedirect("index.jsp");
	}
%>