<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.*,common.*,utility.Utility" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
		String[] uintIds;
		
%>

<%	
	Connection con=null;
	ResultSet rs=null,rs1=null,rs2=null,rs4=null,rs5=null,rs6=null,rs7=null;
	PreparedStatement ps=null,ps1=null,ps2=null,ps3=null;
	Statement st=null,st1=null,st2=null,st4=null,st5=null,st6=null,st7=null;
    
	String courseName="",courseColor="",subject="",noOfUnits="",courseId="",schoolId="",schoolPath="",unitId="";
	int totUnits=0,unitCount=0,checkListStatus=0,slNo=0,totalUnits=0;
	String courseDevPath="",mode="",developerId="",uId="";
	String unitStr="",newUnitId="",newLessonId="",unitName="",lessonName="";
	String learnToday="",questions="",materials="",word="",assessment="",assignment="",lLength="",lessonId="",activity="";
	String slContent="",descWord="",id="",crCourseId="",oldCourseId="";
	Hashtable unitIds=null;
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
		courseId=request.getParameter("courseid");
		noOfUnits=request.getParameter("totunits");
		uintIds = request.getParameterValues("uids");
		
		
		if (uintIds != null)
		{
			for (int i = 0; i < uintIds.length; i++)
			{
				
				if(i==0)
				{
					unitStr=uintIds[i];
				}
				else
				{
					unitStr=unitStr+","+uintIds[i];
				}				
			}			
		}
		
		unitIds=new Hashtable();

		StringTokenizer uidTokens=new StringTokenizer(unitStr,",");
		
		while(uidTokens.hasMoreTokens())
		{
			id=uidTokens.nextToken();
			unitIds.put(id,id);
		}

		totUnits =unitIds.size();
		unitCount=totUnits;
		totalUnits=Integer.parseInt(noOfUnits)+unitIds.size();
			

		con=con1.getConnection();
		st=con.createStatement();
				
		//st6=con.createStatement();

			schoolPath = application.getInitParameter("schools_path");
			courseDevPath = application.getInitParameter("lbcms_dev_path");

			//schoolId = (String)session.getAttribute("schoolid");
			//if(schoolId == null || schoolId=="")
				schoolId="mahoning";		//SchoolId is mahoning hardcoded. I will change it later.	

			Utility utility=new Utility(schoolId,schoolPath);
			int tu=0;
			tu=st.executeUpdate("update lbcms_dev_course_master set no_of_units="+totalUnits+" where course_id='"+courseId+"'");
			
			st.close();

			

			// Insert units info in the units master talbe.
		
			

			for(Enumeration e1 = unitIds.elements() ; e1.hasMoreElements() ;)
			{
				uId=(String)e1.nextElement();
				int noOfLessons=0;
				unitName="";
				st6=con.createStatement();
				
				rs6=st6.executeQuery("select * from lbcms_dev_units_master where unit_id='"+uId+"'");
				while(rs6.next())
				{
					oldCourseId=rs6.getString("course_id");
					st7=con.createStatement();
					rs7=st7.executeQuery("select * from lbcms_dev_course_master where course_id='"+oldCourseId+"' and developer='"+developerId+"'");
					if(rs7.next())
					{
						unitName=rs6.getString("unit_name");
						noOfLessons=rs6.getInt("no_of_lessons");	
						crCourseId=rs7.getString("course_id");
						
					}
					else
					{
						//System.out.println("Course id not matched");
					}
					st7.close();					
							
				}
				st6.close();
								
				newUnitId=utility.getId("Dut_Id");
				if (newUnitId.equals(""))
				{
					utility.setNewId("Dut_Id","DU0000");	//Dev Unit.... DevelopmentUnit
					newUnitId=utility.getId("Dut_Id");
				}

				
				//Units creations

					ps=con.prepareStatement("insert into lbcms_dev_units_master(course_id,unit_id,unit_name,no_of_lessons) values(?,?,?,?)");
					ps.setString(1,courseId);
					ps.setString(2,newUnitId);
					ps.setString(3,unitName);
					ps.setInt(4,noOfLessons);
					ps.executeUpdate();

				// Upto here

				

				//		 Lessons creation
				lessonName=learnToday=questions=materials=activity=assessment=assignment=lLength=lessonId="";
				checkListStatus=0;

				st2=con.createStatement();
				rs2=st2.executeQuery("select * from lbcms_dev_lessons_master where unit_id='"+uId+"' and course_id='"+crCourseId+"' order by lesson_id");
				while(rs2.next())
				{
					lessonId=rs2.getString("lesson_id");
					lessonName=rs2.getString("lesson_name");
					learnToday=rs2.getString("what_i_learn_today");
					if(learnToday==null)
					{
						learnToday="";
					}
					questions=rs2.getString("critical_questions");
					if(questions==null)
					{
						questions="";
					}
					
					materials=rs2.getString("materials_i_need");
					if(materials==null)
					{
						materials="";
					}
					
					activity=rs2.getString("activity");
					if(activity==null)
					{
						activity="";
					}
					
					assessment=rs2.getString("assessment");
					if(assessment==null)
					{
						assessment="";
					}
					
					assignment=rs2.getString("assignment");
					if(assignment==null)
					{
						assignment="";
					}
					
					lLength=rs2.getString("lesson_length");
					if(lLength==null)
					{
						lLength="One day";
					}
					
					checkListStatus=rs2.getInt("status");
					
				

					newLessonId=utility.getId("DevLesson_Id");
					if (newLessonId.equals(""))
					{
						utility.setNewId("DevLesson_Id","DL00000");	//Dev Lesson.... DevelopmentLesson
						newLessonId=utility.getId("DevLesson_Id");
					}
					

			
					ps1=con.prepareStatement("insert into lbcms_dev_lessons_master(course_id,unit_id,lesson_id,lesson_name,what_i_learn_today,critical_questions,materials_i_need,activity,assessment,assignment,lesson_length,status) values(?,?,?,?,?,?,?,?,?,?,?,?)");
					ps1.setString(1,courseId);
					ps1.setString(2,newUnitId);
					ps1.setString(3,newLessonId);
					ps1.setString(4,lessonName);
					ps1.setString(5,learnToday);
					ps1.setString(6,questions);
					ps1.setString(7,materials);
					ps1.setString(8,activity);
					ps1.setString(9,assessment);
					ps1.setString(10,assignment);
					ps1.setString(11,lLength);
					ps1.setInt(12,checkListStatus);

					ps1.executeUpdate();
					
					
					slNo=0;
					slContent="";
					
					st4=con.createStatement();
					rs4=st4.executeQuery("select * from lbcms_dev_lesson_content_master where unit_id='"+uId+"' and lesson_id='"+lessonId+"' and course_id='"+crCourseId+"' order by slide_no");
					while(rs4.next())
					{
						slNo=rs4.getInt("slide_no");
						
						slContent=rs4.getString("slide_content");	
						
						if(slContent==null || slContent.equals(""))
						{
							slContent="<p align='left'><FONT face=Verdana color='#ff0000' size='2'>No Content available for this lesson.</font></P>";
						}
						
		
					ps2=con.prepareStatement("insert into lbcms_dev_lesson_content_master(course_id,unit_id,lesson_id,slide_no,slide_content) values(?,?,?,?,?)");
					ps2.setString(1,courseId);
					ps2.setString(2,newUnitId);
					ps2.setString(3,newLessonId);
					ps2.setInt(4,slNo);
					ps2.setString(5,slContent);
					ps2.executeUpdate();
					ps2.close();
					
					}
					st4.close();
					
					
					word="";
					descWord="";
					st5=con.createStatement();
					rs5=st5.executeQuery("select * from lbcms_dev_lesson_words where unit_id='"+uId+"' and lesson_id='"+lessonId+"' and course_id='"+crCourseId+"' order by word");
					while(rs5.next())
					{
						word=rs5.getString("word");
						if(word==null)
						{
							word="";
						}

						descWord=rs5.getString("description");
						if(descWord==null)
						{
							descWord="";
						}
						word=word.replaceAll("\'","&#39;");
						descWord=descWord.replaceAll("\'","&#39;");						
		
						ps3=con.prepareStatement("insert into lbcms_dev_lesson_words(course_id,unit_id,lesson_id,word,description) values(?,?,?,?,?)");
						ps3.setString(1,courseId);
						ps3.setString(2,newUnitId);
						ps3.setString(3,newLessonId);
						ps3.setString(4,word);
						ps3.setString(5,descWord);
						ps3.executeUpdate();
						ps3.close();						
					}
					ps1.close();
					st5.close();
															
				}						// End of Lessons
				ps.close();
				st2.close();
				
			}							// End of Units
			
			response.sendRedirect("CourseHome.jsp?userid="+developerId);

		}
	catch(Exception e)
	{
		System.out.println("The exception1 in CreateNewCourse.jsp is....."+e);
	}
	finally
		{
			try
			{
				if(st!=null)
					st.close();
				if(st2!=null)
					st2.close();
				if(st4!=null)
					st4.close();
				if(st5!=null)
					st5.close();
				if(st6!=null)
					st6.close();
				if(ps!=null)
					ps.close();
				if(ps1!=null)
					ps1.close();
				if(ps2!=null)
					ps2.close();
				if(ps3!=null)
					ps3.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 in CreateNewCourse.jsp.jsp is....."+se.getMessage());
			}
		}
%>