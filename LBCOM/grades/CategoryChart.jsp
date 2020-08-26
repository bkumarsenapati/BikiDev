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
<title>Summary By Category Chart</title>
<SCRIPT LANGUAGE="Javascript" SRC="../FusionCharts/FusionCharts.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
<!--
function init()
{
	hide_loding();
}
function saveChart(){
         //Get chart from its ID
         var chartToPrint = getChartFromId("chart1Id");   
         chartToPrint.saveAsImage();
      }
//-->
</SCRIPT>
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
	String cId="",sId="",catId="",temp="",catType="",grSys="",status="";
	String catTypeByAttempt="",grSysByAttempt="",catIdByAttempt="";
	float sumofSecuredPoints=0.0f,sumofTotalPoints=0.0f,percentage=0.0f,percentageTotal=0.0f,wghtTotal=0.0f,wghtSecTotal=0.0f,percent=0.0f;
	float sumofSecuredPointsByAttempt=0.0f,sumofTotalPointsByAttempt=0.0f,percentageByAttempt=0.0f,percentByAttempt=0.0f,percentageTotalByAttempt=0.0f,wghtTotalByAttempt=0.0f,wghtSecTotalByAttempt=0.0f;

	int wght=0,wghtByAttempt=0;
	float centMarks=0.0f,centMarksByAttempt=0.0f;
	String graphContent1="",graphContent2="",graphContentbyattmpt1="",graphContentbyattmpt2="";
	String fName="",lName="";
	String grade="",classId="C000",gradeByAttempt="";
	String color="",email="";
	String teacherId=request.getParameter("userid");
	String courseId=request.getParameter("courseid");
	String studentId=request.getParameter("sid");
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
		rs=st.executeQuery("select * from coursewareinfo where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and status>0 order by course_id");
		
%>
<table border="0" cellspacing="0" width="95%" id="AutoNumber3" bgcolor="#429EDF" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" height="28">
 
  <tr>
    <td width="33%" height="28"><font face="Arial" size="2"><b>&nbsp;<font color="#FFFFFF">Summary By Category</font></b></font></td>

	 <td width="50%" height="24" align="right">
	<%
	if(!studentId.equals("no")){
	%><a
href="CategoryChart.jsp?userid=<%=teacherId%>&courseid=<%=courseId%>&sid=<%=studentId%>"><img
border="0" src="images/graph.png" width="22" height="22" BORDER="0"
ALT="Generate Graph"></a> &nbsp;&nbsp;<a href="javascript:window.print()"><img border="0" src="images/printer22.png" width="22" height="22" BORDER="0" ALT="Print"></a><%}%>&nbsp;&nbsp;
		
		<a href="index.jsp?userid=<%=teacherId%>"><IMG SRC="images/back.png" WIDTH="22" HEIGHT="22" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>&nbsp;
	</td>
  </tr>
</table>
  </center>
</div>
<br>
<div align="center">
  <center>
<table border="0" cellspacing="0" width="95%" id="AutoNumber1"  height="26" bordercolor="#111111" cellpadding="5">
  <tr>
    <td width="30%" height="23" colspan="2" bgcolor="#96C8ED">
	<select size="1" id="grade_id" style="width:200px" name="gradeid"  onchange="change(this.value)">
<option value="no" selected>Select Course</option>
<%		
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
		
		}
%>
    </select></td>
