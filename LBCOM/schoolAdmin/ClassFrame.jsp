<%@page language="java" %>
<%@page import="java.sql.*,java.io.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>


<HTML>
<HEAD>
<TITLE>.:: Welcome to www.hotschools.net ::. [ for quality eLearning experience ]</TITLE>
</HEAD>

<%!
	
%>
<form name="DisplayClasses">
<%
out.println("<frameset rows='20%,80%' border='0'>");

out.println("<frame name='one' src='ClassSelection.jsp' scrolling='no'>");
out.println("<frame name='sec'>");
out.println("</FRAMESET>");
%>
</form>
</HTML>

