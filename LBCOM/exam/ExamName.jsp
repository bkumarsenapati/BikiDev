<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>

<BODY>
<%@ page errorPage="/ErrorPage.jsp" %>
<% 
	String examName="";
%>
<%
	examName=request.getParameter("examname");
	out.println("<table border='1' width='100%' cellspacing='0' bordercolordark='#DDEEFF' height='24'>");
    out.println("<tr width='337'  bordercolor='#EFEFF7' height='20'>");
    out.println("<td align=left><b><font face='Arial' size='2' color='#FF65CE'> "+examName+"</font></b></td></tr></table>");
%>




</BODY>
</HTML>
