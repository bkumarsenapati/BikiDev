<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page"/>

<%
	
	String schoolId="",teacherId="",courseId="",courseid="",courseName="",catId="",catType="",grSys="",temp="",fname="",lname="",email="",catTypeByAttempt="",grSysByAttempt="",catIdByAttempt="";
	String mId="",classId="",tfname="",tlname="",temail="";
	String studentId="",grade="";
	int wght=0,i=0,wghtByAttempt=0;
	ResultSet  rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs9=null,rs6=null;
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st9=null,st6=null;
	boolean flag=false;
	float sumofSecuredPoints=0.0f,sumofTotalPoints=0.0f,percentage=0.0f,percent=0.0f,percentageTotal=0.0f,wghtTotal=0.0f,wghtSecTotal=0.0f;

	float sumofSecuredPointsByAttempt=0.0f,sumofTotalPointsByAttempt=0.0f,percentageByAttempt=0.0f,percentByAttempt=0.0f,percentageTotalByAttempt=0.0f,wghtTotalByAttempt=0.0f,wghtSecTotalByAttempt=0.0f;
	String graphContent1="",graphContent2="",graphContentbyattmpt1="",graphContentbyattmpt2="",color="";

	try
	{
		session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		classId="C000";
		schoolId = (String)session.getAttribute("schoolid");
		studentId = (String)session.getAttribute("emailid");
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
		st2=con.createStatement();
		st3=con.createStatement();
		st4=con.createStatement();
		st9=con.createStatement();
		st6=con.createStatement();

		rs=st.executeQuery("select c.course_name,c.course_id,c.teacher_id from coursewareinfo c inner join coursewareinfo_det d  on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+studentId+"' and c.status=1 and c.school_id='"+schoolId+"' and d.school_id='"+schoolId+"' order by c.course_id");	
%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Student Summary By Marking Report</title>
<SCRIPT LANGUAGE="Javascript" SRC="../../FusionCharts/FusionCharts.js"></SCRIPT>
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
function init()
{
	hide_loding();
}
function saveChart(){
         //Get chart from its ID
         var chartToPrint = getChartFromId("chart1Id");   
		 alert(chartToPrint.value);
         chartToPrint.saveAsImage();
      }
//-->
//-->
</SCRIPT>
</head>

<body>
<form name="catsummary" method="POST" action="--WEBBOT-SELF--"><BR>
<%
	
%>

<div align="center">
  <center>
<table border="0" cellspacing="0" width="95%" id="AutoNumber3" bgcolor="#429EDF" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" height="28">
  <tr>
    <td width="33%" height="16">
		<font face="Verdana" color="#FFFFFF" size="2">
			<b>&nbsp;Student Summary By Marking Period</b>
		</font>
		</td>
		<td width="33%" height="16" align="right">
		<%
		if(!mId.equals("selectmp")){
	%>
	<a href="javascript:window.print()"><img border="0" src="images/printer22.png" width="22" height="22" BORDER="0" ALT="Print"></a><%}%>&nbsp;&nbsp;<a href="index.jsp?userid=<%=studentId%>"><IMG SRC="images/back.png" WIDTH="22" HEIGHT="22" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>&nbsp;
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

<tr>
    <td width="60%" height="23" colspan="4" bgcolor="#FFFFFF">
   </td>
  </tr>
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
%>
<div align="center">
  <center>
<table border="1" cellspacing="2" cellpadding="3" colspan="4" width="95%" id="AutoNumber1"  height="26"  bordercolor="#96C8ED">
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


  <%			String[] dates=new String[2];			
	
	dates=report.getMarkingDates(schoolId,marking_id,courseid);
	   
	String yyyy1=dates[0].substring(0,4);
	String mm1=dates[0].substring(5,7);
	String dd1=dates[0].substring(8,10);
	String date1=mm1+"/"+dd1+"/"+yyyy1;

	String yyyy2=dates[1].substring(0,4);
	String mm2=dates[1].substring(5,7);
	String dd2=dates[1].substring(8,10);
	String date2=mm2+"/"+dd2+"/"+yyyy2;
	  
  rs=st.executeQuery("select  t.firstname,t.lastname,t.con_emailid,t.username from teachprofile t,coursewareinfo c 							where t.schoolid='"+schoolId+"' and c.school_id='"+schoolId+"' and  t.username=c.teacher_id and 													c.course_id='"+courseId+"'" );

				  while(rs.next())
					{
					tfname=rs.getString("firstname");
					tlname=rs.getString("lastname");
					temail=rs.getString("con_emailid");
					teacherId=rs.getString("username");
  
				rs1=st1.executeQuery("select  * from studentprofile where username='" +studentId +"' and schoolid='" +schoolId +"'");
				
					Hashtable result = new Hashtable();
					String studentid="",sschoolid="";
					while(rs1.next()){			
						
						studentid=rs1.getString("username");
						sschoolid=rs1.getString("schoolid");
						fname=rs1.getString("fname");
						lname=rs1.getString("lname");
						result=report.getActivityTypeGrade(courseid,classId,studentid,sschoolid,dates,wb,ba);
						
						/*============overall percentageByAtt=============*/

						rs6=st6.executeQuery("select sum(`"+schoolId+"_cescores`.`marks_secured`) as sum1,sum(`"+schoolId+"_cescores`.`total_marks`) as sum2,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores`,`mp_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentid+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`course_id`=`mp_cescores`.`course_id` and `"+schoolId+"_cescores`.`work_id`=`mp_cescores`.`work_id` and `"+schoolId+"_cescores`.`report_status`=1 and (`"+schoolId+"_cescores`.`status`=2) and `mp_cescores`.`m_id`='"+marking_id+"' group by `"+schoolId+"_cescores`.`category_id`");

                                       
						  	sumofSecuredPointsByAttempt=0.0f;
							float TotalSecureMarkingPointsByAttempt=0.0f;
							float TotalMarkingPointsByAttempt=0.0f;
 		                   
							float  TotalMarkingPercentageByAttempt=0.0f;
							while(rs6.next())
							{
								
								catIdByAttempt=rs6.getString("category_id");
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
							System.out.println("sumofSecuredPointsByAttempt is..."+studentid+"......."+sumofSecuredPointsByAttempt);
							System.out.println("sumofTotalPointsByAttempt is..."+sumofTotalPointsByAttempt);
							
							TotalSecureMarkingPointsByAttempt=TotalSecureMarkingPointsByAttempt+sumofSecuredPointsByAttempt;
							TotalMarkingPointsByAttempt=TotalMarkingPointsByAttempt+sumofTotalPointsByAttempt;
							
						if(sumofTotalPointsByAttempt!=0)
							{
								wghtTotalByAttempt=wghtTotalByAttempt+wghtByAttempt;
								percentageByAttempt=(sumofSecuredPointsByAttempt/sumofTotalPointsByAttempt)*wghtByAttempt;
							}
							 
                          	percentageTotalByAttempt=percentageTotalByAttempt+percentageByAttempt;
													
							if(grSys.equals("2"))
							{
								wghtTotalByAttempt=wghtTotalByAttempt-wghtByAttempt;
							}
							wghtSecTotalByAttempt=wghtSecTotalByAttempt+percentageByAttempt;
						
			}
			/*==========end of percenByAttempt=========*/	

						rs2=st2.executeQuery("select CASE WHEN ((`"+schoolId+"_cescores`.`status`=2)|| (`"+schoolId+"_cescores`.`status`=0 && `"+schoolId+"_cescores`.`end_date`<curdate())) THEN sum(`"+schoolId+"_cescores`.`marks_secured`) else '0' END AS sum1,CASE WHEN ((`"+schoolId+"_cescores`.`status`=2)|| (`"+schoolId+"_cescores`.`status`=0 && `"+schoolId+"_cescores`.`end_date`<curdate())) THEN sum(`"+schoolId+"_cescores`.`total_marks`) else '0' END AS sum2,CASE WHEN (`"+schoolId+"_cescores`.`status`=2 and `"+schoolId+"_cescores`.`report_status`=1) THEN sum(`"+schoolId+"_cescores`.`marks_secured`) else '0'end as sum3,CASE WHEN (`"+schoolId+"_cescores`.`status`=2 and `"+schoolId+"_cescores`.`report_status`=1) THEN sum(`"+schoolId+"_cescores`.`total_marks`) else '0' end as sum4,`"+schoolId+"_cescores`.`category_id` from `"+schoolId+"_cescores`,`mp_cescores` where `"+schoolId+"_cescores`.`user_id`='"+studentid+"' and `"+schoolId+"_cescores`.`course_id`='"+courseId+"' and `"+schoolId+"_cescores`.`course_id`=`mp_cescores`.`course_id` and `"+schoolId+"_cescores`.`work_id`=`mp_cescores`.`work_id` and `"+schoolId+"_cescores`.`report_status`=1 and ((`"+schoolId+"_cescores`.`status`=2)||(`"+schoolId+"_cescores`.`end_date`<curdate())) and `mp_cescores`.`m_id`='"+marking_id+"' group by `"+schoolId+"_cescores`.`category_id`");
						    
						  	sumofSecuredPoints=0.0f;
 		                    float TotalMarkingPoints=0.0f;
							float TotalSecureMarkingPoints=0.0f;
							float  TotalMarkingPercentage=0.0f;					
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

							%>			
			
		<!-- <div align="center">
				  <center>
				<table border="1" cellspacing="1" width="95%" id="AutoNumber2" height="18" bordercolorlight="#E6F2FF"> -->
				  
				  <tr>
					<td width="25%" height="1"><font face="Arial" size="2">&nbsp;<a href="SBCScores.jsp?courseid=<%=courseId%>&m_id=<%=marking_id%>&studentid=<%=studentId%>&classid=C000					&catType=<%=catId%>&catName=<%=catType%>"><%=catType%></a></font></td>
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

							
							TotalSecureMarkingPoints=TotalSecureMarkingPoints+sumofSecuredPoints;
							TotalMarkingPoints=TotalMarkingPoints+sumofTotalPoints;
						   
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
							graphContentbyattmpt1=graphContentbyattmpt1+"<set label='"+catType+"' value='"+wght+"' isSliced='1' />";
							graphContentbyattmpt2=graphContentbyattmpt2+"<set label='"+catType+"' value='"+report.trimFloat(percentage)+"' isSliced='1' />";

							%>

					<td width="14%" height="1" align="center"><font size="2" face="Arial"><%=report.trimFloat(percentage)%>%</font></td>
				  </tr>
				  
				<!-- <hr color="#F16C0A" width="100%" size="1"> -->
<%

						
			}
		if(!studentid.equals("C000_vstudent"))
		{
				
			
			percentageTotal=(percentageTotal/wghtTotal)*100;
			percentageTotalByAttempt=(percentageTotalByAttempt/wghtTotalByAttempt)*100;

			
			percent=(float)Float.parseFloat(report.trimFloat(percentageTotal));
			
			TotalMarkingPercentage=percent;
			percentByAttempt=(float)Float.parseFloat(report.trimFloat(percentageTotalByAttempt));

			TotalMarkingPercentageByAttempt=percentByAttempt;
			
				if(i!=0)
				{
					
					rs9=st9.executeQuery("SELECT grade_code from class_grades where schoolid='"+schoolId+"' and "+percent+" between minimum and maximum");
					while(rs9.next())
					{
						grade=rs9.getString("grade_code");
					}
				

%>


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
		   }
%>


  <!-- <tr>
    <td width="25%" height="19"><font face="Arial" size="2"><a href="SBMPScores.jsp?user=<%=studentid%>&m_id=<%=marking_id%>&fname=<%=fname%>&lname=<%=lname%>&classid=<%=classId%>&courseid=<%=courseid%>&schoolid=<%=schoolId%>&na=false&percent=<%=TotalMarkingPercentage%>&perctByatt=<%=TotalMarkingPercentageByAttempt%>&sumofsecpnts=<%=sumofSecuredPoints%>&sumoftotpnts=<%=sumofTotalPoints%>">&nbsp;<%=fname%> &nbsp;<%=lname%></a></font></td>
    <td width="14%" height="19" align="center"><font face="Arial" size="2"><%=TotalMarkingPoints%></font></td>
	<td width="14%" height="19" align="center"><font face="Arial" size="2"><%=TotalSecureMarkingPoints%></font></td>
    <td width="14%" height="19" align="center"><font face="Arial" size="2"><%=TotalSecureMarkingPoints%></font></td>
<td width="14%" height="19" align="center"><font size="2"face="Arial"><%=TotalMarkingPercentageByAttempt%>%</font></td>
    <td width="14%" height="19" align="center"><font size="2" face="Arial"><%=TotalMarkingPercentage%>%</font></td>
  </tr> -->
  
  <%
	      }
  %>
   </table>
  <%
  
 	}
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
			if(st9!=null)
				st9.close();
					
			if(con!=null && !con.isClosed())
				con.close();
			
		
		}catch(SQLException se){
			ExceptionsFile.postException("SummaryByMarking.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
%>
  </center>
</div>

<!-- <hr color="#429EDF" width="100%" size="1"> -->

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
    var chartbyatt1 = new FusionCharts("../../FusionCharts/Bar2D.swf", "chart1Id", "700", "200", "0", "1"); 
	var chartbyatt2 = new FusionCharts("../../FusionCharts/Bar2D.swf", "chart1Id", "500", "200", "0", "1"); 

	//chartbyatt1.setDataXML("<chart caption='Overall Summary By Attempt' palette='2' animation='0' formatNumberScale='0' pieSliceDepth='15' startingAngle='125'><%=graphContentbyattmpt1%><styles><definition><style type='font' name='CaptionFont' size='15' color='666666' /><style type='font' name='SubCaptionFont' bold='0' /></definition><application><apply toObject='caption' styles='CaptionFont' /><apply toObject='SubCaption' styles='SubCaptionFont' /></application></styles></chart>");

	chartbyatt2.setDataXML("<chart caption='Overall Summary By Attempt' palette='2' animation='1' formatNumberScale='0' pieSliceDepth='15' startingAngle='125'><%=graphContentbyattmpt2%><styles><definition><style type='font' name='CaptionFont' size='15' color='666666' /><style type='font' name='SubCaptionFont' bold='0' /></definition><application><apply toObject='caption' styles='CaptionFont' /><apply toObject='SubCaption' styles='SubCaptionFont' /></application></styles></chart>");

	//chartbyatt1.render("chartbyatt1div");
	chartbyatt2.render("chartbyatt2div");




	 var overallchart1 = new FusionCharts("../../FusionCharts/Bar2D.swf", "chart2Id", "700", "200", "0", "1"); 
	var overallchart2 = new FusionCharts("../../FusionCharts/Pie3D.swf", "chart2Id", "700", "200", "0", "1"); 

	//overallchart1.setDataXML("<chart caption='Overall Summary' palette='2' animation='0' formatNumberScale='0' pieSliceDepth='15' startingAngle='125'><%=graphContent1%><styles><definition><style type='font' name='CaptionFont' size='15' color='666666' /><style type='font' name='SubCaptionFont' bold='0' /></definition><application><apply toObject='caption' styles='CaptionFont' /><apply toObject='SubCaption' styles='SubCaptionFont' /></application></styles></chart>");

	overallchart2.setDataXML("<chart caption='Overall Summary' palette='2' animation='1' formatNumberScale='0' pieSliceDepth='15' startingAngle='125'><%=graphContentbyattmpt1%><styles><definition><style type='font' name='CaptionFont' size='15' color='666666' /><style type='font' name='SubCaptionFont' bold='0' /></definition><application><apply toObject='caption' styles='CaptionFont' /><apply toObject='SubCaption' styles='SubCaptionFont' /></application></styles></chart>");

	//overallchart1.render("overallchartdiv1");
	overallchart2.render("overallchartdiv2");

   </script>
<center><input type='button' value='Save Chart as Image' onClick='javascript:saveChart();'></center>
    </CENTER>


<!--				Chart end here.....!	-->
</form>
</body>
</html>