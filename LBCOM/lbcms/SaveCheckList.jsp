<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.Utility" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
    
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="";
	String schoolId="",schoolPath="",developerId="";
	String learnToday="";
	String temp1="",courseDevPath="";
	
	try
	{	
		courseDevPath=application.getInitParameter("lbcms_dev_path");
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		unitId=request.getParameter("unitid");
		unitName=request.getParameter("unitname");
		lessonId=request.getParameter("lessonid");
		lessonName=request.getParameter("lessonname");
		developerId=request.getParameter("userid");
		
		learnToday=request.getParameter("learn_today");
		learnToday=learnToday.replaceAll("\'","&#39;");
		learnToday=learnToday.replaceAll("<A href=","<A target=_blank href=");
		
		con=con1.getConnection();
		st=con.createStatement();

		schoolPath = application.getInitParameter("schools_path");

		schoolId = (String)session.getAttribute("schoolid");
		if(schoolId == null || schoolId=="")
			schoolId="mahoning";		//SchoolId is mahoning hardcoded. I will change it later.

		st.executeUpdate("update lbcms_dev_lessons_master set what_i_learn_today='"+learnToday+"' where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");

		response.sendRedirect("CourseUnitLessons.jsp?userid="+developerId+"&courseid="+courseId+"&coursename="+courseName+"&unitid="+unitId+"&unitname="+unitName);
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in SaveCheckList.jsp is....."+e);
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
				System.out.println("The exception2 in SaveCheckList.jsp is....."+se.getMessage());
			}
		}
%>
