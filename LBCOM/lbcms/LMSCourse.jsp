<%@page import = "java.io.*,java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.*,common.*,utility.Utility" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	
	Connection con=null;
	ResultSet rs=null;
	PreparedStatement ps=null;
	Statement st=null;
    
	String courseName="",courseColor="",subject="",noOfUnits="",courseId="",schoolId="",schoolPath="",unitId="";
	int unitCount=0;
	String courseDevPath="",mode="",developerId="";
	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}

	try
	{	 
		mode=request.getParameter("mode");
		developerId=request.getParameter("userid");	
				
		con=con1.getConnection();
		st=con.createStatement();
		courseId=request.getParameter("courseid");
			
			int i=0;
		
		if(mode.equals("yes"))
		{	
			i=st.executeUpdate("update lbcms_dev_course_master set status=1 where course_id='"+courseId+"'");
			response.sendRedirect("CourseHome.jsp?userid="+developerId);
		}
		else if(mode.equals("no"))
		{
			i=st.executeUpdate("update lbcms_dev_course_master set status=0 where course_id='"+courseId+"'");
			response.sendRedirect("CourseHome.jsp?userid="+developerId);
		}
		
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in LMSCourse.jsp is....."+e);
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
				System.out.println("The exception2 in LMSCourse.jsp.jsp is....."+se.getMessage());
			}
		}
%>
