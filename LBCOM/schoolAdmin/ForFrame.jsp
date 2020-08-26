<%@ page language="java"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<HTML>
<HEAD>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<title></title>
</HEAD>

<%String schoolid="",userid="",tag="";%>
<form name="frm">
<%
schoolid=request.getParameter("schoolid");
userid=request.getParameter("userid");

out.println("<frameset cols='28%,72%' FRAMEBORDER=yes border='1'>");

out.println("<frame name='one' src=\"ForGrade.jsp?school="+schoolid+"\" FRAMEBORDER=yes border='1' >");

out.println("<frame name='two' src=\"about:blank\" FRAMEBORDER=yes border='1' >");
out.println("</FRAMESET>");
%>
</form>
</HTML>

