<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile,exam.FindGrade" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page"/>

<%
	String schoolId="",teacherId="",courseId="",courseid="",courseName="",catId="",catType="",grSys="",temp="",fname="",lname="",email="";
	String studentId="",mId="",classId="";
	String catTypeByAttempt="",grSysByAttempt="",catIdByAttempt="";
	ResultSet  rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs9=null,rs6=null,rs11=null;
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st9=null,st6=null,st11=null;
	float sumofSecuredPoints=0.0f,sumofTotalPoints=0.0f,percentage=0.0f,percent=0.0f,percentageTotal=0.0f,wghtTotal=0.0f,wghtSecTotal=0.0f;

	float sumofSecuredPointsByAttempt=0.0f,sumofTotalPointsByAttempt=0.0f,percentageByAttempt=0.0f,percentByAttempt=0.0f,percentageTotalByAttempt=0.0f,wghtTotalByAttempt=0.0f,wghtSecTotalByAttempt=0.0f;

	int wght=0,i=0,wghtByAttempt=0;
	float centMarks;
	String fName="",lName="",grade1="",grade2="";
	String gradeTotal="",gradeByAttmpt="";
	FindGrade fg;

	boolean flag=false;
	

	try
	{
		session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}   
		//classId="C000";
		classId=request.getParameter("classid");
		schoolId = (String)session.getAttribute("schoolid");
		//teacherId = (String)session.getAttribute("emailid");
		String marking_id=request.getParameter("mid");
		boolean wb=true,ba=true;
		String sel_wb=request.getParameter("wb");
		String sel_ba=request.getParameter("ba");
	
		if((sel_wb==null)||(sel_wb.equals("false")))
		wb=false;
		
		if((sel_ba!=null)&&(sel_ba.equals("false")))
		ba=false;
		
		courseId=request.getParameter("courseid");
		courseid=request.getParameter("courseid");

		if(courseId == null)
			courseId="selectcourse";   
			
			mId=request.getParameter("mid");

		if(mId == null)
			mId="selectmp";   

		con=con1.getConnection();
		report.setConnection(con);  // This function will send connection to the reports bean
		st=con.createStatement();
		st1=con.createStatement();
		
		
		rs=st.executeQuery("select * from coursewareinfo where school_id='"+schoolId+"' and status>0 order by course_name");	
%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>SummaryByMarking</title>
<SCRIPT LANGUAGE="JavaScript">
<!--
function goCourse()
{
	var courseId=document.catsummary.courselist.value;
	window.location="SummaryByMarking.jsp?courseid="+courseId+"&dcourse=dcourse";

}
function goMP()
{
	var courseId=document.catsummary.courselist.value;
	var mId=document.catsummary.mplist.value;
	if((courseId.value!="")&&(mId.value!=""))	
	window.location="SummaryByMarking.jsp?courseid="+courseId+"&mid="+mId + "&classid=C000";
}
//-->
</SCRIPT>
</head>

<body>
<form name="catsummary" method="POST" action="--WEBBOT-SELF--"><BR>

<div align="center">
  <center>
<table border="0" cellspacing="0" width="95%" id="AutoNumber3" bgcolor="#429EDF" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" height="28">
  <tr>
    <td width="33%" height="16">
		<font face="Verdana" color="#FFFFFF" size="2">
			<b>&nbsp;Summary By Marking Period</b>
		</font>
		</td>
		<td width="33%" height="16" align="right">
		<%
		if(!mId.equals("selectmp")){
	%>
	<a href="javascript:window.print()"><img border="0" src="../images/printer22.png" width="22" height="22" BORDER="0" ALT="Print"></a><%}%>&nbsp;&nbsp;<a href="index.jsp?userid=<%=schoolId%>"><IMG SRC="../images/back.png" WIDTH="22" HEIGHT="22" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>&nbsp;
	</td>
  </tr>
</table>
  </center>
</div>
<br>
<div align="center">
  <center>
<table border="0" cellspacing="0" width="95%" id="AutoNumber1" bgcolor="#429EDF" height="26" style="border-collapse: collapse" bordercolor="#111111" cellpadding="5">
  <tr bgcolor="#429EDF">
    <td width="30%" height="23" colspan="2" bgcolor="#96C8ED">
		<select id="courselist" style="width:200px" name="courselist" onchange="goCourse(); return false;">
			<option value="selectcourse" selected>Select Course</option>
<%
	                
              while(rs.next())
				{
				  
					out.println("<option value='"+rs.getString("course_id")+"'>"+rs.getString("course_name")+"</option>");
				}
				rs.close();
