<%@page import = "java.sql.*,coursemgmt.ExceptionsFile" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	 
	String lessonId1="",lessonId2="",move="",tempLessonId="";
	String courseId="",courseName="",unitId="",unitName="",developerId="",tableName="";

	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}
	
	try
	{
		con=con1.getConnection();
		st=con.createStatement();

		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		unitId=request.getParameter("unitid");
		unitName=request.getParameter("unitname");
		developerId=request.getParameter("userid");
		
		lessonId1=request.getParameter("lessonid1");
		lessonId2=request.getParameter("lessonid2");

		if(courseId.equals("DC008")||courseId.equals("DC015")||courseId.equals("DC032")||courseId.equals("DC016")||courseId.equals("DC026")||courseId.equals("DC049")||courseId.equals("DC030")||courseId.equals("DC018")||courseId.equals("DC031")||courseId.equals("DC047")||courseId.equals("DC055")||courseId.equals("DC056")||courseId.equals("DC023")||courseId.equals("DC036")|courseId.equals("DC060")||courseId.equals("DC036")||courseId.equals("DC057")||courseId.equals("DC046")||courseId.equals("DC042")||courseId.equals("DC058")||courseId.equals("DC024")||courseId.equals("DC019"))
		{
			tableName="lbcms_dev_assgn_social_larts_content_master";
		
		}
		else if(courseId.equals("DC048")||courseId.equals("DC005")||courseId.equals("DC043")||courseId.equals("DC044")||courseId.equals("DC051")||courseId.equals("DC037")||courseId.equals("DC080")||courseId.equals("DC050")||courseId.equals("DC020")||courseId.equals("DC017")||courseId.equals("DC059"))
		{
			tableName="lbcms_dev_assgn_science_content_master";
		
		}
		else
		{
			tableName="lbcms_dev_assgn_math_content_master";
		
		}
	
		//tempLessonId=lessonId1;
		
		int i=st.executeUpdate("update lbcms_dev_lessons_master set lesson_id='lessonid1' where lesson_id='"+lessonId1+"' and course_id='"+courseId+"' and unit_id='"+unitId+"'");

		int j=st.executeUpdate("update lbcms_dev_lessons_master set lesson_id='lessonid2' where lesson_id='"+lessonId2+"' and course_id='"+courseId+"' and unit_id='"+unitId+"'");

		////////////////////////////////////////////////

		int k=st.executeUpdate("update lbcms_dev_lessons_master set lesson_id='"+lessonId2+"' where lesson_id='lessonid1' and course_id='"+courseId+"' and unit_id='"+unitId+"'");

		int l=st.executeUpdate("update lbcms_dev_lessons_master set lesson_id='"+lessonId1+"' where lesson_id='lessonid2' and course_id='"+courseId+"' and unit_id='"+unitId+"'");

		////////////////////////////////////////////////

		int m=st.executeUpdate("update lbcms_dev_lesson_content_master set lesson_id='lessonid1' where lesson_id='"+lessonId1+"' and course_id='"+courseId+"' and unit_id='"+unitId+"'");

		int n=st.executeUpdate("update lbcms_dev_lesson_content_master set lesson_id='lessonid2' where lesson_id='"+lessonId2+"' and course_id='"+courseId+"' and unit_id='"+unitId+"'");

		int o=st.executeUpdate("update lbcms_dev_lesson_content_master set lesson_id='"+lessonId2+"' where lesson_id='lessonid1' and course_id='"+courseId+"' and unit_id='"+unitId+"'");

		int p=st.executeUpdate("update lbcms_dev_lesson_content_master set lesson_id='"+lessonId1+"' where lesson_id='lessonid2' and course_id='"+courseId+"' and unit_id='"+unitId+"'");
		
		////////////////////////////////////////////////

		int q=st.executeUpdate("update "+tableName+" set lesson_id='lessonid1' where lesson_id='"+lessonId1+"' and course_id='"+courseId+"' and unit_id='"+unitId+"'");

		int r=st.executeUpdate("update "+tableName+" set lesson_id='lessonid2' where lesson_id='"+lessonId2+"' and course_id='"+courseId+"' and unit_id='"+unitId+"'");

		int s=st.executeUpdate("update "+tableName+" set lesson_id='"+lessonId2+"' where lesson_id='lessonid1' and course_id='"+courseId+"' and unit_id='"+unitId+"'");

		int t=st.executeUpdate("update "+tableName+" set lesson_id='"+lessonId1+"' where lesson_id='lessonid2' and course_id='"+courseId+"' and unit_id='"+unitId+"'");

		////////////////////////////////////////////////

		int u=st.executeUpdate("update lbcms_dev_lesson_words set lesson_id='lessonid1' where lesson_id='"+lessonId1+"' and course_id='"+courseId+"' and unit_id='"+unitId+"'");

		int v=st.executeUpdate("update lbcms_dev_lesson_words set lesson_id='lessonid2' where lesson_id='"+lessonId2+"' and course_id='"+courseId+"' and unit_id='"+unitId+"'");

		int w=st.executeUpdate("update lbcms_dev_lesson_words set lesson_id='"+lessonId2+"' where lesson_id='lessonid1' and course_id='"+courseId+"' and unit_id='"+unitId+"'");

		int x=st.executeUpdate("update lbcms_dev_lesson_words set lesson_id='"+lessonId1+"' where lesson_id='lessonid2' and course_id='"+courseId+"' and unit_id='"+unitId+"'");

		////////////////////////////////////////////////
		response.sendRedirect("CourseUnitLessons.jsp?courseid="+courseId+"&coursename="+courseName+"&unitid="+unitId+"&unitname="+unitName+"&userid="+developerId);
	}
	catch(SQLException e)
	{
		ExceptionsFile.postException("ChangeOrder.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
		System.out.println("Exception in ChangeOrder.jsp is...."+e);
	}	
	catch(Exception e)
	{
		System.out.println("Exception in ChangeOrder.jsp is...."+e);
		ExceptionsFile.postException("ChangeOrder.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
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
			ExceptionsFile.postException("ChangeOrder.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}
	}
%>

<html>

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>New Page 1</title>
</head>
<body>
</body>
</html>