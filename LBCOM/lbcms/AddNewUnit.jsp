<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.Utility" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null;
	PreparedStatement ps=null,ps1=null;
	Statement st=null;
    
	String courseId="",unitId="",unitName="",schoolId="",schoolPath="",insertAt="",noOfLessons="",courseName="";
	String developerId="",lessonId="",mode="";
	int lessonCount=0;

	try
	{	 
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		developerId=request.getParameter("userid");
		unitName=request.getParameter("unitname");
		noOfLessons=request.getParameter("no_of_lessons");
		insertAt=request.getParameter("insert_at");
		mode=request.getParameter("mode");
		if(mode==null)
		{
			mode="add";
		}
		session=request.getSession();
		if(session==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
			return;
		}
		con=con1.getConnection();
		st=con.createStatement();
		schoolPath = application.getInitParameter("schools_path");

	//	schoolId = (String)session.getAttribute("schoolid");
	//	if(schoolId == null || schoolId=="")
			schoolId="mahoning";								//SchoolId is mahoning hardcoded. I will change it later.

		Utility utility=new Utility(schoolId,schoolPath);
		if(mode.equals("edit"))
		{
			unitId=request.getParameter("unitid");
			rs=st.executeQuery("select unit_name from lbcms_dev_units_master where course_id='"+courseId+"' and unit_name='"+unitName+"' and unit_id!='"+unitId+"'");
			if(rs.next())
			{
				response.sendRedirect("EditUnit.jsp?userid="+developerId+"&courseid="+courseId+"&coursename="+courseName+"&unitname="+unitName+"&unitid="+unitId+"&no_of_lessons="+noOfLessons+"&insert_at="+insertAt+"&dispmsg=alreadyexists");
				return;
			}
			int i=st.executeUpdate("update lbcms_dev_units_master set unit_name='"+unitName+"',no_of_lessons="+noOfLessons+" where unit_id='"+unitId+"' and course_id='"+courseId+"'");
			if(i>0)
			{
				System.out.println("Modified Successfully");
			}
			else
				System.out.println("Modify operation failed");
			
		}
		else if(mode.equals("delete"))
		{
			int i=0;
			unitId=request.getParameter("unitid");
			i=st.executeUpdate("delete from lbcms_dev_units_master where unit_id='"+unitId+"' and course_id='"+courseId+"'");
			i=st.executeUpdate("delete from lbcms_dev_lessons_master where unit_id='"+unitId+"' and course_id='"+courseId+"'");
			i=st.executeUpdate("delete from lbcms_dev_lesson_content_master where unit_id='"+unitId+"' and course_id='"+courseId+"'");
			i=st.executeUpdate("delete from lbcms_dev_lesson_words where unit_id='"+unitId+"' and course_id='"+courseId+"'");
			if(i>0)
			{
				System.out.println("Deleted Successfully");
			}
			else
				System.out.println("Deleting operation failed");
			
		}
		if(mode.equals("add"))
		{
			rs=st.executeQuery("select unit_name from lbcms_dev_units_master where course_id='"+courseId+"' and unit_name='"+unitName+"'");
			if(rs.next())
			{
				response.sendRedirect("AddUnit.jsp?userid="+developerId+"&courseid="+courseId+"&coursename="+courseName+"&unitname="+unitName+"&no_of_lessons="+noOfLessons+"&insert_at="+insertAt+"&dispmsg=alreadyexists");
				return;
			}
			
			unitId=utility.getId("Dut_Id");
			if (unitId.equals(""))
			{
				utility.setNewId("Dut_Id","DU0000");	//Dev Unit.... DevelopmentUnit
				unitId=utility.getId("Dut_Id");
			}
				if(noOfLessons=="" || noOfLessons.equals(""))
				{
					noOfLessons="0";
				}

				ps=con.prepareStatement("insert into lbcms_dev_units_master(course_id,unit_id,unit_name,no_of_lessons) values(?,?,?,?)");
				ps.setString(1,courseId);
				ps.setString(2,unitId);
				ps.setString(3,unitName);
				ps.setString(4,noOfLessons);
				ps.executeUpdate();

				// Adding lessons to the unit.
				lessonCount=Integer.parseInt(noOfLessons);

				for(int i=1;i<=lessonCount;i++)
				{
					lessonId=utility.getId("DevLesson_Id");
					if (lessonId.equals(""))
					{
						utility.setNewId("DevLesson_Id","DL00000");	//Dev Lesson.... DevelopmentLesson
						lessonId=utility.getId("DevLesson_Id");
					}

					ps=con.prepareStatement("insert into lbcms_dev_lessons_master(course_id,unit_id,lesson_id,lesson_name) values(?,?,?,?)");
					ps.setString(1,courseId);
					ps.setString(2,unitId);
					ps.setString(3,lessonId);
					ps.setString(4,"Lesson"+i);
					ps.executeUpdate();

					ps1=con.prepareStatement("insert into lbcms_dev_lesson_content_master(course_id,unit_id,lesson_id,slide_no,slide_content) values(?,?,?,?,?)");
					ps1.setString(1,courseId);
					ps1.setString(2,unitId);
					ps1.setString(3,lessonId);
					ps1.setString(4,"1");
					ps1.setString(5,"");
					ps1.executeUpdate();
				}
		}
		
		response.sendRedirect("CourseUnits.jsp?userid="+developerId+"&courseid="+courseId+"&coursename="+courseName);
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in AddNewUnit.jsp is....."+e);
	}
	finally
	{
			try
			{
				if(st!=null)
					st.close();
				if(ps!=null)
					ps.close();
				if(ps1!=null)
					ps1.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 in AddNewUnit.jsp is....."+se.getMessage());
			}
	}
%>
