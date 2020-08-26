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
<title>SummaryByCategory</title>

</head>

<body>

<form name="grstudselectfrm" id='gr_stud_id'><BR>
</form>
<div align="center">
  <center>
<%
	
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st6=null;
	ResultSet  rs=null,rs1=null,rs2=null,rs3=null,rs6=null;
	FindGrade fg;
	boolean flag=false;
	String cId="",sId="",catId="",temp="",catType="",grSys="",status="",teacherId="";
	String catTypeByAttempt="",grSysByAttempt="",catIdByAttempt="";
	float sumofSecuredPoints=0.0f,sumofTotalPoints=0.0f,percentage=0.0f,percent=0.0f,percentageTotal=0.0f,wghtTotal=0.0f,wghtSecTotal=0.0f;
		float sumofSecuredPointsByAttempt=0.0f,sumofTotalPointsByAttempt=0.0f,percentageByAttempt=0.0f,percentByAttempt=0.0f,percentageTotalByAttempt=0.0f,wghtTotalByAttempt=0.0f,wghtSecTotalByAttempt=0.0f;
	int wght=0,wghtByAttempt=0;
	float centMarks=0.0f,centMarksByAttempt=0.0f;
	float  TotalMarkingPercentageByAttempt=0.0f;
	String fName="",lName="",courseName="";
	String grade="",classId="C000",gradeByAttempt="";
	String color="",email="";
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
		st6=con.createStatement();
		rs=st.executeQuery("select c.course_name,c.course_id,c.teacher_id from coursewareinfo c inner join coursewareinfo_det d  on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+studentId+"' and c.status=1 and c.school_id='"+schoolId+"' and d.school_id='"+schoolId+"' order by c.course_id");
%>
<table border="0" cellspacing="0" width="90%" id="AutoNumber3" bgcolor="#429EDF" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" height="28">
 
  <tr>
    <td width="33%" height="28"><font face="Verdana" size="2"><b>&nbsp;<font color="#FFFFFF">Summary By Category</font></b></font></td>

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
<table border="0" cellspacing="0" width="90%" id="AutoNumber1" bgcolor="#429EDF" height="26" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0">
  <tr bgcolor="#96C8ED">
    <td width="30%" height="23" colspan="4" bgcolor="#96C8ED">
	<select size="1" id="gradeid" name="gradeid"  onchange="goResults(this.value)">
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
    <option value="allcourses">List All Courses</option>
<%		
		 }
		while(rs.next())
		{
			cId=rs.getString("course_id");
			if(cId.equals(courseId))
			{
%>
				<option value='<%=cId%>' selected>&nbsp;&nbsp;<%=rs.getString("course_name")%>&nbsp;</option>
<%			}
			else
			{
%>			
				<option value='<%=cId%>'>&nbsp;&nbsp;<%=rs.getString("course_name")%>&nbsp;</option>
<%			}
		
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
  <tr>
	<td width="60%" height="23" colspan="4" bgcolor="#FFFFFF">
			<hr color="#F16C0A"></td>
		  </tr>
  <tr>
   

  </tr>
  <div align="center">
				  <center>
				<table border="1" cellspacing="1" width="90%" id="AutoNumber2" height="13" bordercolorlight="#E6F2FF">
				<tr>
					<td width="25%" align="center" bgcolor="#96C8ED" height="1">
					<p align="left"><b>
					<font face="Verdana" size="2">Category Name</font></b></td>
					<td width="6%" align="center" bgcolor="#96C8ED" height="1"><b>
					<font face="Verdana" size="2">Weight</font></b></td>
					<td width="13%" align="center" bgcolor="#96C8ED" height="1"><b>
					<font face="Verdana" size="2">Points Possible</font></b></td>
					<td width="14%" align="center" bgcolor="#96C8ED" height="1"><b>
					<font face="Verdana" size="2">Points Secured</font></b></td>
					<td width="14%" align="center" bgcolor="#96C8ED" height="1"><b>
					<font face="Verdana" size="2">Weighted Percentage</font></b></td>
				  </tr>
 <% 
	 int i=0,j=0;
	 if(courseId.equals("allcourses"))
		{		

			//rs=st.executeQuery("select course_name,course_id,teacher_id from coursewareinfo where status>0 order by course_id");
			 rs=st.executeQuery("select c.course_name,c.course_id,c.teacher_id from coursewareinfo c,coursewareinfo_det d where c.status>0 and d.student_id='"+studentId+"' and c.course_id=d.course_id and c.school_id='"+schoolId+"' and d.school_id='"+schoolId+"' order by c.course_id");

				while(rs.next())
				{
					courseId=rs.getString("course_id");
					teacherId=rs.getString("teacher_id");
					
					//studentId=rs.getString(1);
					courseName=rs.getString("course_name");

					rs1=st1.executeQuery("select  firstname, lastname,con_emailid from teachprofile where schoolid='"+schoolId+"' and username='"+teacherId+"'");
					
					if(rs1.next())
					{
						fName=rs1.getString("firstname");
						lName=rs1.getString("lastname");
						email=rs1.getString("con_emailid");
						
					
					%>		
				<table border="0" cellspacing="0" width="90%" id="AutoNumber1" bgcolor="#429EDF" height="26" style="border-collapse: collapse" bordercolor="#111111" cellpadding="2">
						  <tr>
						<td width="21%" height="23" bgcolor="#808080">
                        <font color="#800000" face="Verdana" size="2"><b>Course Name:&nbsp;</b></font><font color="#FFFFFF" face="Verdana" size="2"><%=courseName%></font></td>
						<td width="19%" height="23" bgcolor="#808080">
						<font color="#800000" face="Verdana" size="2"><b>Teacher Name:&nbsp;</b></font><font color="#FFFFFF" face="Verdana" size="2"><%=fName%>&nbsp;<%=lName%>&nbsp;&nbsp;<a href="InstantMessage.jsp?emailid=<%=email%>&teacherid=<%=rs.getString("teacher_id")%>&fname=<%=fName%>&lname=<%=lName%>"><img border="0" src="images/m1.jpg" width="19" height="14" alt="Send an Instant Mail"></a></font></b></td>
					<td width="20%" height="23" bgcolor="#808080">
    <p align="center"><font color="#FFFFFF" face="Verdana" size="2"><div id="<%=courseId%>"></div></td>
  </tr>
  </table>

<%  
					
					}					
					
						// rs2=st2.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) as sum1,sum(`"+schoolId+"_cescores`.`total_marks`) as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`report_status`=1 and (`"+schoolId+"_cescores`.`status`=0 ||`"+schoolId+"_cescores`.`status`=1 ||`"+schoolId+"_cescores`.`status`=2) group by `"+schoolId+"_cescores`.`category_id`");

						/*============overall percentageByAtt=============*/
						 
						rs6=st6.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) as sum1,sum(`"+schoolId+"_cescores`.`total_marks`) as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`report_status`=1 and (`"+schoolId+"_cescores`.`status`=2) group by `"+schoolId+"_cescores`.`category_id`");

                                       
						  	sumofSecuredPointsByAttempt=0.0f;
 		                    
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
										if(grSys.equals("2"))
										{
											color="brown";
										}
										wght=rs3.getInt("weightage");
									}
									rs3.close();
		
									temp=rs2.getString("sum1");
									sumofSecuredPoints=Float.parseFloat(rs2.getString("sum1"));
									sumofTotalPoints=Float.parseFloat(rs2.getString("sum2"));		
	
%>	
			</table>
		
		  </center>
		</div>
		
		<div align="center">
				  <center>
				<table border="1" cellspacing="1" width="90%" id="AutoNumber2" height="18" bordercolorlight="#E6F2FF">
				<tr>
					<td width="25%" height="1"><font face="Verdana" color="<%=color%>" size="2">&nbsp;<a href="SBCStudentScores.jsp?courseid=<%=courseId%>&teacherid=<%=rs.getString("teacher_id")%>&studentid=<%=studentId%>&catType=<%=catId%>&classid=C000&catName=<%=catType%>">
					<%=catType%></a></font></td>
					<td width="6%" height="1" align="center">
					<%
					if(grSys.equals("2"))
					{%>
					<font size="2" color="<%=color%>" face="Verdana"><strike><%=wght%></strike>%</font>

					<%}else{%><font size="2" face="Verdana"><%=wght%>%</font>
					<%}
					%>
					</td>
					<!-- <td width="6%" height="19" align="center"><font size="2" face="Verdana"><%=wght%>%</font></td> -->
					<td width="13%" height="1" align="center"><font face="Verdana" size="2"><%=sumofTotalPoints%></font></td>
					<td width="14%" height="1" align="center"><font face="Verdana" size="2"><%=sumofSecuredPoints%></font></td>
					<%
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
							if(sumofTotalPoints!=0)
							  {
							wghtSecTotal=wghtSecTotal+percentage;
							  }
							i++;
						
										
					%>

					<td width="14%" height="1" align="center"><font size="2" face="Verdana"><%=report.trimFloat(percentage)%></font></td>
				  </tr>
				  
				<!-- <hr color="#F16C0A" width="100%" size="1"> -->
<%	percentage=0.0f;	
	}
		if(!courseId.equals("no"))
		 {
				
			
%>
	<table border="0" cellspacing="0" width="90%" id="AutoNumber1" height="26" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0">
 
		  <tr bgcolor="#429EDF">
		  <td>
			<%
				percentageTotal=(percentageTotal/wghtTotal)*100;
		  percent=(float)Float.parseFloat(report.trimFloat(percentageTotal));
			    percentByAttempt=(float)Float.parseFloat(report.trimFloat(percentageTotalByAttempt));
				TotalMarkingPercentageByAttempt=percentByAttempt;

				if(i!=0)
				{
					fg=new FindGrade();
					centMarks=fg.convertToCent(wghtSecTotal,wghtTotal);
					grade=fg.getGrade(schoolId,classId,courseId,centMarks);
					if(percentageTotal>100)
                         grade="A+";

					fg=new FindGrade();
					centMarksByAttempt=fg.convertToCent(wghtSecTotalByAttempt,wghtTotalByAttempt);
					gradeByAttempt=fg.getGrade(schoolId,classId,courseId,centMarksByAttempt);

%>
<SCRIPT LANGUAGE="JavaScript">
					<!--
						document.getElementById("<%=courseId%>").innerHTML="<font color=#800000 face='Verdana' size='2'><b>By Attempt:</font>&nbsp;<%=report.trimFloat(centMarksByAttempt)%>%&nbsp;&nbsp;<b><font color='white' face='Arial' size='2'><%=gradeByAttempt%></b></font>&nbsp;&nbsp;<font color=#800000 face='Verdana' size='2'>Total:</font>&nbsp;</b></font><b><font color=#FFFFFF face='Verdana' size='2'><%=report.trimFloat(percentageTotal)%>%&nbsp;&nbsp;<%=grade%></font></b>";
					//-->
					</SCRIPT>
					<!-- <td width="100%" height="23">
					<p align="right"><font color="#ffffff" face="Verdana" size="2"><b>&nbsp;&nbsp;&nbsp;Total:&nbsp;&nbsp;(<%=wghtSecTotal%>/<%=wghtTotal%>)&nbsp;&nbsp;&nbsp;</b></font><b><font color="#ffffff" face="Verdana" size="2"><%=report.trimFloat(percentageTotal)%>&nbsp;</font><font color="#ffffff">%&nbsp;&nbsp;<%=grade%></font></b></td> --></td>
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
				centMarksByAttempt=0.0f;

				}
			else
			 {
		%>		<SCRIPT LANGUAGE="JavaScript">
					<!--
						document.getElementById("<%=courseId%>").innerHTML="<font color=#800000 face='Verdana' size='2'><b>By Attempt:</font>&nbsp;<%=report.trimFloat(centMarksByAttempt)%>%&nbsp;&nbsp;<b><font color='white' face='Arial' size='2'>F</b></font>&nbsp;&nbsp;<font color=#800000 face='Verdana' size='2'>Total:</font>&nbsp;</b></font><b><font color=#FFFFFF face='Verdana' size='2'><%=report.trimFloat(percentageTotal)%>%&nbsp;&nbsp;F</font></b>";
					//-->
					</SCRIPT>
		<tr>
					<td>
					<p align="left"><font  face="Verdana" size="2">There are no assignments available.</font></td></tr>
<%			 }
%>
 <tr>
	<td width="60%" height="23" colspan="4" bgcolor="#FFFFFF">
			<hr color="#F16C0A" size="1"></td>
		  </tr>
</table>
<%
		}
