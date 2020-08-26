<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",currentSlide="",slideNo="",slideContent="";
	String schoolId="",schoolPath="",developerId="";
	courseId=request.getParameter("courseid");
	courseName=request.getParameter("coursename");
	unitId=request.getParameter("unitid");
	unitName=request.getParameter("unitname");
	lessonId=request.getParameter("lessonid");
	lessonName=request.getParameter("lessonname");
	currentSlide=request.getParameter("slideno");
	developerId=request.getParameter("userid");
%>
<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
	try
	{
		con=con1.getConnection();
		st=con.createStatement();
		

		int i=st.executeUpdate("delete from lbcms_dev_lesson_content_master where slide_no='"+currentSlide+"' and lesson_id='"+lessonId+"' and unit_id='"+unitId+"' and course_id='"+courseId+"'");
		if(i>0)
		{
			response.sendRedirect("01_01_02.jsp?userid="+developerId+"&courseid="+courseId+"&coursename="+courseName+"&unitid="+unitId+"&unitname="+unitName+"&lessonid="+lessonId+"&lessonname="+lessonName+"&slideno=1");
		}
		else
			response.sendRedirect("01_01_02.jsp?userid="+developerId+"&courseid="+courseId+"&coursename="+courseName+"&unitid="+unitId+"&unitname="+unitName+"&lessonid="+lessonId+"&lessonname="+lessonName+"&slideno="+currentSlide);

		}
		catch(Exception e)
		{
			System.out.println("The exception1 in RemoveSlide.jsp is....."+e);
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
				System.out.println("The exception2 in RemoveSlide.jsp is....."+se.getMessage());
			}
		}

%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>This page will be added soon</title>
</head>

<body>

<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p align="center">&nbsp;</p>
</body>

</html>
