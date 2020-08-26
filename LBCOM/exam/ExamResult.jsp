<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,common.*" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<%@page import = "com.oreilly.servlet.MultipartRequest,javax.activation.DataHandler,javax.activation.FileDataSource,javax.activation.*,javax.mail.*,javax.mail.internet.*,javax.servlet.*,javax.servlet.http.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st11=null,st12=null,st13=null,st14=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs11=null,rs12=null,rs13=null,rs14=null;
	String courseId="",examName="",totalMarks="",marksScored="",shortTypeFlag="",examId="",courseName="";
	String schoolId="",studentId="",classId="",cbCourseId="",lessonStr="",examType ="",result="";
	ArrayList unitWorkIds = new ArrayList ();
	String widStr="",wId="",id="",unitStr="",finalUnitIds="",mailStatus="",teacherId="",teachMailId="";
	float securedPercentage=0.0f,passPercent=0.0f;
	
try
{
	

  examId=request.getParameter("exam_id");
  examName=request.getParameter("examname");
  totalMarks=request.getParameter("totalmarks");
  marksScored=request.getParameter("marks");
  shortTypeFlag=request.getParameter("shorttypeflag");
  	
	//securedPercentage=(Float.parseFloat(marksScored)/Float.parseFloat(totalMarks))*100;
	
	schoolId=(String)session.getAttribute("schoolid");
	classId=(String)session.getAttribute("classid");
	courseId=(String)session.getAttribute("courseid");
	studentId=request.getParameter("studentid");
	examType=request.getParameter("examtype");
	con=con1.getConnection();

		st=con.createStatement();
		rs=st.executeQuery("select * from coursewareinfo where course_id='"+courseId+"' and school_id='"+schoolId+"'");
		if(rs.next())
		{
			cbCourseId=rs.getString("cbuilder_id");
			if(cbCourseId==null)
			{
				cbCourseId="";
			}
			
			teacherId=rs.getString("teacher_id");
			courseName=rs.getString("course_name");
		}
		rs.close();
		st.close();

	if(!shortTypeFlag.equals("true")) {
	if(examType.equals("PT"))
	{
		
		int i=0;
		// Getting unit ids amd lesson ids
		String unitIds="",lessonId="";
		float secMarks=0.0f,totMarks=0.0f,passCriteria=0.0f,passCriteriaPercentage=0.0f;
		String unitId="";
			st3=con.createStatement();
			rs3=st3.executeQuery("select sum(secured_marks) as sum1,sum(max_marks) as sum2,lesson_id FROM pretest_lesson_secured_marks where exam_id='"+examId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"' group by lesson_id,exam_id");
			while(rs3.next())
			{
				
				secMarks=Float.parseFloat(rs3.getString("sum1"));
				totMarks=Float.parseFloat(rs3.getString("sum2"));
				lessonId=rs3.getString("lesson_id");
				
				st11=con.createStatement();
				rs11=st11.executeQuery("select * from pretest_unit_lesson_level where exam_id='"+examId+"' and lesson_id='"+lessonId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");
				if(rs11.next())
				{
					passCriteria=rs11.getFloat("pass_criteria");
					if(passCriteria!=0.0)
					{
						securedPercentage=(secMarks/totMarks)*100;
						
					}
					if(securedPercentage<passCriteria)
					{
						lessonStr=lessonStr+","+lessonId;

						
						st12=con.createStatement();
						rs12=st12.executeQuery("select * from lbcms_dev_lessons_master where course_id='"+cbCourseId+"' and lesson_id='"+lessonId+"'");
						if(rs12.next())
						{
							unitId=rs12.getString("unit_id");
							if(unitWorkIds.contains(unitId)==false)
							{
								unitWorkIds.add(unitId);
							}
														
						}
						rs12.close();
						st12.close();

					}
					
				}
				rs11.close();
				st11.close();
				
				
				secMarks=0.0f;
				totMarks=0.0f;
										

			} // end of  unitIds
			rs3.close();
			st3.close();

					
					for(int j=0;j<unitWorkIds.size();j++)
					{
						
						finalUnitIds=finalUnitIds+","+unitWorkIds.get(j);
					}
					int ulen=finalUnitIds.length();
					finalUnitIds=finalUnitIds.substring(1,ulen);

					int lessonLen=lessonStr.length();
					lessonStr=lessonStr.substring(1,lessonLen);

			

		st1=con.createStatement();
		rs1=st1.executeQuery("select * from pretest_student_material_distribution where course_id='"+courseId+"' and student_id='"+studentId+"' and school_id='"+schoolId+"'");
		if(rs1.next())
		{
			// This entry is already there
			
			st2=con.createStatement();
			i=st2.executeUpdate("update pretest_student_material_distribution set lesson_ids='"+lessonStr+"',unit_ids='"+finalUnitIds+"' where course_id='"+courseId+"' and student_id='"+studentId+"' and school_id='"+schoolId+"'");

		}
		else
		{
			
			st2=con.createStatement();
			i=st2.executeUpdate("insert into pretest_student_material_distribution(school_id,student_id,course_id,unit_ids,lesson_ids,status) values ('"+schoolId+"','"+studentId+"','"+courseId+"','"+finalUnitIds+"','"+lessonStr+"','2')");

		}
		st2.close();
		rs1.close();
		st1.close();


		//
				if(!cbCourseId.equals(""))
				{
					response.sendRedirect("StudentPretestCourse.jsp?cbcourseid="+cbCourseId+"&studentid="+studentId+"&totalmarks="+totalMarks+"&marks="+marksScored);
					
				}

			}// End of pretest
		}//End of shortTypeFlag
		else
		{
			// Sending Mail user
			if(examType.equals("PT"))
			{
				String fName="",lName="",stuLName="",stuFName="";

					st13=con.createStatement();
					rs13=st13.executeQuery("select * from teachprofile where schoolid='"+schoolId+"' and username='"+teacherId+"'");
					if(rs13.next())
					{
						fName=rs13.getString("firstname");
						lName=rs13.getString("lastname");
						teachMailId=rs13.getString("con_emailid");
						
					}					
					st13.close();
					rs13.close();
					
					st14=con.createStatement();
					rs14=st14.executeQuery("select * from studentprofile where schoolid='"+schoolId+"' and username='"+studentId+"'");
					if(rs14.next())
					{
						stuFName=rs14.getString("fname");
						stuLName=rs14.getString("lname");
						
					}					
					st14.close();
					rs14.close();
					
				
				HttpServletRequest httpservletrequest=null;
				HttpServletResponse httpservletresponse=null;
				String fileString=null,from=null,to=null,body=null,subject=null,username=null,attach=null,fileName=null;
				final String user="lbinfo@learnbeyond.com";//change accordingly
				final String password="LOlimits1";//change accordingly
				//HttpSession httpsession = httpservletrequest.getSession(true);
				//httpservletresponse.setContentType("text/html");
				ServletContext application1=getServletContext();
				//String host=application1.getInitParameter("host");
				//String host="smtp.gmail.com";
				String host="dedrelay.secureserver.net";
				from = "lbinfo@learnbeyond.com";
				to=teachMailId;
				//to = "hsnsultan@gmail.com";
				//to = "mgidugu@learnbeyond.com";
				//to="philbutto@zoominternet.net";
				//to="hsnsanthosh@gmail.com";
				
				subject = "Pretest evaluation is pending for student - "+stuFName+" "+stuLName+"("+studentId+")";	
				body = "<div  align='center' height='702' width='800' style='background-color:#b9f2ff;'><table border='0' cellpadding='0' cellspacing='0' height='602' width='650'  style='padding:20px;' bgcolor='#FFFFFF'><tbody><tr><td><a href='http://nj.learnbeyond.com' target='_blank'><img src='http://training.learnbeyond.com/LBCOM/session/images/logo.png' border='0' width='254' height='73' alt='learnbeyond' align='left' /></a></td></tr><tr><td>Hello "+lName+" "+fName+",</td></tr><tr></td>Pretest evaluation is pending.<BR><BR><BR>Facility ID: "+schoolId+"<BR>Student ID: "+stuFName+" "+stuLName+"("+studentId+")<BR>Course Name: "+courseName+"<BR><BR>Exam Name: "+examName+"</td></tr><tr><td><BR>Please let us know if you have any questions.</td></tr><tr><td>&nbsp;</td></tr><tr><td>  Thank you,<br /> Team Learnbeyond<br/><a href='mailto:support@learnbeyond.com'>support@learnbeyond.com</a><br/>1-855-28-LEARN<br/>732-658-5384</td></tr></table></td></tr></tbody></table></div>";

				
					try
					{
						java.util.Properties properties = System.getProperties();
					   //properties.put("mail.smtp.host", host);
						//properties.put("mail.smtp.auth", "true");
						System.out.println("Sending Mail user 1");

						properties .put("mail.smtp.starttls.enable", "true");
						properties .put("mail.smtp.host", host);
						properties .put("mail.smtp.user", user);
						properties .put("mail.smtp.password", password);
						properties .put("mail.smtp.port", "25");
						properties .put("mail.smtp.auth", "true");
					   //javax.mail.Session session = javax.mail.Session.getInstance(properties, null);
						 Session session1 = Session.getInstance(properties,
						new javax.mail.Authenticator() {
						protected PasswordAuthentication getPasswordAuthentication() {
							//System.out.println("Sending Mail user 2"+user);
							//System.out.println("Sending Mail user 3");
						return new PasswordAuthentication(user,password);
						  }
						});
						
						MimeMessage mimemessage = new MimeMessage(session1);
						//System.out.println("Sending Mail user 4");
						InternetAddress internetaddress = new InternetAddress(from);
						//System.out.println("Sending Mail user 5"+internetaddress);
						mimemessage.setFrom(internetaddress);
						InternetAddress ainternetaddress[] = InternetAddress.parse(to);
						System.out.println("Sending Mail user 6"+ainternetaddress[0]);
						mimemessage.setRecipients(javax.mail.Message.RecipientType.TO, ainternetaddress);
						mimemessage.setSubject(subject);
						//mimemessage.setText(body);
						mimemessage.setContent(body,"text/html; charset=utf-8");
						mimemessage.setHeader("Content-Transfer-Encoding", "quoted-printable");
						Transport transport=session1.getTransport("smtp");
						if (transport!=null)
						{
							System.out.println("Sending Mail user 7"+transport);
							try
							{
								transport.send(mimemessage);
							}
							catch(Exception e)
							{
								System.out.println("Sending Pretest Mail .."+e.getMessage());
							}
							System.out.println("Sending Mail user 8");
							result = "Sent message successfully....";
						}	
					}
					 catch(AddressException addressexception)
					{
					   
						System.out.println("<body><font face=verdana size=2>"+addressexception+"...1..</font></body></html>");
						out.close();
					}
					catch(SendFailedException sendfailedexception)
					{
					   
						System.out.println("<body><font face=verdana size=2>"+sendfailedexception+"..2</font></body></html>");
						out.close();
					}
					catch(MessagingException messagingexception)
					{
					   
						System.out.println("<body><font face=verdana size=2>"+messagingexception+".3.</font></body></html>");
						out.close();
					}
					catch (Exception genaralException)
					{
						System.out.println("Exception:"+genaralException.toString());
					}


					//Support mail
					// To support start from here

						to = "support@learnbeyond.com";
						//to = "santhosh@learnbeyond.net";
												
						subject = "Pretest evaluation is pending for student - "+stuFName+" "+stuLName+"("+studentId+")";	
						body = "<div  align='center' height='702' width='800' style='background-color:#b9f2ff;'><table border='0' cellpadding='0' cellspacing='0' height='602' width='650'  style='padding:20px;' bgcolor='#FFFFFF'><tbody><tr><td><a href='http://nj.learnbeyond.com' target='_blank'><img src='http://training.learnbeyond.com/LBCOM/session/images/logo.png' border='0' width='254' height='73' alt='learnbeyond' align='left' /></a></td></tr><tr><td>Hello "+lName+" "+fName+",</td></tr><tr></td>Pretest evaluation is pending.<BR><BR><BR>Facility ID: "+schoolId+"<BR>Student ID: "+stuFName+" "+stuLName+"("+studentId+")<BR>Course Name: "+courseName+"<BR><BR>Exam Name: "+examName+"</td></tr><tr><td><BR>Please let us know if you have any questions.</td></tr><tr><td>&nbsp;</td></tr><tr><td>  Thank you,<br /> Team Learnbeyond<br/><a href='mailto:support@learnbeyond.com'>support@learnbeyond.com</a><br/>1-855-28-LEARN<br/>732-658-5384</td></tr></table></td></tr></tbody></table></div>";

						
							try
							{
								java.util.Properties properties = System.getProperties();
							   //properties.put("mail.smtp.host", host);
								//properties.put("mail.smtp.auth", "true");
								System.out.println("Sending Mail user 1");

								properties .put("mail.smtp.starttls.enable", "true");
								properties .put("mail.smtp.host", host);
								properties .put("mail.smtp.user", user);
								properties .put("mail.smtp.password", password);
								properties .put("mail.smtp.port", "25");
								properties .put("mail.smtp.auth", "true");
							   //javax.mail.Session session = javax.mail.Session.getInstance(properties, null);
								 Session session1 = Session.getInstance(properties,
								new javax.mail.Authenticator() {
								protected PasswordAuthentication getPasswordAuthentication() {
									//System.out.println("Sending Mail user 2"+user);
									//System.out.println("Sending Mail user 3");
								return new PasswordAuthentication(user,password);
								  }
								});
								
								MimeMessage mimemessage = new MimeMessage(session1);
								//System.out.println("Sending Mail user 4");
								InternetAddress internetaddress = new InternetAddress(from);
								//System.out.println("Sending Mail user 5"+internetaddress);
								mimemessage.setFrom(internetaddress);
								InternetAddress ainternetaddress[] = InternetAddress.parse(to);
								//System.out.println("Sending Mail user 6"+ainternetaddress[0]);
								mimemessage.setRecipients(javax.mail.Message.RecipientType.TO, ainternetaddress);
								mimemessage.setSubject(subject);
								//mimemessage.setText(body);
								mimemessage.setContent(body,"text/html; charset=utf-8");
								mimemessage.setHeader("Content-Transfer-Encoding", "quoted-printable");
								Transport transport=session1.getTransport("smtp");
								if (transport!=null)
								{
									System.out.println("Sending Mail user 7"+transport);
									try
									{
										transport.send(mimemessage);
									}
									catch(Exception e)
									{
										System.out.println("Sending Pretest Mail .."+e.getMessage());
									}
									System.out.println("Sending Mail user 8");
									result = "Sent message successfully....";
								}	
							}
							 catch(AddressException addressexception)
							{
							   
								System.out.println("<body><font face=verdana size=2>"+addressexception+"...1..</font></body></html>");
								out.close();
							}
							catch(SendFailedException sendfailedexception)
							{
							   
								System.out.println("<body><font face=verdana size=2>"+sendfailedexception+"..2</font></body></html>");
								out.close();
							}
							catch(MessagingException messagingexception)
							{
							   
								System.out.println("<body><font face=verdana size=2>"+messagingexception+".3.</font></body></html>");
								out.close();
							}
							catch (Exception genaralException)
							{
								System.out.println("Exception:"+genaralException.toString());
							}
				   // To Support upto here
				   
    		// Sending Mail upto here
		}
	}


}
catch(Exception e)
	{
		System.out.println("The exception1 in CreatePretest.jsp is....."+e.getMessage());
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
				System.out.println("The exception2 in CreatePretest.jsp is....."+se.getMessage());
			}
	}
