<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile,exam.FindGrade" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page"/>

<%
	String schoolId="",classId="",teacherId="",courseId="",courseName="",crsId="",studentId="",fname="",lname="",sfname="",slname="";
	String query=null,ex="0",as="0",tmpusr="",smarks="",percentage2="",email="",semail="",grade="";
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
		//teacherId = (String)session.getAttribute("emailid");
		courseId=request.getParameter("courseid");
		//courseName=request.getParameter("courseName");
		if(courseId == null)
			courseId="selectcourse";     

		studentId=(String)session.getAttribute("emailid");
		 

		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		st4=con.createStatement();

		rs=st.executeQuery("select c.course_name,c.course_id,c.teacher_id from coursewareinfo c inner join coursewareinfo_det d  on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+studentId+"' and c.status=1 and c.school_id='"+schoolId+"' and d.school_id='"+schoolId+"' order by c.course_id");	
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
	if(courseId.value!="")
	window.location.href="MainStudentScores.jsp?courseid="+courseId+"&studentid="+'<%=studentId%>'+"&classid=C000&dcourse=dcourse";
}

</SCRIPT>
</head>
<body>
<form name="studentscores" method="POST" action="--WEBBOT-SELF--"><BR>

<div align="center">
  <center>
<table border="0" width="90%" bgcolor="#429EDF" bordercolor="#111111" height="28">
  <tr>
    <td width="50%" height="24">&nbsp; <b>
    <font face="Verdana" size="2" color="#FFFFFF">&nbsp;Student Scores</font></b></td>
    <td width="50%" height="24" align="right">
	<%
	if(!courseId.equals("selectcourse") && !courseId.equals("allcourses")){
	%><a href="javascript:window.print()"><img border="0" src="images/print.jpg" width="20" height="15" BORDER="0" ALT="Print"></a><%}%>&nbsp;&nbsp;<% if(request.getParameter("B")!=null){ %> 
		
		<a href="#" onclick="javascript:history.back();"><IMG SRC="images/back.jpg" WIDTH="20" HEIGHT="15" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a><% } else{ %>
		<a href="index.jsp?userid=<%=studentId%>"><IMG SRC="images/back.jpg" WIDTH="20" HEIGHT="15" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a><% } %>&nbsp;
	</td>
  </tr>
</table>
</center>
</div>
<br>
<div align="center">
<center>
<table border="0" cellspacing="0" width="90%" id="AutoNumber1" bgcolor="#429EDF" height="26" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0">
  <tr  bgcolor="#96C8ED">
    <td width="30%" height="23" colspan="4">
		<select id="courselist" name="courselist" onchange="goCourse(); return false;">
			<option value="selectcourse" selected>Select A Course</option>
			<option value="allcourses">List All Courses</option>
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
	
