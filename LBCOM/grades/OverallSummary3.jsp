<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile,exam.FindGrade"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page" />
<%@ include file="/common/checksession.jsp" %> 	

<html>

<head>
<SCRIPT LANGUAGE="JavaScript" src="/LBCOM/common/Validations.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
function init()
{
	hide_loding();
}
</SCRIPT>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Student Overall Summary Report</title>
</head>
<DIV id=loading  style='WIDTH:100%; height:90%; POSITION: absolute; TEXT-ALIGN: center;border: 0px solid;z-index:1;background-color : white;'><IMG src="/LBCOM/common/images/loading.gif" border=0>
</DIV>
<body onload=init();>
<form name="grstudselectfrm" id='gr_stud_id'><BR>
<div align="center">
  <center>
<%   
	
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st8=null,st9=null,st6=null;
	ResultSet  rs=null,rs1=null,rs2=null,rs3=null,rs8=null,rs9=null,rs6=null;
	FindGrade fg;
	boolean flag=false;
	String cId="",sId="",catId="",temp="",catType="",grSys="",status="";
	String catTypeByAttempt="",grSysByAttempt="",catIdByAttempt="";
	float sumofSecuredPoints=0.0f,sumofTotalPoints=0.0f,percentage=0.0f,percent=0.0f,percentageTotal=0.0f,wghtTotal=0.0f,wghtSecTotal=0.0f;

	float sumofSecuredPointsByAttempt=0.0f,sumofTotalPointsByAttempt=0.0f,percentageByAttempt=0.0f,percentByAttempt=0.0f,percentageTotalByAttempt=0.0f,wghtTotalByAttempt=0.0f,wghtSecTotalByAttempt=0.0f;
	int wght=0,wghtByAttempt=0;
	float centMarks=0.0f,centMarksByAttempt=0.0f;
	String fName="",lName="",email="";
	String grade="",classId="C000",gradeByAttempt="";
    String sortStr="",sortingBy="",sortingType="";
	String teacherId=request.getParameter("userid");
	String courseId=request.getParameter("courseid");
	String studentId=request.getParameter("sid");
	String schoolId=(String)session.getValue("schoolid");
	sortingBy=request.getParameter("sortby");
	sortingType=request.getParameter("sorttype");
   
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
		st8=con.createStatement();
		st9=con.createStatement();
		rs=st.executeQuery("select * from coursewareinfo where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and status>0 order by course_id");
%>
<table border="0" colspan="4" cellspacing="0" width="95%" id="AutoNumber3" bgcolor="#429EDF" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" height="28">
  <tr>
    <td width="50%" height="28"><font face="Arial" size="2"><b>&nbsp;<font color="#FFFFFF">Student Overall Summary Report</font></b></font></td>
	<td width="50%" height="24" align="right">
	<%
	if(!studentId.equals("no")){
	%><!-- <a
href="OverallChart.jsp?userid=<%=teacherId%>&courseid=<%=courseId%>&sid=<%=studentId%>"><img
border="0" src="images/graph.png" width="22" height="22" BORDER="0"
ALT="Generate Graph"></a>  -->&nbsp;&nbsp;<a href="javascript:window.print()"><img border="0" src="images/printer22.png" width="22" height="22" BORDER="0" ALT="Print"></a><%}%>&nbsp;&nbsp;
		
		<a href="index.jsp?userid=<%=teacherId%>"><IMG SRC="images/back.png" WIDTH="22" HEIGHT="22" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>&nbsp;
	</td>
	
  </tr>
</table>
  </center>
</div>
<br>
<div align="center">
  <center>
<table border="0" colspan="4" cellspacing="0" width="95%" id="AutoNumber1" bgcolor="#429EDF" height="26" style="border-collapse: collapse" bordercolor="#111111" cellpadding="5">
  <tr>
    <td width="30%" height="23" colspan="2" bgcolor="#96C8ED">
	<select style="width:200px" size="1" id="grade_id" name="gradeid"  onchange="change(this.value)">

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
    </select>
	<script>
			document.grstudselectfrm.gradeid.value='<%=courseId%>';
		</script>
	</td>
