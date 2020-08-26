<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile,exam.FindGrade" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page"/>

<%
	String schoolId="",classId="",teacherId="",courseId="",courseName="",crsId="",studentId="",fname="",lname="";
	String query=null,ex="0",as="0",tmpusr="",smarks="",percentage2="",email="",grade="",catName="";
	
	String cId="",sId="",catId="",temp="",catType="",grSys="",status="",color="",cattype;
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
	String subDate="",clr="";
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
		catName=request.getParameter("catName");
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

		rs=st.executeQuery("select * from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"' and status>0 and course_id='"+courseId+"' order by course_id");	
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
<table border="0" cellspacing="0" width="95%" bgcolor="#429EDF" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" height="28">
  <tr>
    <td width="50%" height="24"><b>
    &nbsp;<font face="verdana" size="2" color="#FFFFFF">Student Summary By Category Scores</font></b></td>
    <td width="50%" height="24" align="right">
	<a href="javascript:window.print()"><img border="0" src="images/printer22.png" width="22" height="22" BORDER="0" ALT="Print"></a>&nbsp;&nbsp;
	<a href="#" onclick="javascript:history.back();"><IMG SRC="images/back.png" WIDTH="22" HEIGHT="22" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>
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
    <td width="30%" height="23"  bgcolor="#96C8ED">
		
<%
				while(rs.next())
				{
					out.println("<b><FONT SIZE='' COLOR='#990000'>Course Name:</FONT> "+rs.getString("course_name")+"</b>");
				}
				rs.close();
%>
	</td>
	<td width="30%" height="23"  bgcolor="#96C8ED">
		
<b><FONT SIZE='' COLOR='#990000'>Category Name:</FONT>&nbsp;<%=catName%></b> 
		</td>
		
</tr>
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
	String ctype=request.getParameter("catType");

	//rs3=st3.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) as sum1,sum(`"+schoolId+"_cescores`.`total_marks`) as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`report_status`=1 and ((`"+schoolId+"_cescores`.`status`=1 ||`"+schoolId+"_cescores`.`status`=2)|| (`"+schoolId+"_cescores`.`status`=0 && `"+schoolId+"_cescores`.`end_date`<curdate())) group by `"+schoolId+"_cescores`.`category_id`");

	
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
<tr>
  <td width="100%" colspan="4" bgcolor="#FFFFFF">
  </tr> 
  
  <tr>
  <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="95%" id="AutoNumber1" height="23">
  <tr>
    <td width="15%"><b><font face="verdana" size="2">Student Name:</font></b></td>
    <td width="25%"><font face="verdana" size="2"><%=fname%>&nbsp;<%=lname%></font></td>
    <td width="12%"><b><font face="verdana" size="2">Student ID:</font></b></td>
    <td width="15%"><font face="verdana" size="2"><%= studentId %></font></td>
    <td width="2%"><font face="verdana" size="2">
    <a href="InstantMessage.jsp?emailid=<%=email%>&studentid=<%= studentId %>&fname=<%=fname%>&lname=<%=lname%>"><img border="0" src="images/email.png" width="16" height="16" alt="Send an Instant Mail"></a></font></td>
    <td width="6%">
    <p align="right"><b><font face="verdana" size="2">Total&nbsp;</font></b></td>
    <td width="25%">
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
					//if(c>=100)
                        // grade="A+";

						/*rs3=st3.executeQuery("SELECT grade_code from class_grades where schoolid='"+schoolId+"' and "+percentageTotal+" between minimum and maximum" );

			while(rs3.next())
			{
				grade=rs3.getString("grade_code");
			}*/
					%>
    <p align="Left"><font face="verdana"size="2">
	
<%=report.trimFloat(percentageTotal)%>%&nbsp;&nbsp;<b>Grade</b>&nbsp;<%=grade%>
	
	</font></td>
  </tr>

  
	
					<tr>
		  
						 
			<%
					
				}
					else
			 {			
					fg=new FindGrade();
					centMarks=fg.convertToCent(wghtSecTotal,wghtTotal);
					grade=fg.getGrade(schoolId,classId,courseId,centMarks);
		%>		
		 <p align="Left"><font face="verdana"size="2">
	
<%=report.trimFloat(percentageTotal)%>%&nbsp;&nbsp;<b>Grade</b>&nbsp;<%=grade%>
	
	</font></td>
						 </tr>
	<%
			 }
