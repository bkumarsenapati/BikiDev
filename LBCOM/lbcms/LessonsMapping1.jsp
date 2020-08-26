<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile,exam.FindGrade" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page"/>

<%
	String schoolId="",classId="",teacherId="",courseId="",courseName="",crsId="",studentId="",fname="",lname="";
	String query=null,ex="0",as="0",tmpusr="",smarks="",percentage2="",email="",grade="";
	
	String cId="",sId="",catId="",temp="",catType="",grSys="",status="",color="";
	FindGrade fg;
	int wght=0;
	float centMarks,a=0.0f,b=0.0f,c=0.0f,d=0.0f,f=0.0f;
	float totalmarks=0.0f,securedmarks=0.0f,percentage1=0.0f;
	float sumofSecuredPoints=0.0f,sumofTotalPoints=0.0f,percentage=0.0f,percentageTotal=0.0f,wghtTotal=0.0f,wghtSecTotal=0.0f;
	ResultSet  rs=null,rs1=null,rs2=null,rs3=null,rs4=null;
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null;
	boolean flag=false;
	int i=0,j=0;

	try
	{
		session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		classId=request.getParameter("classid");
		String user_id=request.getParameter("user");
		String marking_id=request.getParameter("m_id");
		String act=request.getParameter("act");
		String act_schoolId=(String)session.getAttribute("schoolid");
		schoolId = (String)session.getAttribute("schoolid");
		teacherId = (String)session.getAttribute("emailid");
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("courseName");
		if(courseId == null)
			courseId="selectcourse";     

		studentId=request.getParameter("studentid");
		if(studentId == null)
			studentId="selectstudent";   

		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		st4=con.createStatement();

		rs=st.executeQuery("select * from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"' and status>0 order by course_id");	
%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Main Student Score</title>
<SCRIPT LANGUAGE="JavaScript">
<!--

function goCourse()
{
	var courseId=document.studentscores.courselist.value;
	window.location="MainStudentScores1.jsp?courseid="+courseId + "&classid=C000&dcourse=dcourse";
}
function goStudent()
{
	var courseId=document.studentscores.courselist.value;
	var studentId=document.studentscores.studentlist.value;
	if((courseId.value!="")&&(studentId.value!=""))	
	window.location="MainStudentScores1.jsp?courseid="+courseId+"&studentid="+studentId + "&classid=C000";
}
</SCRIPT>
</head>
<body>
<form name="studentscores" method="POST" action="--WEBBOT-SELF--"><BR>

<div align="center">
  <center>
<table border="0" cellspacing="0" width="95%" bgcolor="#429EDF" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" height="28">
  <tr>
    <td width="50%" height="24"><b>
    &nbsp;<font face="Arial" size="2" color="#FFFFFF">Student Scores</font></b></td>
    <td width="50%" height="24" align="right">
	<%
	if(!studentId.equals("selectstudent") && !studentId.equals("allstudents")){
	%><a href="javascript:window.print()"><img border="0" src="images/printer22.png" width="22" height="22" BORDER="0" ALT="Print"></a><%}%>&nbsp;&nbsp;<% if(request.getParameter("catType")!=null || request.getParameter("sid")!=null) {
	%>	
	<a href="#" onclick="javascript:history.back();"><IMG SRC="images/back.png" WIDTH="22" HEIGHT="22" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>
	<%  }
		else{ 
		%>
		<a href="index.jsp?userid=<%=teacherId%>"><IMG SRC="images/back.png" WIDTH="22" HEIGHT="22" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a> <% } %>&nbsp;
	</td>
  </tr>
</table>
</center>
</div>
<br>
<div align="center">
<center>
<table border="0" cellspacing="0" width="95%" id="AutoNumber1" bgcolor="#429EDF" height="26" style="border-collapse: collapse" bordercolor="#111111" cellpadding="5">
  <tr>
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
			document.studentscores.courselist.value="<%=courseId%>";	
		</script> 
	</td>
	<td width="30%" height="23" colspan="2" bgcolor="#96C8ED" align="right">
		<select id="studentlist" style="width:200px" name="studentlist" onchange="goStudent();">
		<option value="selectstudent" selected>Select Student</option>
<%
			//rs=st.executeQuery("select student_id from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"' order by student_id");
			rs=st.executeQuery("select grade, username, fname, lname from studentprofile where schoolid='"+schoolId+"'  and crossregister_flag in(0,1,2) and username= any(select distinct(student_id) from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"' ORDER BY fname,lname)");
			if(!courseId.equals("selectcourse"))
				{	
					out.println("<option value='allstudents'>List All Students</option>");

		while(rs.next())
			{
				if(!rs.getString(1).equals("C000_vstudent"))
				{
				out.println("<option value='"+rs.getString("username")+"'>"+rs.getString("fname")+"&nbsp;&nbsp;"+rs.getString("lname")+"</option>");
				}
			}
		}
			rs.close();
%>
		</select>
		 <script>
			document.studentscores.studentlist.value="<%=studentId%>";	
		</script> 
		</td>
</tr>
<%
	if(!studentId.equals("allstudents"))
		{
			if(courseId.equals("selectcourse") || studentId.equals("selectstudent"))
				{
%>
<tr>
    <td width="60%" height="23" colspan="4" bgcolor="#FFFFFF">
  </tr>
  <tr>
    <td width="21%" height="23"><font color="#FFFFFF" face="Arial" size="2"><b>Student Name</b></font></td>
    <td width="19%" height="23" colspan="2"><b>
    <font color="#FFFFFF" face="Arial" size="2">Student ID </font></b></td>
    <td width="20%" height="23">
    <p align="left"><font color="#FFFFFF" face="Arial" size="2"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </b></font><b><font color="#FFFFFF" face="Arial" size="2"></font></b></td>
  </tr>
</table>
</center>
</div>
<%
		if(request.getParameter("dcourse")!=null)
					{
%>
<tr>
				<td width="100%" colspan="5">
					<font face="Arial" size="2"><center><strong>Please select a Student</strong></center></font>
				</td>
			</tr>
<%
	}
else{		
%>
<tr>
				<td width="100%" colspan="5">
					<font face="Arial" size="2"><center><strong>Please select a Course and  a Student</strong></center></font>
				</td>
			</tr>
<%
	}
				}
	else 
	{		
%>
<%
				rs1=st1.executeQuery("select  fname,lname,con_emailid from studentprofile where username='" +studentId +"'" );
				while(rs1.next())
					{
					fname=rs1.getString("fname");
					lname=rs1.getString("lname");
					email=rs1.getString("con_emailid");
					}
%>
<%
	//rs3=st3.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) as sum1,sum(`"+schoolId+"_cescores`.`total_marks`) as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`report_status`=1 and (`"+schoolId+"_cescores`.`status`=1 ||`"+schoolId+"_cescores`.`status`=2) group by `"+schoolId+"_cescores`.`category_id`");

	 rs3=st3.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) as sum1,sum(`"+schoolId+"_cescores`.`total_marks`) as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`report_status`=1 and ((`"+schoolId+"_cescores`.`status`=1 ||`"+schoolId+"_cescores`.`status`=2)|| (`"+schoolId+"_cescores`.`status`=0 && `"+schoolId+"_cescores`.`end_date`<curdate())) group by `"+schoolId+"_cescores`.`category_id`");
 							
							sumofSecuredPoints=0.0f;

							while(rs3.next())
							{
								catId=rs3.getString("category_id");
								
								rs4=st4.executeQuery("select * from category_item_master where school_id='"+schoolId+"' and course_id='"+courseId+"' and item_id='"+catId+"'");
								if(rs4.next())
								{
									catType=rs4.getString("item_des");
									grSys=rs4.getString("grading_system");
									wght=rs4.getInt("weightage");
								}
								rs4.close();
		
						temp=rs3.getString("sum1");
						sumofSecuredPoints=Float.parseFloat(rs3.getString("sum1"));
						sumofTotalPoints=Float.parseFloat(rs3.getString("sum2"));
						sumofSecuredPoints+=sumofSecuredPoints;
						sumofTotalPoints+=sumofTotalPoints;
						   if(sumofTotalPoints!=0)
							  {
							wghtTotal=wghtTotal+wght;
							
							percentage=(sumofSecuredPoints/sumofTotalPoints)*wght;
							  }
							percentageTotal+=percentage;
							
							if(grSys.equals("2"))
							{
								wghtTotal=wghtTotal-wght;
							}
							wghtSecTotal=wghtSecTotal+percentage;
							j++;
							
				}
%>
<tr>
  <td width="100%" colspan="4" bgcolor="#FFFFFF">
  </tr> 
  
  <tr>
  <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="95%" id="AutoNumber1" height="23">
  <tr>
    <td width="05%" align="left"><b><font face="Arial" size="2">Student Name:</font></b></td>
    <td width="05%" align="left"><font face="Arial" size="2"><%=fname%>&nbsp;<%=lname%></font></td>
    <td width="03%" align="left"><b><font face="Arial" size="2">Student ID:</font></b></td>
    <td width="03%" align="left"><font face="Arial" size="2"><%= studentId %></font></td>
    <td width="01%"><font face="Arial" size="2">
    <a href="InstantMessage.jsp?emailid=<%=email%>&studentid=<%= studentId %>&fname=<%=fname%>&lname=<%=lname%>"><img border="0" src="images/email.png" width="16" height="16" alt="Send an Instant Mail"></a></font></td>
    <td width="01%" align="right">
    <p align="right"><b><font face="Arial" size="2">Total:&nbsp;&nbsp;</font></b></td>
    <td width="08%" align="right">
	<%
		percentageTotal=(percentageTotal/wghtTotal)*100;
		c=percentageTotal;
				if(j!=0)
				{
					fg=new FindGrade();
					centMarks=fg.convertToCent(wghtSecTotal,wghtTotal);
					grade=fg.getGrade(schoolId,classId,courseId,centMarks);
					if(c>100)
                         grade="A+";
					%>
    <p align="left"><font face="Arial"size="2">
<FONT SIZE="2" COLOR="#FF0033"><B><%=report.trimFloat(percentageTotal)%>%</B></FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<b>Grade:</b>&nbsp;&nbsp;<FONT SIZE="2" COLOR="#FF0033"><B><%=grade%></B></FONT>
	
	</font></td>
  </tr>
		<%
		}
		else
		{	
					fg=new FindGrade();
					centMarks=fg.convertToCent(wghtSecTotal,wghtTotal);
					grade=fg.getGrade(schoolId,classId,courseId,centMarks);
		%>		 <p align="Left"><font face="Arial"size="2">
	
<%=report.trimFloat(percentageTotal)%>%&nbsp;&nbsp;<b>Grade:</b>&nbsp;&nbsp;<%=grade%>
	
	</font></td></tr>
<%	
		}
%>
<tr>
    <td width="95%" align="right" colspan="7"><font face="verdana" size="1" color="#9900CC">Here the percentage is calculated based on the weightages of the respective categories!</font></td>
 </tr>
	</table>
  
				<%
				if(!schoolId.equals(act_schoolId))
						tmpusr=act_schoolId+"_"+studentId;
				else
						tmpusr=studentId;
				String pretest="category_item_master.grading_system!=0 and ";
				 String na="and ((act.t_date between '2008-09-01' and '2009-9-1')or(cescores.submit_date between '2008-09-01' and '2009-9-1')) ";
				 pretest="";
				 na="";



//	query="SELECT act.activity_id,act.Activity_name,act.activity_type, CASE WHEN category_item_master.grading_system=0 then '#A9A9A9' else 'Black' end as grading_system,(select marks_total from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id=cescores.work_id limit 1) as  marks_totalAS,CASE WHEN cescores.category_id='EC' THEN CONCAT('<strike>',cescores.total_marks,'</strike>') WHEN cescores.status=3 THEN CONCAT('<U>',cescores.total_marks,'</U>') else cescores.total_marks end as total_marks,CASE WHEN DATE_FORMAT(cescores.submit_date,'%m/%d/%Y')= '00/00/0000'  THEN '---' WHEN cescores.status='1'  THEN CONCAT(cescores.marks_secured,'*') WHEN cescores.status='3'  THEN '*' ELSE cescores.marks_secured  END AS marks_secured,IF(DATE_FORMAT(cescores.submit_date, '%m/%d/%Y')='00/00/0000' ,'Not Attempted',DATE_FORMAT(cescores.submit_date, '%m/%d/%Y')) as s_date,DATE_FORMAT(act.t_date, '%m/%d/%Y') as t_date  FROM "+schoolId+"_cescores as cescores,"+schoolId+"_activities act ,category_item_master WHERE cescores.work_id=act.activity_id and category_item_master.item_id=cescores.category_id and  category_item_master.school_id=cescores.school_id  and category_item_master.course_id=cescores.course_id and "+pretest+"  cescores.course_id=act.course_id and cescores.user_id='"+tmpusr+"' and cescores.course_id='"+courseId+"' and cescores.report_status=1 and cescores.status<3 and cescores.school_id='"+schoolId+"'  order by act.Activity_name,category_item_master.grading_system";

query="SELECT act.activity_id,act.Activity_name,act.activity_type,act.activity_sub_type,cescores.category_id, CASE WHEN category_item_master.grading_system=0 then '#A9A9A9' else 'Black' end as grading_system,(select marks_total from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id=cescores.work_id limit 1) as  marks_totalAS,CASE WHEN cescores.category_id='EC' THEN CONCAT('<strike>',cescores.total_marks,'</strike>') WHEN cescores.status=3 THEN CONCAT('<U>',cescores.total_marks,'</U>') else cescores.total_marks end as total_marks,CASE WHEN((DATE_FORMAT(cescores.submit_date, '%m/%d/%Y')='00/00/0000') and cescores.end_date<curdate()) THEN '0' WHEN DATE_FORMAT(cescores.submit_date,'%m/%d/%Y')= '00/00/0000'  THEN '---'  WHEN cescores.status='1'  THEN CONCAT(cescores.marks_secured,'*') WHEN cescores.status='3'  THEN '*'  ELSE cescores.marks_secured  END AS marks_secured,CASE WHEN DATE_FORMAT(cescores.submit_date, '%m/%d/%Y')='00/00/0000'  and cescores.end_date<curdate() THEN CONCAT('<font color=red>','Due Date Passed','</font>') WHEN DATE_FORMAT(cescores.submit_date, '%m/%d/%Y')='00/00/0000' THEN 'Not Attempted' ELSE DATE_FORMAT(cescores.submit_date, '%m/%d/%Y') END as s_date,DATE_FORMAT(act.t_date, '%m/%d/%Y') as t_date  FROM "+schoolId+"_cescores as cescores,"+schoolId+"_activities act ,category_item_master WHERE cescores.work_id=act.activity_id and category_item_master.item_id=cescores.category_id and  category_item_master.school_id=cescores.school_id  and category_item_master.course_id=cescores.course_id and "+pretest+"  cescores.course_id=act.course_id and cescores.user_id='"+tmpusr+"' and cescores.course_id='"+courseId+"' and cescores.report_status=1 and cescores.status<3 and cescores.school_id='"+schoolId+"'  order by act.Activity_name,category_item_master.grading_system";

	 rs2=st2.executeQuery(query);	

%>
<div align="center">
  <center>
<table border="1" cellspacing="2" cellpadding="3" colspan="4" width="95%" id="AutoNumber1"  height="26"  bordercolor="#96C8ED">
  <tr>
    <td width="25%" align="center" bgcolor="#96C8ED" height="1">
    <p align="left"><b>
    <font face="Arial" size="2">Assignment/Assessment Name</font></b></td>
    <td width="13%" align="center" bgcolor="#96C8ED" height="1"><b>
    <font face="Arial" size="2">Points Possible</font></b></td>
    <td width="14%" align="center" bgcolor="#96C8ED" height="1"><b>
    <font face="Arial" size="2">Points Secured</font></b></td>
    <td width="14%" align="center" bgcolor="#96C8ED" height="1"><b>
    <font face="Arial" size="2">Submission Date</font></b></td>
  </tr>
 <%
					sumofSecuredPoints=0.0f;
					sumofTotalPoints=0.0f;

	while(rs2.next())
				{
	                      i++;
					if(rs2.getString("activity_type").equals("AS"))
						{
						totalmarks=Float.parseFloat(rs2.getString("total_marks"));
						}
						else
						totalmarks=Float.parseFloat(rs2.getString("total_marks"));
	
							if(rs2.getString("activity_type").equals("AS"))
						{
							if(rs2.getString("marks_secured").equals("---"))
								{
									smarks=rs2.getString("marks_secured").replace('*','\0');
									percentage2="N/A";
								}
								else
								{
									securedmarks=Float.parseFloat(rs2.getString("marks_secured").replace('*','\0'));
									percentage1=(securedmarks*100)/totalmarks;

									smarks=Float.toString(securedmarks);
									percentage2=Float.toString(percentage1)+"%";

									sumofSecuredPoints +=Float.parseFloat(rs2.getString("marks_secured").replace('*','\0'));
										sumofTotalPoints +=totalmarks;
								}
							}
						else
							{
									if(rs2.getString("marks_secured").equals("---"))
									{
										smarks=rs2.getString("marks_secured").replace('*','\0');
										percentage2="N/A";
									}
									else
									{
										securedmarks=Float.parseFloat(rs2.getString("marks_secured").replace('*','\0'));
										percentage1=(securedmarks*100)/totalmarks;

										smarks=Float.toString(securedmarks);
										percentage2=Float.toString(percentage1)+"%";

										sumofSecuredPoints +=Float.parseFloat(rs2.getString("marks_secured").replace('*','\0'));
										sumofTotalPoints +=totalmarks;
									}
								}
							
%>
  <tr>
    <td width="25%" height="19"><font face="Arial" size="2">&nbsp;<%=rs2.getString("Activity_name")%></font></td>
    <td width="13%" height="19" align="center"><font face="Arial" size="2"><%=totalmarks%></font></td>
    <td width="14%" height="19" align="center"><font face="Arial" size="2"><%=rs2.getString("marks_secured")%>  </font></td>
    <td width="14%" height="19" align="center"><font size="2" face="Arial">	<%=rs2.getString("s_date")%></font></td>
  </tr>
<%   
	}
%>
<tr>
    <td width="25%" align="left" bgcolor="#96C8ED" height="1"><b><font face="Arial" size="2">&nbsp;Total :</font></b></td>
    <td width="13%" align="center" bgcolor="#96C8ED" height="1"><b><font face="Arial" size="2" color="#FF0033"><%=sumofTotalPoints%></font></b></td>
    <td width="14%" align="center" bgcolor="#96C8ED" height="1"><b><font face="Arial" size="2" color="#FF0033"><%=sumofSecuredPoints%>  </font></b></td>
    <td width="14%" align="center" bgcolor="#96C8ED" height="1"><font size="2" face="Arial">	&nbsp;</font></td>
  </tr>
</table>
<%
	if(i==0)
		{
%>
			<tr>
					<td width="100%" colspan="4"><BR>
					<font face="Arial" size="2"><center><strong>There are no assignments available</strong></center></font>
					</td>
			</tr>
			</table>
<%		
			}
		}   
	}
%>
<%
		if(courseId.equals(""+courseId+"") && studentId.equals("allstudents"))
		{		
			rs=st.executeQuery("select student_id,course_id from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"' order by student_id");
%>

<table border="1" cellspacing="2" cellpadding="3" colspan="4" width="95%" id="AutoNumber2"  height="26"  bordercolor="#96C8ED">
<tr>
    <td width="100%" colspan="4" bgcolor="#FFFFFF">
    </td>
  </tr>
  <tr bgcolor="#429EDF">
     <td width="100%" height="23" colspan="4"><b>
    <font color="#FFFFFF" face="Arial" size="2"><center>List of All Students</center></font></b></td>
</tr>
<%
     while(rs.next()){
	try{
			if(!rs.getString(1).equals("C000_vstudent")){
%>
<tr align="center" >
     <td width="15%" height="23" colspan="1" bgcolor="#FFFFFF" >&nbsp;&nbsp;
    <a href="MainStudentScores1.jsp?courseid=<%=courseId%>&studentid=<%=rs.getString(1)%>&classid=C000&sid=all">
	<font  face="Arial" size="2"><%=rs.getString(1)%></font></a>
	</td>
<%
		
		if(rs.next()){
		%>
      <td width="15%" height="23" colspan="1" bgcolor="#FFFFFF" >&nbsp;&nbsp;
    <a href="MainStudentScores1.jsp?courseid=<%=courseId%>&studentid=<%=rs.getString(1)%>&classid=C000&sid=all">
	<font  face="Arial" size="2"><%=rs.getString(1)%></font></a>
	</td>
		<%
	}
	if(rs.next()){
		%>
      <td width="15%" height="23" colspan="1" bgcolor="#FFFFFF" >&nbsp;&nbsp;
    <a href="MainStudentScores1.jsp?courseid=<%=courseId%>&studentid=<%=rs.getString(1)%>&classid=C000&sid=all">
	<font  face="Arial" size="2"><%=rs.getString(1)%></font></a>
	</td>
		<%
	}
	if(rs.next()){
		%>
      <td width="15%" height="23" colspan="1" bgcolor="#FFFFFF" >&nbsp;&nbsp;
    <a href="MainStudentScores1.jsp?courseid=<%=courseId%>&studentid=<%=rs.getString(1)%>&classid=C000&sid=all">
	<font  face="Arial" size="2"><%=rs.getString(1)%></font></a>
	</td>
	</tr>
			<%
	}
	}
	}
	catch(Exception e){
		%>
        <td width="15%" height="23" colspan="1" bgcolor="#FFFFFF" >&nbsp;&nbsp;</td></tr>
		
		<%
			}
		}
	
%>
</table>
<%
}	
%>
<%
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
			if(st4!=null)
				st4.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}
		catch(SQLException se){
			ExceptionsFile.postException("MainStudentScores1.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
%>
</table>
</center>
</div>

</form>
</body>
</html>