<%
	rs1=st1.executeQuery("select grade, username, fname, lname,con_emailid from studentprofile where schoolid='"+schoolId+"'  and crossregister_flag in(0,1,2) and username= any(select distinct(student_id) from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"')");

%>
    <td width="30%" height="23" colspan="2" bgcolor="#96C8ED">
    <p align="right"><select id='student_id' style="width:200px"  name='studentid' onchange='goResults(this.value)'>
	<option value="no" selected>Select Student</option>
<%
		if(studentId.equals("allstudents"))
		{
%>
			<option value='allstudents' selected>List All Students</option>
<%	}
		else
		 {
			%>
			<option value='allstudents'>List All Students</option>
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
				<option value='<%=sId%>' selected>&nbsp;&nbsp;<%=rs1.getString("fname")%> &nbsp;&nbsp;<%=rs1.getString("lname")%></option>
<%			}
			else
			{
%>			
				<option value='<%=sId%>'>&nbsp;&nbsp;<%=rs1.getString("fname")%> &nbsp;&nbsp;<%=rs1.getString("lname")%></option>
<%			}
			flag=true;
	}
	rs1.close();
	
%>	
	</select>
	<script>
			document.grstudselectfrm.studentid.value='<%=studentId%>';
		</script>
<%
	if(flag==false)
	{
		out.println("<td align='center'>Students are not available yet. </td></tr></table>");
		return;
	}
