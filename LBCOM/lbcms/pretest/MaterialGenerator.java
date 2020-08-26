package cmgenerator;
import java.util.*;
import java.util.Random;
import utility.Utility;
import utility.FileUtility;
import java.sql.*;
import java.io.*;
import coursemgmt.ExceptionsFile;
import java.util.StringTokenizer;
import sqlbean.DbBean;

public class MaterialGenerator 
{
	DbBean db;
	Connection con;
	Statement st,st1,st2,st3,st4,st5;
	ResultSet rs,rs1,rs2,rs3,rs4,rs5;
	PrintWriter out;
	String courseDevPath="",maxattempts="";

	public MaterialGenerator() 
	{
		try
		{	
			db = new DbBean();
			con = db.getConnection();
			st=con.createStatement();
			st1=con.createStatement();
			st2=con.createStatement();
			st3=con.createStatement();
			st4=con.createStatement();
			
		}
		catch(Exception e)
		{
			System.out.println("Exception in MGenerato.java at 909090 is..."+e);
			ExceptionsFile.postException("123 MaterialGenerator.java","constructor","Exception",e.getMessage());
		}
	}

	public void generateLesson(String cName,int a,int b,int c,String lNames,String dPath)
	{
		String courseId="",schoolId="",studentId="",devCourseId="";
		try	
		{		
			File LessonFile=new File(dPath);
			if(LessonFile.exists())
			{
				String tempFiles[]=LessonFile.list();			 
				for(int i=0;i<tempFiles.length;i++) 
				{
					File temp=new File(LessonFile+"/"+tempFiles[i]);	   
				    temp.delete();
				}
			}
			LessonFile.mkdirs();
			createLessonFile(schoolId,studentId,devCourseId,cName,courseId,dPath);
		}
		catch(Exception e) 
		{
			System.out.println("Error 5645678 in generateLesson.java at construct paper is.:"+e);
		}
	}


