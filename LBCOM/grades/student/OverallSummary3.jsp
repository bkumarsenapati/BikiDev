<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile,exam.FindGrade"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page" />
<%@ include file="/common/checksession.jsp" %> 	

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Overall Summary</title>
</head>

<body>
<form name="grstudselectfrm" id='gr_stud_id'><BR>
<div align="center">
  <center>
<%
	
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st6=null;
	ResultSet  rs=null,rs1=null,rs2=null,rs3=null,rs6=null;
	FindGrade fg;
	boolean flag=false;
	String cId="",sId="",catId="",temp="",catType="",grSys="",status="";
	String catTypeByAttempt="",grSysByAttempt="",catIdByAttempt="";
	float sumofSecuredPoints=0.0f,sumofTotalPoints=0.0f,percentage=0.0f,percent=0.0f,percentageTotal=0.0f,wghtTotal=0.0f,wghtSecTotal=0.0f;

	float sumofSecuredPointsByAttempt=0.0f,sumofTotalPointsByAttempt=0.0f,percentageByAttempt=0.0f,percentByAttempt=0.0f,percentageTotalByAttempt=0.0f,wghtTotalByAttempt=0.0f,wghtSecTotalByAttempt=0.0f;

	int wght=0,wghtByAttempt=0;
	float centMarks=0.0f,centMarksByAttempt=0.0f;
	String fName="",lName="",email="";
	String grade="",classId="C000",courseName="",teacherId="",gradeByAttempt="";

	String studentId=request.getParameter("userid");
	String courseId=request.getParameter("courseid");
	//String studentId=request.getParameter("sid");
	String schoolId=(String)session.getValue("schoolid");
	if(schoolId==null){
			out.println("<font face='Arial' size='2'><b>Your session has expired. Please Login again... <a href='#' onclick=\"top.location.href='/LBCOM/'\">Login.</a></b></font>");
			return;
	}
  try
	 {
		con=con1.getConnection();	
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		st4=con.createStatement();
		st6=con.createStatement();
		rs=st.executeQuery("select c.course_name,c.course_id,c.teacher_id from coursewareinfo c inner join coursewareinfo_det d  on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+studentId+"' and c.status=1 and c.school_id='"+schoolId+"' and d.school_id='"+schoolId+"' order by c.course_id");
%>
<table border="0" colspan="4" cellspacing="0" width="90%" id="AutoNumber3" bgcolor="#429EDF" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" height="28">
  <tr>
    <td width="50%" height="28"><font face="Verdana" size="2"><b>&nbsp;<font color="#FFFFFF">Overall Summary</font></b></font></td>
	<td width="50%" height="24" align="right">
	<%
	if(!courseId.equals("no")){
	%><a href="javascript:window.print()"><img border="0" src="images/print.jpg" width="20" height="15" BORDER="0" ALT="Print"></a><%}%>&nbsp;&nbsp;
		
		<a href="index.jsp?userid=<%=studentId%>"><IMG SRC="images/back.jpg" WIDTH="20" HEIGHT="15" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>&nbsp;
	</td>
	
  </tr>
</table>
  </center>
</div>
<br>
<div align="center">
  <center>
<table border="0" colspan="4" cellspacing="0" width="90%" id="AutoNumber1" bgcolor="#429EDF" height="26" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0">
  <tr>
    <td width="30%" height="23" colspan="2" bgcolor="#96C8ED">
	<select size="1" id="grade_id" name="gradeid"  onchange="goResults(this.value)">
  <!-- <option value="no" selected>Select A Course</option> -->
  <%
	  if(courseId.equals("allcourses"))
		 {
	  %>
    <option value="allcourses" selected>List All Courses</option>
<%		
		 }
 if(!courseId.equals("allcourses"))
		 {
	  %>
    <option value="allcourses" selected>List All Courses</option>
<%		
		 }

		while(rs.next())
		{
			cId=rs.getString("course_id");
			courseName=rs.getString("course_name");
			teacherId=rs.getString("teacher_id");
			//out.print("in while"+courseName+"\t"+teacherId);
			
%>
              
				
<%			
%>			
				<option value='<%=cId%>'>&nbsp;&nbsp;<%=rs.getString("course_name")%>&nbsp;</option>
<%			
		flag=true;
		}
%>
    </select>
	<script>
	document.grstudselectfrm.gradeid.value="<%=courseId%>"
	</script>
	</td>

<%
	if(flag==false)
	{
		out.println("<td align='center'>Courses are not available yet. </td></tr></table>");
		return;
	}
%>
</td>
	
  </tr>
  </table>
  <% 
	 int i=0,j=0;
	 if(courseId.equals("allcourses"))
		{		
                
            
			  rs=st.executeQuery("select c.course_name,c.course_id,c.teacher_id from coursewareinfo c,coursewareinfo_det d where c.status>0 and d.student_id='"+studentId+"' and c.course_id=d.course_id and c.school_id='"+schoolId+"' and d.school_id='"+schoolId+"' order by c.course_id");
			  
			
			%>
			<table border="1" cellspacing="1" colspan="6" width="90%" id="AutoNumber1"  height="26"  bordercolorlight="#E6F2FF">
						  <tr bgcolor="#429EDF">
						<td width="20%" height="23" bgcolor="#808080">
                        <p align="center"><b>
                        <font color="#800000" face="Verdana" size="2">Course Name</font></td>
						<td width="20%" height="23" bgcolor="#808080">
						<p align="center">
						<font color="#800000" face="Verdana" size="2"><b>Teacher Name:&nbsp;</b></font><font color="#800000"></b></font></td>
						<!-- <td width="20%" height="23">
						<p align="left"><font color="#FFFFFF" face="Verdana" size="2"><div id="<%=studentId%>"></div></td> -->
						<td width="20%" height="23" bgcolor="#808080">
						<p align="center">
						<b>
						<font color="#800000" face="Verdana" size="2">By Attempt</b></td>
						<td width="20%" height="23" bgcolor="#808080">
						<p align="center">
						<b>
						<font color="#800000" face="Verdana" size="2">By Attempt Grade</b></td>
						<td width="20%" height="23" bgcolor="#808080">
						<p align="center">
						<b>
						<font color="#800000" face="Verdana" size="2">Total</b></td>
						<td width="20%" height="23" bgcolor="#808080">
						<p align="center">
						<b>
						<font color="#800000" face="Verdana" size="2">grade</b></td>
					  </tr>
			<%

				while(rs.next())  
				{
					percentageTotal=0.0f;

					courseId=rs.getString("course_id");
					teacherId=rs.getString("teacher_id");
					
					rs1=st1.executeQuery("select  firstname, lastname,con_emailid from teachprofile where schoolid='"+schoolId+"' and username='"+teacherId+"'");
					
					if(rs1.next())
					{
						fName=rs1.getString("firstname");
						lName=rs1.getString("lastname");
						email=rs1.getString("con_emailid");
					%>	
					<%
					
					 /*============overall percentageByAtt=============*/
						 
						rs6=st6.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) as sum1,sum(`"+schoolId+"_cescores`.`total_marks`) as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`report_status`=1 and (`"+schoolId+"_cescores`.`status`=2) group by `"+schoolId+"_cescores`.`category_id`");

                                       
						  	sumofSecuredPointsByAttempt=0.0f;
 		                   
							float  TotalMarkingPercentageByAttempt=0.0f;
							while(rs6.next())
							{
								 float TotalMarkingPointsByAttempt=0.0f;
								float TotalSecureMarkingPointsByAttempt=0.0f;
								
								catIdByAttempt=rs6.getString("category_id");
								rs3=st3.executeQuery("select * from category_item_master where school_id='"+schoolId+"' and course_id='"+courseId+"' and item_id='"+catIdByAttempt+"'");
								if(rs3.next())
								{
									catTypeByAttempt=rs3.getString("item_des");
									grSysByAttempt=rs3.getString("grading_system");
									wghtByAttempt=rs3.getInt("weightage");
								}
								rs3.close();
		
							//temp=rs6.getString("sum1");
							sumofSecuredPointsByAttempt=Float.parseFloat(rs6.getString("sum1"));
							sumofTotalPointsByAttempt=Float.parseFloat(rs6.getString("sum2"));									
                             
							sumofSecuredPointsByAttempt=+sumofSecuredPointsByAttempt;
							sumofTotalPointsByAttempt=+sumofTotalPointsByAttempt;
							
							TotalSecureMarkingPointsByAttempt=TotalSecureMarkingPointsByAttempt+sumofSecuredPointsByAttempt;
							TotalMarkingPointsByAttempt=TotalMarkingPointsByAttempt+sumofTotalPointsByAttempt;
							//out.print("sec........"+TotalSecureMarkingPointsByAttempt+"total....."+TotalMarkingPointsByAttempt);
						     if(sumofTotalPointsByAttempt!=0)
							  {
								wghtTotalByAttempt=wghtTotalByAttempt+wghtByAttempt;
								percentageByAttempt=(TotalSecureMarkingPointsByAttempt/TotalMarkingPointsByAttempt)*wghtByAttempt;
							  }
							 
                          	percentageTotalByAttempt=percentageTotalByAttempt+percentageByAttempt;
													
							if(grSys.equals("2"))
							{
								wghtTotalByAttempt=wghtTotalByAttempt-wghtByAttempt;
							}
							wghtSecTotalByAttempt=wghtSecTotalByAttempt+percentageByAttempt;
						//	i++;
					}	
		
			/*==========end of percenByAtte=========*/



						rs2=st2.executeQuery("select sum(ntable.sum1) as sum1,sum(ntable.sum2) as sum2,ntable.category_id from ( select        `"+schoolId+"_cescores`.`marks_secured` as sum1,`"+schoolId+"_cescores`.`total_marks` as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"'  and `"+schoolId+"_cescores`.`report_status`=1 and ((`"+schoolId+"_cescores`.`status`=2)||(`"+schoolId+"_cescores`.`end_date`<curdate()))  UNION ALL select marks_secured,'0',category_id from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`status`=0 and `"+schoolId+"_cescores`.`end_date`>=curdate() ) as ntable group by ntable.category_id");
 							
							sumofSecuredPoints=0.0f;
 		
							while(rs2.next())
							{
								
								
								catId=rs2.getString("category_id");
																
								rs3=st3.executeQuery("select * from category_item_master where school_id='"+schoolId+"' and course_id='"+courseId+"' and item_id='"+catId+"'");
								if(rs3.next())
								{
									catType=rs3.getString("item_des");
									grSys=rs3.getString("grading_system");
									wght=rs3.getInt("weightage");
								}
								rs3.close();
		
							temp=rs2.getString("sum1");
							sumofSecuredPoints=Float.parseFloat(rs2.getString("sum1"));
							sumofTotalPoints=Float.parseFloat(rs2.getString("sum2"));									

							sumofSecuredPoints=+sumofSecuredPoints;
							sumofTotalPoints=+sumofTotalPoints;
						     if(sumofTotalPoints!=0)
							  {
							wghtTotal=wghtTotal+wght;
							
							percentage=(sumofSecuredPoints/sumofTotalPoints)*wght;
							  }
                          	percentageTotal=percentageTotal+percentage;
														
							if(grSys.equals("2"))
							{
								wghtTotal=wghtTotal-wght;
							}
							wghtSecTotal=wghtSecTotal+percentage;
							i++;
						
										
			 percentage=0.0f;
			}
			if(!studentId.equals("no"))
		   {
				
			
			percentageTotal=(percentageTotal/wghtTotal)*100;
			percentageTotalByAttempt=(percentageTotalByAttempt/wghtTotalByAttempt)*100;
						
			percent=(float)Float.parseFloat(report.trimFloat(percentageTotal));
			percentByAttempt=(float)Float.parseFloat(report.trimFloat(percentageTotalByAttempt));
			TotalMarkingPercentageByAttempt=percentByAttempt;
			
				if(i!=0)
				{
					
					/*rs9=st9.executeQuery("SELECT grade_code from class_grades where schoolid='"+schoolId+"' and "+percent+" between (minimum-0.001) and (maximum-0.001)");
					while(rs9.next())
					{
						grade=rs9.getString("grade_code");
					}*/
					fg=new FindGrade();
					centMarks=fg.convertToCent(wghtSecTotal,wghtTotal);
					grade=fg.getGrade(schoolId,classId,courseId,centMarks);
					if(percentageTotal>100)
                         grade="A+";
					
					fg=new FindGrade();
					centMarksByAttempt=fg.convertToCent(wghtSecTotalByAttempt,wghtTotalByAttempt);
					gradeByAttempt=fg.getGrade(schoolId,classId,courseId,centMarksByAttempt);
					

%>
						
						 <tr >
						<td width="20%" height="23"><font  face="Verdana" size="2"><a href="StudentScores.jsp?courseid=<%=rs.getString("course_id")%>&studentid=<%=studentId%>
						&teacherid=<%=rs.getString("teacher_id")%>&perctByatt=<%=report.trimFloat(TotalMarkingPercentageByAttempt)%>&grdByatt=<%=gradeByAttempt%>&classid=C000">  <%=rs.getString("course_name")%></a></font></td>
						<td width="20%" height="23">&nbsp;&nbsp;<a href="InstantMessage.jsp?emailid=<%=email%>&teacherid=<%= rs.getString("teacher_id") %> &fname=<%=fName%>&lname=<%=lName%>"><img border="0" src="images/m1.jpg" width="19" height="14" alt="Send an Instant Mail"></a>&nbsp;&nbsp;&nbsp;
						<%=fName%>&nbsp;<%=lName%></td>
						
						<!-- <td width="20%" height="23">
						<p align="left"><font color="#FFFFFF" face="Verdana" size="2"><div id="<%=studentId%>"></div></td> -->
					  
					  
<%  
								
					
						// rs2=st2.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) as sum1,sum(`"+schoolId+"_cescores`.`total_marks`) as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`report_status`=1 and (`"+schoolId+"_cescores`.`status`=1 ||`"+schoolId+"_cescores`.`status`=2) group by `"+schoolId+"_cescores`.`category_id`");
%>
						
						<td width="20%" height="23"><p align="center"><B><%=report.trimFloat(TotalMarkingPercentageByAttempt)%></B>&nbsp;%</td>
						
						<td width="20%" height="23"><p align="center"><B><%=gradeByAttempt%></B></td>
						
						<td width="20%" height="23"><p align="center"><%=report.trimFloat(percentageTotal)%>&nbsp;%</td>
						
						<td width="20%" height="23"><p align="center"><%=grade%></td>

					<!-- <td width="100%" height="23">
					<p align="right"><font color="#ffffff" face="Verdana" size="2"><b>&nbsp;&nbsp;&nbsp;Total:&nbsp;&nbsp;(<%=wghtSecTotal%>/<%=wghtTotal%>)&nbsp;&nbsp;&nbsp;</b></font><b><font color="#ffffff" face="Verdana" size="2"><%=report.trimFloat(percentageTotal)%>&nbsp;</font><font color="#ffffff">%&nbsp;&nbsp;<%=grade%></font></b></td> -->
					</tr>
<%
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
		 
	
			else
			 {		

					fg=new FindGrade();
					centMarks=fg.convertToCent(wghtSecTotal,wghtTotal);
					grade=fg.getGrade(schoolId,classId,courseId,centMarks);
					if(percentageTotal>100)
                         grade="A+";
					fg=new FindGrade();
					centMarksByAttempt=fg.convertToCent(wghtSecTotalByAttempt,wghtTotalByAttempt);					
					gradeByAttempt=fg.getGrade(schoolId,classId,courseId,centMarksByAttempt);
				

		%>		<td width="20%" height="23" colspan="2"><p align="center"> &nbsp;No Assignments&nbsp;</td>
						<td width="20%" height="23" colspan="2"><p align="center"><font  face="Arial" size="2" color="brown"><B>---</B></td></tr>
						</table>
		
		  </center>
		</div>
<%			
			  }
			}
		}
		}
		}

else
		 {
	 rs=st.executeQuery("select course_name,course_id,teacher_id from coursewareinfo where course_id='"+courseId+"' and school_id='"+schoolId+"' and status>0");
	//rs1=st1.executeQuery("select  t.firstname,t.lastname,t.con_emailid from teachprofile t,coursewareinfo_det d where t.schoolid='"+schoolId+"' and d.course_id='"+courseId+"' and d.student_id='"+studentId+"'");

	 %>	
	<table border="1" colspan="6" cellspacing="1" width="90%" id="AutoNumber1"  height="26" bordercolorlight="#E6F2FF" align="center">
 	  <tr bgcolor="#429EDF">
    <td width="20%" height="23" bgcolor="#808080">
    <p align="center"><b><font color="#800000" face="Verdana" size="2">Course Name</font></td>
    <td width="20%" height="23" bgcolor="#808080">
    <p align="center"><b>
    <font color="#800000" face="Verdana" size="2">Teacher Name</font></b></td>
    <!-- <td width="20%" height="23">
    <font color="#FFFFFF" face="Verdana" size="2"><div id="<%=studentId%>"></div></td> -->
	<td width="20%" height="23" bgcolor="#808080">
						<p align="center">
						<font color="#800000" face="Verdana" size="2"><b>By Attempt</b></td>
						<td width="20%" height="23" bgcolor="#808080">
						<p align="center">
						<font color="#800000" face="Verdana" size="2"><b>By Attempt Grade</b></td>
	<td width="20%" height="23" bgcolor="#808080">
						<p align="center">
						<font color="#800000" face="Verdana" size="2"><b>Total</b></td>
						<td width="20%" height="23" bgcolor="#808080">
						<p align="center">
						<font color="#800000" face="Verdana" size="2"><b>grade</b></td>
  </tr>
  <%
		if(rs.next())
		{
		teacherId=rs.getString("teacher_id");

		rs1=st1.executeQuery("select  firstname, lastname,con_emailid from teachprofile where schoolid='"+schoolId+"' and username='"+teacherId+"'");

		if(rs1.next()){
			fName=rs1.getString("firstname");
			lName=rs1.getString("lastname");
			email=rs1.getString("con_emailid");
		%>
		<%

		/*============overall percentageByAtt=============*/

												
						rs6=st6.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) as sum1,sum(`"+schoolId+"_cescores`.`total_marks`) as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`report_status`=1 and (`"+schoolId+"_cescores`.`status`=2) group by `"+schoolId+"_cescores`.`category_id`");
						
						                                       
						  	sumofSecuredPointsByAttempt=0.0f;
 		                   
							float  TotalMarkingPercentageByAttempt=0.0f;
							while(rs6.next())
							{
								 float TotalMarkingPointsByAttempt=0.0f;
								float TotalSecureMarkingPointsByAttempt=0.0f;
								
								catIdByAttempt=rs6.getString("category_id");
								rs3=st3.executeQuery("select * from category_item_master where school_id='"+schoolId+"' and course_id='"+courseId+"' and item_id='"+catIdByAttempt+"'");
								if(rs3.next())
								{
									catTypeByAttempt=rs3.getString("item_des");
									grSysByAttempt=rs3.getString("grading_system");
									wghtByAttempt=rs3.getInt("weightage");
								}
								rs3.close();
		
							//temp=rs6.getString("sum1");
							sumofSecuredPointsByAttempt=Float.parseFloat(rs6.getString("sum1"));
							sumofTotalPointsByAttempt=Float.parseFloat(rs6.getString("sum2"));
							//out.print("sec........"+sumofSecuredPointsByAttempt+"total....."+sumofTotalPointsByAttempt);
							                             
							sumofSecuredPointsByAttempt=+sumofSecuredPointsByAttempt;
							sumofTotalPointsByAttempt=+sumofTotalPointsByAttempt;
							
							TotalSecureMarkingPointsByAttempt=TotalSecureMarkingPointsByAttempt+sumofSecuredPointsByAttempt;
							TotalMarkingPointsByAttempt=TotalMarkingPointsByAttempt+sumofTotalPointsByAttempt;
							//out.print("sec........"+TotalSecureMarkingPointsByAttempt+"total....."+TotalMarkingPointsByAttempt);
						     if(sumofTotalPointsByAttempt!=0)
							  {
								wghtTotalByAttempt=wghtTotalByAttempt+wghtByAttempt;
								percentageByAttempt=(TotalSecureMarkingPointsByAttempt/TotalMarkingPointsByAttempt)*wghtByAttempt;
							  }
							 
                          	percentageTotalByAttempt=percentageTotalByAttempt+percentageByAttempt;
													
							if(grSys.equals("2"))
							{
								wghtTotalByAttempt=wghtTotalByAttempt-wghtByAttempt;
							}
							wghtSecTotalByAttempt=wghtSecTotalByAttempt+percentageByAttempt;
						//	i++;
						
			}
			/*==========end of percenByAtte=========*/

			rs2=st2.executeQuery("select sum(ntable.sum1) as sum1,sum(ntable.sum2) as sum2,ntable.category_id from ( select        `"+schoolId+"_cescores`.`marks_secured` as sum1,`"+schoolId+"_cescores`.`total_marks` as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"'  and `"+schoolId+"_cescores`.`report_status`=1 and ((`"+schoolId+"_cescores`.`status`=2)||(`"+schoolId+"_cescores`.`end_date`<curdate()))  UNION ALL select marks_secured,'0',category_id from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`status`=0 and `"+schoolId+"_cescores`.`end_date`>=curdate() ) as ntable group by ntable.category_id");
 							
							sumofSecuredPoints=0.0f;
		
							while(rs2.next())
							{
								
								
								catId=rs2.getString("category_id");
																
								rs3=st3.executeQuery("select * from category_item_master where school_id='"+schoolId+"' and course_id='"+courseId+"' and item_id='"+catId+"'");
								if(rs3.next())
								{
									catType=rs3.getString("item_des");
									grSys=rs3.getString("grading_system");
									wght=rs3.getInt("weightage");
								}
								rs3.close();
		
							temp=rs2.getString("sum1");
							sumofSecuredPoints=Float.parseFloat(rs2.getString("sum1"));
							sumofTotalPoints=Float.parseFloat(rs2.getString("sum2"));									

							sumofSecuredPoints=+sumofSecuredPoints;
							sumofTotalPoints=+sumofTotalPoints;
						     if(sumofTotalPoints!=0)
							  {
							wghtTotal=wghtTotal+wght;
							percentage=(sumofSecuredPoints/sumofTotalPoints)*wght;
							  }
							percentageTotal=percentageTotal+percentage;
							
							if(grSys.equals("2"))
							{
								wghtTotal=wghtTotal-wght;
							}
							wghtSecTotal=wghtSecTotal+percentage;
							i++;
						
						 percentage=0.0f;
										
			}
			if(!studentId.equals("no"))
		   {
				
			
			percentageTotal=(percentageTotal/wghtTotal)*100;
			percentageTotalByAttempt=(percentageTotalByAttempt/wghtTotalByAttempt)*100;
			
			percent=(float)Float.parseFloat(report.trimFloat(percentageTotal));
			percentByAttempt=(float)Float.parseFloat(report.trimFloat(percentageTotalByAttempt));
			TotalMarkingPercentageByAttempt=percentByAttempt;
				if(i!=0)
				{
					
					/*rs9=st9.executeQuery("SELECT grade_code from class_grades where schoolid='"+schoolId+"' and "+percent+" between (minimum-0.001) and (maximum-0.001)");
					while(rs9.next())
					{
						grade=rs9.getString("grade_code");
					}*/
					fg=new FindGrade();
					centMarks=fg.convertToCent(wghtSecTotal,wghtTotal);
					grade=fg.getGrade(schoolId,classId,courseId,centMarks);
					if(percentageTotal>100)
                         grade="A+";
					fg=new FindGrade();
					centMarksByAttempt=fg.convertToCent(wghtSecTotalByAttempt,wghtTotalByAttempt);
					
					gradeByAttempt=fg.getGrade(schoolId,classId,courseId,centMarksByAttempt);
					

%>
		
  <tr>
  <td width="20%" height="23"><font  face="Verdana" size="2">
  &nbsp;<a href="StudentScores.jsp?courseid=<%=rs.getString("course_id")%>&studentid=<%=studentId%>&teacherid=<%=rs.getString("teacher_id")%>&perctByatt=<%=report.trimFloat(TotalMarkingPercentageByAttempt)%>&grdByatt=<%=gradeByAttempt%>&classid=C000">  <%=rs.getString("course_name")%></a></font></td>

  <td width="20%" height="23">&nbsp;&nbsp;<a href="InstantMessage.jsp?emailid=<%=email%>
  &teacherid=<%=rs.getString("teacher_id") %>&fname=<%=fName%>&lname=<%=lName%>"><img border="0" src="images/m1.jpg" width="19" height="14" alt="Send an Instant Mail"></a>&nbsp;&nbsp;
 <%=fName%>&nbsp;&nbsp;<%=lName%></font></td>
  
 
<% 
	
			// rs2=st2.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) as sum1,sum(`"+schoolId+"_cescores`.`total_marks`) as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`report_status`=1 and (`"+schoolId+"_cescores`.`status`=1 ||`"+schoolId+"_cescores`.`status`=2) group by `"+schoolId+"_cescores`.`category_id`");

	%>
					<!-- <SCRIPT LANGUAGE="JavaScript">
					<!--
						document.getElementById("<%=studentId%>").innerHTML=" -->
						<td width="20%"><p align="center"><%=report.trimFloat(TotalMarkingPercentageByAttempt)%>&nbsp;%&nbsp;&nbsp;&nbsp;</td>
						<td width="20%"><p align="center"><%=gradeByAttempt%></font></b></td>
						<td width="20%"><p align="center"><%=report.trimFloat(percentageTotal)%>&nbsp;%&nbsp;&nbsp;&nbsp;</td>
						<td width="20%"><p align="center"><%=grade%></font></b></td>
						</tr>
					<!-- </SCRIPT> -->
					<!-- <td width="100%" height="23">
					<p align="right"><font color="#ffffff" face="Verdana" size="2"><b>&nbsp;&nbsp;&nbsp;Total:&nbsp;&nbsp;(<%=wghtSecTotal%>/<%=wghtTotal%>)&nbsp;&nbsp;&nbsp;</b></font><b><font color="#ffffff" face="Verdana" size="2"><%=report.trimFloat(percentageTotal)%>&nbsp;</font><font color="#ffffff">%&nbsp;&nbsp;<%=grade%></font></b></td> -->
<%

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
			else
			 {
				fg=new FindGrade();
					centMarks=fg.convertToCent(wghtSecTotal,wghtTotal);
					grade=fg.getGrade(schoolId,classId,courseId,centMarks);
					if(percentageTotal>100)
                         grade="A+";

		%>			<td width="20%" height="23" colspan="2"><p align="center">&nbsp;No Assignments&nbsp;</td>
						<td width="20%" height="23" colspan="2"><p align="center"><font  face="Arial" size="2" color="brown"><B>---</B></td></tr>
<%	
		}
	
}
  %>
	</table>
  </center>
</div>

</form>

</body>
<%
	
			}
			 }
		}
	 }
	
	catch(Exception e)
	{
		ExceptionsFile.postException("OverallSummary3.jsp","operations on database","Exception",e.getMessage());
    }
	finally{
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
			if(st6!=null)
				st6.close();
		
			if(con!=null && !con.isClosed())
				con.close();
			
		
		}
		catch(SQLException se){
			ExceptionsFile.postException("OverallSummary3.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
	out.println("</script>\n");
%>
<script language="javascript">

function goResults(obj)
{
      // 	var gradeObj=document.grstudselectfrm.gradeid;
		//var studentObj=document.grstudselectfrm.studentid;
		//var cid=gradeObj.value;
		var courseId=obj;
		document.location.href="OverallSummary3.jsp?userid=<%=studentId%>&courseid="+courseId;
		
	}

</script>
</html>