%>
</td>
	
  </tr>
  </table>
  <% 
	 int i=0,j=0;
	 if(studentId.equals("allstudents"))
		{		


			//rs=st.executeQuery("select student_id,course_id from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"' order by student_id");
			%>
			<table border="1" cellspacing="2" cellpadding="3" colspan="5" width="95%" id="AutoNumber1"  height="26"  bordercolor="#96C8ED">
						  <tr>
                <!--  <td width="20%" height="23" bgcolor="#429EDF"> -->
                           <p align="center">
						  <%
	if (sortingType==null)
			sortingType="A";
if (sortingBy==null || sortingBy.equals(""))
		{
	        
				sortStr="student_id";
				sortingBy="slno";
				sortingType="D";
		}
		else
		{
			if(sortingBy.equals("slno"))
				{
			   if(sortingType.equals("A"))
			{
				//sortStr="lname asc"+",fname asc";
				sortStr="student_id asc";
			}
			else
			{
				//sortStr="lname desc"+",fname desc";
				sortStr="student_id desc";
			}				
		}
			else if (sortingBy.equals("md"))
			{
			sortStr="student_id";
			if(sortingType.equals("A"))
			{
				sortStr=sortStr+" asc";
			}
			else
			{
				sortStr=sortStr+" desc";
			}
			}
		}
    	String bgColorDoc="#C0C0C0",bgColorDate="#C0C0C0";
			if(sortingBy.equals("slno"))
			{
				bgColorDoc= "#9D9D9D";     
			}
			if(sortingBy.equals("md"))	 
			{
				bgColorDate= "#858585";   
			} 
%>	 
			<td width="25%" bgcolor='<%=bgColorDoc%>' align="left" height="21">
<%  
			if((sortingType.equals("D"))||(sortingBy.equals("en")))
			{
%>
				<a href="OverallSummary3.jsp?sortby=slno&sorttype=A&courseid=<%=courseId%>&userid=<%=teacherId%>&sid=<%=studentId%>&status=" target="_self">
					<img border="0" src="images/sort_dn_1.gif" width="12" height="11"></a>
<%   
			}
			else
			{
%>
				<a href="OverallSummary3.jsp?sortby=slno&sorttype=D&courseid=<%=courseId%>&userid=<%=teacherId%>&sid=<%=studentId%>&status=" target="_self">
					<img border="0" src="images/sort_up_1.gif" width="12" height="11"></a>
<%   
			}
%>
						
                        <b>
                        <font face="Arial" size="2">Student Name</font></td>
						<td width="25%" height="10" bgcolor="<%=bgColorDate%>" colspan="2">
						<%  
			if((sortingType.equals("D"))&&(sortingBy.equals("md")))
			{
%>  
				<a href="OverallSummary3.jsp?&sortby=md&sorttype=A&courseid=<%=courseId%>&userid=<%=teacherId%>&sid=<%=studentId%>&status=" target="_self">
<img border="0" src="images/sort_dn_1.gif" width="12" height="11"></a>
<%   
			}
			else
			{
%>     
				<a href="OverallSummary3.jsp?sortby=md&sorttype=D&courseid=<%=courseId%>&userid=<%=teacherId%>&sid=<%=studentId%>&status=" target="_self">
					<img border="0" src="images/sort_up_1.gif" width="12" height="11"></a>
<%   
			}
%>
						<font face="Arial" size="2"><b>Student ID</b></font><font color="#FFFFFF"></b></font></td>
						
						<td width="20%" height="23" bgcolor="#C0C0C0">
						<p align="center">
						<b>
						<font face="Arial" size="2">By Attempt</b></td>
						<td width="20%" height="23" bgcolor="#C0C0C0">
						<p align="center">
						<b>
						<font face="Arial" size="2">By Attempt Grade</b></td>
						<td width="20%" height="23" bgcolor="#C0C0C0">
						<p align="center">
						<b>
						<font face="Arial" size="2">Total</b></td>
						<td width="25%" height="23" bgcolor="#C0C0C0">
						<p align="center">
						<b>
						<font face="Arial" size="2">Grade</b></td>
					  </tr>
			<%
                    
                  rs=st.executeQuery("select student_id,course_id from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"' order by "+sortStr+"");
				  
        
       
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
						
						 <tr >
						<td width="20%" height="23"><font  face="Arial" size="2"><%=lName%>&nbsp;<%=fName%></font></td>
						<td width="2%" height="23">
						<a href="InstantMessage.jsp?emailid=<%=email%>&studentid=<%= studentId %>&fname=<%=fName%>&lname=<%=lName%>"><img border="0" src="images/email.png" width="16" height="16" alt="Send an Instant Mail"></a></td>
						
					
				  
<%  
					if(!studentId.equals("C000_vstudent"))
					{
						 //rs2=st2.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) as sum1,sum(`"+schoolId+"_cescores`.`total_marks`) as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`report_status`=1 and (`"+schoolId+"_cescores`.`status`=1 ||`"+schoolId+"_cescores`.`status`=2) group by `"+schoolId+"_cescores`.`category_id`");

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






						//rs2=st2.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) as sum1,sum(`"+schoolId+"_cescores`.`total_marks`) as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`report_status`=1 and ((DATE_FORMAT(`"+schoolId+"_activities`.`s_date`, '%m/%d/%Y') >= '"+date1+"' and DATE_FORMAT(`"+schoolId+"_activities`.`s_date`, '%m/%d/%Y') <= '"+date2+"') and  (DATE_FORMAT(`"+schoolId+"_cescores`.`end_date`, '%m/%d/%Y') >= '"+date1+"' and    DATE_FORMAT(`"+schoolId+"_cescores`.`end_date`, '%m/%d/%Y') <= '"+date2+"')) group by `"+schoolId+"_cescores`.`category_id`");
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
						<td width="20%" height="23"><font  face="Arial" size="2"><a href="MainStudentScores.jsp?courseid=<%=courseId%>&studentid=<%=studentId%>&perctByatt=<%=report.trimFloat(TotalMarkingPercentageByAttempt)%>&grdByatt=<%=gradeByAttempt%>&classid=C000&sid=all">
					<%=studentId%></font></a></td>

						<td width="20%"><p align="center"><font  face="Arial" size="2"><%=report.trimFloat(TotalMarkingPercentageByAttempt)%>&nbsp;%</td>
						<td width="20%"><p align="center"><font  face="Arial" size="2" color="brown"><b><%=gradeByAttempt%></b></font></td>
						<td width="20%"><p align="center"><font  face="Arial" size="2"><%=report.trimFloat(percentageTotal)%>&nbsp;%</td>
						<td width="20%"><p align="center"><font  face="Arial" size="2" color="brown"><b><%=grade%></b></font></td>
						
						</tr>
					
<%
				
				}
			else
			 {	
					/*rs9=st9.executeQuery("SELECT grade_code from class_grades where schoolid='"+schoolId+"' and "+percent+"<minimum and "+percent+">maximum");
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

					System.out.println("......................centMarksByAttempt..."+centMarksByAttempt);
					
		%>		<td width="20%" height="23" colspan="5"><p align="center"><font  face="Arial" size="2"> &nbsp;No Assignments&nbsp;</td>
				<!-- <td width="20%" height="23"><p align="center"><font  face="Arial" size="2" color="brown"><B>---</B></td> --></tr>
<%			 }
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
		}
	}
}
%>
  </table>
		
		  </center>
		</div>
<%
}

else
	{
		
			 %>	
	<table border="1" cellspacing="2" cellpadding="3" colspan="5" width="95%" id="AutoNumber1"  height="26"  bordercolor="#96C8ED">
 	  <tr bgcolor="#429EDF">
						<td width="20%" height="23" bgcolor="#429EDF">
                        <p align="center"><b>
                        <font color="#FFFFFF" face="Arial" size="2">Student Name</font></td>
						<td width="20%" height="23" bgcolor="#429EDF" colspan="2">
						<p align="center">
						<font color="#FFFFFF" face="Arial" size="2"><b></b></font><font color="#FFFFFF"></b></font><p align="center">
						<font color="#FFFFFF" face="Arial" size="2"><b>Student ID</b></font><font color="#FFFFFF"></b></font></td>
						
						<td width="20%" height="23" bgcolor="#429EDF">
						<p align="center">
						<b>
						<font color="#FFFFFF" face="Arial" size="2">By Attempt</b></font></td>
						<td width="20%" height="23" bgcolor="#429EDF">
						<p align="center">
						<b>
						<font color="#FFFFFF" face="Arial" size="2">By Attempt Grade</b></font></td>
						<td width="20%" height="23" bgcolor="#429EDF">
						<p align="center">
						<b>
						<font color="#FFFFFF" face="Arial" size="2">Total</b></font></td>
						<td width="20%" height="23" bgcolor="#429EDF">
						<p align="center">
						<b>
						<font color="#FFFFFF" face="Arial" size="2">Grade</b></font></td></tr>
					 <tr >
						<td width="20%" height="23"><font  face="Arial" size="2"><%=fName%>&nbsp;<%=lName%></font></td>
						<td width="2%" height="23"><a href="InstantMessage.jsp?emailid=<%=email%>&studentid=<%= studentId %>&fname=<%=fName%>&lname=<%=lName%>"><img border="0" src="images/email.png" width="16" height="16" alt="Send an Instant Mail"></a></td>
						
 
<%  
			// rs2=st2.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) as sum1,sum(`"+schoolId+"_cescores`.`total_marks`) as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`report_status`=1 and (`"+schoolId+"_cescores`.`status`=1 ||`"+schoolId+"_cescores`.`status`=2) group by `"+schoolId+"_cescores`.`category_id`");

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
						<!-- <td width="20%"><p align="center"><font  face="Arial" size="2"><%=report.trimFloat(percentageTotal)%>&nbsp;%</td>
						<td width="20%"><p align="center"><font  face="Arial" size="2" color="brown"><b><%=grade%></b></font></td>
						</tr> -->
					
						<td width="20%" height="23"><font  face="Arial" size="2"><a href="MainStudentScores.jsp?courseid=<%=courseId%>&studentid=<%=studentId%>&perctByatt=<%=report.trimFloat(TotalMarkingPercentageByAttempt)%>&grdByatt=<%=gradeByAttempt%>&classid=C000"><%=studentId%></font></a></td>

						<td width="20%"><p align="center"><font  face="Arial" size="2"><%=report.trimFloat(TotalMarkingPercentageByAttempt)%>&nbsp;%</td>
						<td width="20%"><p align="center"><font  face="Arial" size="2" color="brown"><b><%=gradeByAttempt%></b></font></td>
						<td width="20%"><p align="center"><font  face="Arial" size="2"><%=report.trimFloat(percentageTotal)%>&nbsp;%</td>
						<td width="20%"><p align="center"><font  face="Arial" size="2" color="brown"><b><%=grade%></b></font></td>

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
					/*rs9=st9.executeQuery("SELECT grade_code from class_grades where schoolid='"+schoolId+"' and "+percent+"<minimum and "+percent+">maximum");
					while(rs9.next())
					{
						grade=rs9.getString("grade_code");
					}*/
					fg=new FindGrade();
					centMarks=fg.convertToCent(wghtSecTotal,wghtTotal);
					grade=fg.getGrade(schoolId,classId,courseId,centMarks);
					if(percentageTotal>100)
                         grade="A+";
		%>		<td width="20%" height="23"><p align="center"><font  face="Arial" size="2">&nbsp;No Assignments&nbsp;</td>
						<td width="20%" height="23"><p align="center"><font  face="Arial" size="2" color="brown"><B>---</B></td></tr>
<%			 }
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
		ExceptionsFile.postException("OverallSummary3.jsp","operations on database","Exception",e.getMessage());
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
			if(st8!=null)
				st8.close();
			if(st6!=null)
				st6.close();
			if(st9!=null)
				st9.close();
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
       	var gradeObj=document.grstudselectfrm.gradeid;
		var studentObj=document.grstudselectfrm.studentid;
		var cid=gradeObj.value;
		var studentid=studentObj.value;
		document.location.href="OverallSummary3.jsp?userid=<%=teacherId%>&courseid="+cid+"&sid="+studentid;
		
	}
function change(grade1)
{
	if(grade1!='no')
	{
		grades=grade1
		document.location.href="OverallSummary2.jsp?userid=<%=teacherId%>&courseid="+grade1;
	}
	else
	{
		
		grades='no';
		location.href="OverallSummary2.jsp?userid=<%=teacherId%>&courseid="+grade1;						
	}
}
function clear1() {
		var i;
		var temp=document.grstudselectfrm.studentid;
		for (i=temp.length;i>0;i--){
			if(temp.options[i]!=null){
				temp.options[i]=null;
			}
		}
	}

</script>
</html>