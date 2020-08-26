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
		
		courseName=request.getParameter("cname");
		courseColor=request.getParameter("ccolor");
		subject=request.getParameter("subject");
		noOfUnits=request.getParameter("units");
		con=con1.getConnection();
		st=con.createStatement();

		if(mode.equals("add"))
		{
			
			rs=st.executeQuery("select course_name from lbcms_dev_course_master where course_name='"+courseName+"' and developer='"+developerId+"'");

			if(rs.next())
			{
				response.sendRedirect("CreateCourse.jsp?coursename="+courseName+"&dispmsg=alreadyexists");
				return;
			}

			schoolPath = application.getInitParameter("schools_path");
			courseDevPath = application.getInitParameter("lbcms_dev_path");

			//schoolId = (String)session.getAttribute("schoolid");
			//if(schoolId == null || schoolId=="")
				schoolId="mahoning";		//SchoolId is mahoning hardcoded. I will change it later.
			
					
			Utility utility=new Utility(schoolId,schoolPath);	
			courseId=utility.getId("DevCrsId");
			if (courseId.equals(""))
			{
				utility.setNewId("DevCrsId","DC000");	//Dev Course.... DevelopmentCourse
				courseId=utility.getId("DevCrsId");
			}
						
			ps=con.prepareStatement("insert into lbcms_dev_course_master(course_id,course_name,subject,developer,no_of_units,color_choice,status) values(?,?,?,?,?,?,?)");

			ps.setString(1,courseId);
			ps.setString(2,courseName);
			ps.setString(3,subject);
			ps.setString(4,developerId);
			ps.setString(5,noOfUnits);
			ps.setString(6,courseColor);
			ps.setString(7,"1");
			ps.executeUpdate();

			// Insert units info in the units master talbe.
		
			unitCount=Integer.parseInt(noOfUnits);

			for(int i=1;i<=unitCount;i++)
			{
				unitId=utility.getId("Dut_Id");
				if (unitId.equals(""))
				{
					utility.setNewId("Dut_Id","DU0000");	//Dev Unit.... DevelopmentUnit
					unitId=utility.getId("Dut_Id");
				}

				ps=con.prepareStatement("insert into lbcms_dev_units_master(course_id,unit_id,unit_name,no_of_lessons) values(?,?,?,?)");
				ps.setString(1,courseId);
				ps.setString(2,unitId);
				ps.setString(3,"Unit"+i);
				ps.setInt(4,0);
				ps.executeUpdate();
			}
			response.sendRedirect("CourseHome.jsp?userid="+developerId);
		}
		else if(mode.equals("edit"))
		{
			
			courseId=request.getParameter("courseid");
			rs=st.executeQuery("select course_name from lbcms_dev_course_master where course_name='"+courseName+"' and course_id!='"+courseId+"'");

			if(rs.next())
			{
				System.out.println("There is another course with this name already!");
				response.sendRedirect("EditCourse.jsp?courseid="+courseId+"&userid="+developerId+"&dispmsg=alreadyexists");
				return;
			}

			int i=0;
			i=st.executeUpdate("update lbcms_dev_course_master set course_name='"+courseName+"',subject='"+subject+"',no_of_units='"+noOfUnits+"',color_choice='"+courseColor+"' where course_id='"+courseId+"'");

			
			response.sendRedirect("CourseHome.jsp?userid="+developerId);
		}
		else if(mode.equals("del"))
		{
			
			courseId=request.getParameter("courseid");
			int i=0;
			i=st.executeUpdate("delete from lbcms_dev_course_master where course_id='"+courseId+"'");
			i=st.executeUpdate("delete from lbcms_dev_units_master where course_id='"+courseId+"'");
			i=st.executeUpdate("delete from lbcms_dev_lessons_master where course_id='"+courseId+"'");
			i=st.executeUpdate("delete from lbcms_dev_lesson_content_master where course_id='"+courseId+"'");
			i=st.executeUpdate("delete from lbcms_dev_lesson_words where course_id='"+courseId+"'");

			
			response.sendRedirect("CourseHome.jsp?userid="+developerId);
		}
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in AddEditCourse.jsp is....."+e);
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
				System.out.println("The exception2 in AddEditCourse.jsp.jsp is....."+se.getMessage());
			}
		}
%>
