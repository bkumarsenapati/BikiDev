<html>
<head>
<title></title>
</head>
<body>
<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,coursemgmt.ExceptionsFile" %>

<!-- <jsp:useBean id="db" class="sqlbean.DbBean" scope="page"/> -->
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
String courseId="",schoolId="",developerId="",teacherId="",devCourseId="";
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
	developerId=request.getParameter("userid");
	devCourseId=request.getParameter("courseid");
	con=con1.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
	schoolId=(String)session.getAttribute("schoolid");
	String checked=request.getParameter("checked");
	String unchecked=request.getParameter("unchecked");
	
	StringTokenizer stk;
	String student="",emailId="";
	con.setAutoCommit(false);
	stk=new StringTokenizer(unchecked,",");
	student="";
	System.out.println("-----------");
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
					
					rs1=st1.executeQuery("select dev_course_id from lbcms_dev_course_permissions where dev_course_id='"+devCourseId+"' and teacher_id='"+student+"'");
					if(rs1.next())
					{
						
						st.executeUpdate("delete from lbcms_dev_course_permissions where dev_course_id='"+devCourseId+"' and teacher_id='"+student+"'");
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
		
		rs2=st2.executeQuery("select dev_course_id from lbcms_dev_course_permissions where dev_course_id='"+devCourseId+"' and teacher_id='"+student+"'");
		if(rs2.next())
		{
			//System.out.println("...............This entry is there already");
		}
		else
		{
			//developerId="developer";
			//devCourseId="DC008";
	
			ps=con.prepareStatement("insert into lbcms_dev_course_permissions values(?,?,?,?)");
			
			ps.setString(1,schoolId);
			ps.setString(2,developerId);
			ps.setString(3,student);
			ps.setString(4,devCourseId);
			ps.executeUpdate();
			
		}
	}

	response.sendRedirect("CourseHome.jsp?userid="+developerId);
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