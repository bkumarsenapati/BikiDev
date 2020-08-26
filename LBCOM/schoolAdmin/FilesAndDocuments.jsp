<html>

<head>
<meta name="GENERATOR" content="Namo WebEditor v5.0"><meta name="author" content="Hotschools, Inc. ">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
</head>

<%!
	String adminid,schoolid;
%>
<%@ page language="java" import="java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	adminid = request.getParameter("adminid");
	schoolid = request.getParameter("schoolid");
%>
<frameset cols="214,*">
  <frame name="dir" src="LeftDir.jsp?adminid=<%= adminid %>&schoolid=<%= schoolid %>" target="displaymain">
  <frame name="displaymain" src="selectpersonalfolder.html">
  <noframes>
  <body>

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</frameset>

</html>