%>
		</select>
		<script>
			document.catsummary.courselist.value="<%=courseId%>";	
		</script>
	</td>
  
	<td width="30%" height="23" colspan="2" bgcolor="#96C8ED" align="right">
		<select id="mplist" style="width:200px" name="mplist" onchange="goMP();">
		<option value="selectmp" selected>Select MarkingPeriod</option>
			
<%
	if(courseId!="selectcourse")
		{
			rs=st.executeQuery("SELECT * from marking_admin where schoolid='"+schoolId+"'");
			
			while(rs.next())
			{
				out.println("<option value='"+rs.getString("m_id")+"'>"+rs.getString("m_name")+"</option>");
				
			}
		
		}	rs.close();
%>
		</select>
		<script>
	
			document.catsummary.mplist.value="<%=mId%>";	
		</script> 
	</td>
</tr>

<%
	
		if(courseId.equals("selectcourse") || mId.equals("selectmp"))
				{
%>

</table>
</center>
</div>
  <%

		if(request.getParameter("dcourse")!=null)
					{
%>
<tr>
				<td width="100%" colspan="4">
					<font face="Arial" size="2"><center><strong>Please select a Marking Period</strong></center></font>
				</td>
			</tr>
<%
	}
else{		
%>
<tr>
				<td width="100%" colspan="4">
					<font face="Arial" size="2"><center><strong>Please select a Course and  a Marking Period</strong></center></font>
				</td>
			</tr>
<%
	}
				}
