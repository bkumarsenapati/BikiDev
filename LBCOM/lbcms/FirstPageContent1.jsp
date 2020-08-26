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
	String learnToday="",questions="",materials="",word="";
	String temp1="",courseDevPath="";
	String wwILT="",crQ="",wmL="";
	
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
		if(learnToday==null)
		{
			learnToday="";
		}
		wwILT=request.getParameter("wwt");
		if(wwILT==null)
		{
			wwILT="";
		}
		System.out.println("....................courseId..."+courseId+"..courseName..."+courseName+"..unitId..."+unitId+"..unitname..."+unitName+"..lessonid..."+lessonId+"..lessonname..."+lessonName+"..userid..."+developerId);
		
		learnToday=learnToday.replaceAll("\'","&#39;");
		System.out.println("learnToday............."+learnToday);
		System.out.println("wwILT............."+wwILT);
		learnToday=learnToday.replaceAll("<A href=","<A target=_blank href=");
		questions=request.getParameter("questions");
		System.out.println("questions............."+questions);
		crQ=request.getParameter("crq");
		questions=questions.replaceAll("\'","&#39;");
		questions=questions.replaceAll("<A href=","<A target=_blank href=");
		materials=request.getParameter("materials");
		wmL=request.getParameter("wml");
		materials=materials.replaceAll("\'","&#39;");
		materials=materials.replaceAll("<A href=","<A target=_blank href=");
		System.out.println("wwILT..."+wwILT+"..crQ..."+crQ+"...wmL...."+wmL);
		
		System.out.println("wwILT............."+wwILT);
		con=con1.getConnection();
		st=con.createStatement();

		schoolPath = application.getInitParameter("schools_path");

		schoolId = (String)session.getAttribute("schoolid");
		if(schoolId == null || schoolId=="")
			schoolId="mahoning";		//SchoolId is mahoning hardcoded. I will change it later.

		st.executeUpdate("update lbcms_dev_lessons_master set ltoday='test',critical_questions='"+questions+"',materials_i_need='"+materials+"' where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");

		// Now we will store the words needed to know.

		st.executeUpdate("delete from lbcms_dev_lesson_words where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");

		for(int i=12;i>=1;i--)
		{
			word=request.getParameter("word"+i);
			word=word.replaceAll("\'","&#39;");
			if(!word.equals(""))
			{
				st.executeUpdate("insert into lbcms_dev_lesson_words(course_id,unit_id,lesson_id,word,description) values ('"+courseId+"','"+unitId+"','"+lessonId+"','"+word+"','"+word+"')");
				
			}
		}

		response.sendRedirect("01_01_01.jsp?userid="+developerId+"&courseid="+courseId+"&coursename="+courseName+"&unitid="+unitId+"&unitname="+unitName+"&lessonid="+lessonId+"&lessonname="+lessonName);
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in FirstPageContent.jsp is....."+e);
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
				System.out.println("The exception2 in FirstPageContent.jsp is....."+se.getMessage());
			}
		}
%>
