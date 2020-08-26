<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ include file="/common/checksession.jsp" %> 	
<%@ page errorPage="/ErrorPage.jsp" %>
<html>
<head>
<title>Summary Report</title>
</head>
<frameset rows="30,*" border="0">
  <frame name="TopFrame" scrolling="no" noresize src="Top.jsp?<%=request.getQueryString()%>">
  <frame name="BodyFrame" scrolling="auto" noresize>
  <noframes>
  <body>
  <p>This page uses frames, but your browser doesn't support them.</p>
  </body>
  </noframes>
</frameset>

</html>
