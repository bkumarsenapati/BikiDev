<HTML>
<HEAD>
<TITLE>A frameset document</TITLE>
</HEAD>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String schoolid="",user="";
	schoolid=request.getParameter("schoolid");
	user=request.getParameter("user");
%>

<form name="srchfrm">
<frameset rows='20%,80%' border='0'>
<frame name="main" scrolling="no" src="CrossRegisterMain.jsp">
<frame name="bottom">
</FRAMESET>
</form>
</HTML>

