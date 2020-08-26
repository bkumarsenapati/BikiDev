<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.Utility" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null;
    
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="";
	String activity="",assessment="",assignment="",lessonLength="",developerId="";
	String actChk="",assmtChk="",assgnChk="";
	String aTitle="",aAssessTitle="",aAssgnTitle="";
	int secNo=0;
	String secTitle="",secContent="",secStatus="";
	
	try
	{	 
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		developerId=request.getParameter("userid");
		unitId=request.getParameter("unitid");
		unitName=request.getParameter("unitname");
		lessonId=request.getParameter("lessonid");
		lessonName=request.getParameter("lessonname");
		
		activity=request.getParameter("activity");
		if(activity==null)
		{
			activity="None";
				
		}
		else
		{
			activity=activity.replaceAll("\'","&#39;");
			activity=activity.replaceAll("<A href=","<A target=_blank href=");
		}
		
		assessment=request.getParameter("assessment");
		if(assessment==null)
		{
			assessment="None";
				
		}
		else
		{
			assessment=assessment.replaceAll("\'","&#39;");
			assessment=assessment.replaceAll("<A href=","<A target=_blank href=");
		}
		
		assignment=request.getParameter("assignment");
		if(assignment==null)
		{
			assignment="None";
				
		}
		else
		{
			assignment=assignment.replaceAll("\'","&#39;");
			assignment=assignment.replaceAll("<A href=","<A target=_blank href=");
		}
		
		lessonLength=request.getParameter("lessonlength");
		lessonLength=lessonLength.replaceAll("\'","&#39;");

		aTitle=request.getParameter("activitytitle");
		if(aTitle==null)
		{
			aTitle="none";
				
		}
		else
		{
			aTitle=aTitle.replaceAll("\'","&#39;");
		}
		aAssessTitle=request.getParameter("assessmenttitle");
		if(aAssessTitle==null)
		{
			aAssessTitle="none";
				
		}
		else
		{
			aAssessTitle=aAssessTitle.replaceAll("\'","&#39;");
		}
		aAssgnTitle=request.getParameter("assignmenttitle");
		if(aAssgnTitle==null)
		{
			aAssgnTitle="none";
				
		}
		else
		{
			aAssgnTitle=aAssgnTitle.replaceAll("\'","&#39;");
		}

		// sections hide or not
		actChk=request.getParameter("chkact");
		if(actChk==null)
		{
			actChk="view";
		}
		
		assmtChk=request.getParameter("chkassmt");
		if(assmtChk==null)
		{
			assmtChk="view";
		}
		
		assgnChk=request.getParameter("chkassgn");
		if(assgnChk==null)
		{
			assgnChk="view";
			
		}

	System.out.println("actChk..."+actChk+"..assmtChk..."+assmtChk+"....assgnChk..."+assgnChk);

		con=con1.getConnection();
		st=con.createStatement();

		st.executeUpdate("update lbcms_dev_lessons_master set lesson_activity='"+aTitle+"',lesson_assessment='"+aAssessTitle+"',lesson_assignment='"+aAssgnTitle+"', activity='"+activity+"',assessment='"+assessment+"',assignment='"+assignment+"',lesson_length='"+lessonLength+"' ,activitystatus='"+actChk+"',assignmentstatus='"+assgnChk+"',assessmentstatus='"+assmtChk+"' where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");


	// Sections info stores from here  
	for(int i=6;i<=10;i++)
		{
			
			secNo=i;
			
			st3=con.createStatement();
			st3.executeUpdate("delete from lbcms_dev_lesson_firstpage_content where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_no="+secNo+"");
			st3.close();

			secTitle=request.getParameter("sect"+i);
			if(secTitle==null)
			{
				secTitle="none";

			}
						
			
			secContent=request.getParameter("seca"+i);	
			secContent=secContent.replaceAll("\'","&#39;");
			secContent=secContent.replaceAll("<A href=","<A target=_blank href=");
			if(secContent.equals(""))
			{
				secTitle="none";

			}
			secStatus=request.getParameter("secstatus"+i);
			System.out.println("secStatus...."+secStatus);
			if(secStatus==null)
			{
				secStatus="view";
			}
			
			if(!secTitle.equals("none"))
			{
				st4=con.createStatement();
				st4.executeUpdate("insert into lbcms_dev_lesson_firstpage_content(course_id,unit_id,lesson_id,section_no,section_title,section_content,sectionstatus) values ('"+courseId+"','"+unitId+"','"+lessonId+"',"+secNo+",'"+secTitle+"','"+secContent+"','"+secStatus+"')");
				
				st4.close();
				
			}
		}

	// Upto here
	
		response.sendRedirect("LessonCreated.jsp?userid="+developerId+"&courseid="+courseId+"&coursename="+courseName+"&unitid="+unitId+"&unitname="+unitName+"&lessonid="+lessonId);
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in ThirdPageContent.jsp is....."+e);
	}
	finally
	{
			try
			{
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(st2!=null)
					st2.close();
				if(st3!=null)
					st3.close();
				if(st4!=null)
					st4.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 in ThirdPageContent.jsp is....."+se.getMessage());
			}
		}
%>