	public void createLessonFile(String schoolId,String studentId,String devCourseId,String courseName, String courseId, String cmPath)
	{
		RandomAccessFile rFile1=null,rFile2=null,rFile3=null,rFile4=null,rFile5=null;
		String unitPath="",unitId="",unitName="",lessonId="",lessonName="",prevLink="",nextLink="",learnToday="",cQuestions="",matNeed="";
		String activity="",assessment="",assignment="",lLength="",nextUnit="",prevUnit="",lessonStatus="";
		boolean unit_last=false, unit_first=false;
		int x=0,y=0,z=0,i=0,prev1=0;
		String lID1="",lID2="";
		String uids="",lids="",uId="",lId="";
		

		try
		{
			
			con = db.getConnection();
			st=con.createStatement();
			st1=con.createStatement();
			st2=con.createStatement();
			st3=con.createStatement();
			st5=con.createStatement();
			
			rs5=st5.executeQuery("select unit_ids,lesson_ids from pretest_student_material_distribution where school_id='"+schoolId+"' and student_id='"+studentId+"' and course_id='"+courseId+"'");
			if(rs5.next())
			{
				uids=rs5.getString("unit_ids");
				lids=rs5.getString("lesson_ids");
			}
			
			StringTokenizer uIdsTkn=new StringTokenizer(uids,",");
			while(uIdsTkn.hasMoreTokens())
			{
				
				uId=uIdsTkn.nextToken();
				System.out.println("select * from dev_units_master where course_id='"+devCourseId+"' and unit_id='"+uId+"'");
				rs=st.executeQuery("select * from dev_units_master where course_id='"+devCourseId+"' and unit_id='"+uId+"'");
				if(rs.next())
				{
					
					prevUnit="";
					nextUnit="";
					unit_last=rs.isLast();
					unit_first=rs.isFirst();
					if(!unit_first){
						rs.previous();
						prevUnit=rs.getString("unit_name");
						rs.next();
					}
					if(!unit_last){
						rs.next();
						nextUnit=rs.getString("unit_name");
						rs.previous();
					}
					x++;
					unitId=rs.getString("unit_id");
					unitName=rs.getString("unit_name");
					System.out.println("cmPath..."+cmPath+"....unitName..."+unitName);
					unitPath=cmPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/CD/"+courseName+"/"+unitName;
					System.out.println("unitPath..."+unitPath);
					File LessonFile=new File(unitPath);
					if(!LessonFile.exists())
							LessonFile.mkdirs();
					i=0;
					int j123=0;
					
					StringTokenizer lIdsTkn=new StringTokenizer(lids,",");
					int noOfTokensTotal=lIdsTkn.countTokens();
					
					while(lIdsTkn.hasMoreTokens())
					{
						
						j123++;
						
					  lId=lIdsTkn.nextToken();
					  System.out.println("lId..."+lId);
					  rs1=st1.executeQuery("select * from dev_lessons_master where course_id='"+devCourseId+"' and unit_id='"+uId+"' order by lesson_id");
					  while(rs1.next())
					  {
						lessonId=rs1.getString("lesson_id");
						
						if(lId.equals(lessonId))
						{
							prev1=i;
							i++;
																			
								lessonName=rs1.getString("lesson_name");
								lessonStatus=rs1.getString("status");
													
								learnToday=rs1.getString("what_i_learn_today");
								if(learnToday==null)
								{
									learnToday="None";
								}
								//learnToday=learnToday.replaceAll("http://oh.learnbeyond.net/LBRT/coursedeveloper/CB_images/","../slides/images/");
								learnToday=learnToday.replaceAll("%20"," ");
								learnToday=learnToday.replaceAll("http://oh.learnbeyond.net/LBRT/coursedeveloper/course_bundles/"+courseName+"/slides/images/","../slides/images/");
												
								
								cQuestions=rs1.getString("critical_questions");
								if(cQuestions==null)
								{
									cQuestions="None";
								}
								//cQuestions=cQuestions.replaceAll("http://oh.learnbeyond.net/LBRT/coursedeveloper/CB_images/","../slides/images/");
								cQuestions=cQuestions.replaceAll("%20"," ");
								cQuestions=cQuestions.replaceAll("http://oh.learnbeyond.net/LBRT/coursedeveloper/course_bundles/"+courseName+"/slides/images/","../slides/images/");
								
								matNeed=rs1.getString("materials_i_need");
								if(matNeed==null)
								{
									matNeed="None";
								}
								//matNeed=matNeed.replaceAll("http://oh.learnbeyond.net/LBRT/coursedeveloper/CB_images/","../slides/images/");
								matNeed=matNeed.replaceAll("%20"," ");
								matNeed=matNeed.replaceAll("http://oh.learnbeyond.net/LBRT/coursedeveloper/course_bundles/"+courseName+"/slides/images/","../slides/images/");

								activity=rs1.getString("activity");
								if(activity==null)
								{
									activity="None";
								}
								//activity=activity.replaceAll("http://oh.learnbeyond.net/LBRT/coursedeveloper/CB_images/","../slides/images/");
								activity=activity.replaceAll("%20"," ");
								activity=activity.replaceAll("http://oh.learnbeyond.net/LBRT/coursedeveloper/course_bundles/"+courseName+"/slides/images/","../slides/images/");


								assessment=rs1.getString("assessment");
								if(assessment=="" || assessment==null)
									assessment="None";
								//assessment=assessment.replaceAll("http://oh.learnbeyond.net/LBRT/coursedeveloper/CB_images/","../slides/images/");
								assessment=assessment.replaceAll("%20"," ");
								assessment=assessment.replaceAll("http://oh.learnbeyond.net/LBRT/coursedeveloper/course_bundles/"+courseName+"/slides/images/","../slides/images/");



								assignment=rs1.getString("assignment");
								if(assignment=="" || assignment==null)
									assignment="None";
								//assignment=assignment.replaceAll("http://oh.learnbeyond.net/LBRT/coursedeveloper/CB_images/","../slides/images/");
								assignment=assignment.replaceAll("%20"," ");
								assignment=assignment.replaceAll("http://oh.learnbeyond.net/LBRT/coursedeveloper/course_bundles/"+courseName+"/slides/images/","../slides/images/");


								lLength=rs1.getString("lesson_length");
								if(lLength=="" || lLength==null)
									lLength="One Day";					
								int k=0;
								String a[]=new String[20];
								

								String str1="",str2="",str3="",prev1Link="",next1Link="",prev2Link="",next2Link="",prev3Link="",next3Link="";
								String uStr1="",lStr1="",uStr2="",lStr2="",firstPage="",secondPage="",thirdPage="",chkPage1="",chkPage2="";
								String activityLink="";

								if(x<10)	
								{
									uStr1="/0";
									uStr2="0";
								}
								else
								{
									uStr1="/";
									uStr2="";
								}
								if(i<10)
								{
									lStr1="_0";
									lStr2="0";
								}
								else	
								{
									lStr1="_";
									lStr2="";
								}

								firstPage=unitPath+uStr1+x+lStr1+i+"_01.html";
								secondPage=unitPath+uStr1+x+lStr1+i+"_02.html";				
								thirdPage=unitPath+uStr1+x+lStr1+i+"_03.html";
								chkPage1=unitPath+uStr1+x+lStr1+i+"_01.html";
								chkPage2=unitPath+uStr1+x+lStr1+i+"_03.html";

							int next1=i+1;
				
							if(i==1)
							{
								if((x-1)<10)
								{
									if(prev1<10)
									{
										prev1Link="../"+prevUnit+"/0"+(x-1)+"_"+lStr2+prev1+"_03.html";
									}
									else
									{
										prev1Link="../"+prevUnit+"/0"+(x-1)+"_"+prev1+"_03.html";
									}
								}
								else
								{
									if(prev1<10)
									{
										prev1Link="../"+prevUnit+"/"+(x-1)+"_"+lStr2+prev1+"_03.html";
									}
									else
										prev1Link="../"+prevUnit+"/"+(x-1)+"_"+prev1+"_03.html";
									
								}
								
							}
							else
							{
								if(prev1<10)
								{
									prev1Link=uStr2+x+"_0"+prev1+"_03.html";
									
								}
								else
									prev1Link=uStr2+x+"_"+lStr2+prev1+"_03.html";
							}
							if(unit_first && i==1)
								prev1Link="../Lessons.html";

							next1Link=uStr2+x+"_"+lStr2+i+"_02.html";
							activityLink=uStr2+x+"_"+lStr2+i+"_03.html";

							prev2Link=uStr2+x+"_"+lStr2+i+"_01.html";
							next2Link=uStr2+x+"_"+lStr2+i+"_03.html";

							prev3Link=uStr2+x+"_"+lStr2+i+"_02.html";
							
							if(!rs1.isLast())
							{
									if(next1<10)
									{
										next3Link=uStr2+x+"_"+lStr2+next1+"_01.html";
									}
									else
										next3Link=uStr2+x+"_"+next1+"_01.html";
									
																		
							}
							else
							{
								if((x+1)<10)
									next3Link="../"+nextUnit+"/0"+(x+1)+"_01_01.html";
									
								else
									next3Link="../"+nextUnit+"/"+(x+1)+"_01_01.html";
							}
												
/*
				if(noOfTokensTotal==j123)
				{
					System.out.println("next3Link.."+next3Link);
					
					next3Link="../Lessons.html";

				}
				*/
				if(unit_last && rs1.isLast())
					next3Link="../Lessons.html";
				
				if(lessonStatus.equals("1"))
				{
					rFile1=new RandomAccessFile(firstPage,"rw");

					str1=str1+"<html><head><title>"+courseName+"</title><meta name='generator' content='Namo WebEditor'><link rel='stylesheet' type='text/css' href='../css/style.css' /><link rel='stylesheet' type='text/css' href='../css/red.css' /><link rel='stylesheet' type='text/css' href='../css/intro_style.css' /></head><body><table class='main_table' align='center'><tr><td class='main_table_c1'></td><td class='main_table_c2'><table class='main_table2' cellpadding='0' cellspacing='0'><tr><td class='main_table2_th'><table class='titel_table' cellpadding='0' cellspacing='0'><tr><td class='title_table_c1'>"+courseName+"</td><td class='title_table_c2'><a class='home_button' href='../Lessons.html' title='Course Home'><span></span></a></td></tr></table></td></tr><tr><td class='main_table2_tb'></td></tr><tr><td class='main_table2_tc'><table class='slides_table'><tr><td class='slides_table_tl'>"+unitName+": "+lessonName+"</td></tr><tr><td><div align='right'><table border='0' cellpadding='0' cellspacing='0'><tr><td><p align='right'><img src='../images/micon_intro.jpg' width='161' height='40' border='0'></a></p></td><td width='161'><p align='center'><a href='"+next1Link+"' target='_self'><img src='../images/micon_lesson.jpg' width='161' height='40' border='0'></a></p></td><td width='161'><p align='left'><a href='"+activityLink+"' target='_self'><img src='../images/micon_activities.jpg' width='161' height='40' border='0'></a></p></td></tr></table></div></td></tr><tr><td width='304'><table><tr><td rowspan='2' valign='top'><img src='../images/icon_head1.jpg' width='84' height='80' border='0'></td><td class='head1'>WHAT WILL I LEARN TODAY?</td></tr><tr><td><ul><FONT face=Verdana size='2' color='#191919'>"+learnToday+"</font></ul></td></tr><tr><td colspan='2'><img src='../images/divider_info.jpg' width='800' height='8' border='0'></td></tr><tr><td width='79' rowspan='2' valign='top'><img src='../images/icon_head2.jpg' width='84' height='80' border='0'></td><td class='head2'>CRITICAL QUESTIONS?</td></tr><tr><td><ul><FONT face=Verdana size='2' color='#191919'>"+cQuestions+"</font></ul></td></tr><tr><td colspan='2'><img src='../images/divider_info.jpg' width='800' height='8' border='0'></td></tr><tr><td width='79' rowspan='2' valign='top'><img src='../images/icon_head3.jpg' width='84' height='80' border='0'></td><td class='head3'>WHAT MATERIALS DO I NEED FOR THIS LESSON?</td></tr><tr><td><ul><FONT face=Verdana size='2' color='#191919'>"+matNeed+"</font></ul></td></tr><tr><td colspan='2'><img src='../images/divider_info.jpg' width='800' height='8' border='0'></td></tr><tr><tr><td width='79' rowspan='2' valign='top'><img src='../images/icon_head4.jpg' width='84' height='80' border='0'></td><td class='head4'>WORDS I NEED TO KNOW</td></tr><tr><td><table border='0' cellpadding='0' cellspacing='0' class='words'><tr>";
					
					rs2=st2.executeQuery("select * from dev_lesson_words where course_id='"+devCourseId+"' and unit_id='"+uId+"' and lesson_id='"+lessonId+"' order by lesson_id");
						while(rs2.next())
						{
							a[k++]=rs2.getString("word");
						}
						
						for(int m=0;m<a.length;m++)
							{
								if(a[m]!=null)
								{
									if(m<4)
									{
										str1=str1+"<td width='180'><FONT face=Verdana size='2' color='#191919'>"+a[m]+"</font></td>";
									}
									if(m==4)
									{
										str1=str1+"<tr><td width='180'><FONT face=Verdana size='2' color='#191919'>"+a[m]+"</font></td>";
									}
									if(m>4 && m<8)
									{
										str1=str1+"<td width='180'><FONT face=Verdana size='2' color='#191919'>"+a[m]+"</font></td>";
									}
								}
							}
						
						str1=str1+"</tr></table></td></tr><tr><td colspan='2'><img src='../images/divider_info.jpg' width='800' height='8' border='0'></td></tr><tr><td width='79' rowspan='2' valign='top'><img src='../images/icon_head5.jpg' width='84' height='80' border='0'></td><td class='head5'>LENGTH</td></tr><tr><td><ul><li>One day lesson</li></ul></td></tr><tr><td width='79'>&nbsp;</td><td width='720'>&nbsp;</td></tr></table></td></tr></table></td></tr><tr><td class='main_table2_tb'></td></tr><tr><td class='main_table2_te'><table class='bottom_table' cellpadding='0' cellspacing='0' align='right'><tr><td class='main_table2_copy'>Mahoning Unlimited Classroom © All Rights Reserved.</td><td class='bottom_table_c1'><a class='previous_button' href='"+prev1Link+"' title='Previous'></a></td><td class='bottom_table_c2'><a class='next_button' href='"+next1Link+"' title='Next'></a></td></tr></table></td></tr></table></td><td class='main_table_c3'></td></tr></table></body></html>"+"\n";
					rFile1.setLength(0);
					rFile1.writeBytes(str1);
					rFile1.close();

					str2="";

					str2=str2+"<html><head><title>"+courseName+"</title><meta name='generator' content='Namo WebEditor'><link rel='stylesheet' type='text/css' href='../css/style.css' /><link rel='stylesheet' type='text/css' href='../css/red.css' /><link rel='stylesheet' type='text/css' href='../css/intro_style.css' /></head><body><table class='main_table' align='center'><tr><td class='main_table_c1'></td><td class='main_table_c2'><table class='main_table2' cellpadding='0' cellspacing='0'><tr><td class='main_table2_th'><table class='titel_table' cellpadding='0' cellspacing='0'><tr><td class='title_table_c1'>"+courseName+"</td><td class='title_table_c2'><a class='home_button' href='../Lessons.html' title='Course Home'><span></span></a></td></tr></table></td></tr><tr><td class='main_table2_tb'></td></tr><tr><td class='main_table2_tc'><table class='slides_table'><tr><td class='slides_table_tl'>"+unitName+": "+lessonName+"</td></tr><tr><td><div align='right'><table border='0' cellpadding='0' cellspacing='0'><tr><td><p align='right'><a href='"+prev2Link+"' target='_self'><img src='../images/micon_intro.jpg' width='161' height='40' border='0'></a></p></td><td width='161'><p align='center'><img src='../images/micon_lesson.jpg' width='161' height='40' border='0'></a></p></td><td width='161'><p align='left'><a href='"+activityLink+"' target='_self'><img src='../images/micon_activities.jpg' width='161' height='40' border='0'></a></p></td></tr></table></div></td></tr><tr><td><table border='0' cellspacing='0' width='100%'><tr><td width='100%'><table border='0' cellpadding='0' cellspacing='0' width='100%' height='24'></table>"+"\n";

					String slideContent="";
					
					rs2=st2.executeQuery("select * from dev_lesson_content_master where course_id='"+devCourseId+"' and unit_id='"+uId+"' and lesson_id='"+lessonId+"' order by slide_no");
					while(rs2.next())
					{
						
							
							slideContent=rs2.getString("slide_content");
							z=rs2.getRow();
							//slideContent=slideContent.replaceAll("http://oh.learnbeyond.net/LBRT/coursedeveloper/CB_images/","../images/");
					slideContent=slideContent.replaceAll("%20"," ");
					slideContent=slideContent.replaceAll("http://oh.learnbeyond.net/LBRT/coursedeveloper/course_bundles/"+courseName+"/slides/images/","../images/");
					slideContent=slideContent.replaceAll("target=_blank href=\"javascript:","href=\"javascript: ");
					slideContent=slideContent.replaceAll(";\" target=_blank",";\"");

					rFile2=new RandomAccessFile(secondPage,"rw");					

					str2=str2+"<p align='left'><FONT face=Verdana size='2' color='#191919'>"+slideContent+"</P>"+"\n";

					}
					if(z==1 && slideContent.equals(""))
					{
						str2=str2+"<p align='left'><FONT face=Verdana color='#ff0000' size='2'>No Content available for this lesson.</font></P>"+"\n";
					}
					str2=str2+"</td></tr></table></td></tr></table></td></tr><tr><td class='main_table2_tb'></td></tr><tr><td class='main_table2_te'><table class='bottom_table' cellpadding='0' cellspacing='0' align='right'><tr><td class='main_table2_copy'>Mahoning Unlimited Classroom © All Rights Reserved.</td><td class='bottom_table_c1'><a class='previous_button' href='"+prev2Link+"' title='Previous'></a></td><td class='bottom_table_c2'><a class='next_button' href='"+next2Link+"' title='Next'></a></td></tr></table></td></tr></table></td><td class='main_table_c3'></td></tr></table></body></html>"+"\n";
					rFile2.setLength(0);
					rFile2.writeBytes(str2);
					rFile2.close();

					rFile3=new RandomAccessFile(thirdPage,"rw");
					str3=str3+"<html><head><title>"+courseName+"</title><meta name='generator' content='Namo WebEditor'><link rel='stylesheet' type='text/css' href='../css/style.css' /><link rel='stylesheet' type='text/css' href='../css/red.css' /><link rel='stylesheet' type='text/css' href='../css/intro_style.css' /><link rel='stylesheet' type='text/css' href='../css/activity_style.css' /></head><body><table class='main_table' align='center'><tr><td class='main_table_c1'></td><td class='main_table_c2'><table class='main_table2' cellpadding='0' cellspacing='0'><tr><td class='main_table2_th'><table class='titel_table' cellpadding='0' cellspacing='0'><tr><td class='title_table_c1'>"+courseName+"</td><td class='title_table_c2'><a class='home_button' href='../Lessons.html' title='Course Home'><span></span></a></td></tr></table></td></tr><tr><td class='main_table2_tb'></td></tr><tr><td class='main_table2_tc'><table class='slides_table'><tr><td class='slides_table_tl'>"+unitName+": "+lessonName+"</td></tr><tr><td><div align='right'><table border='0' cellpadding='0' cellspacing='0'><tr><td><p align='right'><a href='"+prev2Link+"' target='_self'><img src='../images/micon_intro.jpg' width='161' height='40' border='0'></a></p></td><td width='161'><p align='center'><a href='"+prev3Link+"' target='_self'><img src='../images/micon_lesson.jpg' width='161' height='40' border='0'></a></p></td><td width='161'><p align='left'><img src='../images/micon_activities.jpg' width='161' height='40' border='0'></p></td></tr></table></div></td></tr><tr><td width='304'><table><tr><td rowspan='2' valign='top'><img src='../images/icon_activity.jpg' width='84' height='80' border='0'></td><td class='ahead1'>ACTIVITY</td></tr><tr><td><ul><FONT face=Verdana size='2' color='#191919'>&nbsp;"+activity+"</font></ul></td></tr><tr><td colspan='2'><img src='../images/divider_info.jpg' width='800' height='8' border='0'></td></tr><tr><td width='79' rowspan='2' valign='top'><img src='../images/icon_assessments.jpg' width='84' height='80' border='0'></td><td class='ahead2'>ASSESSMENT(S)</td></tr><tr><td><ul><FONT face=Verdana size='2' color='#191919'>&nbsp;"+assessment+"</font></ul></td></tr><tr><td colspan='2'><img src='../images/divider_info.jpg' width='800' height='8' border='0'></td></tr><tr><td width='79' rowspan='2' valign='top'><img src='../images/icon_assignments.jpg' width='84' height='80' border='0'></td><td class='ahead3'>ASSIGNMENT(S)</td></tr><tr><td><ul><FONT face=Verdana size='2' color='#191919'>&nbsp;"+assignment+"</font></ul></td></tr><tr><td width='79'>&nbsp;</td><td width='720'>&nbsp;</td></tr></table></td></tr></table></td></tr><tr><td class='main_table2_tb'></td></tr><tr><td class='main_table2_te'><table class='bottom_table' cellpadding='0' cellspacing='0' align='right'><tr><td class='main_table2_copy'>Mahoning Unlimited Classroom © All Rights Reserved.</td><td class='bottom_table_c1'><a class='previous_button' href='"+prev3Link+"' title='Previous'></a></td><td class='bottom_table_c2'><a class='next_button' href='"+next3Link+"' title='Next'></a></td></tr></table></td></tr></table></td><td class='main_table_c3'></td></tr></table></body></html>"+"\n";
					rFile3.setLength(0);
					rFile3.writeBytes(str3);
					rFile3.close();
				}
				else if(lessonStatus.equals("2"))
				{
						rFile4=new RandomAccessFile(chkPage1,"rw");
						String learnTodayPrint=learnToday;
						
						str1=str1+"<html><head><title>"+courseName+"</title><meta name='generator' content='Namo WebEditor'><link rel='stylesheet' type='text/css' href='../css/style.css' /><link rel='stylesheet' type='text/css' href='../css/red.css' /><link rel='stylesheet' type='text/css' href='../css/intro_style.css' /><script language='javascript'>function winprint(){var w = 650;var h = 450;var l = (window.screen.availWidth - w)/2;var t = (window.screen.availHeight - h)/2;var sOption='toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,width=' + w + ',height=' + h + ',left=' + l + ',top=' + t;var sDivText =window.document.getElementById('divcontent').innerHTML;var objWindow = window.open('', 'Print', sOption);sDivText=sDivText.replace(/&lt;/g,'<');sDivText=sDivText.replace(/&gt;/g,'>');objWindow.document.write(sDivText);objWindow.document.close(); objWindow.print();objWindow.close();}</script></head><body><table class='main_table' align='center'><tr><td class='main_table_c1'></td><td class='main_table_c2'><table class='main_table2' cellpadding='0' cellspacing='0'><tr><td class='main_table2_th'><table class='titel_table' cellpadding='0' cellspacing='0'><tr><td class='title_table_c1'>"+courseName+"</td><td class='title_table_c2'><a class='home_button' href='../Lessons.html' title='Course Home'><span></span></a></td></tr></table></td></tr><tr><td class='main_table2_tb'></td></tr><tr><td class='main_table2_tc'><table class='slides_table'><tr><td class='slides_table_tl'>"+unitName+": "+lessonName+"</td></tr><tr><td><div align='right'></div></td></tr><tr><td width='304'><table><tr><td width='23' height='64' align='center' valign='top'>&nbsp;</td><td width='76' height='64' align='center' valign='top'><td width='2690' height='64' align='right' valign='top'><a href='javascript:winprint();'><b>Print</b></a><table border='0' cellpadding='0' cellspacing='0' width='100%'><tr><td width='7%' height='60' rowspan='2' valign='top' align='right'><img border='0' src='../images/image_20.jpg' width='42' height='42' align='middle'></td><td class='head1'>Checklist</td></tr><tr><td width='93%' height='41'>&nbsp;&nbsp;&nbsp;<div id='divcontent'><FONT face=Verdana size='2' color='#191919'>"+learnToday+"</font></div></td></tr><tr><td width='79'>&nbsp;</td><td width='720'>&nbsp;</td></tr></table></td></tr></table></td></tr><tr><td class='main_table2_tb'></td></tr><tr><td class='main_table2_te'><table class='bottom_table' cellpadding='0' cellspacing='0' align='right'><tr><td class='main_table2_copy'>Mahoning Unlimited Classroom © All Rights Reserved.</td><td class='bottom_table_c1'><a class='previous_button' href='"+prev1Link+"' title='Previous'></a></td><td class='bottom_table_c2'><a class='next_button' href='"+next3Link+"' title='Next'></a></td></tr></table></td></tr></table></td><td class='main_table_c3'></td></tr></table></body></html>"+"\n";
						rFile4.setLength(0);
						rFile4.writeBytes(str1);
						rFile4.close();


						rFile5=new RandomAccessFile(chkPage2,"rw");
						str2=str2+"<html><head><title>"+courseName+"</title><meta name='generator' content='Namo WebEditor'><link rel='stylesheet' type='text/css' href='../css/style.css' /><link rel='stylesheet' type='text/css' href='../css/red.css' /><link rel='stylesheet' type='text/css' href='../css/intro_style.css' /><script language='javascript'>function winprint(){var w = 650;var h = 450;var l = (window.screen.availWidth - w)/2;var t = (window.screen.availHeight - h)/2;var sOption='toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,width=' + w + ',height=' + h + ',left=' + l + ',top=' + t;var sDivText =window.document.getElementById('divcontent').innerHTML;var objWindow = window.open('', 'Print', sOption);sDivText=sDivText.replace(/&lt;/g,'<');sDivText=sDivText.replace(/&gt;/g,'>');objWindow.document.write(sDivText);objWindow.document.close(); objWindow.print();objWindow.close();}</script></head><body><table class='main_table' align='center'><tr><td class='main_table_c1'></td><td class='main_table_c2'><table class='main_table2' cellpadding='0' cellspacing='0'><tr><td class='main_table2_th'><table class='titel_table' cellpadding='0' cellspacing='0'><tr><td class='title_table_c1'>"+courseName+"</td><td class='title_table_c2'><a class='home_button' href='../Lessons.html' title='Course Home'><span></span></a></td></tr></table></td></tr><tr><td class='main_table2_tb'></td></tr><tr><td class='main_table2_tc'><table class='slides_table'><tr><td class='slides_table_tl'>"+unitName+": "+lessonName+"</td></tr><tr><td><div align='right'></div></td></tr><tr><td width='304'><table><tr><td width='23' height='64' align='center' valign='top'>&nbsp;</td><td width='76' height='64' align='center' valign='top'><td width='2690' height='64' align='right' valign='top'><a href='javascript:winprint();'><b>Print</b></a><table border='0' cellpadding='0' cellspacing='0' width='100%'><tr><td width='7%' height='60' rowspan='2' valign='top' align='right'><img border='0' src='../images/image_20.jpg' width='42' height='42' align='middle'></td><td class='head1'>Checklist</td></tr><tr><td width='93%' height='41' class='main_s'>&nbsp;&nbsp;&nbsp;<div id='divcontent'><FONT face=Verdana size='2' color='#191919'>"+learnToday+"</font></div></td></tr><tr><td width='79'>&nbsp;</td><td width='720'>&nbsp;</td></tr></table></td></tr></table></td></tr><tr><td class='main_table2_tb'></td></tr><tr><td class='main_table2_te'><table class='bottom_table' cellpadding='0' cellspacing='0' align='right'><tr><td class='main_table2_copy'>Mahoning Unlimited Classroom © All Rights Reserved.</td><td class='bottom_table_c1'><a class='previous_button' href='"+prev1Link+"' title='Previous'></a></td><td class='bottom_table_c2'><a class='next_button' href='"+next3Link+"' title='Next'></a></td></tr></table></td></tr></table></td><td class='main_table_c3'></td></tr></table></body></html>"+"\n";
						rFile5.setLength(0);
						rFile5.writeBytes(str2);
						rFile5.close();


					}
				}
				
			}
		}
	}
	}
}
		catch(Exception e)
		{
			System.out.println("Error 67891234 in createLessonFile.java at construct paper is.:"+e);
			
		}
		finally
		{
			try
			{
				if(rFile1!=null)
					rFile1.close();
				if(rFile2!=null)
					rFile2.close();
				if(rFile3!=null)
					rFile3.close();
				if(rFile4!=null)
					rFile4.close();
				if(rFile5!=null)
					rFile5.close();
				if(con!=null)
					con.close();
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(st2!=null)
					st2.close();
				if(st3!=null)
					st3.close();
			}
			catch(Exception e)
			{
				System.out.println("Error 3456 in createLessonFile.java at construct paper is.:"+e);	
			}
		}
	}
	public void createLessonSlide(String courseName, String courseId, String cmPath)
	{
		RandomAccessFile rFile1=null,rFile2=null;
		String unitPath="",lessonSlide="",unitId="",unitName="",lessonId="",lessonName="",prevLink="",nextLink="",learnToday="",cQuestions="",matNeed="";
		String slideContent="",nextUnit="",prevUnit="",firstPage="";
		boolean unit_last=false, unit_first=false;
		int x=0,y=0,z=0,i=0,prev1=0;
		String uids="",lids="",uId="",lId="";
		
		try
		{
			con = db.getConnection();
			st=con.createStatement();
			st1=con.createStatement();
			st2=con.createStatement();
			st3=con.createStatement();
			st5=con.createStatement();
			
			rs5=st5.executeQuery("select unit_ids,lesson_ids from pretest_student_material_distribution where school_id='eschool' and student_id='student2' and course_id='c0005'");
			if(rs5.next())
			{
				uids=rs5.getString("unit_ids");
				lids=rs5.getString("lesson_ids");
			}
			
			StringTokenizer uIdsTkn=new StringTokenizer(uids,",");
			while(uIdsTkn.hasMoreTokens())
			{
				uId=uIdsTkn.nextToken();
							
			rs=st.executeQuery("select * from dev_units_master where course_id='"+courseId+"' and unit_id='"+uId+"'");
			while(rs.next())
			{
				x++;
				unitId=rs.getString("unit_id");
				unitName=rs.getString("unit_name");
				i=0;

				StringTokenizer lIdsTkn=new StringTokenizer(lids,",");
								
				while(lIdsTkn.hasMoreTokens())
				{
				  lId=lIdsTkn.nextToken();
				 
					rs1=st1.executeQuery("select * from dev_lessons_master where course_id='"+courseId+"' and unit_id='"+unitId+"' order by lesson_id");
					while(rs1.next())
					{
						
						String str1="",str2="",str3="",prev1Link="",next1Link="",prev2Link="",next2Link="",prev3Link="",next3Link="";
						String uStr1="",lStr1="",uStr2="",lStr2="",nextSlide="",home="";
						lessonId=rs1.getString("lesson_id");
						
						if(lId.equals(lessonId))
						{
							 							 
							 i++;
							if(x<10)	
							{
								uStr1="/0";
								uStr2="0";
							}
							else
							{
								uStr1="/";
								uStr2="";
							}
						
						i=rs1.getRow();
						if(i<10)
							{
								lStr1="_0";
								lStr2="0";
							}
							else	
							{
								lStr1="_";
								lStr2="";
							}
					
					lessonName=rs1.getString("lesson_name");
					//unitPath=cmPath+"/course_bundles/"+courseName+"/slides";
					unitPath=cmPath+"/eschool/student2/coursemgmt/c0001/CD/"+courseName+"/slides";
					unitPath=unitPath+"/"+lessonId;
					File LessonSlide=new File(unitPath);
					if(!LessonSlide.exists())
						LessonSlide.mkdirs();
					firstPage=unitPath+uStr1+x+lStr1+i+"_02_01.html";
					rs2=st2.executeQuery("select * from dev_lesson_content_master where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' order by slide_no");
					if(rs2.next())
					{
						do{
							str1="";
							str2="";
							slideContent=rs2.getString("slide_content");
							//slideContent=slideContent.replaceAll("http://oh.learnbeyond.net/LBRT/coursedeveloper/CB_images/","../images/");
					slideContent=slideContent.replaceAll("%20"," ");
					slideContent=slideContent.replaceAll("http://oh.learnbeyond.net/LBRT/coursedeveloper/course_bundles/"+courseName+"/slides/images/","../images/");
					slideContent=slideContent.replaceAll("target=_blank href=\"javascript:","href=\"javascript: ");
					slideContent=slideContent.replaceAll(";\" target=_blank",";\"");

						z=rs2.getRow();
												
						
						if((z+1)<10){
							nextSlide=unitPath+uStr1+x+lStr1+i+"_02_0"+(z+1)+".html";
						}
						else
							nextSlide=unitPath+uStr1+x+lStr1+i+"_02_"+(z+1)+".html";

						if(z<10){
							prev1Link=uStr2+x+"_"+lStr2+i+"_02_0"+(z)+".html";
							if((z+2)<10)
								next1Link=uStr2+x+"_"+lStr2+i+"_02_0"+(z+2)+".html";
							else
								next1Link=uStr2+x+"_"+lStr2+i+"_02_"+(z+2)+".html";
						}
						else{
							prev1Link=uStr2+x+"_"+lStr2+i+"_02_"+(z)+".html";
							next1Link=uStr2+x+"_"+lStr2+i+"_02_"+(z+2)+".html";
						}

						if(rs2.isLast())
							next2Link="";
						else
							next2Link="<a href='"+next1Link+"'><font face='Verdana' size='1'>NEXT&gt;&gt;&nbsp;</font></a>";

						home=uStr2+x+"_"+lStr2+i+"_02_01.html";
						nextLink=uStr2+x+"_"+lStr2+i+"_02_02.html";
					
						if(z==1 && !slideContent.equals(""))
						{
							
							rFile1=new RandomAccessFile(firstPage,"rw");
							str1=str1+"<html><head><meta name='GENERATOR' content='Microsoft FrontPage 5.0'><meta name='ProgId' content='FrontPage.Editor.Document'><meta http-equiv='Content-Type' content='text/html; charset=windows-1252'><title>"+courseName+"</title><link href='images/slide_css.css' rel='stylesheet' type='text/css'><script src='../images/script.js'></script><bgsound id=pptSound><link href='images/slide_css.css' rel='stylesheet' type='text/css'></head><body><table border='2' cellpadding='0' cellspacing='0' bordercolor='#000080' width='670' height='440' align='center'><tr><td width='670' height='425'><div class='slide_heading' align='center' color='red'><font color='#FF0000'><b>Directions for viewing a Lesson</b></font><p>&nbsp;</div><br><div class='slide_sub_heading'>&nbsp;&nbsp;&nbsp;&bull;&nbsp;<font color='#6600CC'>In order to move to the next page, simply click on the <font size='1' face='Verdana'>&nbsp;&quot;NEXT<span style='font-weight: 400'>&gt;&gt;</span>&quot;</font>&nbsp;link below.</font><p><br>&nbsp;&nbsp;&nbsp;&bull;&nbsp;<font color='#6600CC'>Be sure to view all the pages within the lesson.</font><br>&nbsp;</div><br><br></td></tr><tr><td height='15' width='670'><table border='0' cellpadding='0' cellspacing='0' width='670' height='15'><tr><td width='33%' height='15' class='main'><!-- <font face='Verdana' size='1'><a href='01_01_02_02.html'>&nbsp;&lt;&lt;PREVIOUS</a></font> --></td><td width='34%' height='15' class='main' align='center'><a href='"+home+"'><font face='Verdana' size='1'>&lt;&lt;HOME&gt;&gt;</font></a></td><td width='33%' height='15' class='main' align='right'><a href='"+nextLink+"'><font face='Verdana' size='1'>NEXT&gt;&gt;&nbsp;</font></a></td></tr></table></td></tr></table></body></html>"+"\n";
							rFile1.setLength(0);
							rFile1.writeBytes(str1);
							rFile1.close();
						}
						else if(z==1 && slideContent.equals(""))
						{
							
							rFile1=new RandomAccessFile(firstPage,"rw");
							str1=str1+"<html><head><meta name='GENERATOR' content='Microsoft FrontPage 5.0'><meta name='ProgId' content='FrontPage.Editor.Document'><meta http-equiv='Content-Type' content='text/html; charset=windows-1252'><title>"+courseName+"</title><link href='images/slide_css.css' rel='stylesheet' type='text/css'><script src='../images/script.js'></script><bgsound id=pptSound><link href='images/slide_css.css' rel='stylesheet' type='text/css'></head><body><table border='2' cellpadding='0' cellspacing='0' bordercolor='#000080' width='670' height='440' align='center'><tr>	<td width='670' height='425'><div class='slide_heading' align='center'>Here there is no Lesson Content for viewing</div><br><br><br></td></tr><tr><td height='15' width='670'><table border='0' cellpadding='0' cellspacing='0' width='100%' height='15'><tr><td width='33%' height='15' class='main'></td><td width='34%' height='15' class='main' align='center'></td><td width='33%' height='15' class='main' align='right'></td></tr></table></td></tr></table></body></html>"+"\n";
							rFile1.setLength(0);
							rFile1.writeBytes(str1);
							rFile1.close();
						}
						rFile2=new RandomAccessFile(nextSlide,"rw");
						str2=str2+"<html><head><meta name='GENERATOR' content='Microsoft FrontPage 5.0'><meta name='ProgId' content='FrontPage.Editor.Document'><meta http-equiv='Content-Type' content='text/html; charset=windows-1252'><title>"+courseName+"</title><link href='images/slide_css.css' rel='stylesheet' type='text/css'><script src='../images/script.js'></script><bgsound id=pptSound><link href='images/slide_css.css' rel='stylesheet' type='text/css'></head><body><table border='2' cellpadding='0' cellspacing='0' bordercolor='#000080' width='670' height='440' align='center'><tr><td width='670' height='425'><div class='slide_heading' align='center'></div><br><div class='slide_sub_heading'>&nbsp;&nbsp;</div><br><div class='slide_content'><UL>"+slideContent+"</UL></div><br></td></tr><tr><td height='15' width='670'><table border='0' cellpadding='0' cellspacing='0' width='100%' height='15'><tr><td width='33%' height='15' class='main'><font face='Verdana' size='1'><a href='"+prev1Link+"'>&nbsp;&lt;&lt;PREVIOUS</a></font></td><td width='34%' height='15' class='main' align='center'><a href='"+home+"'><font face='Verdana' size='1'>&lt;&lt;HOME&gt;&gt;</font></a></td><td width='33%' height='15' class='main' align='right'>"+next2Link+"</td></tr></table></td></tr></table></body></html>"+"\n";
						rFile2.setLength(0);
						rFile2.writeBytes(str2);
						rFile2.close();
						
						}while(rs2.next());
					}
					else
					{
						rFile1=new RandomAccessFile(firstPage,"rw");
						str1=str1+"<html><head><meta name='GENERATOR' content='Microsoft FrontPage 5.0'><meta name='ProgId' content='FrontPage.Editor.Document'><meta http-equiv='Content-Type' content='text/html; charset=windows-1252'><title>"+courseName+"</title><link href='images/slide_css.css' rel='stylesheet' type='text/css'><script src='../images/script.js'></script><bgsound id=pptSound><link href='images/slide_css.css' rel='stylesheet' type='text/css'></head><body><table border='2' cellpadding='0' cellspacing='0' bordercolor='#000080' width='670' height='440' align='center'><tr>	<td width='670' height='425'><div class='slide_heading' align='center'>Here there is no Lesson Content for viewing</div><br><br><br></td></tr><tr><td height='15' width='670'><table border='0' cellpadding='0' cellspacing='0' width='100%' height='15'><tr><td width='33%' height='15' class='main'></td><td width='34%' height='15' class='main' align='center'></td><td width='33%' height='15' class='main' align='right'></td></tr></table></td></tr></table></body></html>"+"\n";
						rFile1.setLength(0);
						rFile1.writeBytes(str1);
						rFile1.close();
					}
					}
				}
		}
	}
}
	
}
		catch(Exception e)
		{
			System.out.println("Error 67890 in createLessonSlide at construct paper is.:"+e);
		}
		finally
		{
			try
			{
				if(rFile1!=null)
					rFile1.close();
				if(rFile2!=null)
					rFile2.close();
				if(con!=null)
					con.close();
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(st2!=null)
					st2.close();
				if(st3!=null)
					st3.close();
				
			}
			catch(Exception e)
			{
				System.out.println("Error in 1200000 MaterialGenerator at construct paper is.:"+e);	
			}
		}
	}


