<%@ page import = "java.sql.*,java.sql.Statement" language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	//final  String dbURL    = "jdbc:mysql://59.162.195.22.static-hyderabad.vsnl.net.in:3306/webhuddle?user=root&password=whizkids";
	Connection con=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs10=null,rs11=null,rs12=null,rsst1=null,rsst2=null,rsst3=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st10=null,st11=null,st12=null,stst1=null,stst2=null,stst3=null;
	String unitPath="",unitId="",unitName="",lessonId="",lessonName="",prevLink="",nextLink="",learnToday="",cQuestions="",matNeed="";
		String activity="",assessment="",assignment="",lLength="",nextUnit="",prevUnit="",lessonStatus="";
		String aTitle="",aAssessTitle="",aAssgnTitle="",devCourseId="";
		String str3="",tableName="",lmsTableName="",courseName="",lmsCourseName="";
		String prev2Link="",prev3Link="",next3Link="";
%>
<%	
	
	
	try{
		
		System.out.println("......navMenu..LBCMSDB....");
		String cmsPath = application.getInitParameter("lbcms_course_path");
		String uType=(String)session.getAttribute("logintype");
		String schoolId=(String)session.getAttribute("schoolid");
		String grade=(String)session.getAttribute("classid");
		String userId=(String)session.getAttribute("emailid");
		String courseId=(String)session.getAttribute("courseid");
		
		
		System.out.println("schoolId =" +schoolId);
		System.out.println("grade =" +grade);
		System.out.println("userID =" +userId);
		System.out.println("courseId =" +courseId);
		System.out.println("cmsPath =" +cmsPath);
		System.out.println("uType =" +uType);
		
		

		devCourseId=request.getParameter("dev_courseid");
		unitId=request.getParameter("unitid");
		lessonId=request.getParameter("lessonid");
		prev2Link=request.getParameter("prev2link");
		prev3Link=request.getParameter("prev3link");
		next3Link=request.getParameter("nextpage");

		/*
		System.out.println("devCourseId =" +devCourseId);
		System.out.println("unitId =" +unitId);
		System.out.println("lessonId =" +lessonId);
		System.out.println("prev2Link =" +prev2Link);
		System.out.println("prev3Link =" +prev3Link);
		System.out.println("next3Link =" +next3Link);
			*/
		
		
		//out.println("........next3Link...."+next3Link+"...prev2Link..."+prev2Link+"...prev3Link..."+next3Link+"\n");
		//out.println("<br><br>");
		//out.println("........uType...."+uType+"......schoolId...."+schoolId+"......devCourseId...."+devCourseId+"......grade...."+grade+"...courseName.."+courseName+"...unitId..."+unitId);

		con=con1.getConnection();
		
		// If course id is null, here I have hardcoded. I will change it later.

			  //courseId="c0001";

			  lmsTableName=schoolId+"_"+grade+"_"+courseId+"_workdocs";

		/*
		
		if(courseId==null)
		{
			st5=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs5=st5.executeQuery("select * from coursewareinfo where cbuilder_id='"+devCourseId+"' and school_id='"+schoolId+"'");
			if(rs5.next())
			{
				courseId=rs5.getString("course_id");
				System.out.println("lmscourseId...."+courseId);
				

			}
		}
		*/
		st3=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs3=st3.executeQuery("select * from coursewareinfo where course_id='"+courseId+"' and school_id='"+schoolId+"'");
		if(rs3.next())
		{
			lmsCourseName=rs3.getString("course_name");
			//System.out.println("lmsCourseName...."+lmsCourseName);			

		}
		st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs=st.executeQuery("SELECT lbcms_dev_course_master.course_name,lbcms_dev_units_master.unit_name,lbcms_dev_lessons_master.lesson_name FROM lbcms_dev_course_master LEFT JOIN lbcms_dev_units_master USING(course_id) LEFT JOIN lbcms_dev_lessons_master USING (course_id) where course_id='"+devCourseId+"' and lbcms_dev_units_master.unit_id='"+unitId+"' and lbcms_dev_lessons_master.lesson_id='"+lessonId+"'");
		if(rs.next())
		{
			courseName=rs.getString("course_name");	
			unitName=rs.getString("unit_name");	
			lessonName=rs.getString("lesson_name");

		}
		st1=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs1=st1.executeQuery("select * from lbcms_dev_lessons_master where course_id='"+devCourseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
		if(rs1.next())
		{
			aTitle=rs1.getString("lesson_activity");
			aAssessTitle=rs1.getString("lesson_assessment");
			aAssgnTitle=rs1.getString("lesson_assignment");

			String acts=rs1.getString("activitystatus");
			String assgns=rs1.getString("assignmentstatus");
			String assmts=rs1.getString("assessmentstatus");

			activity=rs1.getString("activity");
			if(activity==null)
			{
				activity="None";
			}
			assessment=rs1.getString("assessment");
			if(assessment=="" || assessment==null)
				assessment="None";
			assignment=rs1.getString("assignment");
			if(assignment=="" || assignment==null)
				assignment="None";
					


		str3=str3+"<html><head><title>"+courseName+"</title><META http-equiv='Content-Type' content='text/html; charset=ISO-8859-1'><meta name='generator' content='Namo WebEditor'><link rel='stylesheet' type='text/css' href='/LBCOM/lbcms/course_bundles/"+courseName+"/css/style.css' /><link rel='stylesheet' type='text/css' href='/LBCOM/lbcms/course_bundles/"+courseName+"/css/red.css' /><link rel='stylesheet' type='text/css' href='/LBCOM/lbcms/course_bundles/"+courseName+"/css/intro_style.css' /><link rel='stylesheet' type='text/css' href='/LBCOM/lbcms/course_bundles/"+courseName+"/css/activity_style.css'/><link href='/LBCOM/lbcms/course_bundles/"+courseName+"/slides/images/slide_css.css' rel='stylesheet' type='text/css'><script src='/LBCOM/lbcms/course_bundles/"+courseName+"/slides/images/script.js'></script><bgsound id=pptSound><style>a {	text-decoration:underline;}a:hover {	text-decoration:none;	color:#000;}</style></head><body><table class='main_table' align='center'><tr><td class='main_table_c1'></td><td class='main_table_c2'><table class='main_table2' cellpadding='0' cellspacing='0'><tr><td class='main_table2_th'><table class='titel_table' cellpadding='0' cellspacing='0'><tr><td class='title_table_c1'>"+courseName+"</td><td class='title_table_c2'><a class='home_button' href='/LBCOM/lbcms/course_bundles/"+courseName+"/Lessons.html' title='Course Home'><span></span></a></td></tr></table></td></tr><tr><td class='main_table2_tb'></td></tr><tr><td class='main_table2_tc'><table class='slides_table'><tr><td class='slides_table_tl'>"+unitName+": "+lessonName+"</td></tr><tr><td><div align='right'><table border='0' cellpadding='0' cellspacing='0'><tr><td><p align='right'><a href='/LBCOM/lbcms/course_bundles/"+courseName+"/"+unitName+"/"+prev2Link+"' target='_self'><img src='/LBCOM/lbcms/course_bundles/"+courseName+"/images/micon_intro.jpg' width='161' height='40' border='0'></a></p></td><td width='161'><p align='center'><a href='/LBCOM/lbcms/course_bundles/"+courseName+"/"+unitName+"/"+prev3Link+"' target='_self'><img src='/LBCOM/lbcms/course_bundles/"+courseName+"/images/micon_lesson.jpg' width='161' height='40' border='0'></a></p></td><td width='161'><p align='left'><img src='/LBCOM/lbcms/course_bundles/"+courseName+"/images/micon_activities.jpg' width='161' height='40' border='0'></p></td></tr></table></div></td></tr><tr><td width='304'><table>";
					
					 if(!acts.equals("none"))
					{
						 //activity=activity.replaceAll("http://oh.learnbeyond.net/LBCOM/coursedeveloper/CB_images/","../slides/images/");
					activity=activity.replaceAll("%20"," ");
					//activity=activity.replaceAll("http://oh.learnbeyond.net/LBCOM","http://oh.learnbeyond.net:8080/LBCOM");				activity=activity.replaceAll("http://oh.learnbeyond.net:8080/LBCOM/coursedeveloper/course_bundles/"+courseName+"/slides/images/","../slides/images/");
					activity=activity.replaceAll("img src=\"course_bundles/"+courseName+"/slides/images/","img src=\"../slides/images/");					activity=activity.replaceAll("\"CB_images","\"http://oh.learnbeyond.net:8080/LBCOM/coursedeveloper/CB_images");
					activity=activity.replaceAll("param name=\"url\" value=\"CB_images","param name=\"url\" value=\"http://oh.learnbeyond.net:8080/LBCOM/coursedeveloper/CB_images");
					
					// Sec Icons
						String secImage="";
						int secImageId=0;
						st10=con.createStatement();
						rs10=st10.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+devCourseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='acttitleicon'");
						if(rs10.next())
						 {
							secImageId=rs10.getInt("image_id");
							
							st11=con.createStatement();
								rs11=st11.executeQuery("select * from lbcms_dev_sec_icons_master where image_id="+secImageId+"");
								if(rs11.next())
								 {
									secImage=rs11.getString("image_name");
									//System.out.println("secImage..."+secImage);
									
								 }
								 rs11.close();
								 st11.close();
							
						 }
						 else
						{
							 secImage="Course_Icon_blank.png";

						}
						 rs10.close();
						 st10.close();

						 //secImage=secImage.replaceAll("img src=\"course_bundles/"+courseName+"/slides/images/","img src=\"../slides/images/");	

		// Sec Icons Upto here

					//str3=str3+"<tr><td rowspan='2' valign='top'><img src='../images/divider_info.jpg' width='800' height='2' border='0'></td></tr><tr><td width='79' rowspan='2' valign='top'><img src='/LBCOM/lbcms/coursebuilder/SectionImages/"+secImage+"' width='84' height='80' border='0'></td><td class='ahead1'>"+aTitle+"</td></tr><tr><td><ul><FONT face=Verdana size='2' color='#191919'>&nbsp;"+activity+"</font></ul></td></tr>";
					
					str3=str3+"<tr><td colspan='2'><img src='../images/divider_info.jpg' width='800' height='2' border='0'></td></tr><tr><td width='79' rowspan='2' valign='top'><img src='/LBCOM/lbcms/coursebuilder/SectionImages/"+secImage+"' width='84' height='80' border='0'></td><td class='ahead3'>"+aTitle+"</td></tr><tr><td><ul><FONT face=Verdana size='2' color='#191919'>&nbsp;"+activity+"</font></ul></td></tr>";
						 
					}
					 if(!assmts.equals("none"))
					{
						//assessment=assessment.replaceAll("http://oh.learnbeyond.net/LBCOM/coursedeveloper/CB_images/","../slides/images/");
					assessment=assessment.replaceAll("%20"," ");

					//assessment=assessment.replaceAll("http://oh.learnbeyond.net/LBCOM","http://oh.learnbeyond.net:8080/LBCOM");
					//assessment=assessment.replaceAll("http://oh.learnbeyond.net:8080/LBCOM/coursedeveloper/course_bundles/"+courseName+"/slides/images/","../slides/images/");
					assessment=assessment.replaceAll("img src=\"course_bundles/"+courseName+"/slides/images/","img src=\"../slides/images/");

					assessment=assessment.replaceAll("\"CB_images","\"http://oh.learnbeyond.net:8080/LBCOM/coursedeveloper/CB_images");
					assessment=assessment.replaceAll("param name=\"url\" value=\"CB_images","param name=\"url\" value=\"http://oh.learnbeyond.net:8080/LBCOM/coursedeveloper/CB_images");

					
					// Sec Icons
					String secImage="";
					int secImageId=0;
					st10=con.createStatement();
					
					//System.out.println("select * from lbcms_dev_sec_icons where course_id='"+devCourseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='assmttitleicon'");
					
					rs10=st10.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+devCourseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='assmttitleicon'");
					if(rs10.next())
					 {
						secImageId=rs10.getInt("image_id");
						
						st11=con.createStatement();
							rs11=st11.executeQuery("select * from lbcms_dev_sec_icons_master where image_id="+secImageId+"");
							if(rs11.next())
							 {
								secImage=rs11.getString("image_name");
								//System.out.println("secImage..."+secImage);
								
							 }
							 rs11.close();
							 st11.close();
						
					 }
					 else
					{
						 secImage="Course_Icon_blank.png";

					}
					 rs10.close();
					 st10.close();

		// Sec Icons Upto here
					
					
					str3=str3+"<tr><td colspan='2'><img src='../images/divider_info.jpg' width='800' height='2' border='0'></td></tr><tr><td width='79' rowspan='2' valign='top'><img src='/LBCOM/lbcms/coursebuilder/SectionImages/"+secImage+"' width='84' height='80' border='0'></td><td class='ahead2'>"+aAssessTitle+"</td></tr><tr><td><ul><FONT face=Verdana size='2' color='#191919'>&nbsp;"+assessment+"</font></ul></td></tr>";

					// Assessments names

					str3=str3+"<tr><td>&nbsp;</td><td>";
					if(uType.equals("teacher"))
						{
					st12=con.createStatement();
					
					rs12=st12.executeQuery("select * from lbcms_dev_assessment_master  where course_id='"+devCourseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
					while(rs12.next())
					{
						String slNo=rs12.getString("slno");
						String assmtId=rs12.getString("assmt_id");
						String assmtName=rs12.getString("assmt_name");
						String catId=rs12.getString("category_id");

						//str3=str3+"<tr><td>&nbsp;</td></tr><tr><td colspan='2'><font color='red'><a href="+assmtName+"</font></td></tr><tr>";
						str3=str3+"<font color='red'><a href='#' onClick=\"viewAssmt('"+assmtId+"');return false;\">"+assmtName+"</a></font>\n";

					}
					st12.close();
					rs12.close();
						
						//
					str3=str3+"</td><tr>";
						}
						else
						{

							// Student Assessments from LMS
					 
							String chances="",stuPassword="";
	String examId="",linkStr="",teacherId="",examName="";
	String bgColor="",foreColor="";
	String status="",eType="",tdate="",fDate="";
	String durationInSecs="";
	int marks=0;
	int totRecords=0,start=0,end=0,c=0,ass=0,sub=0,pen=0,eval=0,markScheme=0;
	
	int index=0,startIndex=0,examPassword=0,currentPage=0;
	int i=0,childStatus=0,masterStatus=0,attempted=0,noOfAttempts=0;
	Date currentDate=null,fromDate=null,toDate=null,createDate=null;
	boolean flag=false,dateFlag=false,mAttemptsFlag=false;
	Time currentTime=null,toTime=null,fromTime=null;
	String nChances="";
	float totalMarks=0.0f,shortAnsMarks=0.0f;
	String scheme="";

	String sortBy,sortType,sortImg="";		
							 String stdId=(String)session.getAttribute("emailid");
							String tblName=schoolId+"_"+stdId;
							stst1=con.createStatement();

							//System.out.println("select * from lbcms_dev_assessment_master  where course_id='"+devCourseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");


							rsst1=stst1.executeQuery("select * from lbcms_dev_assessment_master where course_id='"+devCourseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");					
							while(rsst1.next())
							{
								String examType=rsst1.getString("category_id");

								int assmtNO=rsst1.getInt("slno");

								//
								stst3=con.createStatement();

								rsst3=stst3.executeQuery("select * from exam_tbl where school_id='"+schoolId+"' and course_id='"+courseId+"'");
								if(rsst3.next())
								{
								   examId=rsst3.getString("exam_id");
								}

								//



								stst2=con.createStatement();
								
								//System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$"+assmtNO+".....examId..."+examId);

								//System.out.println("select s.*,e.*,c.total_marks,curdate() t ,curtime() ct from "+tblName+" as s inner join exam_tbl as e inner join "+schoolId+"_cescores as c on s.exam_id='"+examId+"' and e.school_id='"+schoolId+"' and e.course_id='"+courseId+"' and e.exam_type='"+examType+"' and e.status='1' and c.school_id='"+schoolId+"' and c.work_id=e.exam_id and e.exam_id='"+examId+"' and user_id='"+stdId+"' and c.report_status=1 and s.start_date is NOT NULL");
								
								rsst2=stst2.executeQuery("select s.*,e.*,c.total_marks,curdate() t ,curtime() ct from "+tblName+" as s inner join exam_tbl as e inner join "+schoolId+"_cescores as c on s.exam_id=e.exam_id and e.school_id='"+schoolId+"' and e.course_id='"+courseId+"' and e.exam_type='"+examType+"' and e.status='1' and c.school_id='"+schoolId+"' and c.work_id=e.exam_id and user_id='"+stdId+"' and c.report_status=1 and s.start_date is NOT NULL");
								//rsst2=stst2.executeQuery("select s.*,e.*,c.total_marks,curdate() t ,curtime() ct from "+tblName+" as s inner join exam_tbl as e inner join "+schoolId+"_cescores as c on s.exam_id='"+examId+"' and e.school_id='"+schoolId+"' and e.course_id='"+courseId+"' and e.exam_type='"+examType+"' and e.status='1' and c.school_id='"+schoolId+"' and c.work_id=e.exam_id and e.exam_id='"+examId+"' and user_id='"+stdId+"' and c.report_status=1 and s.start_date is NOT NULL");
								if(rsst2.next())
								{	
									//System.out.println("rsst2 if...............**********");
									


									 int hrs=0;
									 int mins=0;
			
											//while((i<=pageSize)&&(startIndex<totRecords)) {
											
													dateFlag=false;
													mAttemptsFlag=false;

													examName=rsst2.getString("exam_name");
													examName=examName.replaceAll("&#39;","&#92;&#39;");
													
													examId=rsst2.getString("exam_id");
													examType=rsst2.getString("exam_type");
													currentDate=rsst2.getDate("t");
													// Individual dates
													
													fromDate=rsst2.getDate("start_date");
													toDate=rsst2.getDate("end_date");
													 // Upto here

													//fromDate=rs.getDate("from_date");
													//toDate=rs.getDate("to_date");
													teacherId=rsst2.getString("teacher_id");
													//System.out.println("teacherId...."+teacherId);
													createDate=rsst2.getDate("create_date");
													toTime=rsst2.getTime("to_time");
													fromTime=rsst2.getTime("from_time");
													currentTime=rsst2.getTime("ct");
													masterStatus=rsst2.getInt("status");
													childStatus=rsst2.getInt("exam_status");
													markScheme=rsst2.getInt("grading");
													tableName=schoolId+"_"+examId+"_"+(createDate.toString()).replace('-','_');
													hrs=rsst2.getInt("dur_hrs");
													mins=rsst2.getInt("dur_min");
													durationInSecs=String.valueOf((hrs*360)+(mins*60));
													totalMarks=rsst2.getInt("total_marks");
																							
													
													attempted=rsst2.getInt("count");
													if (fromDate==null){
														
													   fDate="-";
													}
													else{
														fDate=String.valueOf(fromDate);
													}
									

													if (toDate==null){
														
														tdate="-";
													}else{
														tdate=String.valueOf(toDate);
													}
																			
													if (childStatus==0)
														foreColor="#FF0000";
													else
														foreColor="green";//foreColor="#FF7B4F";
													
									%>
									<tr>
								   
									<!--  <td width="14" height="18" align="center" valign="middle"></td> -->
									
									 <% 
									 if (masterStatus==1) {
										 
										// noOfAttempts=rs.getInt("mul_attempts");
										 noOfAttempts=rsst2.getInt("max_attempts");

										 stuPassword=rsst2.getString("exam_password");
										 examPassword=rsst2.getInt("password");
										 if (noOfAttempts==-1){
											 chances="No&nbsp;Limit";
											 nChances="-";
											 noOfAttempts=attempted+2;
										 }else{
											chances=attempted+"/"+noOfAttempts;
											nChances=(attempted+1)+"/"+noOfAttempts;

										 }
												 
										if ((noOfAttempts<=attempted)&&(childStatus>=1))
											 mAttemptsFlag=false;
										 else
											 mAttemptsFlag=true;
										
										if ((fromDate==null)&&(toDate!=null))
										{
											if (currentDate.compareTo(toDate)<=0)
												dateFlag=true;
										}
										else if ((fromDate!=null)&&(toDate==null))
										{
											if (currentDate.compareTo(fromDate)>=0) 
												dateFlag=true;
										}
										else if ((fromDate==null)&&(toDate==null))
										{	
											dateFlag=true;
										}
										
										if((fromDate!=null)&&(toDate!=null))
										{
												if ((currentDate.compareTo(fromDate)>=0)&&((currentDate.compareTo(toDate)<=0)))
												{
													dateFlag=true;
												}
												
										}
										
										if ((dateFlag==true)&&(currentDate.compareTo(fromDate)==0))
										{
											  if ((currentTime).after(fromTime))
											  { 	
												dateFlag=true;
											  }
											  else 
												dateFlag=false;
											
										}
										if ((dateFlag==true)&&(toDate!=null)&&(currentDate.compareTo(toDate)==0))
										{	
											
											 if ((currentTime).before(toTime))
											  {
												 dateFlag=true;	
												
											  }
											  else if ((currentTime).after(toTime))
											  {
												dateFlag=true;
																
											  }
											  else
											  {
												dateFlag=false;
																
											  }
										 }
									 }
									 else {

										mAttemptsFlag=false;
										dateFlag=false;
									 }
										
									if ((mAttemptsFlag)&&(dateFlag)) {
										
										
										%>  											
										
										<td class="griditem">&nbsp;<a href="#" onClick="openpassword('<%=examId%>','<%=tableName%>','<%=teacherId%>','<%=examPassword%>','<%=stuPassword%>','<%=examType%>','<%=nChances %>','<%=markScheme%>','<%=durationInSecs%>'); return false;" ><%=examName.replaceAll("&#92;&#39;","&#39;")%></a></td>
									<%     
									} else {
											
											foreColor="blue";
									%>
										<td class="griditem">&nbsp;<%=examName%></td>
									 <%} 
									if(examType.equals("ST")){%>
										<td class="griditem">&nbsp;<%=chances%></td>
									<%} else{%>
										<td class="griditem">&nbsp;<b><a href="#" onClick="return openwin('<%=examId%>','<%=examName.replaceAll("'","&#92;&#39;")%>','<%=rsst2.getInt("mul_attempts")%>','<%=examType%>','<%=createDate%>','<%=teacherId%>','<%=courseId%>','<%=rsst2.getString("version")%>','<%=stuPassword%>','<%=mAttemptsFlag%>','<%=attempted%>','<%=totalMarks%>','<%=rsst2.getString("status")%>');" target="contents" ><%=chances%></a></td> 
										
									<%}%>
									<td class="griditem"><%=rsst2.getString("instructions")%></td>
									<td class="griditem"> <%=fDate%></td>
									<td class="griditem"><%=tdate%></td>
									<td class="griditem"> <%=fromTime%></td>
									<td class="griditem"> <%=toTime%></td>
									<td class="griditem"> <%=rsst2.getInt("dur_hrs")%>:<%=rsst2.getInt("dur_min")%>
									</td>
									<input type="hidden" name="attempted" value="<%=attempted%>">
									<input type="hidden" name="version" value="<%=rsst2.getString("version")%>">
									<input type="hidden" name="status" value="<%=rsst2.getString("status")%>"> 
									</tr>
								  <%
										 
									




								 

								}
								rsst2.close();
								stst2.close();

					 

							// Student Assessments from LMS upto here
					


						}
						rsst1.close();
						stst1.close();

					}
					}
					 if(!assgns.equals("none"))
					{
						 
						//assignment=assignment.replaceAll("http://oh.learnbeyond.net/LBCOM/coursedeveloper/CB_images/","../slides/images/");
					assignment=assignment.replaceAll("%20"," ");

					//assignment=assignment.replaceAll("http://oh.learnbeyond.net/LBCOM","http://oh.learnbeyond.net:8080/LBCOM");
					//assignment=assignment.replaceAll("http://oh.learnbeyond.net:8080/LBCOM/coursedeveloper/course_bundles/"+courseName+"/slides/images/","../slides/images/");
					assignment=assignment.replaceAll("img src=\"course_bundles/"+courseName+"/slides/images/","img src=\"../slides/images/");

					assignment=assignment.replaceAll("\"CB_images","\"http://oh.learnbeyond.net:8080/LBCOM/coursedeveloper/CB_images");
					assignment=assignment.replaceAll("param name=\"url\" value=\"CB_images","param name=\"url\" value=\"http://oh.learnbeyond.net:8080/LBCOM/coursedeveloper/CB_images");
					
					// Sec Icons
						String secImage="";
						int secImageId=0;
						st10=con.createStatement();
						rs10=st10.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+devCourseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='assgntitleicon'");
						if(rs10.next())
						 {
							secImageId=rs10.getInt("image_id");
							
							st11=con.createStatement();
								rs11=st11.executeQuery("select * from lbcms_dev_sec_icons_master where image_id="+secImageId+"");
								if(rs11.next())
								 {
									secImage=rs11.getString("image_name");
									//System.out.println("secImage..."+secImage);
									
								 }
								 rs11.close();
								 st11.close();
							
						 }
						 else
						{
							 secImage="Course_Icon_blank.png";

						}
						 rs10.close();
						 st10.close();

		// Sec Icons Upto here
					
					str3=str3+"<tr><td colspan='2'><img src='../images/divider_info.jpg' width='800' height='2' border='0'></td></tr><tr><td width='79' rowspan='2' valign='top'><img src='/LBCOM/lbcms/coursebuilder/SectionImages/"+secImage+"' width='84' height='80' border='0'></td><td class='ahead3'>"+aAssgnTitle+"</td></tr><tr><td><ul><FONT face=Verdana size='2' color='#191919'>&nbsp;"+assignment+"</font></ul></td></tr>";

					

				// Assignment count start from here

					 					
					if(devCourseId.equals("DC008")||devCourseId.equals("DC015")||devCourseId.equals("DC032")||devCourseId.equals("DC016")||devCourseId.equals("DC026")||devCourseId.equals("DC049")||devCourseId.equals("DC030")||devCourseId.equals("DC018")||devCourseId.equals("DC031")||devCourseId.equals("DC047")||devCourseId.equals("DC055")||devCourseId.equals("DC056")||devCourseId.equals("DC023")||devCourseId.equals("DC036")|devCourseId.equals("DC060")||devCourseId.equals("DC036")||devCourseId.equals("DC057")||devCourseId.equals("DC046")||devCourseId.equals("DC042")||devCourseId.equals("DC058")||devCourseId.equals("DC024")||devCourseId.equals("DC019"))
					{
						tableName="lbcms_dev_assgn_social_larts_content_master";
						
					
					}
					else if(devCourseId.equals("DC048")||devCourseId.equals("DC005")||devCourseId.equals("DC043")||devCourseId.equals("DC044")||devCourseId.equals("DC051")||devCourseId.equals("DC037")||devCourseId.equals("DC080")||devCourseId.equals("DC050")||devCourseId.equals("DC020")||devCourseId.equals("DC017")||devCourseId.equals("DC059"))
					{
						tableName="lbcms_dev_assgn_science_content_master";
						
					
					}
					else
					{
						tableName="lbcms_dev_assgn_math_content_master";
						
					
					}
					
					st1=con.createStatement();
					
					//System.out.println("select * from "+tableName+" where course_id='"+devCourseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");

					str3=str3+"<td colspan='1'>&nbsp;</td><td colspan='1'>";
					rs1=st1.executeQuery("select * from "+tableName+" where course_id='"+devCourseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");					
					while(rs1.next())
					{	
						int assgnNo=rs1.getInt("slno");

						//LMS

						if(uType.equals("teacher"))
						{
							st2=con.createStatement();
							//System.out.println("select * from "+lmsTableName+" where builder_courseid='"+devCourseId+"' and builder_workid='"+assgnNo+"'");
							rs2=st2.executeQuery("select * from "+lmsTableName+" where builder_courseid='"+devCourseId+"' and builder_workid='"+assgnNo+"'");
							if(rs2.next())
							{	
								
								String assgnName=rs2.getString("doc_name");
								String workId	 =rs2.getString("work_id");;
							 str3=str3+"<a href='#' onClick=\"viewLMSAssgn('"+workId+"');return false;\"><font color='green'>"+assgnName+"</font></a>\n";

							
							}
							else
							{
								String assgnName=rs1.getString("assgn_name");
							 str3=str3+"<a href='#' onClick=\"viewAssgn('"+assgnNo+"');return false;\"><font color='red'>"+assgnName+"</font></a></td>\n";
							}
							st2.close();
							rs2.close();
						}
						else
						{
						//Variables lms side
						   //String  classId=grade;
						   String studentId=(String)session.getAttribute("emailid");

						   %>
								<table>
						   <%
						
							st2=con.createStatement();

							//System.out.println("=======================");
							//System.out.println("select curdate(),d.status,d.start_date,d.end_date,d.work_id,max(submit_count) submit_count ,w.doc_name,w.teacher_id,category_id,w.modified_date,w.asgncontent,w.to_date,w.marks_total,w.max_attempts,w.status workstatus,w.from_date from "+schoolId+"_"+grade+"_"+courseId+"_workdocs w inner join " +schoolId+"_"+grade+"_"+courseId+"_dropbox d   on w.work_id=d.work_id and d.status!=5 where d.student_id='"+studentId+"' and w.builder_workid='"+assgnNo+"' and w.status='1' and (d.start_date<=curdate())");

							rs2=st2.executeQuery("select curdate(),d.status,d.start_date,d.end_date,d.work_id,max(submit_count) submit_count ,w.doc_name,w.teacher_id,category_id,w.modified_date,w.asgncontent,w.to_date,w.marks_total,w.max_attempts,w.status workstatus,w.from_date from "+schoolId+"_"+grade+"_"+courseId+"_workdocs w inner join " +schoolId+"_"+grade+"_"+courseId+"_dropbox d   on w.work_id=d.work_id and d.status!=5 where d.student_id='"+studentId+"' and w.builder_workid='"+assgnNo+"' and w.status='1' and (d.start_date<=curdate())"); 
							 
	
							// While Start here
							 while(rs2.next())
								{
									boolean atmtsAllOver=true,deadLineFlag=false,startLineFlag=false;
									
									
									String workId=rs2.getString("work_id");
									if(workId==null)
									{
										workId="";
									}
									//System.out.println("workId................"+workId);
									if(!workId.equals(""))
									{
									String categoryId=rs2.getString("category_id");
									String docName=rs2.getString("doc_name");

									docName=docName.replaceAll("&#39;","&#92;&#39;");

									docName=docName.replaceAll("&#34;","&#92;&#34;");

									//docName=docName.replaceAll("\"","&#92;&#34;");

									String teacherId=rs2.getString("teacher_id");
									int maxAttempts=rs2.getInt("max_attempts");
									String workStatus=rs2.getString("workstatus");
									int status=rs2.getInt("status");
									int submitCount=rs2.getInt("submit_count");		
									String tag="",deadLine="",foreColor="";
									
									
									
									if(maxAttempts!=-1)
										tag=""+maxAttempts;
									else
										tag="No Limit";
									
												
								/*
									if(status==0)				//student not yet viewed the work document
										foreColor="#FF0000";
									else if(status==1)			//the student viewed the document
										foreColor="#006666";		
									else if (status==2)			//the student submitted the work given
										foreColor="#6D79CD";
									else if (status==3)		    //the teacher viewed the submitted work
										foreColor="#005900";		
									else if ((status==4)||(status==5))//the teacher had evaluated||the student viewed the results
										foreColor="#FF7B4F";
									else if (status==6)
										foreColor="#993399";

										*/

									if(rs2.getString("end_date")!=null)
									{
										if(!rs2.getString("end_date").equals("0000-00-00"))
										{ 	  
											if((rs2.getDate(1).compareTo(rs2.getDate("end_date")) <=0))
											{  
												/*current date is before than the deadline*/
												deadLineFlag=true;
												foreColor="green";
											}
											else
											{
												deadLineFlag=false;		    //last date to submit is over
												foreColor="blue";
											}
											deadLine=rs2.getDate("end_date").toString();
										}
									}
									else
										deadLine="-";

									if((rs2.getDate(1).compareTo(rs2.getDate("end_date")) <=0))
									{
										if((rs2.getDate(1).compareTo(rs2.getDate("start_date")) >=0))
											{  
												/*current date is before than the deadline*/
												startLineFlag=true;
												foreColor="green";
											}
											else
											{
												startLineFlag=false;		    //last date to submit is over
												foreColor="blue";
											}
										
									}
									if(!tag.equals("No Limit"))
									{
										if(submitCount==0 && rs2.getDate(1).compareTo(rs2.getDate("start_date")) <=0)
										{
											foreColor="red";
										}
										else if(submitCount==0 && rs2.getDate(1).compareTo(rs2.getDate("end_date")) <=0)
										{
											foreColor="red";
										}
										else if(submitCount==Integer.parseInt(tag))
										{
											foreColor="blue";
											atmtsAllOver=false;
										}
									}
									else
									{
										if(submitCount==0 && rs2.getDate(1).compareTo(rs2.getDate("start_date")) <=0)
										{
											foreColor="red";
										}
									}
									
									
									
						%>	
							<tr >
								<td class="griditem">
									<%
							
									if(deadLineFlag)
									{
							%>

							
										<a href="/LBCOM/coursemgmt/student/InboxFrameAssgnBuilderLMS.jsp?workid=<%=workId%>&cat=<%=categoryId%>&coursename=<%=lmsCourseName%>&status=<%=status%>&flag=<%=deadLineFlag%>&workstatus=<%=workStatus%>&maxattempts=<%=maxAttempts%>&submitcount=<%=submitCount%>&devcourseid=<%=devCourseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>&prev2link=<%=prev2Link%>&prev3link=<%=prev3Link%>&nextpage=<%=next3Link%>" onClick="parent.category.document.leftpanel.asgncategory.value='<%=categoryId%>'" target="contents"><%=docName.replaceAll("&#92;&#39;","&#39;")%></a>
							<%
										}
										else if(!deadLineFlag)
										{
										%>			
											 <font size="2" face="verdana" color="<%=foreColor%>" title="Due date is passed"><%=docName.replaceAll("&#92;&#39;","&#39;")%>
										<%

										}
										else if (!startLineFlag)
										{
											
											
							%>			
											 <font size="2" face="verdana" color="<%=foreColor%>" title="Due date is passed"><%=docName.replaceAll("&#92;&#39;","&#39;")%>
							<%
										}
										else if(atmtsAllOver)
										{
										%>			
											 <font size="2" face="verdana" color="<%=foreColor%>" title="Due date is passed"><%=docName.replaceAll("&#92;&#39;","&#39;")%>
										<%
										}
										
										%>
								</td>
								<%
											
										docName=docName.replaceAll("\"","&#92;&#34;");
								%>
								<td class="griditem">
									
										<a href="javascript://" onClick="showHistory('<%=workId%>','<%=maxAttempts%>','<%=categoryId%>','<%=docName.replaceAll("'","&#92;&#39;")%>'); return false;">
											<%=submitCount%>&nbsp;/&nbsp;<%=tag%>
										</a>
									
								</td>
								<td class="griditem">
									<%=rs2.getInt("marks_total")%>
								</td>
								<td class="griditem">
									<%= rs2.getDate("start_date")%>
								</td>
								<td class="griditem">
									<%=deadLine%>
								</td>
							</tr>
								
						<%
									}
								}

						%></table><%

							// While Ends here

						} //end of else

						

					// LMS upto here
						/*
						String assgnName=rs1.getString("assgn_name");
						str3=str3+"<td colspan='1'><font color='red'><a href='#' onClick=\"viewAssgn('"+assgnNo+"');return false;\">"+assgnName+"</a></font></td>\n";
						*/

					
					}
					st1.close();
					rs1.close();
					}




					// Sections starts from here

					int k=5;
					st4=con.createStatement();
					rs4=st4.executeQuery("select * from lbcms_dev_lesson_firstpage_content where course_id='"+devCourseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_no>5 order by section_no");
					while(rs4.next())
					{
					
						String secTitle="",secContent="";
						secTitle=rs4.getString("section_title");
						secContent=rs4.getString("section_content");

						if(secContent=="" || secContent==null)
							secContent="None";
					//assessment=assessment.replaceAll("http://oh.learnbeyond.net/LBCOM/coursedeveloper/CB_images/","../slides/images/");
					secContent=secContent.replaceAll("%20"," ");

					secContent=secContent.replaceAll("http://oh.learnbeyond.net/LBCOM","http://oh.learnbeyond.net:8080/LBCOM");
					secContent=secContent.replaceAll("http://oh.learnbeyond.net:8080/LBCOM/coursedeveloper/course_bundles/"+courseName+"/slides/images/","../slides/images/");
					secContent=secContent.replaceAll("img src=\"course_bundles/"+courseName+"/slides/images/","img src=\"../slides/images/");

					secContent=secContent.replaceAll("\"CB_images","\"http://oh.learnbeyond.net:8080/LBCOM/coursedeveloper/CB_images");
					secContent=secContent.replaceAll("param name=\"url\" value=\"CB_images","param name=\"url\" value=\"http://oh.learnbeyond.net:8080/LBCOM/coursedeveloper/CB_images");


						// Sec Icons
					String secImage="";
					int secImageId=0;
					st10=con.createStatement();
					rs10=st10.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+devCourseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='"+k+"'");
					if(rs10.next())
					 {
						secImageId=rs10.getInt("image_id");
						
						st11=con.createStatement();
							rs11=st11.executeQuery("select * from lbcms_dev_sec_icons_master where image_id="+secImageId+"");
							if(rs11.next())
							 {
								secImage=rs11.getString("image_name");
								//System.out.println("secImage..."+secImage);
								
							 }
							 rs11.close();
							 st11.close();
						
					 }
					 else
					{
						 secImage="Course_Icon_blank.png";

					}
					 rs10.close();
					 st10.close();

		// Sec Icons Upto here
					str3=str3+"<tr><td colspan='2'><img src='../images/divider_info.jpg' width='800' height='2' border='0'></td></tr><tr><td width='79' rowspan='2' valign='top'><img src='/LBCOM/lbcms/coursebuilder/SectionImages/"+secImage+"' width='84' height='80' border='0'></td><td class='head2'>"+secTitle+"</td></tr><tr><td><ul><FONT face=Verdana size='2' color='#191919'>"+secContent+"</font></ul></td></tr><tr><td colspan='2'><img src='../images/divider_info.jpg' width='800' height='2' border='0'></td></tr>";
					}
					rs4.close();
					st4.close();					
					
					str3=str3+"<tr><td width='79'>&nbsp;</td><td width='720'>&nbsp;</td></tr></table></td></tr></table></td></tr><tr><td class='main_table2_tb'></td></tr><tr><td class='main_table2_te'><table class='bottom_table' cellpadding='0' cellspacing='0' align='right'><tr><td class='main_table2_copy'>Mahoning Unlimited Classroom © All Rights Reserved.</td><td class='bottom_table_c1'><a class='previous_button' href='/LBCOM/lbcms/course_bundles/"+courseName+"/"+unitName+"/"+prev3Link+"' title='Previous'></a></td><td class='bottom_table_c2'><a class='next_button' href='/LBCOM/lbcms/course_bundles/"+courseName+"/"+unitName+"/"+next3Link+"' title='Next'></a></td></tr></table></td></tr></table></td><td class='main_table_c3'></td></tr></table></body></html>"+"\n";
					out.println(str3);
					rs1.close();
					st1.close();
				
	
		}
%>

		<input type="hidden" name="dev_courseid" value="<%=courseId%>">
		<input type="hidden" name="unitid" value="<%=unitId%>">
		<input type="hidden" name="lessonid" value="<%=lessonId%>">
		<input type="hidden" name="prev2link" value="<%=prev2Link%>">
		<input type="hidden" name="prev3link" value="<%=prev3Link%>">
		<input type="hidden" name="nextpage" value="<%=next3Link%>">	
<%
	}catch(Exception e){
		try{
		
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			//ExceptionsFile.postException("QuestionImport.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			
		}
		e.printStackTrace();
	}
	
	
%>

<SCRIPT LANGUAGE="JavaScript">
<!--
function viewAssmt(sno)
{
	//alert("yes"+sno);
	
	var win;
		win=window.open("/LBCOM/lbcms/AssmtBuilder/exams/<%=devCourseId%>/"+sno+"/1.html");
	
}
function viewAssgn(sno)
{
	//alert("yes"+sno);
	
	var assgnwin;
		assgnwin=window.open("/LBCOM/lbcms/ViewCBAssignInfo.jsp?assgnno="+sno+"&courseid=<%=devCourseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>");
	
}

function viewLMSAssgn(workid)
{
	//alert("yes"+sno);
	
	window.open("/LBCOM/coursemgmt/teacher/ShowAssignment.jsp?workid="+workid,"Document","resizable=no,scrollbars=yes,width=800,height=500,toolbars=no");
	
}
function openpassword(eId,tblName,teacherId,expassword,stupassword,etype,chances,markscheme,durationinsecs)
	{
		/*
		parent.category.document.leftpanel.asgncategory.value=etype;
		if(top.studenttopframe.stuExamHistoryWin!=null && ! top.studenttopframe.stuExamHistoryWin.closed)
			top.studenttopframe.stuExamHistoryWin.close();
		if(top.studenttopframe.stuAnsSheetWin!=null && !top.studenttopframe.stuAnsSheetWin.closed)
			top.studenttopframe.stuAnsSheetWin.close();
			*/
		if(expassword==1){
			if(stupassword!="")
				window.location.href="ExamPassword.jsp?examid="+eId+"&tblname="+tblName+"&teacherid="+teacherId+"&exampassword="+expassword+"&status=0&examtype="+etype+"&start=0&totrecords=1&chances="+chances+"&markscheme="+markscheme+"&durationinsecs="+durationinsecs;	
			else{
				alert("Sorry! You cannot take the Assessment.");
				return false;
			}
		}else{
			window.location="/LBCOM/exam/ExamDetailsLMS.jsp?examid="+eId+"&tblname="+tblName+"&teacherid="+teacherId+"&exampassword="+expassword+"&examtype="+etype+"&chances="+chances+"&markscheme="+markscheme+"&durationinsecs="+durationinsecs+"&devcourseid=<%=devCourseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>&prev2link=<%=prev2Link%>&prev3link=<%=prev3Link%>&nextpage=<%=next3Link%>";
			//win=window.open("ExamPlayer.jsp?examid="+eId+"&tblname="+tblName+"&teacherid="+teacherId+"&exampassword="+expassword+"&examtype="+etype+"&chances="+chances+"&markscheme="+markscheme+"&durationinsecs="+durationinsecs,"ExamPlayer","width=900,height=700,status=yes,resizable=1");
			//top.studenttopframe.studentExamWin=win;
			//win.focus();
		}
		//var t=setTimeout("window.location.reload()",2000)
	}
//-->

</SCRIPT>