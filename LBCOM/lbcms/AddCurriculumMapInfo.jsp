<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.Utility" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
    
	String courseId="",courseName="";
	String schoolId="",developerId="";
	String month="",week="",standard="",newStandard="",unitslessons="",skills="",assessments="",resources="",vocabulary="",order="1";
	
	try
	{	
		developerId=request.getParameter("userid");
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		month=request.getParameter("month");
		week=request.getParameter("week");
		standard=request.getParameter("standard");
		newStandard=request.getParameter("newstandard");
		unitslessons=request.getParameter("unitslessons");
		skills=request.getParameter("skills");
		skills=skills.replaceAll("\'","&#39;");
		assessments=request.getParameter("assessments");
		assessments=assessments.replaceAll("\'","&#39;");
		resources=request.getParameter("resources");
		resources=resources.replaceAll("\'","&#39;");
		vocabulary=request.getParameter("vocabulary");
		vocabulary=vocabulary.replaceAll("\'","&#39;");
		
		
		con=con1.getConnection();
		st=con.createStatement();

		schoolId = (String)session.getAttribute("schoolid");
		if(schoolId == null || schoolId=="")
			schoolId="mahoning";		//SchoolId is mahoning hardcoded. I will change it later.

		System.out.println("unitslessons is..."+unitslessons);

		if(newStandard.equals(standard))
		{
			st.executeUpdate("update curriculum_mapping_info set month='"+month+"',week='"+week+"',skills='"+skills+"',units_lessons_mapped='"+unitslessons+"',assessments='"+assessments+"',resources='"+resources+"',vocabulary='"+vocabulary+"',display_order='"+order+"',status='1' where course_id='"+courseId+"' and standard='"+newStandard+"' and status='2'");
		}
		else
		{
			st.executeUpdate("insert into curriculum_mapping_info(course_id,month,week,standard,skills,units_lessons_mapped,assessments,resources,vocabulary,display_order,status) values ('"+courseId+"','"+month+"','"+week+"','"+standard+"','"+skills+"','"+unitslessons+"','"+assessments+"','"+resources+"','"+vocabulary+"','"+order+"','1')");
		}

		response.sendRedirect("CurriculumMap.jsp?userid="+developerId+"&courseid="+courseId+"&coursename="+courseName+"");
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in AddCurriculumMapInfo.jsp is....."+e);
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
				System.out.println("The exception2 in AddCurriculumMapInfo.jsp is....."+se.getMessage());
			}
		}
%>
