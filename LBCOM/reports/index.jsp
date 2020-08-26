<%@ include file="/common/checksession.jsp" %> 	
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
<frameset rows='6%,8%,*' border='1' noresize>
<frame name="top" scrolling="no" src="<%=userType%>/top.html" noresize>
<frame name="report" scrolling="no" src="about:blank" noresize><!-- <%=userType%> -->
<frame name="sec" noresize>
</FRAMESET>
</form>
</HTML>

