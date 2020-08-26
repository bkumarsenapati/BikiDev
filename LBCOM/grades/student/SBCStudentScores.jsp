<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile,exam.FindGrade" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page"/>

<%
	String schoolId="",classId="",teacherId="",courseId="",courseName="",crsId="",studentId="",fname="",lname="",sfname="",slname="",semail="";
	String query=null,ex="0",as="0",tmpusr="",smarks="",percentage2="",email="",grade="",catName="";
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
		teacherId = request.getParameter("teacherid");
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("courseName");
		catName=request.getParameter("catName");
		studentId=request.getParameter("studentid");
		catType=request.getParameter("cattype");

		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		st4=con.createStatement();

		rs=st.executeQuery("select course_name from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"' and course_id='"+courseId+"'");	
		if(rs.next())
%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Student Summary By Category Scores</title>
</head>
<body>
<form name="studentscores" method="POST" action="--WEBBOT-SELF--"><BR>

<div align="center">
  <center>
<table border="0" width="90%" bgcolor="#429EDF" bordercolor="#111111" height="28">
  <tr>
  <td width="50%" height="24"><b>
    &nbsp;<font face="verdana" size="2" color="#FFFFFF">Student Summary By Category Scores</font></b></td>
    <td width="50%" height="24" align="right">
	<a href="javascript:window.print()"><img border="0" src="images/print.jpg" width="20" height="15" BORDER="0" ALT="Print"></a>&nbsp;&nbsp;
		
		<a href="#" onclick="javascript:history.back();"><IMG SRC="images/back.jpg" WIDTH="20" HEIGHT="15" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>&nbsp;
	</td>
  </tr>
</table>
</center>
</div>
<br>
<div align="center">
<center>
<table border="0" cellspacing="0" width="90%" id="AutoNumber1" bgcolor="#429EDF" height="26" style="border-collapse: collapse" bordercolor="#111111" cellpadding="5">
  <tr  bgcolor="#96C8ED">
  <td width="50%" height="24"><b><FONT SIZE="2" face="Verdana" COLOR="#990000">&nbsp;Course Name :</FONT><b>
    <font face="Verdana" size="2"><%=rs.getString("course_name")%></font></b></td>
	<td width="30%" height="23">
		
<b><FONT SIZE='' COLOR='#990000'>Category Name:</FONT>&nbsp;<%=catName%></b> 
		</td>
	</tr>
	</table>
</center>
</div>


<%
		String ctype=request.getParameter("catType");

		rs3=st3.executeQuery("select  fname,lname,con_emailid from studentprofile where username='" +studentId +"' and schoolid='"+schoolId+"'" );
				while(rs3.next())
					{
					sfname=rs3.getString("fname");
					slname=rs3.getString("lname");
					semail=rs3.getString("con_emailid");
					}
		rs3.close();
				rs1=st1.executeQuery("select  firstname,lastname,con_emailid from teachprofile where username='" +teacherId +"' and schoolid='"+schoolId+"'" );
				while(rs1.next())
					{
					fname=rs1.getString("firstname");
					lname=rs1.getString("lastname");
					email=rs1.getString("con_emailid");
					}
%>
<%

	rs3=st3.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) as sum1,sum(`"+schoolId+"_cescores`.`total_marks`) as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`report_status`=1  and  `"+schoolId+"_cescores`.category_id='"+ctype+"' and (`"+schoolId+"_cescores`.`status`=2||  `"+schoolId+"_cescores`.`end_date`<curdate()) group by `"+schoolId+"_cescores`.`category_id`");



							while(rs3.next())
							{
								
								//catId=rs3.getString("category_id");
								
								rs4=st4.executeQuery("select * from category_item_master where school_id='"+schoolId+"' and course_id='"+courseId+"' and item_id='"+ctype+"'");
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
						
						 sumofSecuredPoints=+sumofSecuredPoints;
						 sumofTotalPoints=+sumofTotalPoints;
						
						wghtTotal=wghtTotal+wght;

						if(wghtTotal==0.0f)
								{
                               percentage=(sumofSecuredPoints/sumofTotalPoints);
								}
								else
							percentage=(sumofSecuredPoints/sumofTotalPoints)*wght;
							
							percentageTotal=percentageTotal+percentage;
							
							if(grSys.equals("2"))
							{
								wghtTotal=wghtTotal-wght;
							}
							wghtSecTotal=wghtSecTotal+percentage;
							j++;
							
				}
				rs3.close();
