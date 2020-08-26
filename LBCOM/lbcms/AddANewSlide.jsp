<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.Utility" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	PreparedStatement ps=null;
    
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",slideNo="",developerId="";
	int newSlideNo=0;

	try
	{	 
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		unitId=request.getParameter("unitid");
		unitName=request.getParameter("unitname");
		lessonId=request.getParameter("lessonid");
		lessonName=request.getParameter("lessonname");
		slideNo=request.getParameter("slideno");
		developerId=request.getParameter("userid");
		newSlideNo=Integer.parseInt(slideNo)+1;

		con=con1.getConnection();

		ps=con.prepareStatement("insert into lbcms_dev_lesson_content_master(course_id,unit_id,lesson_id,slide_no,slide_content) values(?,?,?,?,?)");
		ps.setString(1,courseId);
		ps.setString(2,unitId);
		ps.setString(3,lessonId);
		ps.setInt(4,newSlideNo);
		ps.setString(5,"");
		ps.executeUpdate();
		response.sendRedirect("01_01_02.jsp?userid="+developerId+"&courseid="+courseId+"&coursename="+courseName+"&unitid="+unitId+"&unitname="+unitName+"&lessonid="+lessonId+"&lessonname="+lessonName+"&slideno="+newSlideNo);
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in AddANewSlide.jsp is....."+e);
	}
	finally
		{
			try
			{
				if(ps!=null)
					ps.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 in AddANewSlide.jsp is....."+se.getMessage());
			}
		}
%>