</tr>
<%
	if(!courseId.equals("allcourses"))
		{
			if(courseId.equals("selectcourse"))
				{
%>
<tr>
    <td width="60%" height="23" colspan="4" bgcolor="#FFFFFF">
    <hr color="#F16C0A"></td>
  </tr>
  <tr>
    <td width="21%" height="23"><font color="#FFFFFF" face="Verdana" size="2"><b>&nbsp;Student Name</b></font></td>
    <td width="19%" height="23" colspan="2"><b>
    <font color="#FFFFFF" face="Verdana" size="2"> Teacher ID </font></b></td>
    <td width="20%" height="23">
    <p align="left"><font color="#FFFFFF" face="Verdana" size="2"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </b></font><b><font color="#FFFFFF" face="Verdana" size="2"></font></b></td>
  </tr>
</table>
</center>
</div>
<%
		if(request.getParameter("dcourse")==null)
					{
%>
<tr>
				<td width="100%" colspan="5">
					<font face="Verdana" size="2"><center>-*****-Please select a course.-*****-</center></font>
				</td>
			</tr>
<%
	}
}
	else 
	{		
%>
<%
                  rs=st.executeQuery("select  t.firstname,t.lastname,t.con_emailid,t.username from teachprofile t,coursewareinfo c where t.schoolid='"+schoolId+"' and c.school_id='"+schoolId+"' and  t.username=c.teacher_id and c.course_id='"+courseId+"'" );
				  while(rs.next())
					{
					fname=rs.getString("firstname");
					lname=rs.getString("lastname");
					email=rs.getString("con_emailid");
					
                  rs1=st1.executeQuery("select  fname,lname,con_emailid from studentprofile where username='" +studentId +"' and schoolid='" +schoolId +"'" );
				while(rs1.next())
					{
					sfname=rs1.getString("fname");
					slname=rs1.getString("lname");
					semail=rs1.getString("con_emailid");
					}
%>
<%
	//rs4=st4.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) as sum1,sum(`"+schoolId+"_cescores`.`total_marks`) as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`report_status`=1 and (`"+schoolId+"_cescores`.`status`=1 ||`"+schoolId+"_cescores`.`status`=2) group by `"+schoolId+"_cescores`.`category_id`");

	rs4=st4.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) as sum1,sum(`"+schoolId+"_cescores`.`total_marks`) as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`report_status`=1 and ((`"+schoolId+"_cescores`.`status`=1 ||`"+schoolId+"_cescores`.`status`=2)|| (`"+schoolId+"_cescores`.`status`=0 && `"+schoolId+"_cescores`.`end_date`<curdate())) group by `"+schoolId+"_cescores`.`category_id`");
 							
							sumofSecuredPoints=0.0f;

							while(rs4.next())
							{
								catId=rs4.getString("category_id");
								
								rs3=st3.executeQuery("select * from category_item_master where school_id='"+schoolId+"' and course_id='"+courseId+"' and item_id='"+catId+"'");
								if(rs3.next())
								{
									catType=rs3.getString("item_des");
									grSys=rs3.getString("grading_system");
									wght=rs3.getInt("weightage");
								}
								rs3.close();
		
			temp=rs4.getString("sum1");
			sumofSecuredPoints=Float.parseFloat(rs4.getString("sum1"));
			sumofTotalPoints=Float.parseFloat(rs4.getString("sum2"));	
//a=sumofSecuredPoints;
//b=sumofTotalPoints;
                       
					sumofSecuredPoints=+sumofSecuredPoints;
						sumofTotalPoints=+sumofTotalPoints;
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
    <td width="60%" height="23" colspan="4" bgcolor="#FFFFFF">
    <hr color="#F16C0A"></td>
  </tr>
  <tr>
    <td width="21%" height="23"><font color="#FFFFFF" face="Verdana" size="2"><b>&nbsp;<%=sfname%>&nbsp;<%=slname%></b></font></td>
    <td width="19%" height="23"><b>
    <font color="#FFFFFF" face="Verdana" size="2">&nbsp;<%=fname%>&nbsp;<%=lname%>&nbsp;&nbsp;&nbsp;<a href="InstantMessage.jsp?emailid=<%=email%>&teacherid=<%= rs.getString("username") %>&fname=<%=fname%>&lname=<%=lname%>"><img border="0" src="images/m1.jpg" width="19" height="14" alt="Send an Instant Mail"></a></font></b></td>
    <td width="20%" height="1">
    <p align="center"><font color="#FFFFFF" face="Verdana" size="2"><div id="<%=courseId%>"></div></td>
  </tr>
  <%
		percentageTotal=(percentageTotal/wghtTotal)*100;
							
				if(j!=0)
				{
					fg=new FindGrade();
					centMarks=fg.convertToCent(wghtSecTotal,wghtTotal);
					grade=fg.getGrade(schoolId,classId,courseId,centMarks);
					if(percentageTotal>=100)
                         grade="A+";
		

%>
  		  <tr>
		  <td width="20%" height="0">
		  <SCRIPT LANGUAGE="JavaScript">
					
						document.getElementById("<%=courseId%>").innerHTML="<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color=#FFFFFF face='Verdana' size='2'>Total:</font>&nbsp;&nbsp;&nbsp;</b></font><b><font color=#800000 face='Verdana' size='2'><%=report.trimFloat(percentageTotal)%>%&nbsp;&nbsp;<%=grade%></font></b>";
					
					</SCRIPT>
					</td>
						 </tr>
	<%	
		}
			else
			 {		
				fg=new FindGrade();
					centMarks=fg.convertToCent(wghtSecTotal,wghtTotal);
					grade=fg.getGrade(schoolId,classId,courseId,centMarks);
		%>		<tr>
		  <td width="20%" height="0">
		  <SCRIPT LANGUAGE="JavaScript">
					
						document.getElementById("<%=courseId%>").innerHTML="<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color=#FFFFFF face='Verdana' size='2'>Total:</font>&nbsp;&nbsp;&nbsp;</b></font><b><font color=#800000 face='Verdana' size='2'><%=report.trimFloat(percentageTotal)%>%&nbsp;&nbsp;<%=grade%></font></b>";
					
					</SCRIPT>
					</td>
						 </tr>
<%			 }
		
		}
	}
				if(!schoolId.equals(act_schoolId))
						tmpusr=act_schoolId+"_"+studentId;
					else
						tmpusr=studentId;
				String pretest="category_item_master.grading_system!=0 and ";

					
    // query="SELECT act.activity_id,act.Activity_name,act.activity_type, CASE WHEN category_item_master.grading_system=0 then '#A9A9A9' else 'Black' end as grading_system,(select marks_total from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id=cescores.work_id limit 1) as  marks_totalAS,CASE WHEN cescores.category_id='EC' THEN CONCAT('<strike>',cescores.total_marks,'</strike>') WHEN cescores.status=3 THEN CONCAT('<U>',cescores.total_marks,'</U>') else cescores.total_marks end as total_marks,( select   CASE WHEN DATE_FORMAT(submitted_date,'%m/%d/%Y')= '00/00/0000'  then '---' ELSE   marks_secured end as markssecured from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id=cescores.work_id and  student_id=cescores.user_id order by marks_secured DESC LIMIT 1  ) as marks_securdAS,CASE  WHEN cescores.status='1'  THEN CONCAT(cescores.marks_secured,'*') WHEN cescores.status='3'  THEN '*' WHEN DATE_FORMAT(cescores.submit_date,'%m/%d/%Y')= '00/00/0000'  THEN '---' ELSE cescores.marks_secured  END AS marks_secured,IF(DATE_FORMAT(cescores.submit_date, '%m/%d/%Y')='00/00/0000' ,'Not&nbsp;Attempted',DATE_FORMAT(cescores.submit_date, '%m/%d/%Y')) as s_date,DATE_FORMAT(act.t_date, '%m/%d/%Y') as t_date  FROM "+schoolId+"_cescores as cescores,"+schoolId+"_activities act ,category_item_master WHERE cescores.work_id=act.activity_id and category_item_master.item_id=cescores.category_id and  category_item_master.school_id=cescores.school_id  and category_item_master.course_id=cescores.course_id and "+pretest+"  cescores.course_id=act.course_id and cescores.user_id='"+tmpusr+"' and cescores.course_id='"+courseId+"' and cescores.report_status=1 and cescores.status<3 and cescores.school_id='"+schoolId+"'  order by act.Activity_name,category_item_master.grading_system";

	query="SELECT act.activity_id,act.Activity_name,act.activity_type,act.activity_sub_type,cescores.category_id, CASE WHEN category_item_master.grading_system=0 then '#A9A9A9' else 'Black' end as grading_system,(select marks_total from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id=cescores.work_id limit 1) as  marks_totalAS,CASE WHEN cescores.category_id='EC' THEN CONCAT('<strike>',cescores.total_marks,'</strike>') WHEN cescores.status=3 THEN CONCAT('<U>',cescores.total_marks,'</U>') else cescores.total_marks end as total_marks,CASE WHEN((DATE_FORMAT(cescores.submit_date, '%m/%d/%Y')='00/00/0000') and cescores.end_date<curdate()) THEN '0' WHEN DATE_FORMAT(cescores.submit_date,'%m/%d/%Y')= '00/00/0000'  THEN '---'  WHEN cescores.status='1'  THEN CONCAT(cescores.marks_secured,'*') WHEN cescores.status='3'  THEN '*'  ELSE cescores.marks_secured  END AS marks_secured,CASE WHEN DATE_FORMAT(cescores.submit_date, '%m/%d/%Y')='00/00/0000'  and cescores.end_date<curdate() THEN CONCAT('<font color=red>','Due Date Passed','</font>') WHEN DATE_FORMAT(cescores.submit_date, '%m/%d/%Y')='00/00/0000' THEN 'Not Attempted' ELSE DATE_FORMAT(cescores.submit_date, '%m/%d/%Y') END as s_date,DATE_FORMAT(act.t_date, '%m/%d/%Y') as t_date  FROM "+schoolId+"_cescores as cescores,"+schoolId+"_activities act ,category_item_master WHERE cescores.work_id=act.activity_id and category_item_master.item_id=cescores.category_id and  category_item_master.school_id=cescores.school_id  and category_item_master.course_id=cescores.course_id and "+pretest+"  cescores.course_id=act.course_id and cescores.user_id='"+tmpusr+"' and cescores.course_id='"+courseId+"' and cescores.report_status=1 and cescores.status<3 and cescores.school_id='"+schoolId+"'  order by act.Activity_name,category_item_master.grading_system";

    
	 rs2=st2.executeQuery(query);	

%>
<div align="center">
  <center>
<table border="1" cellspacing="1" width="90%" id="AutoNumber2" height="25" bordercolorlight="#E6F2FF">
  <tr>
    <td width="25%" align="center" bgcolor="#96C8ED" height="1">
    <p align="left"><b>
    <font face="Verdana" size="2">&nbsp;Assignment/Assessment Name</font></b></td>
    <td width="13%" align="center" bgcolor="#96C8ED" height="1"><b>
    <font face="Verdana" size="2">Points Possible</font></b></td>
    <td width="14%" align="center" bgcolor="#96C8ED" height="1"><b>
    <font face="Verdana" size="2">Points Secured</font></b></td>
    <td width="14%" align="center" bgcolor="#96C8ED" height="1"><b>
    <font face="Verdana" size="2">Submission Date</font></b></td>
  </tr>
 <%
	while(rs2.next())
				{
	                      i++;
					if(rs2.getString("activity_type").equals("AS"))
						{
						totalmarks=Float.parseFloat(rs2.getString("marks_totalAS"));
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
									}
								}
                       							
%>
  <tr>
    <td width="25%" height="19"><font face="Verdana" size="2">&nbsp;<%=rs2.getString("Activity_name")%></font></td>
    <td width="13%" height="19" align="center"><font face="Verdana" size="2"><%=totalmarks%></font></td>
    <td width="14%" height="19" align="center"><font face="Verdana" size="2"><%=rs2.getString("marks_secured")%>  </font></td>
    <td width="14%" height="19" align="center"><font size="2" face="Verdana">	<%=rs2.getString("s_date")%></font></td>
  </tr>
<%   
	}
