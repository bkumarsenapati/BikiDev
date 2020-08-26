<html>
<head>
<title></title>
</head>
<body>
<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,coursemgmt.ExceptionsFile" %>

<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
String courseId="",schoolId="";
Connection con=null;
Statement st=null;
PreparedStatement ps=null;
%>

<%
try   
{
	String[] studentIds=request.getParameterValues("studentids");
	Hashtable selectedIds=new Hashtable();
	courseId=request.getParameter("courseid");	
	con=con1.getConnection();
	st=con.createStatement();
	schoolId=(String)session.getAttribute("schoolid");
	String checked=request.getParameter("checked");
	String unchecked=request.getParameter("unchecked");
	StringTokenizer stk;
	String student="";
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
	
	con.setAutoCommit(false);

	st.executeUpdate("delete from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"'");
	ps=con.prepareStatement("insert into coursewareinfo_det values(?,?,?)");

	Enumeration enum=selectedIds.keys();
	while(enum.hasMoreElements())
	{	
		student=(String)enum.nextElement();
		ps.setString(1,schoolId);
		ps.setString(2,courseId);
		ps.setString(3,student);
		ps.executeUpdate();
	}

	response.sendRedirect("CourseManager.jsp");
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