<%@page import = "java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<%@ page import = "java.sql.*,java.sql.Statement" language="java" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="con3" class="sqlbean.WHDbBean" scope="page" />


<%
	Connection con=null,con2=null;  
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null;
	String schoolId="",studentId="",meetingName="",classId="";
	int meetingId=0;
	int sCount=0;
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

		//Class.forName(dbDriver );
		//con2 = DriverManager .getConnection( dbURL );	// WebHuddle
		con2=con3.getConnection();
		con=con1.getConnection();							// LMS
		st=con2.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
				
%>
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Students List</title>

<SCRIPT LANGUAGE="JavaScript">

function unassignStudents(sid)
{
	if(confirm("Are you sure that you want to delete this assignment for this student?"))
	{
		location.href="UnassignParticipants.jsp?studentid="+sid+"&mid=<%=meetingId%>&mname=<%=meetingName%>";
		return true;
	}
	opener.location.reload();
}
//-->
</SCRIPT>
</head>
<body  onunload="opener.location=('ScheduledMeetings.jsp')">
<center>
<table border="1" cellspacing="1" width="500" align="center">
<tr>
	<td colspan="4" width="100%" height="21" bgcolor="#C0C0C0">
		<font face="Verdana" size="2" color="brown"><b>&nbsp;Meeting Name :</b>&nbsp;<%=meetingName%></font>
	</td>
</tr>
<tr>
	<td width="5%" height="19">&nbsp;</td>
	<td width="58%" height="19">
		<font face="Verdana" size="2" color="#008000">&nbsp;<b>Participant  Name</b></font></td>
	
</tr>

<%
		rs=st.executeQuery("select logon_name from invitations where meeting_id_fk="+meetingId+" order by logon_name");
		
		while(rs.next())
		{
			studentId=rs.getString("logon_name");
			sCount=sCount+1;
%>
			<tr>
					<td width="5%" bgcolor="#C0C0C0">
<%

			rs1=st1.executeQuery("select username,fname,lname from studentprofile where schoolid='"+schoolId+"' and username='"+studentId+"' order by fname,lname");
			if(rs1.next())
			{
				
%>
				
						<a href="#" onclick="unassignStudents('<%=studentId%>');return false;">
							<IMG SRC="../images/iddelete.gif" BORDER="0" align="middle" width="19" height="21" alt="Click here to delete this assignment for this student."></a></td>
					<td width="58%"><font face="Verdana" size="2"><%=rs1.getString("fname")%> <%=rs1.getString("lname")%></font>&nbsp;</td>
				
<%
			}
			rs2=st2.executeQuery("select username,firstname,lastname from teachprofile where schoolid='"+schoolId+"' and username='"+studentId+"' order by firstname,lastname");
			if(rs2.next())
			{
				
%>
				
						<a href="#" onclick="unassignStudents('<%=studentId%>');return false;">
							<IMG SRC="../images/iddelete.gif" BORDER="0" align="middle" width="19" height="21" alt="Click here to delete this participant."></a></td>
					<td width="58%"><font face="Verdana" size="2"><%=rs2.getString("firstname")%> <%=rs2.getString("lastname")%></font>&nbsp;</td>
				
<%
			}


				%></tr><%
		}
		if(sCount==0)
		{
%>
			<tr>
				<td width="100%" colspan="4" height="19">
					<font face="Verdana" size="2">There are no participants.</font>
				</td>
			</tr>
<%
		}
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in ParticipantsList.jsp.jsp is....."+e);
	}
	finally
		{
			try
			{
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(st2!=null)
					st2.close();
				if(con!=null && !con.isClosed())
					con.close();
				if(con2!=null && !con2.isClosed())
					con2.close();
			}
			catch(SQLException se)
			{
				System.out.println("The exception in ParticipantsList.jsp.jsp is....."+se.getMessage());
			}
		}
%>
   
    <tr>
      <td colspan="4" width="100%" align="center" height="19" bgcolor="#C0C0C0">
		<font face="Verdana" size="2"><a href="#" onclick="javascript:window.close(-1);">CLOSE</a></font>
      </td>
    </tr>
</table>
</center>
</body>
</html>