%>
<HTML>
<HEAD>
<title></title>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>

<BODY>
<BR><BR>
<p align="left"><b><font face="arial" size="5" color="#9966CC"> Results For Assessment <%=examName%></font></b></p>
 
<table border='0'  width='100%' bordercolorlight='#FFFFFF' cellspacing='1'>
<tr bgcolor='#E3975E'><td><font size="2" face="Arial" color="#FFFFFF"> You Scored <%=marksScored%> Out Of <%=totalMarks%></td>
<td><font size="2" face="Arial" color="#FFFFFF">Successfully submitted the assessment!<BR><img src="images/pleasewait.gif" border="0" title="Please wait.."/></td>
</tr>
     <%	
		
		if(shortTypeFlag.equals("true")) {%>
		<tr><td></td>
		</tr>
		<tr><td></td>
		</tr>
		<tr bgcolor='#9999FF'><!-- <td>Note:These points are only for objective type of questions.Short/Essay type of questions have to be evaluated by the teacher.</td> -->
		<td>Note:Short/Essay type or Fill In The Blank type of questions have to be evaluated by the teacher.</td>
		</tr>
		<%}
		
		out.println("<script language=\"JavaScript\">function Redirect(){window.close();}");
		out.println("function RedirectWithDelay(){ window.setTimeout('Redirect();',10000);}</script></head>");
		out.println("<body onload=\"RedirectWithDelay();\"><br><center><b><i><font face=\"Arial\" size=\"2\" align=\"center\">&nbsp;</font></i></b></center></body></html>");
		
		%>
		



   
</table>   
</BODY>
</HTML>
