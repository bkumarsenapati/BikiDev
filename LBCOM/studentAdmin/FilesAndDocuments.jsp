<html>

<head>
<meta name="GENERATOR" content="Namo WebEditor v5.0"><meta name="author" content="Hotschools, Inc. ">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
</head>

<%!
	String emailid,schoolid;
%>
<%@ page language="java" import="java.io.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	emailid = request.getParameter("emailid");
	schoolid = request.getParameter("schoolid");
%>
<frameset cols="214,*">
  <frame name="dir" src="/LBCOM/studentAdmin/LeftDir.jsp?emailid=<%= emailid %>&schoolid=<%= schoolid %>" target="displaymain">
  <frame name="displaymain" src="/LBCOM/studentAdmin/selectpersonalfolder.html">
  <noframes>
  <body>

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</frameset>

</html>