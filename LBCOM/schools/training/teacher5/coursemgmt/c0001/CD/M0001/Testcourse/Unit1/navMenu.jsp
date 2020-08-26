<%@ page import = "java.sql.*,java.sql.Statement" language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	//final  String dbURL    = "jdbc:mysql://59.162.195.22.static-hyderabad.vsnl.net.in:3306/webhuddle?user=root&password=whizkids";
	Connection con=null;
	ResultSet rs1=null,rs4=null,rs10=null,rs11=null,rs12=null;
	Statement st1=null,st4=null,st10=null,st11=null,st12=null;
	String unitPath="",unitId="",unitName="",lessonId="",lessonName="",prevLink="",nextLink="",learnToday="",cQuestions="",matNeed="";
		String activity="",assessment="",assignment="",lLength="",nextUnit="",prevUnit="",lessonStatus="";
		String aTitle="",aAssessTitle="",aAssgnTitle="",devCourseId="";
		String str3="",tableName="";
%>
<%	
	
	
	try{
		System.out.println("......navMenu..LBCMSDB....");
		String uType=(String)session.getAttribute("logintype");
		String schoolId=(String)session.getAttribute("schoolid");
		String grade=(String)session.getAttribute("classid");

		devCourseId=request.getParameter("dev_courseid");
		String courseName=request.getParameter("coursename");	
		unitName=request.getParameter("unitname");	
		lessonName=request.getParameter("lessonname");	
		unitId=request.getParameter("unitid");
		lessonId=request.getParameter("lessonid");
		String prev2Link=request.getParameter("prev2link");
		String prev3Link=request.getParameter("prev3link");
		String next3Link=request.getParameter("nextpage");
		
		
		
		//out.println("........next3Link...."+next3Link+"...prev2Link..."+prev2Link+"...prev3Link..."+next3Link+"\n");
		//out.println("<br><br>");
		//out.println("........uType...."+uType+"......schoolId...."+schoolId+"......devCourseId...."+devCourseId+"......grade...."+grade+"...courseName.."+courseName+"...unitId..."+unitId);

		con=con1.getConnection();
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
					


		str3=str3+"<html><head><title>"+courseName+"</title><META http-equiv='Content-Type' content='text/html; charset=ISO-8859-1'><meta name='generator' content='Namo WebEditor'><link rel='stylesheet' type='text/css' href='../css/style.css' /><link rel='stylesheet' type='text/css' href='../css/red.css' /><link rel='stylesheet' type='text/css' href='../css/intro_style.css' /><link rel='stylesheet' type='text/css' href='../css/activity_style.css' /><link href='../slides/images/slide_css.css' rel='stylesheet' type='text/css'><script src='../slides/images/script.js'></script><bgsound id=pptSound></head><body><table class='main_table' align='center'><tr><td class='main_table_c1'></td><td class='main_table_c2'><table class='main_table2' cellpadding='0' cellspacing='0'><tr><td class='main_table2_th'><table class='titel_table' cellpadding='0' cellspacing='0'><tr><td class='title_table_c1'>"+courseName+"</td><td class='title_table_c2'><a class='home_button' href='../Lessons.html' title='Course Home'><span></span></a></td></tr></table></td></tr><tr><td class='main_table2_tb'></td></tr><tr><td class='main_table2_tc'><table class='slides_table'><tr><td class='slides_table_tl'>"+unitName+": "+lessonName+"</td></tr><tr><td><div align='right'><table border='0' cellpadding='0' cellspacing='0'><tr><td><p align='right'><a href='"+prev2Link+"' target='_self'><img src='../images/micon_intro.jpg' width='161' height='40' border='0'></a></p></td><td width='161'><p align='center'><a href='"+prev3Link+"' target='_self'><img src='../images/micon_lesson.jpg' width='161' height='40' border='0'></a></p></td><td width='161'><p align='left'><img src='../images/micon_activities.jpg' width='161' height='40' border='0'></p></td></tr></table></div></td></tr><tr><td width='304'><table>";
					
					 if(!acts.equals("none"))
					{
						 //activity=activity.replaceAll("http://oh.learnbeyond.net/LBCOM/coursedeveloper/CB_images/","../slides/images/");
					activity=activity.replaceAll("%20"," ");
					activity=activity.replaceAll("http://oh.learnbeyond.net/LBCOM","http://oh.learnbeyond.net:8080/LBCOM");				activity=activity.replaceAll("http://oh.learnbeyond.net:8080/LBCOM/coursedeveloper/course_bundles/"+courseName+"/slides/images/","../slides/images/");
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
									System.out.println("secImage..."+secImage);
									
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
					
					str3=str3+"<tr><td colspan='2'><img src='../images/divider_info.jpg' width='800' height='2' border='0'></td></tr><tr><td width='79' rowspan='2' valign='top'><img src='http://localhost:8080/LBCOM/lbcms/coursebuilder/SectionImages/"+secImage+"' width='84' height='80' border='0'></td><td class='ahead3'>"+aTitle+"</td></tr><tr><td><ul><FONT face=Verdana size='2' color='#191919'>&nbsp;"+activity+"</font></ul></td></tr>";
						 
					}
					 if(!assmts.equals("none"))
					{
						//assessment=assessment.replaceAll("http://oh.learnbeyond.net/LBCOM/coursedeveloper/CB_images/","../slides/images/");
					assessment=assessment.replaceAll("%20"," ");

					assessment=assessment.replaceAll("http://oh.learnbeyond.net/LBCOM","http://oh.learnbeyond.net:8080/LBCOM");
					assessment=assessment.replaceAll("http://oh.learnbeyond.net:8080/LBCOM/coursedeveloper/course_bundles/"+courseName+"/slides/images/","../slides/images/");
					assessment=assessment.replaceAll("img src=\"course_bundles/"+courseName+"/slides/images/","img src=\"../slides/images/");

					assessment=assessment.replaceAll("\"CB_images","\"http://oh.learnbeyond.net:8080/LBCOM/coursedeveloper/CB_images");
					assessment=assessment.replaceAll("param name=\"url\" value=\"CB_images","param name=\"url\" value=\"http://oh.learnbeyond.net:8080/LBCOM/coursedeveloper/CB_images");

					
					// Sec Icons
					String secImage="";
					int secImageId=0;
					st10=con.createStatement();
					System.out.println("select * from lbcms_dev_sec_icons where course_id='"+devCourseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='assmttitleicon'");
					rs10=st10.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+devCourseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='assmttitleicon'");
					if(rs10.next())
					 {
						secImageId=rs10.getInt("image_id");
						
						st11=con.createStatement();
							rs11=st11.executeQuery("select * from lbcms_dev_sec_icons_master where image_id="+secImageId+"");
							if(rs11.next())
							 {
								secImage=rs11.getString("image_name");
								System.out.println("secImage..."+secImage);
								
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
					
					
					str3=str3+"<tr><td colspan='2'><img src='../images/divider_info.jpg' width='800' height='2' border='0'></td></tr><tr><td width='79' rowspan='2' valign='top'><img src='http://localhost:8080/LBCOM/lbcms/coursebuilder/SectionImages/"+secImage+"' width='84' height='80' border='0'></td><td class='ahead2'>"+aAssessTitle+"</td></tr><tr><td><ul><FONT face=Verdana size='2' color='#191919'>&nbsp;"+assessment+"</font></ul></td></tr>";

					// Assessments names

					str3=str3+"<tr><td>&nbsp;</td></tr><tr>";
					st12=con.createStatement();
					rs12=st12.executeQuery("select * from lbcms_dev_assessment_master  where course_id='"+devCourseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
			
					while(rs12.next())
					{
						String slNo=rs12.getString("slno");
						String assmtId=rs12.getString("assmt_id");
						String assmtName=rs12.getString("assmt_name");
						String catId=rs12.getString("category_id");

						//str3=str3+"<tr><td>&nbsp;</td></tr><tr><td colspan='2'><font color='red'><a href="+assmtName+"</font></td></tr><tr>";
						str3=str3+"<td colspan='1'><font color='red'><a href='#' onClick=\"viewAssmt('"+assmtId+"');return false;\">"+assmtName+"</a></font></td>\n";

					}
					st12.close();
					rs12.close();

					//
					str3=str3+"</tr><tr>";
					



					}
					 if(!assgns.equals("none"))
					{
						 
						//assignment=assignment.replaceAll("http://oh.learnbeyond.net/LBCOM/coursedeveloper/CB_images/","../slides/images/");
					assignment=assignment.replaceAll("%20"," ");

					assignment=assignment.replaceAll("http://oh.learnbeyond.net/LBCOM","http://oh.learnbeyond.net:8080/LBCOM");
					assignment=assignment.replaceAll("http://oh.learnbeyond.net:8080/LBCOM/coursedeveloper/course_bundles/"+courseName+"/slides/images/","../slides/images/");
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
									System.out.println("secImage..."+secImage);
									
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
					
					str3=str3+"<tr><td colspan='2'><img src='../images/divider_info.jpg' width='800' height='2' border='0'></td></tr><tr><td width='79' rowspan='2' valign='top'><img src='http://localhost:8080/LBCOM/lbcms/coursebuilder/SectionImages/"+secImage+"' width='84' height='80' border='0'></td><td class='ahead3'>"+aAssgnTitle+"</td></tr><tr><td><ul><FONT face=Verdana size='2' color='#191919'>&nbsp;"+assignment+"</font></ul></td></tr>";

					

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
					System.out.println("select * from "+tableName+" where course_id='"+devCourseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");

					rs1=st1.executeQuery("select * from "+tableName+" where course_id='"+devCourseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
					
					while(rs1.next())
					{	
						int assgnNo=rs1.getInt("slno");
						String assgnName=rs1.getString("assgn_name");
					 str3=str3+"<td colspan='1'><font color='red'><a href='#' onClick=\"viewAssgn('"+assgnNo+"');return false;\">"+assgnName+"</a></font></td>\n";

					
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
								System.out.println("secImage..."+secImage);
								
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
					str3=str3+"<tr><td colspan='2'><img src='../images/divider_info.jpg' width='800' height='2' border='0'></td></tr><tr><td width='79' rowspan='2' valign='top'><img src='http://localhost:8080/LBCOM/lbcms/coursebuilder/SectionImages/"+secImage+"' width='84' height='80' border='0'></td><td class='head2'>"+secTitle+"</td></tr><tr><td><ul><FONT face=Verdana size='2' color='#191919'>"+secContent+"</font></ul></td></tr><tr><td colspan='2'><img src='../images/divider_info.jpg' width='800' height='2' border='0'></td></tr>";
					}
					rs4.close();
					st4.close();					
					
					str3=str3+"<tr><td width='79'>&nbsp;</td><td width='720'>&nbsp;</td></tr></table></td></tr></table></td></tr><tr><td class='main_table2_tb'></td></tr><tr><td class='main_table2_te'><table class='bottom_table' cellpadding='0' cellspacing='0' align='right'><tr><td class='main_table2_copy'>Mahoning Unlimited Classroom © All Rights Reserved.</td><td class='bottom_table_c1'><a class='previous_button' href='"+prev3Link+"' title='Previous'></a></td><td class='bottom_table_c2'><a class='next_button' href='"+next3Link+"' title='Next'></a></td></tr></table></td></tr></table></td><td class='main_table_c3'></td></tr></table></body></html>"+"\n";
					out.println(str3);
					rs1.close();
					st1.close();
				
	
		}
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
	alert("yes"+sno);
	
	var win;
		win=window.open("/LBCOM/lbcms/AssmtBuilder/exams/<%=devCourseId%>/"+sno+"/1.html");
	
}
function viewAssgn(sno)
{
	alert("yes"+sno);
	
	var assgnwin;
		assgnwin=window.open("/LBCOM/lbcms/ViewCBAssignInfo.jsp?assgnno="+sno+"&courseid=<%=devCourseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>");
	
}
//-->
</SCRIPT>