<html>
<head>
<title>Participants List</title>
<SCRIPT LANGUAGE="JavaScript">

window.parent.refresh();
//-->
</SCRIPT>
</head>

<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.WHDbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null;
	String schoolId="",classId="",courseId="",studentId="",meetingName="";
	int sCount=0,meetingId=0;
	//final  String dbURL    = "jdbc:mysql://64.72.92.78:9306/webhuddle?user=root&password=whizkids";
	//final  String dbDriver = "com.mysql.jdbc.Driver";
%>
<%
	
	try
	{	 
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}

		schoolId = (String)session.getAttribute("schoolid");
		classId=(String)session.getAttribute("classid");
		meetingId=Integer.parseInt(request.getParameter("mid"));
		meetingName=request.getParameter("mname");
		studentId=request.getParameter("studentid");
					
		//Class.forName(dbDriver );
		//con = DriverManager .getConnection( dbURL );	// WebHuddle
		con=con1.getConnection();	
		st=con.createStatement();
				
		int i=st.executeUpdate("delete from invitations where meeting_id_fk="+meetingId+" and logon_name='"+studentId+"'");

		if(i > 0)
			response.sendRedirect("ParticipantsList.jsp?mid="+meetingId+"&mname="+meetingName);
	}
	catch(SQLException se)
	{
		System.out.println("The exception in UnassignParticipants.jsp is....."+se.getMessage());
	}
	
	finally
		{
			try
			{
				if(st!=null)
					st.close();
				
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception in UnassignParticipants.jsp.jsp.jsp is....."+se.getMessage());
			}
		}	
%>
<body></body></html>