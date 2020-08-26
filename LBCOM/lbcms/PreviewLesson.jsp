<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@page import = "cmgenerator.MaterialGenerator,java.io.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",cmPath="";
	MaterialGenerator matGen=null;
%>
<%
	courseId=request.getParameter("courseid");
	unitId=request.getParameter("unitid");
	lessonId=request.getParameter("lessonid");

	cmPath = application.getInitParameter("lbcms_dev_path");

	try
	{	
		matGen=new MaterialGenerator();
				
		matGen.createLessonPage(courseId,cmPath);
		
%>

<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>

<BODY>

</BODY>
</HTML>
<%
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in PreviewLesson.jsp is....."+e);
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
				System.out.println("SQLException in PreviewLesson.java is..."+se);
			}
		}
%>