%>
</table>
<%
  
				if(!schoolId.equals(act_schoolId))
						tmpusr=act_schoolId+"_"+studentId;
					else
						tmpusr=studentId;
				String pretest="";
				
	query="SELECT act.activity_id,act.Activity_name,act.activity_type,act.activity_sub_type,cescores.category_id, CASE WHEN category_item_master.grading_system=0 then '#A9A9A9' else 'Black' end as grading_system,(select marks_total from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id=cescores.work_id limit 1) as  marks_totalAS,CASE WHEN cescores.category_id='EC' THEN CONCAT('<strike>',cescores.total_marks,'</strike>') WHEN cescores.status=3 THEN CONCAT('<U>',cescores.total_marks,'</U>') else cescores.total_marks end as total_marks,CASE WHEN((DATE_FORMAT(cescores.submit_date, '%m/%d/%Y')='00/00/0000') and cescores.end_date<curdate()) THEN '0' WHEN DATE_FORMAT(cescores.submit_date,'%m/%d/%Y')= '00/00/0000'  THEN '---'  WHEN cescores.status='1'  THEN CONCAT(cescores.marks_secured,'*') WHEN cescores.status='3'  THEN '*'  ELSE cescores.marks_secured  END AS marks_secured,CASE WHEN DATE_FORMAT(cescores.submit_date, '%m/%d/%Y')='00/00/0000'  and cescores.end_date<curdate() THEN 'Due Date Passed' WHEN DATE_FORMAT(cescores.submit_date, '%m/%d/%Y')='00/00/0000' THEN 'Not Attempted' ELSE DATE_FORMAT(cescores.submit_date, '%m/%d/%Y') END as s_date,DATE_FORMAT(act.t_date, '%m/%d/%Y') as t_date  FROM "+schoolId+"_cescores as cescores,"+schoolId+"_activities act ,category_item_master WHERE cescores.work_id=act.activity_id and category_item_master.item_id=cescores.category_id and  category_item_master.school_id=cescores.school_id  and category_item_master.course_id=cescores.course_id and "+pretest+"  cescores.course_id=act.course_id and cescores.user_id='"+tmpusr+"' and cescores.course_id='"+courseId+"' and cescores.report_status=1 and cescores.status<3 and cescores.school_id='"+schoolId+"'  order by act.Activity_name,category_item_master.grading_system";

	 rs2=st2.executeQuery(query);	

%>
<div align="center">
  <center>
<table border="1" cellspacing="2" cellpadding="3" colspan="4" width="95%" id="AutoNumber1"  height="26"  bordercolor="#96C8ED">
  <tr>
    <td width="25%" align="center" bgcolor="#96C8ED" height="1">
    <p align="left"><b>
    <font face="verdana" size="2">Assignment/Assessment Name</font></b></td>
    <td width="13%" align="center" bgcolor="#96C8ED" height="1"><b>
    <font face="verdana" size="2">Points Possible</font></b></td>
    <td width="14%" align="center" bgcolor="#96C8ED" height="1"><b>
    <font face="verdana" size="2">Points Secured</font></b></td>
    <td width="14%" align="center" bgcolor="#96C8ED" height="1"><b>
    <font face="verdana" size="2">Submission Date</font></b></td>
  </tr>
 <%
					//sumofSecuredPoints=0.0f;
					//sumofTotalPoints=0.0f;
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

									//sumofSecuredPoints +=Float.parseFloat(rs2.getString("marks_secured").replace('*','\0'));
										//sumofTotalPoints +=totalmarks;
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

										//sumofSecuredPoints +=Float.parseFloat(rs2.getString("marks_secured").replace('*','\0'));
										//sumofTotalPoints +=totalmarks;
									}
								}

								cattype=request.getParameter("catType");
                                
												    						  
					if(cattype.equals(rs2.getString("category_id")))
					{
						subDate=rs2.getString("s_date");
						if(subDate.equals("Due Date Passed"))
						{
							clr="red";
						}
						else
						{
							clr="Black";
						}

												
%>
  <tr>
    <td width="25%" height="19"><font face="verdana" size="2">&nbsp;<%=rs2.getString("Activity_name")%></font></td>
    <td width="13%" height="19" align="center"><font face="verdana" size="2"><%=totalmarks%></font></td>
    <td width="14%" height="19" align="center"><font face="verdana" size="2"><%=rs2.getString("marks_secured")%>  </font></td>
    <td width="14%" height="19" align="center"><font size="2" face="verdana" color="<%=clr%>"><%= subDate%></font></td>
  </tr>
<%   
}

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
					<font face="verdana" size="2"><center><strong>There are no assignments available</strong></center></font>
					</td>
			</tr>
			</table>
<%		
			}   

%>
</table>
<%
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
			ExceptionsFile.postException("SBCScores.jsp","closing statement and connection  objects","SQLException",se.getMessage());
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