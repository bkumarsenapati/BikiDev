<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.Utility" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<html>
<head>
	<title>Add Edit Lesson</title>
</head>
<body>

<%
	Connection con=null;
	ResultSet rs=null;
	PreparedStatement ps=null;
	Statement st=null;
    
	String courseId="",unitId="",unitName="",schoolId="",schoolPath="",insertAt="";
	String noOfLessons="",courseName="",lessonId="",lessonName="";
	String mode="",developerId="",checkListStatus="";

	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}
	try
	{	 
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		developerId=request.getParameter("userid");
		unitId=request.getParameter("unitid");
		unitName=request.getParameter("unitname");
		
		
		checkListStatus=request.getParameter("chklst");
		
		if(checkListStatus == null || checkListStatus.equals("off"))
			checkListStatus="1";
		
		if(checkListStatus.equals("on"))
			checkListStatus="2";

		mode=request.getParameter("mode");
		if(!mode.equals("delete"))
		{
			lessonName=request.getParameter("lessonname");
			lessonName=lessonName.replaceAll("\'","&#39;");
		}

		con=con1.getConnection();
		st=con.createStatement();
		schoolPath = application.getInitParameter("schools_path");

		//schoolId = (String)session.getAttribute("schoolid");
	//	if(schoolId == null || schoolId=="")
			schoolId="mahoning";		//SchoolId is mahoning hardcoded. I will change it later.

		Utility utility=new Utility(schoolId,schoolPath);

		if(mode.equals("edit"))
		{
			lessonId=request.getParameter("lessonid");
			rs=st.executeQuery("select lesson_name from lbcms_dev_lessons_master where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_name='"+lessonName+"' and lesson_id!='"+lessonId+"'");
			if(rs.next())
			{
				response.sendRedirect("EditLesson.jsp?userid="+developerId+"&courseid="+courseId+"&coursename="+courseName+"&unitid="+unitId+"&unitname="+unitName+"&lessonid="+lessonId+"&lessonname="+lessonName+"&dispmsg=alreadyexists");
				return;
			}
			int i=st.executeUpdate("update lbcms_dev_lessons_master set lesson_name='"+lessonName+"',status='"+checkListStatus+"' where lesson_id='"+lessonId+"' and unit_id='"+unitId+"' and course_id='"+courseId+"'");
			if(i>0)
			{
				System.out.println("Modified Successfully");
			}
			else
				System.out.println("Modify operation failed");		
		}
		else if(mode.equals("delete"))
		{
			lessonId=request.getParameter("lessonid");

			st.executeUpdate("delete from lbcms_dev_lessons_master where lesson_id='"+lessonId+"' and unit_id='"+unitId+"' and course_id='"+courseId+"'");

			st.executeUpdate("delete from lbcms_dev_lesson_content_master where lesson_id='"+lessonId+"' and unit_id='"+unitId+"' and course_id='"+courseId+"'");

			st.executeUpdate("delete from lbcms_dev_lesson_words where lesson_id='"+lessonId+"' and unit_id='"+unitId+"' and course_id='"+courseId+"'");
		}	
		else if(mode.equals("add"))
		{
			rs=st.executeQuery("select lesson_name from lbcms_dev_lessons_master where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_name='"+lessonName+"'");
			if(rs.next())
			{
				response.sendRedirect("AddLesson.jsp?userid="+developerId+"&courseid="+courseId+"&coursename="+courseName+"&unitid="+unitId+"&unitname="+unitName+"&lessonname="+lessonName+"&dispmsg=alreadyexists");
				return;
			}

			lessonId=utility.getId("DevLesson_Id");
			if (lessonId.equals(""))
			{
				utility.setNewId("DevLesson_Id","DL00000");	//Dev Lesson.... DevelopmentLesson
				lessonId=utility.getId("DevLesson_Id");
			}

			
			ps=con.prepareStatement("insert into lbcms_dev_lessons_master(course_id,unit_id,lesson_id,lesson_name,what_i_learn_today,critical_questions,materials_i_need,activity,assessment,assignment,lesson_length,status) values(?,?,?,?,?,?,?,?,?,?,?,?)");
			ps.setString(1,courseId);
			ps.setString(2,unitId);
			ps.setString(3,lessonId);
			ps.setString(4,lessonName);
			ps.setString(5,"");
			ps.setString(6,"");
			ps.setString(7,"");
			ps.setString(8,"");
			ps.setString(9,"");
			ps.setString(10,"");
			ps.setString(11,"");
			ps.setString(12,checkListStatus);

			ps.executeUpdate();
		
			ps=con.prepareStatement("insert into lbcms_dev_lesson_content_master(course_id,unit_id,lesson_id,slide_no,slide_content) values(?,?,?,?,?)");
			ps.setString(1,courseId);
			ps.setString(2,unitId);
			ps.setString(3,lessonId);
			ps.setString(4,"1");
			ps.setString(5,"");
			ps.executeUpdate();
			
	}
	
	response.sendRedirect("CourseUnitLessons.jsp?userid="+developerId+"&courseid="+courseId+"&coursename="+courseName+"&unitid="+unitId+"&unitname="+unitName);
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in AddNewLesson.jsp is....."+e);
	}
	finally
	{
			try
			{
				if(st!=null)
					st.close();
				if(ps!=null)
					ps.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 in AddNewLesson.jsp is....."+se.getMessage());
			}
	}
%>
</body>
</html>