	public void createHomePage(String schoolId,String studentId,String courseId,String devCourseId,String cmPath)
	{
		RandomAccessFile rFile1=null;
		String homePagePath="",courseName="";
		String subject="",color="",lessonsPage="",str1="",lessonName="";
		String firstUnitId="",firstUnitName="",secondUnitId="",secondUnitName="",unitName="";
		String lessonId="",lessonId2="";

		try
		{
			con = db.getConnection();
			st1=con.createStatement();
			st2=con.createStatement();
			st3=con.createStatement();
			st4=con.createStatement();
			System.out.println("devCourseId..."+devCourseId);
			rs=st.executeQuery("select * from dev_course_master where course_id='"+devCourseId+"' and status=1");
			if(rs.next())
			{
				courseName=rs.getString("course_name");
				subject=rs.getString("subject");
				color=rs.getString("color_choice");
			}
			
			homePagePath=cmPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/CD/"+courseName;
			File LessonFile1=new File(homePagePath);
			if(!LessonFile1.exists())
					LessonFile1.mkdirs();
	
			lessonsPage=homePagePath+"/Lessons.html";	
			System.out.println("lessonsPage...."+lessonsPage);
			
			rFile1=new RandomAccessFile(lessonsPage,"rw");

			str1=str1+"<html><head><title>"+courseName+"</title><meta name='generator' content='Namo WebEditor'><link rel='stylesheet' type='text/css' href='css/style.css' /><link rel='stylesheet' type='text/css' href='css/red.css' />\n<script type='text/JavaScript'>\n<!--\nfunction MM_jumpMenu(targ,selObj,restore){   eval(targ+\".location='\"+selObj.options[selObj.selectedIndex].value+\"'\");  \nif (restore) selObj.selectedIndex=0;}\n//-->\n</script></head><body><table class='main_table' align='center'><tr><td class='main_table_c1'></td><td class='main_table_c2'><table class='main_table2' cellpadding='0' cellspacing='0'><tr><td class='main_table2_th'><table class='titel_table' cellpadding='0' cellspacing='0'><tr><td class='title_table_c1'>"+courseName+"</td><td class='title_table_c2'><a class='home_button' href='Lessons.html' title='Course Home'><span></span></a></td></tr></table></td></tr><tr><td class='main_table2_tb'></td></tr><tr><td class='main_table2_tc'><table class='units_table' width='548'><tr><td class='units_table_cl'>&nbsp;</td><td class='units_table_cl'>&nbsp;</td></tr>"+"\n";

			

			int unitNo=0;
			String uNo="",uId="",lId="";
			String uids="",lids="";
						
			rs4=st4.executeQuery("select unit_ids,lesson_ids from pretest_student_material_distribution where school_id='"+schoolId+"' and student_id='"+studentId+"' and course_id='"+courseId+"'");
			if(rs4.next())
			{
				uids=rs4.getString("unit_ids");
				lids=rs4.getString("lesson_ids");
			}
			
			
			StringTokenizer uIdsTkn=new StringTokenizer(uids,",");
			while(uIdsTkn.hasMoreTokens())
			{
				int i=0,k=0;
				uId=uIdsTkn.nextToken();
				
						
			rs1=st1.executeQuery("select * from dev_units_master where course_id='"+devCourseId+"' and unit_id='"+uId+"'");
			
			if(rs1.next())
			{
				unitNo=unitNo+1;
				if(unitNo==1)
					unitName=rs1.getString("unit_name");
				firstUnitId=rs1.getString("unit_id");
				firstUnitName=rs1.getString("unit_name");
											
				
					secondUnitId="";
					secondUnitName="";
					
				
							
				str1=str1+"<tr><td height='14' class='units_table_cl'>"+firstUnitName+"</td></tr>";

				str1=str1+"<tr><td class='units_table_cl'><SELECT onchange=\"MM_jumpMenu('self',this,1)\" name=Llist_2><OPTION value='Lessons.html' selected>Select your lesson</OPTION>";
				

				i=0;
				StringTokenizer lIdsTkn=new StringTokenizer(lids,",");
				while(lIdsTkn.hasMoreTokens())
				{
					lId=lIdsTkn.nextToken();
									
				rs2=st2.executeQuery("select lesson_id,lesson_name from dev_lessons_master where course_id='"+devCourseId+"' and unit_id='"+firstUnitId+"' order by lesson_id");
				while(rs2.next())
				{					
					
					lessonName=rs2.getString("lesson_name");
					System.out.println("firstUnitName..."+firstUnitName);
					System.out.println("lessonName..."+lessonName);
					lessonId=rs2.getString("lesson_id");
					if(lId.equals(lessonId))
					{
						i++;
						if(unitNo<10)
							uNo="0"+unitNo;
						else
							uNo=""+unitNo;
						if(i<10)
							str1=str1+"<OPTION value='"+firstUnitName+"/"+uNo+"_0"+i+"_01.html'>"+lessonName+"</OPTION>";
						else
							str1=str1+"<OPTION value='"+firstUnitName+"/"+uNo+"_"+i+"_01.html'>"+lessonName+"</OPTION>";
												
					}
					
										
				}							
				
			}
			str1=str1+"</SELECT></td>";
				
				str1=str1+"</tr>";
			}
		}
		}
		catch(Exception e)
		{
			System.out.println("Special Exception44444444444 is..."+e);
		}
			
		try
		{		
			

			str1=str1+"<tr><td class='units_table_cl'>&nbsp;</td><td class='units_table_cl'>&nbsp;</td></tr></table></td></tr><tr><td class='main_table2_tb'></td></tr><tr><td class='main_table2_te'><table class='bottom_table' cellpadding='0' cellspacing='0' align='right'><tr><td class='main_table2_copy'>Mahoning Unlimited Classroom © All Rights Reserved.</td><td class='bottom_table_c1'><a class='previous_button' href='Lessons.html' title='Previous'></a></td><td class='bottom_table_c2'><a class='next_button' href='"+unitName+"/01_01_01.html' title='Next'></a></td></tr></table></td></tr></table></td><td class='main_table_c3'></td></tr></table></body></html>";

			rFile1.setLength(0);
		    rFile1.writeBytes(str1);
			rFile1.close();
		}
		catch(Exception e)
		{
			System.out.println("Special Exception555555555555 is..."+e);
		}
		finally
		{
			try
			{
				if(rFile1!=null)
					rFile1.close();
				if(con!=null)
					con.close();
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
			}
			catch(Exception e)
			{
				System.out.println("Error 14543 in createHomePage.java at construct paper is.:"+e);	
			}
		}
	}

