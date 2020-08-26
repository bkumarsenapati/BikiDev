<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page" />
<%@ include file="/common/checksession.jsp" %> 	
<%
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet  rs=null,rs1=null;
try{
	String marking_id=request.getParameter("m_id");
	String courseId=request.getParameter("courseid");
	String courseName=request.getParameter("courseName");
	String act=request.getParameter("act");
	String studentName=(String)session.getAttribute("studentname");
	String classId=(String)session.getAttribute("classid");	
	String user_id=(String)session.getAttribute("emailid");
	String act_schoolid=(String)session.getAttribute("schoolid");
	String schoolid="";
	String classname=(String)session.getAttribute("classname");
	String query=null,ex="0",as="0",tmpusr="";
	String oschoolid=act_schoolid;
	String sel_na=request.getParameter("na");    //based on attempted
	String sel_showall=request.getParameter("showall");    //based on attempted
	boolean na=true,showall=true;
	float total_Points=0.0f,total_waitages=0.0f,percent=0.0f;
	con=con1.getConnection();	
	st=con.createStatement();
	st1=con.createStatement();
	report.setConnection(con);  // This function will send connection to the reports bean
	
	if(sel_na==null||sel_na.equals("false"))
		na=false;
	if(sel_showall==null||sel_showall.equals("false"))
		showall=false;
%>
<html>
<head>
<SCRIPT LANGUAGE="JavaScript">
<!--
function goreport(){
	var course=document.getElementById("course");
	var coursename=course.options[course.selectedIndex].text
	var na=document.getElementById("nattempted").checked;
	var showall=document.getElementById("showall").checked;
	window.location="ByActivity.jsp?m_id=<%=marking_id%>&courseid="+course.value+"&courseName="+coursename+"&na="+na+"&showall="+showall;
	return false;
}
function onld(){
	if("<%=showall%>"=="true")
		document.getElementById("showhide").style.visibility = 'hidden';
	document.getElementById("showall").checked=<%=showall%>;
	document.getElementById("nattempted").checked=<%=na%>;
	if("<%=courseId%>"==="null")return false;
	document.getElementById("course").value="<%=courseId%>";
	
}
//-->
</SCRIPT>
</head>
<body topmargin=0 leftmargin=5 onload=onld()>
<table border="1" cellspacing="0" style="border-collapse: collapse" width="100%">
	<tr>
		<%
		String sc="";			
		query="select sp.student_id,c.course_name,c.course_id,c.school_id,c.teacher_id from (select schoolid,grade,username student_id from studentprofile where (username='"+user_id+"' and schoolid='"+act_schoolid+"')OR(username='"+act_schoolid+"_"+user_id+"' and crossregister_flag='2')) sp,coursewareinfo c,coursewareinfo_det d where c.course_id=d.course_id and c.school_id=d.school_id and d.student_id=sp.student_id and c.status=1 and c.school_id=sp.schoolid and c.class_id=sp.grade ";
		rs=st.executeQuery(query);			
				if(!rs.next()){	
				%>
					<td width="100%" height="22"><b><font face="Arial" size="2"><font face="Arial">&nbsp;There&nbsp;are&nbsp;no&nbsp;courses&nbsp;available&nbsp;&nbsp;&nbsp;
					</font></b>
					</td>
					</tr></table>
				<%
					return;
				}else{
					if(courseId==null){
						courseId=rs.getString("course_id");
						courseName=rs.getString("course_name");
						schoolid=rs.getString("school_id");
						tmpusr=rs.getString("student_id");
					}else{
						schoolid=courseId.substring(courseId.indexOf("_")+1);
						courseId=courseId.substring(0,courseId.indexOf("_"));						
					}
					%>
					<td width="250" >
						<font face="Arial">&nbsp;Course&nbsp;:&nbsp;<select size="1" name="course" id="course" onchange="goreport()">
					<%
					do{
					%>
					<option value="<%=rs.getString("course_id")+"_"+rs.getString("school_id")%>"><%=rs.getString("course_name")%>
			</option>
					<%
					}while(rs.next());
				}
				%></select></font></td>
		<td valign="bottom" id="showhide">&nbsp;<input type= checkbox name="nattempted" id="nattempted" onclick="goreport()">Expired&nbsp;Only</td>
		<td valign="bottom">&nbsp;<input type= checkbox name="showall" id="showall" onclick="goreport()">Show 
		All</td>
		<td valign="bottom"><font face="Arial" size="2">&nbsp;</font><font face="Arial" size="2"><a href="javascript:window.print()">Print</a>&nbsp;&nbsp;</font></td>

		</tr>
</table><br>
</font>
<%
					float pp=0.0f,sp=0.0f,percentage=0.0f;
					if(!schoolid.equals(act_schoolid))
						tmpusr=act_schoolid+"_"+user_id;
					else
						tmpusr=user_id;
					String nas="";
					String[] dates=new String[2];
					dates=report.getMarkingDates(oschoolid,marking_id,courseId);			
		
%>
			<table border="0" cellspacing="0" id="AutoNumber3" width="100%" bgcolor="#E08443" bordercolor="#C0C0C0" cellpadding="0" style="border-collapse: collapse" height="20">
				<tr>
					<td height="20" width="319"><b><font face="Arial" size="2" >&nbsp;Course:&nbsp;</font><font face="Arial" size="2" color="blue"><%=courseName%></font></b></td>
					<td height="20" width="319"><b><font face="Arial" size="2" >&nbsp;From:&nbsp;</font><font face="Arial" size="2" color="blue"><%=common.convertoDisplayDate(dates[0])%></font></b></td>
					<td height="20" width="319"><b><font face="Arial" size="2" >&nbsp;To:&nbsp;</font><font face="Arial" size="2" color="blue"><%=common.convertoDisplayDate(dates[1])%></font></b></td>
					<td height="20" id="showtotal" align=right color=white>&nbsp;</td>
				</tr>
			</table>
			<table border="2" cellspacing="0" style="border-collapse:collapse;border-style:solid" width="100%">
				<tr bgcolor=#B0A890>
					<th width="40%"><font face="Arial" size="2">Name</font></th>
					<th width="15%"><font face="Arial" size="2">Last Attempted On</font></th>
					<th width="15%"><font face="Arial" size="2">Points&nbsp;Possible</font></th>	
					<th width="15%"><font face="Arial" size="2">Secured Points</font></th>									
					<th width="15%"><font face="Arial" size="2">To Date</font></th>
					
				</tr>
				<%				
				String pretest="category_item_master.grading_system!=0 and ";		
				if(na==false)				//if By attempt based
					nas="and ((act.t_date between '"+dates[0]+"' and '"+dates[1]+"')or(cescores.submit_date between '"+dates[0]+"' and '"+dates[1]+"'))";	 
				else
					nas="and act.t_date between '"+dates[0]+"' and '"+dates[1]+"'";
				if(showall==true){
					nas="";
					pretest="";
				}
				query="SELECT act.activity_id,act.Activity_name,CASE WHEN cescores.status= 1 then concat(cescores.marks_secured,'*') WHEN cescores.status=3 then '*' else cescores.marks_secured end as marks_secured,CASE WHEN cescores.category_id='EC' then concat('<strike>',cescores.total_marks,'</strike>') WHEN cescores.status=3 then concat('<U>',cescores.total_marks,'</U>')else cescores.total_marks end as total_marks,IF(DATE_FORMAT(cescores.submit_date, '%m/%d/%Y')='00/00/0000' ,'Not&nbsp;Attempted',DATE_FORMAT(cescores.submit_date, '%m/%d/%Y')) as s_date,CASE WHEN category_item_master.grading_system=0 then '#A9A9A9' else 'Black' end as grading_system,DATE_FORMAT(act.t_date, '%m/%d/%Y') as t_date  FROM "+schoolid+"_cescores as cescores,"+schoolid+"_activities act,category_item_master WHERE cescores.work_id=act.activity_id and category_item_master.item_id=cescores.category_id and  "+pretest+" category_item_master.school_id=cescores.school_id  and category_item_master.course_id=cescores.course_id and cescores.course_id=act.course_id and cescores.user_id='"+tmpusr+"' and cescores.course_id='"+courseId+"' and cescores.school_id='"+schoolid+"' and cescores.report_status=1 "+nas+" order by category_item_master.grading_system,act.Activity_name";

				rs1=st1.executeQuery(query);			
				if(!rs1.next()){
				%>
				<tr><td colspan=5 align=center><font face="Arial" size="2"><font color="#FF0000">No Activity is available in this course</font>.</font></td></tr>
				<%
				}else{
					String sdate="";
					do{	
						if(showall==false){
							try{
								pp=pp+Float.parseFloat(rs1.getString("total_marks"));	
							}catch(Exception e){}
							try{
								sp=sp+Float.parseFloat(rs1.getString("marks_secured"));	
							}catch(Exception e){}							
						}
					%>
					<tr style="color:<%=rs1.getString("grading_system")%>">
						<td width="40%" align=left><font face="Arial" size="2">&nbsp;&nbsp;&nbsp;
							<%=rs1.getString("Activity_name")%></td>
						<td width="15%" align=center><font face="Arial" size="2"><%=rs1.getString("s_date")%></font></td>
						<td width="15%" align=center><font face="Arial" size="2"><%=rs1.getString("total_marks")%></font></td>
						<td width="15%" align=center><font face="Arial" size="2"><%=rs1.getString("marks_secured")%></font></font></td>	
						<td width="15%" align=center><font face="Arial" size="2"><%=rs1.getString("t_date")%></font></td>				
					</tr>
					<%}while(rs1.next());
					if(showall==false){
						percentage=(sp/pp)*100;
					}
				}%>		
					<tr bgcolor=#B0A890>
					<%if(showall==true){%>
							<th width="40%" colspan=5><font face="Arial" size="2">&nbsp;</font></th>
						<%}else{%>
							<th width="40%"><font face="Arial" size="2">&nbsp;</font></th>
							<th width="15%"><font face="Arial" size="2">&nbsp;</font></th>
							<th width="15%"><font face="Arial" size="2"><%=pp%></font></th>	
							<th width="15%"><font face="Arial" size="2"><%=sp%></font></th>									
							<th width="15%"><font face="Arial" size="2">&nbsp;</font></th>
						<%}%>
					</tr>
					<tr  bgcolor="#E08443" >
					<th width="40%"><font face="Arial" size="2">&nbsp;</font></th>
						<th width="15%"><font face="Arial" size="2">&nbsp;</font></th>
						<th width="15%"><font face="Arial" size="2">&nbsp;</font></th>	
						<th width="15%"><font face="Arial" size="2">&nbsp;</font></th>									
						<th width="15%">&nbsp;</th>
				</tr>
			</table>
			<HR><br>
			<%if(showall!=true){%>
			<SCRIPT LANGUAGE="JavaScript">
			<!--
			var gscore="<%=report.trimFloat(percentage)%>%";
			document.getElementById("showtotal").innerHTML="<b>Total&nbsp;Percentage&nbsp;:&nbsp;</b>"+gscore+"&nbsp;";
			//-->
			</SCRIPT>
			<%}%>
</body>
</html>
<%
}catch(Exception e){
	System.out.println("Exception in ByActivity.jsp "+e);	
}
finally
		{
			try
			{
				if(rs!=null)
					rs.close();
				if(rs1!=null)
					rs1.close();
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(con!=null && !con.isClosed())
				con.close();
			}
			catch(Exception ee){
				 ExceptionsFile.postException("reports/student/over_all.jsp","closing statement,resultset and connection objects","Exception",ee.getMessage());
			}
		}

%>