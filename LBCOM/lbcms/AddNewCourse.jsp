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
	String courseDevPath="";

	try
	{	 
		courseName=request.getParameter("cname");
		courseColor=request.getParameter("ccolor");
		subject=request.getParameter("subject");
		noOfUnits=request.getParameter("units");

		FileUtility fu=new FileUtility();

		con=con1.getConnection();

		st=con.createStatement();

		rs=st.executeQuery("select course_name from lbcms_dev_course_master where course_name='"+courseName+"'");

		if(rs.next())
		{
			response.sendRedirect("CreateCourse.jsp?coursename="+courseName+"&dispmsg=alreadyexists");
			return;
		}

		schoolPath = application.getInitParameter("schools_path");
		courseDevPath = application.getInitParameter("lbcms_dev_path");

		//schoolId = (String)session.getAttribute("schoolid");
	//	if(schoolId == null || schoolId=="")
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
		ps.setString(4,"");
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
			ps.setString(4,"");
			ps.executeUpdate();
		}

		response.sendRedirect("CourseHome.jsp");

	}
	catch(Exception e)
	{
		System.out.println("The exception1 in AddNewCourse.jsp is....."+e);
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
				System.out.println("The exception2 in AddNewCourse.jsp is....."+se.getMessage());
			}
	}
%>