	public void importAssignment(String sPath, String aNos, String courseId, String oldURL, String cmPath, String aCId, String aTId, String aSId,String to_date)
	{
		RandomAccessFile rFile1=null;
		String ids=null;
		String coursePath="",assgnContent="",unitName="",lessonId="",lessonName="",unitId="",assgnName="",assgnCat="";
		int totMarks=0,assgnNo=0;
		String str1="",contentPath="",assgnContentPage="",attachFile="",attachFileNew="";
		String fromDate="",deadLine="",fileName="",topic="",subtopic="",comments="",workDoc="",docName="",courseName="";
		int i=0,j=0;
			
		String schoolPath =sPath;
		String schoolId=aSId;
		String assgnNos="";
		File ContentFile=null;
		FileUtility fu=null;

		String workId="",tableName="";
		String newURL="",oldURL1="";

		Utility utility= new Utility(schoolId,schoolPath);
			
		try
		{
			ids=aNos;
			StringTokenizer idsTkn=new StringTokenizer(ids,",");
								
			while(idsTkn.hasMoreTokens())
			{
								
				assgnNos=idsTkn.nextToken();

				coursePath=cmPath;

				if(courseId.equals("DC008")||courseId.equals("DC015")||courseId.equals("DC032")||courseId.equals("DC016")||courseId.equals("DC026")||courseId.equals("DC049")||courseId.equals("DC030")||courseId.equals("DC018")||courseId.equals("DC031")||courseId.equals("DC047")||courseId.equals("DC055")||courseId.equals("DC056")||courseId.equals("DC023")||courseId.equals("DC036")|courseId.equals("DC060")||courseId.equals("DC036")||courseId.equals("DC057")||courseId.equals("DC046")||courseId.equals("DC042")||courseId.equals("DC058")||courseId.equals("DC024")||courseId.equals("DC019"))
				{
					tableName="dev_assgn_social_larts_content_master";
				
				}
				else if(courseId.equals("DC048")||courseId.equals("DC005")||courseId.equals("DC043")||courseId.equals("DC044")||courseId.equals("DC051")||courseId.equals("DC037")||courseId.equals("DC080")||courseId.equals("DC050")||courseId.equals("DC020")||courseId.equals("DC017")||courseId.equals("DC059"))
				{
					tableName="dev_assgn_science_content_master";
				
				}
				else
				{
					tableName="dev_assgn_math_content_master";
				
				}

				rs1=st1.executeQuery("select * from "+tableName+" where course_id='"+courseId+"' and slno='"+assgnNos+"'");
				
				if(rs1.next())
				{					
					courseName=rs1.getString("course_name");
					lessonId=rs1.getString("lesson_id");
					lessonName=rs1.getString("lesson_name");
					assgnNo=Integer.parseInt(rs1.getString("assgn_no"));
					assgnName=rs1.getString("assgn_name");
					assgnName=assgnName.replaceAll("\'","&#39;");
					assgnCat=rs1.getString("category_id");
					maxattempts=rs1.getString("maxattempts");
					if(assgnCat.equals("WR"))
					{
						assgnCat="WA";
						
					}
					totMarks=Integer.parseInt(rs1.getString("marks_total"));
														
					assgnContent=rs1.getString("assgn_content");

					assgnContent=assgnContent.replaceAll("%20"," ");
					attachFile=rs1.getString("assgn_attachments");
					if(attachFile==null)
						attachFile="";
										
					workId=utility.getId("WorkId");

					if (workId.equals(""))
					{
						utility.setNewId("WorkId","w0000");
						workId=utility.getId("WorkId");
						
					}
										
					contentPath=coursePath+"/"+assgnCat;
										
					ContentFile=new File(contentPath);
					
					
					if(!ContentFile.exists())
						ContentFile.mkdirs();
						docName=assgnName;
										
						if (deadLine==null || deadLine.equals(""))
							deadLine=to_date;
						if (fromDate==null)
							fromDate="2008-08-28";
						
									
						workDoc=workId+"_"+lessonId+"_"+assgnNo+".html";
						
						fileName=workDoc;
						
																		
						if(comments==null)
							comments="";
						if(topic==null)
							topic="";
						if(subtopic==null)
							subtopic="";
						/* attachments    */
						oldURL1=oldURL;
						
						if(attachFile.equals("null") || attachFile==null || attachFile.equals(""))
						{
							attachFileNew="";
														
						}
						else
						{
							
							oldURL=oldURL+"/"+assgnCat;
														
							fu=new FileUtility();
							
							newURL=schoolPath+"/"+schoolId+"/"+aTId+"/coursemgmt/"+aCId+"/"+assgnCat;
							
							fu.createDir(newURL);
							
							attachFileNew=workId+"_"+attachFile;
							
							fu.copyFile(oldURL+"/"+attachFile,newURL+"/"+attachFileNew);
							oldURL=oldURL1;
							
							
						}

						/* attachments  upto here   */


						
					i=st2.executeUpdate("insert into "+aSId+"_C000_"+aCId+"_workdocs (work_id,category_id,doc_name,topic,subtopic,teacher_id,created_date,from_date,modified_date,asgncontent,attachments,max_attempts,marks_total,to_date,mark_scheme,instructions,status) values('"+workId+"','"+assgnCat+"','"+assgnName+"','','','"+aTId+"',curdate(),curdate(),curdate(),'"+assgnContent+"','"+attachFileNew+"',"+maxattempts+","+totMarks+",'"+deadLine+"',0,'','0')");
					
					st.executeUpdate("update category_item_master set status=1 where item_id='"+assgnCat+"' and course_id='"+aCId+"' and school_id='"+aSId+"'");					
						
					j=st2.executeUpdate("insert into "+aSId+"_activities() values('"+workId+"','"+assgnName+"','AS','"+assgnCat+"','"+aCId+"',curdate(),'"+deadLine+"')");
						
					assgnContentPage=contentPath+"/"+fileName;
					
					i++;
					
					j++;
					
			}
		
	}
}

		catch(Exception e)
		{
			System.out.println("Error 123456789 in importassignments.java at construct paper is.:"+e);
		}
		finally
		{
			try
			{
				if(rFile1!=null)
					rFile1.close();
				if(con!=null)
					con.close();
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(st2!=null)
					st2.close();
				if(st3!=null)
					st3.close();
				
			}
			catch(Exception e)
			{
				System.out.println("Error 12578 in MaterialGenerator.java at construct paper is.:"+e);	
			}
		}
	}
	public void generateAssignment(String sPath, String courseName, String courseId, String oldURL, String newURL, String aCId, String aTId, String aSId)
	{
		RandomAccessFile rFile1=null;
		String coursePath="",assgnContent="",unitName="",lessonId="",lessonName="",unitId="",assgnName="",assgnCat="";
		int totMarks=0,assgnNo=0;
		String str1="",contentPath="",assgnContentPage="";
		String fromDate="",deadLine="",fileName="",topic="",subtopic="",comments="",workDoc="",docName="";
		int i=0;
			
		String schoolPath ="C:/Tomcat5/webapps/LBRT/schools";
		String schoolId=aSId;

		Utility utility= new Utility(schoolId,schoolPath);
			
		try
		{
			
			rs=st.executeQuery("select * from dev_units_master where course_id='"+courseId+"' order by unit_id");
			while(rs.next())
			{			
				unitId=rs.getString("unit_id");
				coursePath=newURL;
				File LessonFile=new File(coursePath);
				if(!LessonFile.exists())
						LessonFile.mkdirs();
				rs1=st1.executeQuery("select * from dev_lesson_assgn_content_master where course_id='"+courseId+"' and unit_id='"+unitId+"'");
				while(rs1.next())
				{					
					lessonId=rs1.getString("lesson_id");
					lessonName=rs1.getString("lesson_name");
					assgnNo=Integer.parseInt(rs1.getString("assgn_no"));
					assgnName=rs1.getString("assgn_name");
					assgnCat=rs1.getString("category_id");
					maxattempts=rs1.getString("maxattempts");
					if(assgnCat.equals("WR"))
						assgnCat="WA";
					totMarks=Integer.parseInt(rs1.getString("marks_total"));
										
					assgnContent=rs1.getString("assgn_content");
					//assgnContent=assgnContent.replaceAll("http://oh.learnbeyond.net/LBRT/coursedeveloper/CB_images/","../images/");
					assgnContent=assgnContent.replaceAll("%20"," ");
										
					String workId=utility.getId("WorkId");
					if (workId.equals(""))
					{
						utility.setNewId("WorkId","w0000");
						workId=utility.getId("WorkId");
					}
					
					contentPath=coursePath+"/"+assgnCat;
					File ContentFile=new File(contentPath);
						if(!ContentFile.exists())
						ContentFile.mkdirs();
						docName=assgnName;
				
						if (deadLine==null || deadLine.equals(""))
							deadLine="2008-09-20";
						if (fromDate==null)
							fromDate="2008-08-01";
						
									
						workDoc=workId+"_"+lessonId+"_"+assgnNo+".html";
						fileName=workDoc;
																		
						if(comments==null)
							comments="";
						if(topic==null)
							topic="";
						if(subtopic==null)
							subtopic="";
						
						
					i=st2.executeUpdate("insert into "+aSId+"_C000_"+aCId+"_workdocs (work_id,category_id,doc_name,topic,subtopic,teacher_id,created_date,from_date,modified_date,asgncontent,attachments,max_attempts,marks_total,to_date,mark_scheme,instructions,status) values('"+workId+"','"+assgnCat+"','"+assgnName+"','','','"+aTId+"',curdate(),curdate(),curdate(),'"+assgnContent+"','',"+maxattempts+","+totMarks+",'"+deadLine+"',0,'','0')");
					st.executeUpdate("update category_item_master set status=1 where item_id='"+assgnCat+"' and course_id='"+aCId+"' and school_id='"+aSId+"'");
						
					st2.executeUpdate("insert into "+aSId+"_activities() values('"+workId+"','"+assgnName+"','AS','"+assgnCat+"','"+aCId+"','','')");
						
					assgnContentPage=contentPath+"/"+fileName;
														
					rFile1=new RandomAccessFile(assgnContentPage,"rw");
				
				str1=str1+"<html><head><meta http-equiv='Content-Language' content='en-us'><meta name='GENERATOR' content='Microsoft FrontPage 5.0'><meta name='ProgId' content='FrontPage.Editor.Document'><meta http-equiv='Content-Type' content='text/html; charset=windows-1252'><title>ASSIGNMENT INFO</title></head><body><form><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><div align='center'><center><table border='0' cellspacing='0' width='80%' id='AutoNumber2' style='border-collapse: collapse' bordercolor='#111111' cellpadding='0'><tr><td width='100%' colspan='2'><hr color='#C0C0C0' size='1'></td></tr><tr><td width='50%'><font face='Verdana' size='2' color='#000080'><b>Course Name :</b></font><font face='Verdana' size='2' color='#800000'>"+courseName+"</font></td><td width='50%'><p align='right'><font face='Verdana' size='2' color='#000080'><b>&nbsp;Lesson Name: </b></font><font face='Verdana' size='2' color='#800000'>"+lessonName+"</font></td></tr></table></center></div><div align='center'><center><table border='0' cellspacing='1' width='80%' id='AutoNumber1' height='524'><tr><td width='73%' bgcolor='#FFFFFF' height='25' colspan='2'><hr color='#C0C0C0' size='1'></td></tr><tr><td width='28%' bgcolor='#7C7C7C' height='25'><b><font face='Verdana' size='2' color='#FFFFFF'>&nbsp;ASSIGNMENT VIEW</font><font face='Verdana' size='2' color='#000080'></font></b></td><td width='45%' bgcolor='#7C7C7C' height='25'><p align='right'><b><font face='Verdana' size='1' color='#FFFFFF'><font color='#FFFFFF'></font></a>&nbsp; </font></b></td></tr><tr><td width='12%' height='22' bgcolor='#C0C0C0'><font face='Verdana' size='2'>&nbsp;Assignment Name</font></td><td width='61%' height='22' bgcolor='#EBEBEB'>&nbsp;"+assgnName+"</td></tr><tr><td width='12%' height='22' bgcolor='#C0C0C0'><font face='Verdana' size='2'>&nbsp;Category</font></td><td width='61%' height='22' bgcolor='#EBEBEB'>&nbsp;"+assgnCat+"</td></tr><tr><td width='12%' height='22' bgcolor='#C0C0C0'><font face='Verdana' size='2'>&nbsp;Maximum Points</font></td><td width='61%' height='22' bgcolor='#EBEBEB'>&nbsp;"+totMarks+"</td></tr><tr><td width='73%' colspan='2' height='28' bgcolor='#C0C0C0' align='center'><p align='left'><font face='Verdana' size='2'>&nbsp;Assignment:</font></td></tr><tr><td width='73%' colspan='2' height='388' bgcolor='#EBEBEB'>&nbsp;"+assgnContent+"</td></tr><tr><td width='73%' colspan='2' height='27' bgcolor='#C0C0C0'>&nbsp;</td></tr></table></center></div>&nbsp;</p></form><p>&nbsp;</body></html>";
				rFile1.setLength(0);
			    rFile1.writeBytes(str1);
				rFile1.close();
				str1="";
				i++;
				
				
			}
		}
	}

		catch(Exception e)
		{
			System.out.println("Error 6789 in generateLesson.java at construct paper is.:"+e);
		}
		finally
		{
			try
			{
				if(rFile1!=null)
					rFile1.close();
				if(con!=null)
					con.close();
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(st2!=null)
					st2.close();
				if(st3!=null)
					st3.close();
				
			}
			catch(Exception e)
			{
				System.out.println("Error 1234234 in MaterialGenerator.java at construct paper is.:"+e);	
			}
		}
	}






