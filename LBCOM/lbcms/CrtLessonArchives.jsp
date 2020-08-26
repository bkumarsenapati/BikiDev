<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.*,common.*,utility.Utility" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
		String[] uintIds;		
%>

<%	
	Connection con=null;
	ResultSet rs=null,rs1=null,rs2=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs10=null,rs11=null;
	PreparedStatement ps=null,ps1=null,ps2=null,ps3=null,ps4=null,ps5=null;
	Statement st=null,st2=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null,st11=null;
    
	String courseName="",courseId="",schoolId="",schoolPath="",unitId="";
	int checkListStatus=0,slNo=0;
	String courseDevPath="",mode="",developerId="",uId="";
	String learnToday="",questions="",materials="",word="",assessment="",assignment="",lLength="",lessonId="",activity="";
	String slContent="",descWord="",id="",crCourseId="",oldCourseId="",lessonStr="";
	String lessonIds[];
	Hashtable lIds=null;
	String newLessonId="",lessonName="";
	
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
		unitId=request.getParameter("unitid");
		lessonIds= request.getParameterValues("lessonids");
		
		System.out.println("courseid is .."+courseId+"...unit id is ..."+unitId+"...lessonIds are "+lessonIds);
		if (lessonIds != null)
		{
			for (int i = 0; i < lessonIds.length; i++)
			{
				
				if(i==0)
				{
					lessonStr=lessonIds[i];
				}
				else
				{
					lessonStr=lessonStr+","+lessonIds[i];
				}				
			}			
		}
		System.out.println("lessonStr..."+lessonStr);
		lIds=new Hashtable();

		StringTokenizer lidTokens=new StringTokenizer(lessonStr,",");
		
		while(lidTokens.hasMoreTokens())
		{
			id=lidTokens.nextToken();
			lIds.put(id,id);
		}
		con=con1.getConnection();
		st=con.createStatement();
		schoolPath = application.getInitParameter("schools_path");
		courseDevPath = application.getInitParameter("lbcms_dev_path");

			//schoolId = (String)session.getAttribute("schoolid");
			//if(schoolId == null || schoolId=="")
				schoolId="mahoning";		//SchoolId is mahoning hardcoded. I will change it later.	

			Utility utility=new Utility(schoolId,schoolPath);
			System.out.println("lIds...."+lIds);
			int	totLessons=0; 
			for(Enumeration e1 = lIds.elements() ; e1.hasMoreElements() ;)
			{
				String lttitle="",cqtitle="",wmtitle="",lt="",cq="",wm="";
				String aTitle="",aAssessTitle="",aAssgnTitle="",acts="",assgns="",assmts="";
				
				//		 Lessons creation
				lessonName=learnToday=questions=materials=activity=assessment=assignment=lLength="";
				checkListStatus=0;
				lessonId=(String)e1.nextElement();
				totLessons++;
				System.out.println(" before rs2.....lessonId..."+lessonId);
				int noOfLessons=0;
				st2=con.createStatement();				
				System.out.println("select * from lbcms_dev_lessons_master where lesson_id='"+lessonId+"'");
				rs2=st2.executeQuery("select * from lbcms_dev_lessons_master where lesson_id='"+lessonId+"'");
				while(rs2.next())
				{					
					lessonName=rs2.getString("lesson_name");
					System.out.println(" while rs 2...lessonName....."+lessonName);
					learnToday=rs2.getString("what_i_learn_today");
					if(learnToday==null)
					{
						learnToday="";
					}
				//	System.out.println(" while rs 2...learnToday....."+learnToday);
					questions=rs2.getString("critical_questions");
					if(questions==null)
					{
						questions="";
					}
				//	System.out.println(" while rs 2...questions....."+questions);
					materials=rs2.getString("materials_i_need");
					if(materials==null)
					{
						materials="";
					}
				//	System.out.println(" while rs 2...materials....."+materials);
					
					activity=rs2.getString("activity");
					if(activity==null)
					{
						activity="";
					}
					//System.out.println(" while rs 2...activity....."+activity);
					
					assessment=rs2.getString("assessment");
					if(assessment==null)
					{
						assessment="";
					}
				//	System.out.println(" while rs 2...assessment....."+assessment);
					assignment=rs2.getString("assignment");
					if(assignment==null)
					{
						assignment="";
					}
				//	System.out.println(" while rs 2...assignment....."+assignment);
					
					lLength=rs2.getString("lesson_length");
					if(lLength==null)
					{
						lLength="One day";
					}
					System.out.println(" while rs 2...lLength....."+lLength);
					
					checkListStatus=rs2.getInt("status");
					System.out.println(" while rs 2...checkListStatus....."+checkListStatus);

					lttitle=rs2.getString("ltoday");
					cqtitle=rs2.getString("cquestions");
					wmtitle=rs2.getString("wmaterial");
					System.out.println(" while rs 2...wmtitle....."+wmtitle);

					lt=rs2.getString("ltodaystatus");
					cq=rs2.getString("cquestionsstatus");
					wm=rs2.getString("wmaterialstatus");
					System.out.println(" while rs 2...wm....."+wm);

					aTitle=rs2.getString("lesson_activity");
					aAssessTitle=rs2.getString("lesson_assessment");
					aAssgnTitle=rs2.getString("lesson_assignment");
					System.out.println(" while rs 2...aAssgnTitle....."+aAssgnTitle);

					acts=rs2.getString("activitystatus");
					assgns=rs2.getString("assignmentstatus");
					assmts=rs2.getString("assessmentstatus");
					System.out.println(" while rs 2...assmts....."+assmts);

					System.out.println(" Before ..newLessonId...");
					
				

					newLessonId=utility.getId("DevLesson_Id");
					if (newLessonId.equals(""))
					{
						utility.setNewId("DevLesson_Id","DL00000");	//Dev Lesson.... DevelopmentLesson
						newLessonId=utility.getId("DevLesson_Id");
					}
					System.out.println(" After ..newLessonId..."+newLessonId);

			
					ps1=con.prepareStatement("insert into lbcms_dev_lessons_master(course_id,unit_id,lesson_id,lesson_name,what_i_learn_today,critical_questions,materials_i_need,activity,assessment,assignment,lesson_length,status,ltoday,cquestions,wmaterial,lesson_activity,lesson_assessment,lesson_assignment,ltodaystatus,cquestionsstatus,wmaterialstatus,activitystatus,assignmentstatus,assessmentstatus) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					ps1.setString(1,courseId);
					ps1.setString(2,unitId);
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
					ps1.setString(13,lttitle);
					ps1.setString(14,cqtitle);
					ps1.setString(15,wmtitle);
					ps1.setString(16,aTitle);
					ps1.setString(17,aAssessTitle);
					ps1.setString(18,aAssgnTitle);
					ps1.setString(19,lt);
					ps1.setString(20,cq);
					ps1.setString(21,wm);
					ps1.setString(22,acts);
					ps1.setString(23,assgns);
					ps1.setString(24,assmts);
					ps1.executeUpdate();
					ps1.close();
					}						// End of Lessons
				st2.close();
					
					
					// Standards
					st6=con.createStatement();
					rs6=st6.executeQuery("select * from lbcms_dev_cc_standards_lessons where lesson_id='"+lessonId+"'");
					while(rs6.next())
					 {
						String strndId=rs6.getString("standard_code");						
						st7=con.createStatement();
						st7.executeUpdate("insert into lbcms_dev_cc_standards_lessons(course_id,unit_id,lesson_id,standard_code) values ('"+courseId+"','"+unitId+"','"+newLessonId+"','"+strndId+"')");
						st7.close();
					}						
					 rs6.close();
					 st6.close();

					// Upto here

					// Sec Icons

					st8=con.createStatement();
					rs8=st8.executeQuery("select * from lbcms_dev_sec_icons where lesson_id='"+lessonId+"'");
					while(rs8.next())
					 {
						String secImageId=rs8.getString("image_id");
						String secTitle=rs8.getString("section_title");

						st9=con.createStatement();
						st9.executeUpdate("insert into lbcms_dev_sec_icons(course_id,unit_id,lesson_id,section_title,image_id) values ('"+courseId+"','"+unitId+"','"+newLessonId+"','"+secTitle+"',"+secImageId+")");
						st9.close();
					}						
					 rs8.close();
					 st8.close();

					// Upto here

			
					
					slNo=0;
					slContent="";
					
					System.out.println(" After ..lbcms_dev_lesson_content_master.");
					st4=con.createStatement();
					rs4=st4.executeQuery("select * from lbcms_dev_lesson_content_master where lesson_id='"+lessonId+"' order by slide_no");
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
					ps2.setString(2,unitId);
					ps2.setString(3,newLessonId);
					ps2.setInt(4,slNo);
					ps2.setString(5,slContent);
					ps2.executeUpdate();
					ps2.close();
					
					}
					st4.close();
					
					// First page content

					int secNo=0;
					String sectionTitle="",sectionContent="",sectionStatus="";


					System.out.println(" After ..lbcms_dev_lesson_firstpage_content.");
					st10=con.createStatement();
					rs10=st10.executeQuery("select * from lbcms_dev_lesson_firstpage_content where lesson_id='"+lessonId+"' order by section_no");
					while(rs10.next())
					{
						secNo=rs10.getInt("section_no");
						
						sectionTitle=rs10.getString("section_title");
						sectionContent=rs10.getString("section_content");
						sectionStatus=rs10.getString("sectionstatus");
						
						ps4=con.prepareStatement("insert into lbcms_dev_lesson_firstpage_content(course_id,unit_id,lesson_id,section_no,section_title,section_content,sectionstatus) values(?,?,?,?,?,?,?)");
						ps4.setString(1,courseId);
						ps4.setString(2,unitId);
						ps4.setString(3,newLessonId);
						ps4.setInt(4,secNo);
						ps4.setString(5,sectionTitle);
						ps4.setString(6,sectionContent);
						ps4.setString(7,sectionStatus);
						ps4.executeUpdate();
						ps4.close();
						
						}
						st10.close();

					//

					// Web Resources
						// First page content

					System.out.println("select * from lbcms_dev_lesson_web_resource where lesson_id='"+lessonId+"' order by web_title");
					String webTitle="",webURL="";
					System.out.println(" After ..lbcms_dev_lesson_web_resource.");
					st11=con.createStatement();
					rs11=st11.executeQuery("select * from lbcms_dev_lesson_web_resource where lesson_id='"+lessonId+"' order by web_title");
					while(rs11.next())
					{
											
						webTitle=rs11.getString("web_title");
						webURL=rs11.getString("web_url");
						if(webTitle==null || webTitle.equals(""))
						{
							//

						}
						else
						{
												
							ps5=con.prepareStatement("insert into lbcms_dev_lesson_web_resource(course_id,unit_id,lesson_id,web_title,web_url) values(?,?,?,?,?)");
							ps5.setString(1,courseId);
							ps5.setString(2,unitId);
							ps5.setString(3,newLessonId);
							ps5.setString(4,webTitle);
							ps5.setString(5,webURL);
							ps5.executeUpdate();
							ps5.close();
						}
						}
						st11.close();

					//

					//

					// Words
					
					word="";
					descWord="";
					System.out.println(" After ..lbcms_dev_lesson_words.");
					System.out.println("select * from lbcms_dev_lesson_words where lesson_id='"+lessonId+"' order by word");
					st5=con.createStatement();
					rs5=st5.executeQuery("select * from lbcms_dev_lesson_words where lesson_id='"+lessonId+"' order by word");
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
						ps3.setString(2,unitId);
						ps3.setString(3,newLessonId);
						ps3.setString(4,word);
						ps3.setString(5,descWord);
						ps3.executeUpdate();
						ps3.close();						
					}
					st5.close();
															
				
				
			}							// End of Units
			
			
			response.sendRedirect("SelectLessons.jsp?userid="+developerId+"&courseid="+courseId+"&unitid="+unitId+"&msg=success");

		}
	catch(Exception e)
	{
		System.out.println("The exception1 in CrtLessonArchives.jsp is....."+e);
	}
	finally
		{
			try
			{
				if(st2!=null)
					st2.close();
				if(st4!=null)
					st4.close();
				if(st5!=null)
					st5.close();
				if(st10!=null)
					st10.close();
				if(st11!=null)
					st11.close();
				if(ps1!=null)
					ps1.close();
				if(ps2!=null)
					ps2.close();
				if(ps3!=null)
					ps3.close();
				if(ps4!=null)
					ps4.close();
				if(ps5!=null)
					ps5.close();				
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 in CrtLessonArchives.jsp is....."+se.getMessage());
			}
		}
	
%>