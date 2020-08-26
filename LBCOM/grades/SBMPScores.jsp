<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile,exam.FindGrade" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page"/>
<%@ include file="/common/checksession.jsp" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<%
	String schoolId="",classId="",teacherId="",courseId="",courseName="",crsId="",studentId="",fname="",lname="";
	String query=null,ex="0",as="0",tmpusr="",smarks="",percentage2="",email="",grade="",nas="";
	
	String cId="",sId="",catId="",temp="",catType="",grSys="",status="",color="";
	FindGrade fg;
	int wght=0;
	float centMarks,a=0.0f,b=0.0f,c=0.0f,d=0.0f,f=0.0f;
	float totalmarks=0.0f,securedmarks=0.0f,percentage1=0.0f,percent=0.0f;
	float sumofSecuredPoints=0.0f,sumofTotalPoints=0.0f,percentage=0.0f,percentageTotal=0.0f,wghtTotal=0.0f,wghtSecTotal=0.0f;
	ResultSet  rs=null,rs1=null,rs2=null,rs3=null,rs4=null;
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null;
	boolean flag=false,na=true;
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
		//classId=(String)session.getAttribute("classid");
		//System.out.println("classId..in SBMP...."+classId);
		String user_id=request.getParameter("user");
		String marking_id=request.getParameter("m_id");
		String act=request.getParameter("act");
		String act_schoolId=(String)session.getAttribute("schoolid");
		String sel_na=request.getParameter("na"); 
		schoolId = (String)session.getAttribute("schoolid");
		teacherId = (String)session.getAttribute("emailid");
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("courseName");

		percent=(float)Float.parseFloat(request.getParameter("percent"));
		String percentageByAttempt=request.getParameter("perctByatt");
			
		if(sel_na==null||sel_na.equals("false"))
		na=false;

		if(courseId == null)
			courseId="selectcourse";     

		studentId=request.getParameter("user");
		
		if(studentId == null)
			studentId="selectstudent";   

		con=con1.getConnection();
		report.setConnection(con);  // This function will send connection to the reports bean
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		
		
		rs=st.executeQuery("select * from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"' and course_id='"+courseId+"' and status>0 order by course_id");	


		
	
%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Summary By Marking Period</title>
</head>
<body>
<form name="studentscores" method="POST" action="--WEBBOT-SELF--">
</form>
<BR>

<div align="center">
  <center>
<table border="0" cellspacing="0" width="95%" bgcolor="#429EDF" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" height="28">
  <tr>
    <td width="50%" height="24"><b>
    &nbsp;<font face="verdana" size="2" color="#FFFFFF">Student Summary By Marking Period</font></b></td>
    <td width="50%" height="24" align="right"><!-- <a
href="MPChart.jsp?user=<%=user_id%>&m_id=<%=marking_id%>&fname=<%=fname%>&lname=<%=lname%>&classid=<%=classId%>&courseid=<%=courseId%>&schoolid=<%=schoolId%>&na=false&percent=<%=percent%>&perctByatt=<%=percentageByAttempt%>"><img
border="0" src="images/graph.png" width="22" height="22" BORDER="0"
ALT="Generate Graph"></a> --> &nbsp;&nbsp;<a href="javascript:window.print()"><img border="0" src="images/printer22.png" width="22" height="22" BORDER="0" ALT="Print"></a>&nbsp;&nbsp;
	<a href="#" onclick="javascript:history.back();"><IMG SRC="images/back.png" WIDTH="22" HEIGHT="22" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>
	&nbsp;
	</td>
  </tr>
</table>
</center>
</div>
<br>
<div align="center">
<center>
<table border="0" cellspacing="0" width="95%" id="AutoNumber1"  height="26" style="border-collapse: collapse" bordercolor="#111111" cellpadding="5" colspan="4">
  <tr bgcolor="#96C8ED">
    <td width="20%" height="23" colspan="1" bgcolor="#96C8ED">
		
<%
				while(rs.next())
				{
					out.println("<b><FONT SIZE='' COLOR='#990000'>Course Name:</FONT> "+rs.getString("course_name")+"</b>");
				}
				rs.close();
%>
	</td>
	<td width="20%" height="23" colspan="1" bgcolor="#96C8ED" align="right">
		
			
<%
	if(courseId!="selectcourse")
		{
			rs=st.executeQuery("SELECT * from marking_admin where schoolid='"+schoolId+"' and m_id='"+marking_id+"'");
			
			while(rs.next())
			{
				out.println("<b><FONT SIZE='' COLOR='#990000'>Marking Period:</FONT> "+rs.getString("m_name")+"</b>");
				
			}
		
		}	rs.close();

%>
	</td>
	<%
	String[] dates=new String[2];
				dates=report.getMarkingDates(act_schoolId,marking_id,courseId);
	%>
	
					

	
</tr>
<%
	
	
				rs1=st1.executeQuery("select  fname,lname,con_emailid from studentprofile where username='" +studentId +"'" );
				while(rs1.next())
					{
						fname=rs1.getString("fname");
						lname=rs1.getString("lname");
						email=rs1.getString("con_emailid");
					}
					st4=con.createStatement();
					rs4=st4.executeQuery("SELECT grade_code from class_grades where schoolid='"+schoolId+"' and "+percent+" between (minimum-0.01) and (maximum-0.01)");
					while(rs4.next())
					{
						grade=rs4.getString("grade_code");
					}
					st4.close();
					if(percent>=100)
					{
						grade="A";
					}
					
%>

<tr>
  <td width="100%" colspan="4" bgcolor="#FFFFFF">
  </tr> 
  
  <tr>
  <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="95%" id="AutoNumber1" height="23">
  <tr>
    <td width="28%"><b><font face="verdana" size="2" color="#990000">Student Name:</font>&nbsp;<font face="verdana" size="2"><%=fname%>&nbsp;<%=lname%></font></b></td>
    <td width="24%"><b><font face="verdana" size="2" color="#990000">Student ID:</font>&nbsp;<font face="verdana" size="2"><%= studentId %></font></b>&nbsp;&nbsp;&nbsp;<a href="InstantMessage.jsp?emailid=<%=email%>&studentid=<%=studentId%>&fname=<%=fname%>&lname=<%=lname%>"><img border="0" src="images/email.png" width="16" height="16" alt="Send an Instant Mail"></a></td>
	<td width="19%">
    <b><font face="verdana" size="2">ByAttempt&nbsp;: </font>&nbsp;<font face="verdana"size="2" color="#990000"><b><%=percentageByAttempt%>%</font></b></td>
     <td width="18%">
    <b><font face="verdana" size="2">Total&nbsp;: </font>&nbsp;<font face="verdana"size="2" color="#990000"><b><%=percent%>%</font></b></td>
    <td width="16%">
    <b><font face="verdana" size="2">Grade&nbsp;: </font>&nbsp;<font face="verdana"size="2" color="#990000"><b><%=grade%></font></b></td>
  </tr>
</table>
  
	
					<tr>
					 
			<%

				

				String yyyy1=dates[0].substring(0,4);
				String mm1=dates[0].substring(5,7);
				String dd1=dates[0].substring(8,10);

				String yyyy2=dates[1].substring(0,4);
				String mm2=dates[1].substring(5,7);
				String dd2=dates[1].substring(8,10);

				String date1=mm1+"/"+dd1+"/"+yyyy1;
				String date2=mm2+"/"+dd2+"/"+yyyy2;

						if(!schoolId.equals(act_schoolId))
						tmpusr=act_schoolId+"_"+studentId;
					else
						tmpusr=studentId;
				String pretest="category_item_master.grading_system!=0 and ";
				
				if(na==false)     
				nas="and ((DATE_FORMAT(act.`s_date`, '%m/%d/%Y') >= '"+date1+"' and DATE_FORMAT(act.`s_date`, '%m/%d/%Y') <= '"+date2+"') and  (DATE_FORMAT(cescores.`end_date`, '%m/%d/%Y') >= '"+date1+"' and    DATE_FORMAT(cescores.`end_date`, '%m/%d/%Y') <= '"+date2+"'))";
		             else
					nas="and (DATE_FORMAT(cescores.`end_date`, '%m/%d/%Y') > '"+date1+"' and    DATE_FORMAT(cescores.`end_date`, '%m/%d/%Y') < '"+date2+"'))";

                 pretest="";
	
	 rs2=st2.executeQuery("select sum(ntable.sum1) as sum1,sum(ntable.sum2) as sum2,ntable.category_id from ( select        `"+schoolId+"_cescores`.`marks_secured` as sum1,`"+schoolId+"_cescores`.`total_marks` as sum2,`"+schoolId+"_cescores`.category_id from `"+schoolId+"_cescores`,`mp_cescores`  where    `"+schoolId+"_cescores`.`user_id`='"+studentId+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"'  and `"+schoolId+"_cescores`.`report_status`=1 and `"+schoolId+"_cescores`.`category_id`!='ST' and `"+schoolId+"_cescores`.`course_id`=`mp_cescores`.`course_id` and `"+schoolId+"_cescores`.`work_id`=`mp_cescores`.`work_id`  and `"+schoolId+"_cescores`.school_id=`mp_cescores`.school_id and `mp_cescores`.`m_id`='"+marking_id+"')  as ntable group by ntable.category_id");
	
    %>
<div align="center">
  <center>
<table border="1" cellspacing="2" cellpadding="3" colspan="4" width="95%" id="AutoNumber1"  height="26"  bordercolor="#96C8ED">
  <tr>
					<td width="25%" align="center" bgcolor="#96C8ED" height="1">
					<p align="left"><b>
					<font face="Arial" size="2">Category Name</font></b></td>
					<td width="13%" align="center" bgcolor="#96C8ED" height="1"><b>
					<font face="Arial" size="2">Points Possible</font></b></td>
					<td width="14%" align="center" bgcolor="#96C8ED" height="1"><b>
					<font face="Arial" size="2">Points Secured</font></b></td>
					<td width="14%" align="center" bgcolor="#96C8ED" height="1"><b>
					<font face="Arial" size="2">Percentage</font></b></td>
				  </tr>


<%						float TotalSecuredPoints=0.0f,TotalPoints=0.0f,TotalPercentage=0.0f;
						while(rs2.next())
						{
							
								
								catId=rs2.getString("category_id");
								st3=con.createStatement();
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
								st3.close();
		
						
							sumofSecuredPoints=Float.parseFloat(rs2.getString("sum1"));
							sumofTotalPoints=Float.parseFloat(rs2.getString("sum2"));
							sumofSecuredPoints=+sumofSecuredPoints;
						sumofTotalPoints=+sumofTotalPoints;
						
						TotalSecuredPoints=TotalSecuredPoints+sumofSecuredPoints;
						TotalPoints=TotalPoints+sumofTotalPoints;
						
						      
							if(grSys.equals("2"))
							{
								
								//TotalPoints=TotalPoints-sumofTotalPoints;
								//sumofTotalPoints=sumofTotalPoints-sumofTotalPoints;
								
							}
							 if(sumofTotalPoints!=0)
							 {
								percentage=(sumofSecuredPoints/sumofTotalPoints)*100;
							 }
							 
%>			
			
				  
				  <tr>
				  <td width="25%" height="1"><font face="Arial" size="2">&nbsp;<a href="SBCScores.jsp?courseid=<%=courseId%>&m_id=<%=marking_id%>&studentid=<%=studentId%>&classid=<%=classId%>&catType=<%=catId%>&catName=<%=catType%>&pcg=<%=percentage%>&sosp=<%=sumofSecuredPoints%>&sotp=<%=sumofTotalPoints%>"><%=catType%></a></font></td>
					
					<td width="6%" height="1" align="center">
<%
					if(grSys.equals("2"))
					{
%>
						<font face="Arial" size="2">&nbsp;<font color="red" title="Extra Credit"><%=sumofTotalPoints%></a></font>

<%
					}
					else
					{
%>
						<font face="Arial" size="2">&nbsp;<%=sumofTotalPoints%></a></font>
<%
					}
%>
					</td>
					
					
					<td width="14%" height="1" align="center"><font face="Arial" size="2"><%=sumofSecuredPoints%></font></td>
					<%
						

							  
										
					%>

					<td width="14%" height="1" align="center"><font size="2" face="Arial"><%=report.trimFloat(percentage)%>%</font></td>
				  </tr>
				  
				<!-- <hr color="#F16C0A" width="100%" size="1"> -->

<%		      percentage=0.0f;
				TotalPercentage=(TotalSecuredPoints/TotalPoints)*100;

				i++;
					
              }
%>
<tr>
    <td width="25%" align="left" bgcolor="#96C8ED" height="1"><b><font face="Arial" size="2">&nbsp;Total :</font></b></td>
    <td width="13%" align="center" bgcolor="#96C8ED" height="1"><b><font face="Arial" size="2" color="#FF0033"><%=TotalPoints%></font></b></td>
    <td width="14%" align="center" bgcolor="#96C8ED" height="1"><b><font face="Arial" size="2" color="#FF0033"><%=TotalSecuredPoints%>  </font></b></td>
    <td width="14%" align="center" bgcolor="#96C8ED" height="1"><font size="2" face="Arial"><b><%=report.trimFloat(TotalPercentage)%>%</b></font></td>
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
		try{
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
			ExceptionsFile.postException("SBMPScores.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("SQLExeption in SBMPScores.jsp is..."+se);
		}

    }
%>
</table>
</center>
</div>

</form>
</body>
</html>