%>
<div align="center">
<center>
<table border="0" cellspacing="0" width="90%" id="AutoNumber1" bgcolor="#429EDF" height="26" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0">
<tr>
    <td width="60%" height="10" colspan="4" bgcolor="#FFFFFF">
    <hr color="#F16C0A"></td>
  </tr>
  <tr >
    <td width="21%" height="23"><FONT SIZE="2" face="Verdana" COLOR="#990000">&nbsp;Student Name :</FONT><font color="#FFFFFF" face="Verdana" size="2"><b>&nbsp;<%=sfname%>&nbsp;<%=slname%></b></font></td>
    <td width="19%" height="23" colspan="2"><FONT SIZE="2" face="Verdana" COLOR="#990000">Teacher Name :</FONT>
    <font color="#FFFFFF" face="Verdana" size="2"><b><%=fname%>&nbsp;<%=lname%></b>&nbsp;&nbsp;&nbsp;<a href="InstantMessage.jsp?emailid=<%=email%>&teacherid=<%= teacherId %>&fname=<%=fname%>&lname=<%=lname%>"><img border="0" src="images/m1.jpg" width="19" height="14" alt="Send an Instant Mail"></a></font></b></td>
   <td width="20%" height="1">
    <p align="center"><font color="#FFFFFF" face="Verdana" size="2"><div id="<%=courseId%>"></div></td>
  </tr>
  </table>
</center>
</div>
<%

		if(wghtTotal==0.0f)
		{
             percentageTotal=(percentageTotal)*100;
		}
		else
			percentageTotal=(percentageTotal/wghtTotal)*100;

		//c=percentageTotal;

				if(j!=0)
				{
					fg=new FindGrade();
					centMarks=fg.convertToCent(wghtSecTotal,wghtTotal);
					grade=fg.getGrade(schoolId,classId,courseId,centMarks);
		    /*rs3=st3.executeQuery("SELECT grade_code from class_grades where schoolid='"+schoolId+"' and "+percentageTotal+" between minimum and maximum" );
			while(rs3.next()){
                            grade=rs3.getString("grade_code");
			}*/
 
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
  
				if(!schoolId.equals(act_schoolId))
						tmpusr=act_schoolId+"_"+studentId;
					else
						tmpusr=studentId;
				String pretest="";

				
    //query="SELECT act.activity_id,act.Activity_name,act.activity_type,act.activity_sub_type,cescores.category_id, CASE WHEN category_item_master.grading_system=0 then '#A9A9A9' else 'Black' end as grading_system,(select marks_total from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id=cescores.work_id limit 1) as  marks_totalAS,CASE WHEN cescores.category_id='EC' THEN CONCAT('<strike>',cescores.total_marks,'</strike>') WHEN cescores.status=3 THEN CONCAT('<U>',cescores.total_marks,'</U>') else cescores.total_marks end as total_marks,( select   CASE WHEN DATE_FORMAT(submitted_date,'%m/%d/%Y')= '00/00/0000'  then '---' ELSE   marks_secured end as markssecured from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id=cescores.work_id and  student_id=cescores.user_id order by marks_secured DESC LIMIT 1  ) as marks_securdAS,CASE  WHEN cescores.status='1'  THEN CONCAT(cescores.marks_secured,'*') WHEN cescores.status='3'  THEN '*' WHEN DATE_FORMAT(cescores.submit_date,'%m/%d/%Y')= '00/00/0000'  THEN '---' ELSE cescores.marks_secured  END AS marks_secured,IF(DATE_FORMAT(cescores.submit_date, '%m/%d/%Y')='00/00/0000' ,'Not&nbsp;Attempted',DATE_FORMAT(cescores.submit_date, '%m/%d/%Y')) as s_date,DATE_FORMAT(act.t_date, '%m/%d/%Y') as t_date  FROM "+schoolId+"_cescores as cescores,"+schoolId+"_activities act ,category_item_master WHERE cescores.work_id=act.activity_id and category_item_master.item_id=cescores.category_id and  category_item_master.school_id=cescores.school_id  and category_item_master.course_id=cescores.course_id and "+pretest+"  cescores.course_id=act.course_id and cescores.user_id='"+tmpusr+"' and cescores.course_id='"+courseId+"' and cescores.report_status=1 and cescores.status<3 and cescores.school_id='"+schoolId+"'  order by act.Activity_name,category_item_master.grading_system";

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
				
									    
						if(ctype.equals(rs2.getString("category_id"))){
	%>
  <tr>
    <td width="25%" height="19"><font face="Verdana" size="2">&nbsp;<%=rs2.getString("Activity_name")%></font></td>
    <td width="13%" height="19" align="center"><font face="Verdana" size="2"><%=totalmarks%></font></td>
    <td width="14%" height="19" align="center"><font face="Verdana" size="2"><%=rs2.getString("marks_secured")%>  </font></td>
    <td width="14%" height="19" align="center"><font size="2" face="Verdana">	<%=rs2.getString("s_date")%></font></td>
  </tr>
<%   
     }
}
%>
<tr>
    <td width="25%" height="19"><font face="Verdana" size="2">&nbsp;Total :</font></td>
    <td width="13%" height="19" align="center"><b><font face="Arial" size="2" color="#FF0033"><%=sumofTotalPoints%></font></b></td>
    <td width="14%" height="19" align="center"><b><font face="Arial" size="2" color="#FF0033"><%=sumofSecuredPoints%>  </font></b></td>
    <td width="14%" height="19" align="center">&nbsp;</td>
  </tr>
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
%>

</table>

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
			
		
		}catch(SQLException se){
			ExceptionsFile.postException("SBCStudentScores.jsp","closing statement and connection  objects","SQLException",se.getMessage());
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