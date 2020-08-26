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
<frameset rows='8%,92%' border='0'>
<frame name="search" scrolling="no" src="SearchMain.jsp?schoolid=<%=schoolid%>&user=<%=user%>">
<frame name="sec">
</FRAMESET>
</form>
</HTML>