	//	matGen.submitFirstPage(courseName,unitNo,lessonName,learnToday,criticalQtns,materials,words,cmPath);

	public void submitFirstPage(String courseName,String unitNo,String lessonName,String learnToday,String criticalQtns,String materials,String words,String path)
	{
		RandomAccessFile rFile1=null;

		try
		{
			
			File LessonFile=new File(path);
			LessonFile.mkdirs();
			
			String fileName="",str1="",prev1Link="",next1Link="";
			fileName=path+"/0"+unitNo+"_0"+lessonName+"_01.html";
			rFile1=new RandomAccessFile(fileName,"rw");
		
			str1=str1+"<html><head><title>"+courseName+"</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><link href='../images/sheet1' rel='stylesheet' type='text/css'><link href='../images/sheet2' rel='stylesheet' type='text/css'></head><body bgcolor='#FFFFFF' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'><table width='770' border='1' align='center' cellpadding='0' cellspacing='0'><tr><td align='left' valign='top' width='766'><table id='Table_01' width='800' height='400' border='0' cellpadding='0' cellspacing='0' align='center'><tr><td rowspan='14' width='1' height='399'><img src='images/content_01.jpg' width='1' height='600' alt=''></td><td colspan='5' rowspan='2' width='254' height='1'><img src='../images/image_01.jpg' width='254' height='58' alt=''></td><td colspan='2' rowspan='2' width='328' height='1'><img src='../images/image_02.jpg' width='328' height='58' alt=''></td><td colspan='3' rowspan='2' width='129' height='1'><img src='../images/image_03.jpg' width='129' height='58' alt=''></td><td colspan='2' width='65' height='1'><img src='../images/image_04.jpg' width='87' height='20' alt='' border='0'></td><td width='23' height='1'><img src='../images/image_07.gif' width='1' height='20' alt=''></td></tr><tr><td colspan='2' rowspan='2' width='65' height='1' valign='top'><a href='../Lessons.html'><img src='../images/image_05.jpg' width='87' height='78' alt='' border='0'></a></td><td width='23' height='1'><img src='../images/image_07.gif' width='1' height='38' alt=''></td></tr><tr><td colspan='10' background='../images/image_06.jpg' class='main' width='711' height='1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;UNIT "+unitNo+": Lesson "+lessonName+" - "+lessonName+"</td><td width='23' height='1'><img src='../images/image_07.gif' width='1' height='40' alt=''></td></tr><tr><td colspan='12' width='776' align='left' valign='top' rowspan='8' height='376'><table width='795' border='0' cellspacing='0' cellpadding='0' height='15'><tr><td width='17' height='16'></td><td width='48' height='16'></td><td width='730' class='main' height='16'></td></tr><tr><td width='17' height='42'>&nbsp;</td><td width='48' height='42'><img src='../images/Unit1Lesson2_10.jpg' width='48' height='42'></td><td width='730' class='main' height='42'>WHAT WILL I LEARN TODAY?</td></tr><tr><td height='19' width='17'>&nbsp;</td><td height='19' width='48'>&nbsp;</td><td height='19' width='730'><FONT color=#000000 class='main_s'>&nbsp;&nbsp;&bull;&nbsp;"+learnToday+"</FONT></td></tr><tr><td width='17' height='19'>&nbsp;</td><td width='778' height='19' colspan='2'><hr color='#C0C0C0' width='90%' size='1' align='left'></td></tr><tr><td width='17' height='45'>&nbsp;</td><td width='48' height='45'><img src='../images/image_09.jpg' width='48' height='45'></td><td width='730' class='main' height='45'>CRITICAL QUESTIONS?</td></tr><tr><td height='38' width='17'>&nbsp;</td><td height='38' width='48'>&nbsp;</td><td height='38' width='730'><FONT color=#000000 class='main_s'>&nbsp;&nbsp;&bull;&nbsp;"+criticalQtns+"</FONT></td></tr><tr><td height='20' width='17'>&nbsp;</td><td height='20' width='778' colspan='2'><hr color='#C0C0C0' width='90%' size='1' align='left'></td></tr><tr><td height='1' width='17'></td><td height='1' width='48'><IMG SRC='../images/image_10.jpg' WIDTH='48' HEIGHT='58' BORDER='0' ALT=''></td><td class='main' height='1' width='730'>WHAT MATERIALS DO I NEED FOR THIS LESSON?</td></tr><tr><td height='19' width='17'>&nbsp;</td><td height='19' width='48'>&nbsp;</td><td height='19' class='main_s' width='730'><FONT color=#000000 class='main_s'>&nbsp;&nbsp;&bull;&nbsp;"+materials+"</FONT></td></tr><tr><td height='13' width='17'></td><td height='13' width='778' colspan='2'><hr color='#C0C0C0' width='90%' size='1' align='left'></td></tr><tr><td height='43' width='17'>&nbsp;</td><td height='43' width='48'><img border='0' src='../images/image_11.jpg' width='48' height='54'></td><td class='main' height='43' width='730'>WORDS I NEED TO KNOW :</td></tr><tr><td height='28' width='17'>&nbsp;</td><td height='28' width='48'>&nbsp;</td><td class='main_s' height='28' valign='top' width='730'><FONT color=#000000 class='main_s'>&nbsp;&nbsp;"+words+"</FONT></td></tr><tr><td height='28' width='17'></td><td height='28' width='778' colspan='2'><hr color='#C0C0C0' size='1' width='90%' align='left'></td></tr></table></td><td width='23' height='25'><img src='../images/image_07.gif' width='1' height='25' alt=''></td></tr><tr><td width='23' height='38'><img src='../images/image_07.gif' width='1' height='38' alt=''></td></tr><tr><td width='23' height='30'><img src='../images/image_07.gif' width='1' height='30' alt=''></td></tr><tr><td width='23' height='40'><img src='../images/image_07.gif' width='1' height='40' alt=''></td></tr><tr><td width='23' height='40'><img src='../images/image_07.gif' width='1' height='40' alt=''></td></tr><tr><td width='23' height='58'><img src='../images/image_07.gif' width='1' height='58' alt=''></td></tr><tr><td width='23' height='146'><img src='../images/image_07.gif' width='1' height='146' alt=''></td></tr><tr><td width='23' height='1'><img src='../images/image_07.gif' width='1' height='39' alt=''></td></tr><tr><td colspan='8' width='628' height='47'><img src='../images/image_12.jpg' width='628' height='47' alt=''></td><td colspan='4' width='148' height='47'><img src='../images/image_26.jpg' width='170' height='47' alt=''></td><td width='23' height='47'><img src='../images/image_07.gif' width='1' height='47' alt=''></td></tr><tr><td colspan='6' width='448' height='19'><img src='../images/image_13.jpg' width='448' height='19' alt=''></td><td colspan='2' rowspan='2' width='180' height='39'><img src='../images/image_28.jpg' width='180' height='39' alt=''></td><td rowspan='2' width='73' height='39'><img src='../images/image_29.jpg' width='73' height='39' alt=''></td><td colspan='2' rowspan='2' width='48' height='39'><a href='"+prev1Link+"'><img src='../images/image_30.jpg' width='48' height='39' alt='' border='0'></a></td><td rowspan='2' width='27' height='39'><a href='"+next1Link+"'><img src='../images/image_31.jpg' width='49' height='39' alt='' border='0'></a></td><td width='23' height='19'>	<img src='../images/image_07.gif' width='1' height='19' alt=''></td></tr><tr><td colspan='6' width='448' height='20'><img src='../images/image_32.jpg' width='448' height='20' alt=''></td><td width='23' height='20'><img src='../images/image_07.gif' width='1' height='20' alt=''></td></tr><tr><td width='1' height='1'><img src='../images/image_07.gif' width='1' height='1' alt=''></td><td width='30' height='1'><img src='../images/image_07.gif' width='30' height='1' alt=''></td><td width='2' height='1'><img src='../images/image_07.gif' width='2' height='1' alt=''></td><td width='2' height='1'><img src='../images/image_07.gif' width='2' height='1' alt=''></td><td width='44' height='1'><img src='../images/image_07.gif' width='44' height='1' alt=''></td><td width='176' height='1'><img src='../images/image_07.gif' width='176' height='1' alt=''></td><td width='194' height='1'><img src='../images/image_07.gif' width='194' height='1' alt=''></td><td width='134' height='1'><img src='../images/image_07.gif' width='134' height='1' alt=''></td><td width='46' height='1'><img src='../images/image_07.gif' width='46' height='1' alt=''></td><td width='73' height='1'><img src='../images/image_07.gif' width='73' height='1' alt=''></td><td width='10' height='1'><img src='../images/image_07.gif' width='10' height='1' alt=''></td><td width='38' height='1'><img src='../images/image_07.gif' width='38' height='1' alt=''></td><td width='27' height='1'><img src='../images/image_07.gif' width='49' height='1' alt=''></td><td width='23' height='1'></td></tr></table></td></tr></table></body></html>"+"\n";
			
			rFile1.seek(rFile1.length());
			rFile1.writeBytes(str1);
			rFile1.close();
		}
		catch(Exception e)
		{
			System.out.println("Error 0006789 in generateLesson.java at construct paper is.:"+e);
		}
		finally
		{
			try
			{
				if(rFile1!=null)
					rFile1.close();
				if(con!=null)
					con.close();
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(st2!=null)
					st2.close();
				if(st3!=null)
					st3.close();
			}
			catch(Exception e)
			{
				System.out.println("Error 1234890 in MaterialGenerator.java at construct paper is.:"+e);	
			}
		}
	}