%>
</table>
<%
	if(i==0)
		{
%>
			<tr>
					<td width="100%" colspan="4"><BR>
					<font face="Verdana" size="2"><center>-*****-There are no assignments available.-*****-</center></font>
					</td>
			</tr>
			</table>
<%		
			}
		}   
	
%>
<%
		if(courseId.equals("allcourses"))
		{		
			rs=st.executeQuery("select c.course_name,c.course_id,c.teacher_id from coursewareinfo c inner join coursewareinfo_det d  on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+studentId+"' and c.status=1 and c.school_id='"+schoolId+"' and d.school_id='"+schoolId+"' order by c.course_id");
%>
<table border="1" cellspacing="1" width="90%" id="AutoNumber2" height="100" bordercolorlight="#E6F2FF">
<tr>
    <td width="60%" height="23" colspan="4" bgcolor="#FFFFFF">
    <hr color="#F16C0A"></td>
  </tr>
  <tr bgcolor="#429EDF">
     <td width="60%" height="23" colspan="4"><b>
    <font color="#FFFFFF" face="Verdana" size="2"><center>List Of All Courses</center></font></b></td>
</tr>
<%
     while(rs.next()){
	try{
			
%>
<tr>
     <td width="15%" height="23" colspan="1" bgcolor="#FFFFFF" >&nbsp;&nbsp;
    <a href="MainStudentScores.jsp?courseid=<%=rs.getString("course_id")%>&studentid=<%=studentId%>&B=b&classid=C000">
	<font  face="Verdana" size="2"><%=rs.getString("course_name")%></font></a>
	</td>
<%
		
		if(rs.next()){
		%>
      <td width="15%" height="23" colspan="1" bgcolor="#FFFFFF" >&nbsp;&nbsp;
    <a href="MainStudentScores.jsp?courseid=<%=rs.getString("course_id")%>&studentid=<%=studentId%>&B=b&classid=C000">
	<font  face="Verdana" size="2"><%=rs.getString("course_name")%></font></a>
	</td>
		<%
	}
	if(rs.next()){
		%>
      <td width="15%" height="23" colspan="1" bgcolor="#FFFFFF" >&nbsp;&nbsp;
    <a href="MainStudentScores.jsp?courseid=<%=rs.getString("course_id")%>&studentid=<%=studentId%>&B=b&classid=C000">
	<font  face="Verdana" size="2"><%=rs.getString("course_name")%></font></a>
	</td>
		<%
	}
	if(rs.next()){
		%>
      <td width="15%" height="23" colspan="1" bgcolor="#FFFFFF" >&nbsp;&nbsp;
    <a href="MainStudentScores.jsp?courseid=<%=rs.getString("course_id")%>&studentid=<%=studentId%>&B=b&classid=C000">
	<font  face="Verdana" size="2"><%=rs.getString("course_name")%></font></a>
	</td>
	</tr>
			<%
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
		
			if(con!=null && !con.isClosed())
				con.close();
			
		
		}
		catch(SQLException se){
			ExceptionsFile.postException("MainStudentScores.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
%>
</table>
</center>
</div>
<hr color="#F16C0A" width="90%" size="1">
</form>
</body>
</html>