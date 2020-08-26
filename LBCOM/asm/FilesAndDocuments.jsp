<html>

<head>
<meta name="GENERATOR" content="Namo WebEditor v5.0"><meta name="author" content="Think-And-Learn">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
</head>
<%@ page language="java" import="java.io.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String emailid="",schoolid="";
%>


<%
	emailid = request.getParameter("emailid");
	schoolid = request.getParameter("schoolid");
%>
<frameset cols="214,*">
  <frame name="dir" src="LeftDir.jsp?emailid=<%= emailid %>&schoolid=<%= schoolid %>" target="displaymain">
  <frame name="displaymain" src="selectpersonalfolder.html">
  <noframes>
  <body>

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</frameset>

</html>


