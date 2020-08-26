<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,common.*" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
    
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",slideNo="",slideContent="",developerId="";
	
	try
	{	 
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		developerId=request.getParameter("userid");
		unitId=request.getParameter("unitid");
		unitName=request.getParameter("unitname");
		lessonId=request.getParameter("lessonid");
		lessonName=request.getParameter("lessonname");
		slideNo=request.getParameter("slideno");
		slideContent=request.getParameter("slidecontentgen");
		slideContent=slideContent.replaceAll("\'","&#39;");
		slideContent=slideContent.replaceAll("<A href=","<A target=_blank href=");
		
		con=con1.getConnection();
		st=con.createStatement();

		FileUtility fu=new FileUtility();
		String courseDevPath=application.getInitParameter("lbcms_dev_path");

		st.executeUpdate("update lbcms_dev_lesson_content_master set slide_content='"+slideContent+"' where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and slide_no='"+slideNo+"'");

		response.sendRedirect("01_01_02.jsp?userid="+developerId+"&courseid="+courseId+"&coursename="+courseName+"&unitid="+unitId+"&unitname="+unitName+"&lessonid="+lessonId+"&lessonname="+lessonName+"&slideno="+slideNo+"");
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in SaveSlide.jsp is....."+e);
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
				System.out.println("The exception2 in SaveSlide.jsp is....."+se.getMessage());
			}
		}
%>