	public void copyDirectory(File srcPath, File dstPath)throws IOException
	{
		  
		try
		{
			
			if (srcPath.isDirectory())
			{

				if (!dstPath.exists())
				{
					dstPath.mkdir();
					 
			     }

 
     String files[] = srcPath.list();
  
    for(int i = 0; i < files.length; i++){
        copyDirectory(new File(srcPath, files[i]),new File(dstPath, files[i]));
				  
      }

    }
 
   else
	{
       if(!srcPath.exists())
		{

			System.out.println("File or directory does not exist.");
	        
		 }
      
else
  
      {
 
       InputStream in = new FileInputStream(srcPath);
       OutputStream out = new FileOutputStream(dstPath); 
                     // Transfer bytes from in to out
            byte[] buf = new byte[1024];
 
              int len;
 
           while ((len = in.read(buf)) > 0) {
  
          out.write(buf, 0, len);

        }
 
       in.close();
 
           out.close();

      }
 
   }
   
	
 
	}
	catch(Exception e)
	{
		System.out.println("Error 11116789 in generateLesson.java at construct paper is.:"+e);
	}
	
}
public int copyCourse(File srcPath, File dstPath)throws IOException
{
		int flag=0;  
		try
		{
			
			if (srcPath.isDirectory())
			{

				if (!dstPath.exists())
				{
					dstPath.mkdir();
					 
			     }

 
     String files[] = srcPath.list();
  
    for(int i = 0; i < files.length; i++){
        copyDirectory(new File(srcPath, files[i]),new File(dstPath, files[i]));
		flag=1;
				  
      }

    }
 
   else
	{
       if(!srcPath.exists())
		{

			System.out.println("File or directory does not exist.");			
	        
		 }
      
		else
		{
 
			InputStream in = new FileInputStream(srcPath);
			OutputStream out = new FileOutputStream(dstPath); 
                     // Transfer bytes from in to out
            byte[] buf = new byte[1024];
 
              int len;
 
            while ((len = in.read(buf)) > 0)
			{
  
				out.write(buf, 0, len);
			}
		   in.close();
		   out.close();
		   

      }
 
   }
   
	}
	catch(Exception e)
	{
		System.out.println("Error 11116789 in generateLesson.java at construct paper is.:"+e);
	}
	return flag;
}
}