%>
</table>
<%
	i=0;
	}
}

else
		 {
	              	rs=st.executeQuery("select course_name,teacher_id from coursewareinfo where status>0 and course_id='"+courseId+"' and school_id='"+schoolId+"' order by course_id");

					

					while(rs.next())
				{
				    teacherId=rs.getString("teacher_id");
					courseName=rs.getString("course_name");

					rs1=st1.executeQuery("select  firstname, lastname,con_emailid from teachprofile where schoolid='"+schoolId+"' and username='"+teacherId+"'");
										
					if(rs1.next())
					{
						fName=rs1.getString("firstname");
						lName=rs1.getString("lastname");
						email=rs1.getString("con_emailid");
					}

			 %>	   
			 
<table border="0" cellspacing="0" width="90%" id="AutoNumber1" bgcolor="#429EDF" height="26" style="border-collapse: collapse" bordercolor="#111111" cellpadding="2">
 	  <tr>
    <td width="21%" height="23" bgcolor="#808080">
    <font color="#800000" face="Verdana" size="2"><b>Course Name:&nbsp;</b></font><font color="#FFFFFF" face="Verdana" size="2"><%=courseName%></font></td>
    <td width="19%" height="23"  bgcolor="#808080">
    <b>
    <font color="#800000" face="Verdana" size="2">Teacher Name:</font><font color="#FFFFFF" face="Verdana" size="2">&nbsp;</font></b><font color="#FFFFFF" face="Verdana" size="2"><%=fName%>&nbsp;<%=lName%>&nbsp;&nbsp;<a href="InstantMessage.jsp?emailid=<%=email%>&teacherid=<%= rs.getString("teacher_id") %>&fname=<%=fName%>&lname=<%=lName%>"><img border="0" src="images/m1.jpg" width="19" height="14" alt="Send an Instant Mail"></a></font></b></td>
    <td width="20%" height="23" bgcolor="#808080">
    <p align="center"><font color="#FFFFFF" face="Verdana" size="2"><div id="<%=courseId%>"></div></td>
  </tr>
	</table>
  <%  

			 /*============overall percentageByAtt=============*/

											
						rs6=st6.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) as sum1,sum(`"+schoolId+"_cescores`.`total_marks`) as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`report_status`=1 and (`"+schoolId+"_cescores`.`status`=2) group by `"+schoolId+"_cescores`.`category_id`");
						
						                                       
						  	sumofSecuredPointsByAttempt=0.0f;
 		                    
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
		
							
							sumofSecuredPointsByAttempt=Float.parseFloat(rs6.getString("sum1"));
							sumofTotalPointsByAttempt=Float.parseFloat(rs6.getString("sum2"));
														                             
							sumofSecuredPointsByAttempt=+sumofSecuredPointsByAttempt;
							sumofTotalPointsByAttempt=+sumofTotalPointsByAttempt;
													
							TotalSecureMarkingPointsByAttempt=TotalSecureMarkingPointsByAttempt+sumofSecuredPointsByAttempt;
							TotalMarkingPointsByAttempt=TotalMarkingPointsByAttempt+sumofTotalPointsByAttempt;
						
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
						
						
			}
			/*==========end of percenByAtte=========*/
			
			// rs2=st2.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) as sum1,sum(`"+schoolId+"_cescores`.`total_marks`) as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`report_status`=1 and (`"+schoolId+"_cescores`.`status`=0 ||`"+schoolId+"_cescores`.`status`=1 ||`"+schoolId+"_cescores`.`status`=2) group by `"+schoolId+"_cescores`.`category_id`");

			rs2=st2.executeQuery("select sum(ntable.sum1) as sum1,sum(ntable.sum2) as sum2,ntable.category_id from ( select        `"+schoolId+"_cescores`.`marks_secured` as sum1,`"+schoolId+"_cescores`.`total_marks` as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"'  and `"+schoolId+"_cescores`.`report_status`=1 and ((`"+schoolId+"_cescores`.`status`=2)||(`"+schoolId+"_cescores`.`end_date`<curdate()))  UNION ALL select marks_secured,'0',category_id from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`status`=0 and `"+schoolId+"_cescores`.`end_date`>=curdate() ) as ntable group by ntable.category_id");
						while(rs2.next())
						{
							
								
								catId=rs2.getString("category_id");
								
								rs3=st3.executeQuery("select * from category_item_master where school_id='"+schoolId+"' and course_id='"+courseId+"' and item_id='"+catId+"'");
								if(rs3.next())
								{
									catType=rs3.getString("item_des");
									grSys=rs3.getString("grading_system");
									if(grSys.equals("2"))
									{
										color="brown";
									}
									wght=rs3.getInt("weightage");
								}
								rs3.close();
		
			temp=rs2.getString("sum1");
			sumofSecuredPoints=Float.parseFloat(rs2.getString("sum1"));
			sumofTotalPoints=Float.parseFloat(rs2.getString("sum2"));									
%>		
			
		<div align="center">
				  <center>
				<table border="1" cellspacing="1" width="90%" id="AutoNumber2" height="18" bordercolorlight="#E6F2FF">
				  
				  <tr>
					<td width="25%" height="1"><font face="Verdana" size="2">&nbsp;<a href="SBCStudentScores.jsp?courseid=<%=courseId%>&teacherid=<%=rs.getString("teacher_id")%>
				&studentid=<%=studentId%>&catType=<%=catId%>&classid=C000&catName=<%=catType%>">
					<%=catType%></a></font></td>
					<td width="6%" height="1" align="center">
					<%
					if(grSys.equals("2"))
					{%>
					<font size="2" color="<%=color%>" face="Verdana"><strike><%=wght%></strike>%</font>

					<%}else{%><font size="2" face="Verdana"><%=wght%>%</font>
					<%}
					%>
					</td>
					<!-- <td width="6%" height="19" align="center"><font size="2" face="Verdana"><%=wght%>%</font></td> -->
					<td width="13%" height="1" align="center"><font face="Verdana" size="2"><%=sumofTotalPoints%></font></td>
					<td width="14%" height="1" align="center"><font face="Verdana" size="2"><%=sumofSecuredPoints%></font></td>
					<%
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
						
										
					%>

					<td width="14%" height="1" align="center"><font size="2" face="Verdana"><%=report.trimFloat(percentage)%></font></td>
				  </tr>
				  
				<!-- <hr color="#F16C0A" width="100%" size="1"> -->
<%		percentage=0.0f;
   }
  }
			if(!courseId.equals("no"))
		   {
				
			
%>
			<table border="0" cellspacing="0" width="90%" id="AutoNumber1"  height="26" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0">
				
				<tr bgcolor="#429EDF">
		             <td>
		  
			<%
				percentageTotal=(percentageTotal/wghtTotal)*100;
			percent=(float)Float.parseFloat(report.trimFloat(percentageTotal));
				percentByAttempt=(float)Float.parseFloat(report.trimFloat(percentageTotalByAttempt));
				TotalMarkingPercentageByAttempt=percentByAttempt;

				if(i!=0)
				{
					fg=new FindGrade();
					centMarks=fg.convertToCent(wghtSecTotal,wghtTotal);
					grade=fg.getGrade(schoolId,classId,courseId,centMarks);
					if(percentageTotal>100)
                         grade="A+";

					fg=new FindGrade();
					centMarksByAttempt=fg.convertToCent(wghtSecTotalByAttempt,wghtTotalByAttempt);
					gradeByAttempt=fg.getGrade(schoolId,classId,courseId,centMarksByAttempt);

%>
                     
					<SCRIPT LANGUAGE="JavaScript">
					<!--
						document.getElementById("<%=courseId%>").innerHTML="<font color=#800000 face='Verdana' size='2'><b>By Attempt:</font>&nbsp;<%=report.trimFloat(centMarksByAttempt)%>%&nbsp;&nbsp;<b><font color='white' face='Arial' size='2'><%=gradeByAttempt%></b></font>&nbsp;&nbsp;<font color=#800000 face='Verdana' size='2'>Total:</font>&nbsp;</b></font><b><font color=#FFFFFF face='Verdana' size='2'><%=report.trimFloat(percentageTotal)%>%&nbsp;&nbsp;<%=grade%></font></b>";
					//-->
					</SCRIPT>
					<!-- <td width="100%" height="23">
					<p align="right"><font color="#ffffff" face="Verdana" size="2"><b>&nbsp;&nbsp;&nbsp;Total:&nbsp;&nbsp;(<%=wghtSecTotal%>/<%=wghtTotal%>)&nbsp;&nbsp;&nbsp;</b></font><b><font color="#ffffff" face="Verdana" size="2"><%=report.trimFloat(percentageTotal)%>&nbsp;</font><font color="#ffffff">%&nbsp;&nbsp;<%=grade%></font></b></td> --></td>
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
		%>		<SCRIPT LANGUAGE="JavaScript">
					<!--
						document.getElementById("<%=courseId%>").innerHTML="<font color=#800000 face='Verdana' size='2'><b>By Attempt:</font>&nbsp;<%=report.trimFloat(centMarksByAttempt)%>%&nbsp;&nbsp;<b><font color='white' face='Arial' size='2'><%=gradeByAttempt%></b></font>&nbsp;&nbsp;<font color=#800000 face='Verdana' size='2'>Total:</font>&nbsp;</b></font><b><font color=#FFFFFF face='Verdana' size='2'><%=report.trimFloat(percentageTotal)%>%&nbsp;&nbsp;F</font></b>";
					//-->
					</SCRIPT>
		
		
		<tr>
					<td width="20%" height="18">
					<p align="left"><font face="Verdana" size="2">There are no assignments available.</font></td></tr>
<%			 }
%>
 <tr>
	<td width="60%" height="23" colspan="4" bgcolor="#FFFFFF">
			<hr color="#F16C0A" size="1"></td>
		  </tr>
		 </table>
		 
<%
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
	catch(Exception e)
	{
		ExceptionsFile.postException("SummaryByCategory3.jsp","operations on database","Exception",e.getMessage());
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

			if(con!=null && !con.isClosed())
				con.close();
			
		}
		catch(SQLException se){
			ExceptionsFile.postException("SummaryByCategory3.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
	out.println("</script>\n");
%>
<script language="javascript">

function goResults(obj)
{
	//alert("1");
    //   	var gradeObj=document.grstudselectfrm.gradeid;
		//var studentObj=document.grstudselectfrm.studentid;
		//alert("2");
		//var cid=gradeObj.value;
		//var studentid=studentObj.value;
		var courseid=obj;
		document.location.href="SummaryByCategory3.jsp?userid=<%=studentId%>&courseid="+courseid;
		
	}

</script>

</html>