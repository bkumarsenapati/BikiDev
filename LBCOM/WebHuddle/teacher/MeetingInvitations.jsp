<html>
<head>
<title></title>
</head>
<body>
<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,coursemgmt.ExceptionsFile" %>

<!-- <jsp:useBean id="db" class="sqlbean.DbBean" scope="page"/> -->
<jsp:useBean id="con1" class="sqlbean.WHDbBean" scope="page" />

<%
String courseId="",schoolId="";
	//final  String dbURL    = "jdbc:mysql://64.72.92.78:9306/webhuddle?user=root&password=whizkids";
	//final  String dbDriver = "com.mysql.jdbc.Driver"; 
Connection con=null;
Statement st=null,st1=null,st2=null;
ResultSet rs1=null,rs2=null;
PreparedStatement ps=null;
%>

<%
try
{
	String[] studentIds=request.getParameterValues("studentids");
	Hashtable selectedIds=new Hashtable();
	//courseId=request.getParameter("courseid");	
	//con=con1.getConnection();
	//Class.forName(dbDriver );
	//con = DriverManager .getConnection( dbURL );
	con=con1.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
	schoolId=(String)session.getAttribute("schoolid");
	String checked=request.getParameter("checked");
	String unchecked=request.getParameter("unchecked");
	int meetingId=Integer.parseInt(request.getParameter("mid"));
	StringTokenizer stk;
	String student="",emailId="";
	int maxInId=0;
	con.setAutoCommit(false);
	rs1=st1.executeQuery("select max(invitation_id) from invitations");
	if(rs1.next())
	{
		maxInId=rs1.getInt(1);
		
	}
	maxInId++;
	stk=new StringTokenizer(unchecked,",");
	student="";
	if(session.getAttribute("selectedids")!=null)
	{
		selectedIds=(Hashtable)session.getAttribute("selectedids");
		if(selectedIds.size()>0)
		{
			while(stk.hasMoreTokens())
			{
				student=stk.nextToken();
				if(selectedIds.containsKey(student))
				{
					selectedIds.remove(student);
					rs1=st1.executeQuery("select logon_name from invitations where meeting_id_fk="+meetingId+" and logon_name='"+student+"'");
					if(rs1.next())
					{
						st.executeUpdate("delete from invitations where meeting_id_fk="+meetingId+" and logon_name='"+student+"'");
					}
					
				}
			}
		}
	}

	stk=new StringTokenizer(checked,",");
	while(stk.hasMoreTokens())
	{
		student=stk.nextToken();
		selectedIds.put(student,student);
	}
	
	
	st2=con.createStatement();

	

	Enumeration enum=selectedIds.keys();
	while(enum.hasMoreElements())
	{	
		student=(String)enum.nextElement();
		rs2=st2.executeQuery("select logon_name from invitations where meeting_id_fk="+meetingId+" and logon_name='"+student+"'");
		if(rs2.next())
		{
			System.out.println("This entry is there already");
		}
		else
		{
	
			ps=con.prepareStatement("insert into invitations values(?,?,?,?)");
			
			emailId=student+"@"+schoolId;
			ps.setInt(1,maxInId);
			ps.setString(2,student);
			ps.setString(3,emailId);
			ps.setInt(4,meetingId);
			ps.executeUpdate();
			maxInId++;
		}
	}

	response.sendRedirect("ScheduledMeetings.jsp");
}
catch(SQLException e)
{
	con.rollback();
	ExceptionsFile.postException("DistributeCourse.jsp","Operations on database and reading  parameters","SQLException",e.getMessage());
	System.out.println(e);
}
finally
{
	try
	{
		con.commit();
		if(ps!=null)
			ps.close();	
		if(st!=null)
			st.close();
		if(st1!=null)
			st1.close();
		if(con!=null && !con.isClosed())
			con.close();
	}
	catch(SQLException e)
	{
		ExceptionsFile.postException("CourseEdit.jsp","closing statement objects","SQLException",e.getMessage());
	}
}
%>

</body>
</html>