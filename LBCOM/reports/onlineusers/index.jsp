<!-- CODE FOR SESSION HANDELING -->
<%@ include file="/common/checksession.jsp" %> 	
<!-- CODE FOR SESSION HANDELING -->
<HTML>
<HEAD>
<TITLE>www.hotschools.net</TITLE>
</HEAD>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String schoolid="",user="";
	String userType=(String)session.getAttribute("logintype");
	userType=userType+"";
%>
<form name="reportframe">
<frameset rows='8%,92%' border='0'>
<frame name="report" scrolling="no" src="online.jsp">
<frame name="sec">
</FRAMESET>
</form>
</HTML>

