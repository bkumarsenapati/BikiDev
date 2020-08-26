<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.Utility" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null;
    
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="";
	String schoolId="",schoolPath="",developerId="";
	String learnToday="",questions="",materials="",word="";
	String temp1="",courseDevPath="";
	String wwILT="",crQ="",wmL="";
	String sec1="",sec2="",sec3="",sec4="",sec5="";
	int secNo=0;
	String secTitle="",secContent="",wwlTChk="",secStatus="";
	String secWebTitle="",secWebUrl="";
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
				
		learnToday=learnToday.replaceAll("\'","&#39;");
		learnToday=learnToday.replaceAll("<A href=","<A target=_blank href=");
		questions=request.getParameter("questions");
		if(questions==null)
		{
			questions="";
		}
		
		questions=questions.replaceAll("\'","&#39;");
		questions=questions.replaceAll("<A href=","<A target=_blank href=");
		materials=request.getParameter("materials");
		if(materials==null)
		{
			materials="";
		}
		
		materials=materials.replaceAll("\'","&#39;");
		materials=materials.replaceAll("<A href=","<A target=_blank href=");
		
		

		/* New titles Start from here */

		wwILT=request.getParameter("wwt");
		if(wwILT==null)
		{
			wwILT="none";
		}
		if(wwILT.equals("Enter title here"))
		{
			wwILT="Essential Question";
		}
		
		crQ=request.getParameter("crq");
		if(crQ==null)
		{
			crQ="none";
		}
		if(crQ.equals("Enter title here"))
		{
			crQ="Learning Targets";
		}
		
		wmL=request.getParameter("wml");
		if(wmL==null)
		{
			wmL="none";
		}
		if(wmL.equals("Enter title here"))
		{
			wmL="Standards Addressed";
		}

// sections hide or not
		
		System.out.println("******************************");
		wwlTChk=request.getParameter("chkwwt");
		System.out.println("wwlTChk..."+wwlTChk+" &&&&&");
		if(wwlTChk==null)
		{
			wwlTChk="view";
		}
				
		String cqChk=request.getParameter("chkcq");
		System.out.println("cqChk..."+cqChk+" &&&&&");
		if(cqChk==null)
		{
			cqChk="view";
		}
		
		String wmChk=request.getParameter("chkwm");
		System.out.println("wmChk..."+wmChk+" &&&&&");
		if(wmChk==null)
		{
			wmChk="view";
			
		}

		
	
	System.out.println("wwlTChk..."+wwlTChk+"..cqChk..."+cqChk+"....wmChk..."+wmChk);
	System.out.println("******************************");
	System.out.println("materials..."+materials);

		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		
		//st.executeUpdate("update lbcms_dev_lessons_master set what_i_learn_today='"+learnToday+"',critical_questions='"+questions+"',materials_i_need='"+materials+"' where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");

		System.out.println("update lbcms_dev_lessons_master  where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");

		st.executeUpdate("update lbcms_dev_lessons_master set ltoday='"+wwILT+"',cquestions='"+crQ+"',wmaterial='"+wmL+"',what_i_learn_today='"+learnToday+"',critical_questions='"+questions+"',materials_i_need='"+materials+"',ltodaystatus='"+wwlTChk+"',cquestionsstatus='"+cqChk+"',wmaterialstatus='"+wmChk+"' where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
		st.close();

		// Now we will store the words needed to know.

		st1.executeUpdate("delete from lbcms_dev_lesson_words where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
		st1.close();

		for(int i=12;i>=1;i--)
		{
			st2=con.createStatement();
			word=request.getParameter("word"+i);
			word=word.replaceAll("\'","&#39;");
			if(!word.equals(""))
			{
				st2.executeUpdate("insert into lbcms_dev_lesson_words(course_id,unit_id,lesson_id,word,description) values ('"+courseId+"','"+unitId+"','"+lessonId+"','"+word+"','"+word+"')");
				st2.close();
				
			}
		}

			// Now we will store the section textareas.

		for(int i=1;i<=5;i++)
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
						
			if(secContent.equals(""))
			{
				secTitle="none";

			}
			else
			{
				secContent=secContent.replaceAll("\'","&#39;");
				secContent=secContent.replaceAll("<A href=","<A target=_blank href=");
			}
			secStatus=request.getParameter("secstatus"+i);
			System.out.println("secStatus...."+secStatus);
			if(secStatus==null)
			{
				secStatus="view";
			}
			
			
			if(!secTitle.equals("none"))
			{
				System.out.println("secStatus..in if.."+secStatus);
				st4=con.createStatement();
				st4.executeUpdate("insert into lbcms_dev_lesson_firstpage_content(course_id,unit_id,lesson_id,section_no,section_title,section_content,sectionstatus) values ('"+courseId+"','"+unitId+"','"+lessonId+"',"+secNo+",'"+secTitle+"','"+secContent+"','"+secStatus+"')");
				
				st4.close();
				
			}
		}

		// Web Resources starts from here
		System.out.println("******Web Resources starts from here********");
		st4=con.createStatement();
			st4.executeUpdate("delete from lbcms_dev_lesson_web_resource where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
			st4.close();

		for(int j=1;j<=5;j++)
		{
			
			secWebTitle=request.getParameter("secwebt"+j);
			
			if(secWebTitle==null)
			{
				secWebTitle="";

			}
			secWebUrl=request.getParameter("secwebu"+j);	
			System.out.println("secWebUrl..."+secWebUrl);
						
			if(!secWebTitle.equals("Enter title here"))
			{
				secWebTitle=secWebTitle.replaceAll("\'","&#39;");
				secWebTitle=secWebTitle.replaceAll("<A href=","<A target=_blank href=");
				System.out.println("secWebTitle..."+secWebTitle);
				st5=con.createStatement();
				st5.executeUpdate("insert into lbcms_dev_lesson_web_resource(course_id,unit_id,lesson_id,web_title,web_url) values ('"+courseId+"','"+unitId+"','"+lessonId+"','"+secWebTitle+"','"+secWebUrl+"')");
				
				st5.close();
			}
					
		}

		// Web Resources upto here


		response.sendRedirect("01_01_02.jsp?userid="+developerId+"&courseid="+courseId+"&coursename="+courseName+"&unitid="+unitId+"&unitname="+unitName+"&lessonid="+lessonId+"&lessonname="+lessonName+"&slideno=1");
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
				if(st1!=null)
					st1.close();
				if(st2!=null)
					st2.close();
				if(st3!=null)
					st3.close();
				if(st4!=null)
					st4.close();
				if(st5!=null)
					st5.close();
				if(con!=null && !con.isClosed())
					con.close();				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 in FirstPageContent.jsp is....."+se.getMessage());
			}
		}
%>
