<%@page import = "java.sql.*,java.lang.*,coursemgmt.ExceptionsFile" %>

<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
    
	String courseId="",developerId="",courseName="",standard="";
	
	try
	{	
		courseId=request.getParameter("courseid");
		developerId=request.getParameter("userid");
		courseName=request.getParameter("coursename");
		standard=request.getParameter("standard");
		
		con=con1.getConnection();
		st=con.createStatement();

		st.executeUpdate("insert into curriculum_mapping_info(course_id,standard,status) values ('"+courseId+"','"+standard+"','2')");

		response.sendRedirect("CurriculumMap.jsp?userid="+developerId+"&courseid="+courseId+"&coursename="+courseName+"&standard="+standard+"");
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in AddCurriculumMapInfo.jsp is....."+e);
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
				System.out.println("The exception2 in AddCurriculumMapInfo.jsp is....."+se.getMessage());
			}
		}
%>