else 
	{	
	
	String[] dates=new String[2];					
	dates=report.getMarkingDates(schoolId,marking_id,courseid);
   
	String yyyy1=dates[0].substring(0,4);
	String mm1=dates[0].substring(5,7);
	String dd1=dates[0].substring(8,10);
	String date1=mm1+"/"+dd1+"/"+yyyy1;

	String yyyy2=dates[1].substring(0,4);
	String mm2=dates[1].substring(5,7);
	String dd2=dates[1].substring(8,10);
	String date2=mm2+"/"+dd2+"/"+yyyy2;
	

%>
<div align="center">
  <center>
<table  border="1" cellspacing="2" cellpadding="3" width="95%" id="AutoNumber2" height="26"  bordercolor="#96C8ED">
  <tr>
    <td width="25%" align="center" bgcolor="#96C8ED" height="25">
    <p align="left"><b>
    <font face="Arial" size="2">Student Name</font></b></td>
    <td width="14%" align="center" bgcolor="#96C8ED" height="25"><b>
    <font face="Arial" size="2">Total Points Possible</font></b></td>
	<td width="14%" align="center" bgcolor="#96C8ED" height="25"><b>
    <font face="Arial" size="2">Points Attempted</font></b></td>
    <td width="14%" align="center" bgcolor="#96C8ED" height="25"><b>
    <font face="Arial" size="2">Points Secured</font></b></td>
	<td width="14%" align="center" bgcolor="#96C8ED" height="25"><b>
    <font face="Arial" size="2">Percentage By Attempt</font></b></td>
	<td width="14%" align="center" bgcolor="#96C8ED" height="25"><b>
    <font face="Arial" size="2">Grade By Attemptt</font></b></td>
	<td width="14%" align="center" bgcolor="#96C8ED" height="25"><b>
    <font face="Arial" size="2">Percentage By Marking Period</font></b></td>
    <td width="14%" align="center" bgcolor="#96C8ED" height="25"><b>
    <font face="Arial" size="2">Grade By Marking Period</font></b></td>
  </tr>


  <%
				rs1=st1.executeQuery("select * from studentprofile sp,coursewareinfo_det cid where  cid.course_id='"+courseId+"' and sp.username=cid.student_id and sp.schoolid=cid.school_id and  schoolid='"+schoolId+"'  and crossregister_flag<'3' order by cid.student_id");
					Hashtable result = new Hashtable();
					String studentid="",sschoolid="";
					
					
						while(rs1.next())
						{
							studentid=rs1.getString("student_id");

							sschoolid=rs1.getString("schoolid");
							classId=rs1.getString("grade");
							fname=rs1.getString("fname");
							lname=rs1.getString("lname");
							result=report.getActivityTypeGrade(courseid,classId,studentid,sschoolid,dates,wb,ba);	
                        
												
							/*============overall percentageByAtt=============*/

							st6=con.createStatement();				

						rs6=st6.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) as sum1,sum(`"+schoolId+"_cescores`.`total_marks`) as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores`,`mp_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentid+"' and `"+schoolId+"_cescores`.school_id=mp_cescores.school_id and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`course_id`=`mp_cescores`.`course_id` and `"+schoolId+"_cescores`.`category_id`!='ST'  and `"+schoolId+"_cescores`.`work_id`=`mp_cescores`.`work_id` and `"+schoolId+"_cescores`.`report_status`=1 and (`"+schoolId+"_cescores`.`status`=2) and `mp_cescores`.`m_id`='"+marking_id+"' group by `"+schoolId+"_cescores`.`category_id`");

                                       
						  	sumofSecuredPointsByAttempt=0.0f;
							float TotalSecureMarkingPointsByAttempt=0.0f;
							float TotalMarkingPointsByAttempt=0.0f;
 		                   
							float  TotalMarkingPercentageByAttempt=0.0f;
							while(rs6.next())
							{
																
								catIdByAttempt=rs6.getString("category_id");
								
								st3=con.createStatement();
								rs3=st3.executeQuery("select * from category_item_master where school_id='"+schoolId+"' and course_id='"+courseId+"' and item_id='"+catIdByAttempt+"'");
								if(rs3.next())
								{
									catTypeByAttempt=rs3.getString("item_des");
									grSysByAttempt=rs3.getString("grading_system");
									wghtByAttempt=rs3.getInt("weightage");
								}
								rs3.close();
										
							
							sumofSecuredPointsByAttempt =Float.parseFloat(rs6.getString("sum1"));
							sumofTotalPointsByAttempt =Float.parseFloat(rs6.getString("sum2"));
							
							
							TotalSecureMarkingPointsByAttempt=TotalSecureMarkingPointsByAttempt+sumofSecuredPointsByAttempt;
							TotalMarkingPointsByAttempt=TotalMarkingPointsByAttempt+sumofTotalPointsByAttempt;
							
							/*													
							if(grSysByAttempt.equals("2"))
							{
														
								TotalMarkingPointsByAttempt=TotalMarkingPointsByAttempt-sumofTotalPointsByAttempt;
								
							}
										
							*/
			}
			st6.close();
			/*==========end of percenByAttempt=========*/					
										
						st2=con.createStatement();
						rs2=st2.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) AS sum1,sum(`"+schoolId+"_cescores`.`total_marks`) AS sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores`,`mp_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentid+"' and `"+schoolId+"_cescores`.school_id=mp_cescores.school_id and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`course_id`=`mp_cescores`.`course_id` and `"+schoolId+"_cescores`.`category_id`!='ST' and `"+schoolId+"_cescores`.`work_id`=`mp_cescores`.`work_id` and `"+schoolId+"_cescores`.`report_status`=1 and (`"+schoolId+"_cescores`.`status`<3) and `mp_cescores`.`m_id`='"+marking_id+"' group by `"+schoolId+"_cescores`.`category_id`");
						    
						  	sumofSecuredPoints=0.0f;
 		                    float TotalMarkingPoints=0.0f;
							float TotalSecureMarkingPoints=0.0f;
							float  TotalMarkingPercentage=0.0f;					
							while(rs2.next())
							{
								catId=rs2.getString("category_id");
								st4=con.createStatement();
								rs4=st4.executeQuery("select * from category_item_master where school_id='"+schoolId+"' and course_id='"+courseId+"' and item_id='"+catId+"'");
								if(rs4.next())
								{
									catType=rs4.getString("item_des");
									grSys=rs4.getString("grading_system");
									wght=rs4.getInt("weightage");
								}
								rs4.close();
								st4.close();
		
							temp=rs2.getString("sum1");
							
							sumofSecuredPoints=Float.parseFloat(rs2.getString("sum1"));
							sumofTotalPoints=Float.parseFloat(rs2.getString("sum2"));		
														                            
							sumofSecuredPoints=+sumofSecuredPoints;
							sumofTotalPoints=+sumofTotalPoints;

							
							TotalSecureMarkingPoints=TotalSecureMarkingPoints+sumofSecuredPoints;
							TotalMarkingPoints=TotalMarkingPoints+sumofTotalPoints;
						  
							/*
							if(grSys.equals("2"))
							{
								
								TotalMarkingPoints=TotalMarkingPoints-sumofTotalPoints;
								
							}
							*/
							i++;
							
													
			}
			st2.close();
		if(!studentid.equals("C000_vstudent"))
		{
				
			//percentageTotal=(percentageTotal/wghtTotal)*100;
			//percentageTotalByAttempt=(percentageTotalByAttempt/wghtTotalByAttempt)*100;

			
			percentageTotalByAttempt=(TotalSecureMarkingPoints/TotalMarkingPointsByAttempt)*100;
			percentageTotal=(TotalSecureMarkingPoints/TotalMarkingPoints)*100;

			
			percent=(float)Float.parseFloat(report.trimFloat(percentageTotal));
			
			TotalMarkingPercentage=percent;
			percentByAttempt=(float)Float.parseFloat(report.trimFloat(percentageTotalByAttempt));
			
			TotalMarkingPercentageByAttempt=percentByAttempt;
									
				if(i!=0)
				{
					st11=con.createStatement();
					rs11=st11.executeQuery("SELECT grade_code from class_grades where schoolid='"+schoolId+"' and "+percentByAttempt+" and minimum <='"+percentByAttempt+"' and maximum >'"+percentByAttempt+"'");
					while(rs11.next())
					{
						grade1=rs11.getString("grade_code");
					}
					st11.close();
					st9=con.createStatement();					
					rs9=st9.executeQuery("SELECT grade_code from class_grades where schoolid='"+schoolId+"' and "+percent+" and minimum <='"+percent+"' and maximum >'"+percent+"'");
					while(rs9.next())
					{
						grade2=rs9.getString("grade_code");
					}
					st9.close();

					if(TotalMarkingPercentageByAttempt>=100)
					{
						//TotalMarkingPercentageByAttempt=100;
						grade1="A";

					}
					if(TotalMarkingPercentage>=100)
					{
						grade2="A";

					}
					if(TotalMarkingPercentageByAttempt==0.0)
					{
						grade1="-";

					}
					if(TotalMarkingPercentage==0.0)
					{
						grade2="-";

					}
		  
					   
%>

  <tr bgcolor="#FFFFFF" onMouseover="bgColor='#A8B8D1'" onMouseOut="bgColor='#FFFFFF'">
    <td width="25%" height="19">
		<font face="Arial" size="2"><a href="SBMPScores.jsp?user=<%=studentid%>&m_id=<%=marking_id%>&fname=<%=fname%>&lname=<%=lname%>&classid=<%=classId%>&courseid=<%=courseid%>&schoolid=<%=schoolId%>&na=false&percent=<%=TotalMarkingPercentage%>&perctByatt=<%=TotalMarkingPercentageByAttempt%>&sumofsecpnts=<%=sumofSecuredPoints%>&sumoftotpnts=<%=sumofTotalPoints%>">&nbsp;<%=fname%> &nbsp;<%=lname%></a></font>
	</td>
    <td width="14%" height="19" align="center"><font face="Arial" size="2" color="red"><%=TotalMarkingPoints%></font></td>
	<td width="14%" height="19" align="center"><font face="Arial" size="2"><%=TotalMarkingPointsByAttempt%></font></td>
    <td width="14%" height="19" align="center"><font face="Arial" size="2" color="red"><%=TotalSecureMarkingPoints%></font></td>
	<td width="14%" height="19" align="center"><font size="2"face="Arial"><%=TotalMarkingPercentageByAttempt%>%</font></td>
	<td width="14%" height="19" align="center"><font size="2"face="Arial" color="green"><b><%=grade1%></b></font></td>
	<td width="14%" height="19" align="center"><font size="2"face="Arial" color="red"><%=TotalMarkingPercentage%>%</font></td>
    <td width="14%" height="19" align="center"><font size="2" face="Arial" color="green"><b><%=grade2%></b></font></td>
  </tr>
  
  <%			}
				else
				{
					grade1="-";
					grade2="-";
				}
				
				percentageTotal=0.0f;
				wghtTotal=0.0f;
				wghtSecTotal=0.0f;
				percentage=0.0f;
				wghtTotal=0.0f;
				sumofSecuredPoints=0.0f;
				sumofTotalPoints=0.0f;

				percentageTotalByAttempt=0.0f;
				wghtTotalByAttempt=0.0f;
				wghtSecTotalByAttempt=0.0f;
				percentageByAttempt=0.0f;
				wghtTotalByAttempt=0.0f;
				sumofSecuredPointsByAttempt=0.0f;
				sumofTotalPointsByAttempt=0.0f;
	}
	     
		}
   %>
  
  </table>
  
  <%
		}
  		}	
		catch(SQLException se)
		{
			System.out.println("Error: SQL -" + se.getMessage());
		}
		catch(Exception e)
		{
			System.out.println("Error:  -" + e.getMessage());
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
				if(st9!=null)
					st9.close();
				if(st11!=null)
					st11.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se){
				ExceptionsFile.postException("SummaryByMarking.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				System.out.println(se.getMessage());
		}

    }
%>
  </center>
</div>

<hr color="#429EDF" width="100%" size="1">
<% 
	if(i==0)
	{
%>
		<table>
			<tr>
					<td width="20%" height="18">
					<p align="left"><font face="Verdana" size="2" color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;There are no assignments available.</font></td></tr>
		</table>
<%	}
%>
		
		</form>
</body>
</html>