<%
	rs1=st1.executeQuery("select grade, username, fname, lname,con_emailid from studentprofile where schoolid='"+schoolId+"'  and crossregister_flag in(0,1,2) and username= any(select distinct(student_id) from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"')");

%>
    <td width="30%" height="23" colspan="2" bgcolor="#96C8ED">
    <p align="right"><select id='student_id' style="width:200px" name='studentid' onchange='goResults(this.value)'>
	<option value="no" selected>Select Student</option>
<%
		if(studentId.equals("allstudents"))
		{
%>
			<option value='allstudents' selected>&nbsp;List All Students</option>
<%	}
		else
		 {
			%>
			<option value='allstudents'>&nbsp;List All Students</option>
<%	}


	while (rs1.next()) 
	{
		sId=rs1.getString("username");
			if(sId.equals(studentId))
			{
				fName=rs1.getString("fname");
				lName=rs1.getString("lname");
				email=rs1.getString("con_emailid");
				
%>
				<option value='<%=sId%>' selected><%=rs1.getString("fname")%> &nbsp;&nbsp;<%=rs1.getString("lname")%></option>
<%			}
			else
			{
%>			
				<option value='<%=sId%>'><%=rs1.getString("fname")%> &nbsp;&nbsp;<%=rs1.getString("lname")%></option>
<%			}
			flag=true;
	}
	rs1.close();
%>	
	</select>
<%
	if(flag==false)
	{
		out.println("<td align='center'>Students are not available yet. </td></tr></table>");
		return;
	}
%>
</td>
	
  </tr>
  <tr>
	<td width="60%" colspan="4">
			</td>
		  </tr>
  <tr>
   

  </tr>
  <div align="center">
				  <center>
				 
				
 <% 
	 int i=0,j=0;
	 if(studentId.equals("allstudents"))
		{		


			rs=st.executeQuery("select student_id,course_id from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"' order by student_id");

				while(rs.next())
				{
					 percentageTotal=0.0f;
					
					studentId=rs.getString(1);
					rs1=st1.executeQuery("select grade, username, fname, lname,con_emailid from studentprofile where schoolid='"+schoolId+"'  and crossregister_flag in(0,1,2) and username= any(select distinct(student_id) from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"' and username='"+studentId+"')");
					
					if(rs1.next())
					{
						fName=rs1.getString("fname");
						lName=rs1.getString("lname");
						email=rs1.getString("con_emailid");
						
					if(!studentId.equals("C000_vstudent"))
					{
					%>		
					 <table border="0" cellspacing="0" width="95%" height="26" bordercolor="#111111">
						  <tr>
						<td width="21%" height="23">
                        <font color="#000000" face="Arial" size="2"><b>Student Name&nbsp;:&nbsp;</b></font><font color="#000000" face="Arial" size="2"><%=fName%>&nbsp;<%=lName%></font></td>
						<td width="19%" height="23" colspan="1">
						<font color="#000000" face="Arial" size="2"><b>Student ID&nbsp;:&nbsp;</b></font>
						<font color="#000000" face="Arial" size="2"><%=studentId%>&nbsp;&nbsp;<a href="InstantMessage.jsp?emailid=<%=email%>&studentid=<%= studentId %>&fname=<%=fName%>&lname=<%=lName%>"><img border="0" src="images/email.png" width="16" height="16" alt="Send an Instant Mail"></a></td>
						<td width="20%" height="23">
							<font color="#000000" face="Arial" size="2">
							<div id="<%=studentId%>"></div>
						</td>
					  </tr>
					  </table>
					<table  border="1" cellspacing="2" cellpadding="3" width="95%" id="AutoNumber2" height="26"  bordercolor="#96C8ED">
				<tr>
					<td width="25%" align="center" bgcolor="#96C8ED" height="1">
					<p align="left"><b>
					<font face="Arial" size="2">Category Name</font></b></td>
					<td width="6%" align="center" bgcolor="#96C8ED" height="1"><b>
					<font face="Arial" size="2">Weight</font></b></td>
					<td width="13%" align="center" bgcolor="#96C8ED" height="1"><b>
					<font face="Arial" size="2">Points Possible</font></b></td>
					<td width="14%" align="center" bgcolor="#96C8ED" height="1"><b>
					<font face="Arial" size="2">Points Secured</font></b></td>
					<td width="14%" align="center" bgcolor="#96C8ED" height="1"><b>
					<font face="Arial" size="2">Weighted Percentage</font></b></td>
				  </tr>
				
					  


<%  
					}
					}					
					if(!studentId.equals("C000_vstudent"))
					{
                      
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


						// rs2=st2.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) as sum1,sum(`"+schoolId+"_cescores`.`total_marks`) as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`report_status`=1 and ((`"+schoolId+"_cescores`.`status`=1 ||`"+schoolId+"_cescores`.`status`=2)|| (`"+schoolId+"_cescores`.`status`=0 && `"+schoolId+"_cescores`.`end_date`<curdate())) group by `"+schoolId+"_cescores`.`category_id`");

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
									
									// Assignment start here



									// End of Assignment
%>			
				<tr>
					<td width="25%" height="1"><font face="Arial" color="<%=color%>" size="2">&nbsp;<a href="SBCScoresCat.jsp?courseid=<%=courseId%>&studentid=<%=studentId%>&classid=C000
					&catType=<%=catId%>&catName=<%=catType%>"><%=catType%></a></font></td>
					<td width="6%" height="0" align="center">
					<%
					if(grSys.equals("2"))
					{%>
					<font size="2" color="<%=color%>" face="Arial"><strike><%=wght%></strike>%</font>

					<%}else{%><font size="2" face="Arial"><%=wght%>%</font>
					<%}
					%>
					</td>
					<!-- <td width="6%" height="19" align="center"><font size="2" face="Arial"><%=wght%>%</font></td> -->
					<td width="13%" height="1" align="center"><font face="Arial" size="2"><%=sumofTotalPoints%></font></td>
					<td width="14%" height="1" align="center"><font face="Arial" size="2"><%=sumofSecuredPoints%></font></td>
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

					<td width="14%" height="1" align="center"><font size="2" face="Arial"><%=report.trimFloat(percentage)%>%</font></td>
				  </tr>
				  
<!-- <hr color="#F16C0A" width="100%" size="1"> -->
<%		

	    percentage=0.0f;
							}
		if(!studentId.equals("no"))
		 {
				
			
%>
		<table border="0" cellspacing="0" width="95%" id="AutoNumber1" height="26" bordercolor="#111111" cellpadding="0">
 
		  <tr>
		  <td align="right">
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

					fg=new FindGrade();
					centMarksByAttempt=fg.convertToCent(wghtSecTotalByAttempt,wghtTotalByAttempt);
					gradeByAttempt=fg.getGrade(schoolId,classId,courseId,centMarksByAttempt);
					
	%>
					<SCRIPT LANGUAGE="JavaScript">
					<!--
						//document.getElementById("<%=studentId%>").innerHTML="<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color=#000000 face='Arial' size='2'>Total:</font>&nbsp;&nbsp;&nbsp;</b></font><b><font color=#000000 face='Arial' size='2'><%=report.trimFloat(percentageTotal)%>%&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Grade:&nbsp;&nbsp;<font size='2' color='brown'><b><%=grade%></b></font></b>";
						document.getElementById("<%=studentId%>").innerHTML="<b>By Attempt:</font>&nbsp;<%=report.trimFloat(centMarksByAttempt)%>%&nbsp;&nbsp;Grade:&nbsp;<b><font color='brown' face='Arial' size='2'><%=gradeByAttempt%></b></font>&nbsp;&nbsp;<font color=#000000 face='Arial' size='2'>Total:</font>&nbsp;&nbsp;&nbsp;</b></font><b><font color=#000000 face='Arial' size='2'><%=report.trimFloat(percentageTotal)%>%&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Grade:&nbsp;&nbsp;<font size='2' color='brown'><b><%=grade%></b></font></b>";
					//-->
					</SCRIPT>
					<!-- <td width="100%" height="23">
					<p align="right"><font color="#ffffff" face="Arial" size="2"><b>&nbsp;&nbsp;&nbsp;Total:&nbsp;&nbsp;(<%=wghtSecTotal%>/<%=wghtTotal%>)&nbsp;&nbsp;&nbsp;</b></font><b><font color="#ffffff" face="Arial" size="2"><%=report.trimFloat(percentageTotal)%>&nbsp;</font><font color="#ffffff">%&nbsp;&nbsp;<%=grade%></font></b></td> --></td>
</td></tr>
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
		%>		<tr>
					<td>
					<p align="left"><font  face="Arial" size="2">There are no assignments available.</font></td></tr>
<%			 }
%>
 <tr>
	<td width="60%" height="23" colspan="4" bgcolor="#FFFFFF">
	 <hr color="#429EDF" size="1"></td>
		  </tr>
</table>
<%
		}
		
		}
		 
		else
		{
%>			
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
			 %>
			  <table border="0" cellspacing="0" width="95%" id="AutoNumber1" height="26" bordercolor="#111111" cellpadding="2">
						  <tr>
						<td width="21%" height="23">
                        <font color="#000000" face="Arial" size="2"><b>Student Name:&nbsp;</b></font><font color="#000000" face="Arial" size="2"><%=fName%>&nbsp;<%=lName%></font></td>
						<td width="19%" height="23" colspan="1">
						<font color="#000000" face="Arial" size="2"><b>Student ID:&nbsp;</b></font><font color="#000000" face="Arial" size="2"><%=studentId%>&nbsp;&nbsp;<a href="InstantMessage.jsp?emailid=<%=email%>&studentid=<%= studentId %>&fname=<%=fName%>&lname=<%=lName%>"><img border="0" src="images/email.png" width="16" height="16" alt="Send an Instant Mail"></a></font></b></td>
						<td width="20%" height="23" >
						<font color="#000000" face="Arial" size="2"><div id="<%=studentId%>"></div></td>
					  </tr>
					  </table>
			 
			 <table  border="1" cellspacing="2" cellpadding="3" width="95%" id="AutoNumber2" height="26"  bordercolor="#96C8ED">
				<tr>
					<td width="25%" align="center"  bgcolor="#96C8ED" height="1">
					<p align="left"><b>
					<font face="Arial" size="2">Category Name</font></b></td>
					<td width="6%" align="center" bgcolor="#96C8ED" height="1"><b>
					<font face="Arial" size="2">Weight</font></b></td>
					<td width="13%" align="center" bgcolor="#96C8ED" height="1"><b>
					<font face="Arial" size="2">Points Possible</font></b></td>
					<td width="14%" align="center" bgcolor="#96C8ED" height="1"><b>
					<font face="Arial" size="2">Points Secured</font></b></td>
					<td width="14%" align="center" bgcolor="#96C8ED" height="1"><b>
					<font face="Arial" size="2">Weighted Percentage</font></b></td>
				  </tr>

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

							graphContentbyattmpt1=graphContentbyattmpt1+"<set label='"+catType+"' value='"+wght+"' isSliced='1' />";
							graphContentbyattmpt2=graphContentbyattmpt2+"<set label='"+catType+"' value='"+report.trimFloat(percentageByAttempt)+"' isSliced='1' />";

							//percentageByAttempt=0.0f;
							//sumofSecuredPointsByAttempt=0.0f;
							//sumofTotalPointsByAttempt=0.0f;
						//	i++;
						
			}
			/*==========end of percenByAtte=========*/


			 //rs2=st2.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) as sum1,sum(`"+schoolId+"_cescores`.`total_marks`) as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`report_status`=1 and ((`"+schoolId+"_cescores`.`status`=1 ||`"+schoolId+"_cescores`.`status`=2)|| (`"+schoolId+"_cescores`.`status`=0 && `"+schoolId+"_cescores`.`end_date`<curdate())) group by `"+schoolId+"_cescores`.`category_id`");
			 
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
			
		<!-- <div align="center">
				  <center>
				<table border="1" cellspacing="1" width="95%" id="AutoNumber2" height="18" bordercolorlight="#E6F2FF"> -->
				  
				  <tr>
					<td width="25%" height="1"><font face="Arial" size="2">&nbsp;<a href="SBCScoresCat.jsp?courseid=<%=courseId%>&studentid=<%=studentId%>&classid=C000
					&catType=<%=catId%>&catName=<%=catType%>"><%=catType%></a></font></td>
					<td width="6%" height="1" align="center">
					<%
					if(grSys.equals("2"))
					{%>
					<font size="2" color="<%=color%>" face="Arial"><strike><%=wght%></strike>%</font>

					<%}else{%><font size="2" face="Arial"><%=wght%>%</font>
					<%}
					%>
					</td>
					<!-- <td width="6%" height="19" align="center"><font size="2" face="Arial"><%=wght%>%</font></td> -->
					<td width="13%" height="1" align="center"><font face="Arial" size="2"><%=sumofTotalPoints%></font></td>
					<td width="14%" height="1" align="center"><font face="Arial" size="2"><%=sumofSecuredPoints%></font></td>
					<%
						sumofSecuredPoints=+sumofSecuredPoints;
						sumofTotalPoints=+sumofTotalPoints;
						
						      if(sumofTotalPoints!=0)
							  {
								wghtTotal=wghtTotal+wght;
								percentage=(sumofSecuredPoints/sumofTotalPoints)*wght;
							  }
							//wghtTotal=wghtTotal+wght;
							//percentage=(sumofSecuredPoints/sumofTotalPoints)*wght;
							percentageTotal=percentageTotal+percentage;
							if(grSys.equals("2"))
							{
								wghtTotal=wghtTotal-wght;
							}
							wghtSecTotal=wghtSecTotal+percentage;
							i++;
							graphContent1=graphContent1+"<set label='"+catType+"' value='"+wght+"' isSliced='1' />";
							graphContent2=graphContent2+"<set label='"+catType+"' value='"+report.trimFloat(percentage)+"' isSliced='1' />";
						
										
					%>

					<td width="14%" height="1" align="center"><font size="2" face="Arial"><%=report.trimFloat(percentage)%>%</font></td>
				  </tr>
				  
				<!-- <hr color="#F16C0A" width="100%" size="1"> -->

<%		      percentage=0.0f;
	
              }
			if(!studentId.equals("no"))
		   {
				
			
%>
		<table border="1" cellspacing="0" width="95%" id="AutoNumber1"  height="26" bordercolor="#111111" cellpadding="0">
 
		  <tr>
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

					fg=new FindGrade();
					centMarksByAttempt=fg.convertToCent(wghtSecTotalByAttempt,wghtTotalByAttempt);
					gradeByAttempt=fg.getGrade(schoolId,classId,courseId,centMarksByAttempt);
					
					  /*rs9=st9.executeQuery("SELECT grade_code from class_grades where schoolid='"+schoolId+"' and "+percent+"<minimum and "+percent+">maximum");
					while(rs9.next())
					{
						grade=rs9.getString("grade_code");
					}*/
%>
					<SCRIPT LANGUAGE="JavaScript">
					<!--
						document.getElementById("<%=studentId%>").innerHTML="<b>By Attempt:</font>&nbsp;<%=report.trimFloat(centMarksByAttempt)%>%&nbsp;&nbsp;Grade:&nbsp;<b><font color='brown' face='Arial' size='2'><%=gradeByAttempt%></b></font>&nbsp;&nbsp;<font color=#000000 face='Arial' size='2'>Total:</font>&nbsp;&nbsp;&nbsp;</b></font><b><font color=#000000 face='Arial' size='2'><%=report.trimFloat(percentageTotal)%>%&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Grade:&nbsp;&nbsp;<font size='2' color='brown'><b><%=grade%></b></font></b>";
					//-->
					</SCRIPT>
					<!-- <td width="100%" height="23">
					<p align="right"><font color="#ffffff" face="Arial" size="2"><b>&nbsp;&nbsp;&nbsp;Total:&nbsp;&nbsp;(<%=wghtSecTotal%>/<%=wghtTotal%>)&nbsp;&nbsp;&nbsp;</b></font><b><font color="#ffffff" face="Arial" size="2"><%=report.trimFloat(percentageTotal)%>&nbsp;</font><font color="#ffffff">%&nbsp;&nbsp;<%=grade%></font></b></td> --></td>
</tr>
<%
				}
			else
			 {
		%>		<tr>
					<td width="20%" height="18">
					<p align="left"><font face="Arial" size="2">There are no assignments available.</font></td></tr>
<%			 }
%>
 <tr>
	<td width="60%" height="23" colspan="4" bgcolor="#FFFFFF">
			<!-- <hr color="#F16C0A" size="1"> -->
			</td>
		  </tr>
		 </table>
<%
		}
%>
</table>
  </center>
</div>
<!--				Chart start here...!	-->


<table border="0" bordercolor="green"><tr><td>&nbsp;</td></tr></table>

  <CENTER>
   <div id="chartbyatt1div">
      <!-- FusionCharts by attempt -->
   </div>
   <br>
   <div id="chartbyatt2div">
      <!-- FusionCharts Second -->
   </div>

 <div id="overallchartdiv1">
      <!-- FusionCharts overall percentage -->
   </div>
   <br>
   <div id="overallchartdiv2">
      <!-- FusionCharts Second -->
   </div>


   <script language="JavaScript"> 
    var chartbyatt1 = new FusionCharts("../FusionCharts/Pie3D.swf", "chart1Id", "700", "200", "0", "1"); 
	var chartbyatt2 = new FusionCharts("../FusionCharts/Pie3D.swf", "chart1Id", "700", "200", "0", "1"); 

	//chartbyatt1.setDataXML("<chart caption='Overall Summary By Attempt' palette='2' animation='0' formatNumberScale='0' pieSliceDepth='15' startingAngle='125'><%=graphContentbyattmpt1%><styles><definition><style type='font' name='CaptionFont' size='15' color='666666' /><style type='font' name='SubCaptionFont' bold='0' /></definition><application><apply toObject='caption' styles='CaptionFont' /><apply toObject='SubCaption' styles='SubCaptionFont' /></application></styles></chart>");

	chartbyatt2.setDataXML("<chart caption='Summary By Category - By Attempt' palette='2' animation='1' formatNumberScale='0' pieSliceDepth='15' startingAngle='125'><%=graphContentbyattmpt2%><styles><definition><style type='font' name='CaptionFont' size='15' color='666666' /><style type='font' name='SubCaptionFont' bold='0' /></definition><application><apply toObject='caption' styles='CaptionFont' /><apply toObject='SubCaption' styles='SubCaptionFont' /></application></styles></chart>");

	//chartbyatt1.render("chartbyatt1div");
	chartbyatt2.render("chartbyatt2div");




	// var overallchart1 = new FusionCharts("../FusionCharts/Pie3D.swf", "chart1Id", "700", "200", "0", "1"); 
	var overallchart2 = new FusionCharts("../FusionCharts/Pie3D.swf", "chart1Id", "700", "200", "0", "1"); 

	//overallchart1.setDataXML("<chart caption='Overall Summary' palette='2' animation='0' formatNumberScale='0' pieSliceDepth='15' startingAngle='125'><%=graphContent1%><styles><definition><style type='font' name='CaptionFont' size='15' color='666666' /><style type='font' name='SubCaptionFont' bold='0' /></definition><application><apply toObject='caption' styles='CaptionFont' /><apply toObject='SubCaption' styles='SubCaptionFont' /></application></styles></chart>");

	overallchart2.setDataXML("<chart caption='Summary By Category - Overall' palette='2' animation='1' formatNumberScale='0' pieSliceDepth='15' startingAngle='125'><%=graphContent2%><styles><definition><style type='font' name='CaptionFont' size='15' color='666666' /><style type='font' name='SubCaptionFont' bold='0' /></definition><application><apply toObject='caption' styles='CaptionFont' /><apply toObject='SubCaption' styles='SubCaptionFont' /></application></styles></chart>");

	//overallchart1.render("overallchartdiv1");
	overallchart2.render("overallchartdiv2");

   </script>
  <!--  <center><input type='button' value='Save Chart as Image' onClick='javascript:saveChart();'></center> -->
    </CENTER>


<!--				Chart end here.....!	-->

</form>

</body>
<%
	
	 }
	 }
	catch(Exception e)
	{
		ExceptionsFile.postException("CategoryChart.jsp","operations on database","Exception",e.getMessage());
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
			ExceptionsFile.postException("CategoryChart.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
	out.println("</script>\n");
%>
<script language="javascript">

function change(grade1)
{
	if(grade1!='no')
	{
		grades=grade1
		document.location.href="OverallSummary2.jsp?userid=<%=teacherId%>&courseid="+grade1;
	}
	else
	{
		alert("Select Grade")
		grades='no';
		location.href="OverallSummary2.jsp?userid=<%=teacherId%>&courseid="+grade1;						
	}
}
function goResults(obj)
{
	//alert("1");
    //   	var gradeObj=document.grstudselectfrm.gradeid;
		//var studentObj=document.grstudselectfrm.studentid;
		//alert("2");
		//var cid=gradeObj.value;
		//var studentid=studentObj.value;
		document.location.href="CategoryChart.jsp?userid=<%=teacherId%>&courseid=<%=courseId%>&sid="+obj;
		
	}
</script>

</html>