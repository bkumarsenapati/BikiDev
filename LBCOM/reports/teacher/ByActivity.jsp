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
	String user_id=request.getParameter("user");
	String act_schoolid=(String)session.getAttribute("schoolid");
	String schoolid=request.getParameter("schoolid");
	String classId=request.getParameter("classid");
	String classname=(String)session.getAttribute("classname");
	String query=null,ex="0",as="0",tmpusr="";
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
<SCRIPT LANGUAGE="JavaScript" src="/LBCOM/common/Validations.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
<!--
function goreport(){
	var na=document.getElementById("nattempted").checked;
	var showall=document.getElementById("showall").checked;	window.location="ByActivity.jsp?user=<%=user_id%>&m_id=<%=marking_id%>&fname=<%=request.getParameter("fname")%>&lname=<%=request.getParameter("lname")%>&classid=<%=classId%>&classdes=<%=classname%>&schoolid=<%=schoolid%>&courseid=<%=courseId%>&courseName=<%=courseName%>&na="+na+"&showall="+showall;
	return false;
}
function export1(){
	var x=window.open ('csv_ByActivity.jsp?<%=request.getQueryString()%>','mywindow');
}
function onld(){
	if("<%=showall%>"=="true")
		document.getElementById("showhide").style.visibility = 'hidden';
		document.getElementById("showall").checked=<%=showall%>;
		document.getElementById("nattempted").checked=<%=na%>;	
		hide_loding();
}
//-->
</SCRIPT>
</head>
 <DIV id=loading  style='WIDTH:100%;height:100%; POSITION: absolute; TEXT-ALIGN: center;border: 3px solid;z-index:1;background-color : white;'><IMG src="/LBCOM/common/images/loading.gif" border=0></DIV>
<body topmargin=0 leftmargin=5 onload=onld()>
<FORM METHOD=POST ACTION="" style="visibility:hidden">
<%
	String[] dates=new String[2];
	dates=report.getMarkingDates(act_schoolid,marking_id,courseId);	 
 %>
<table border="1" cellspacing="0" style="border-collapse: collapse" width="100%">
	<tr>
		<td valign="bottom" id="showhide">&nbsp;<input type= checkbox name="nattempted" id="nattempted" onclick="goreport()" value="ON"><b><font face="Arial" size="2">Expired&nbsp;Only</font></b></td>
		<td valign="bottom">&nbsp;<input type= checkbox name="showall" id="showall" onclick="goreport()" value="ON"><b><font face="Arial" size="2">Show 
		All</font></b></td>
		<td valign="bottom"><font face="Arial" size="2">&nbsp;</font><font face="Arial" size="2"><a href="javascript:window.print()">Print</a>&nbsp;&nbsp;</font></td>
		<td valign="bottom"><font face="Arial" size="2">&nbsp;</font><font face="Arial" size="2"><a href="javascript:export1()">Export</a>&nbsp;&nbsp;</font></td>
		<td height="20" align="right" ><b><font face="Arial" size="2">
		<a href="/LBCOM/reports/teacher/Summary?m_id=<%=marking_id%>&classid=<%=classId%>&classdes=<%=classname%>&courseid=&coursedes=&wb=false&ba=true">Back</a></font></b></td>
		</tr>		
</table>
</font>
			<table border="0" cellspacing="0" id="AutoNumber3" width="100%" bgcolor="#63ADE4" bordercolor="#C0C0C0" cellpadding="0" style="border-collapse: collapse" height="20">
				<tr>
					<td height="20" ><b><font face="Arial" size="2" >&nbsp;Student Name :&nbsp;</font><font face="Arial" size="2" color="white"><%=request.getParameter("lname")%>&nbsp;<%=request.getParameter("fname")%>&nbsp;</font></b></td>
					<td height="20" ><b><font face="Arial" size="2" >&nbsp;Student&nbsp;ID :&nbsp;</font><font face="Arial" size="2" color="white"><%=user_id%>&nbsp;</font></b></td>
					<td height="20" align=left><b><font face="Arial" size="2" >&nbsp;Course:&nbsp;</font><font face="Arial" size="2" color="white"><%=courseName%></font></b></td>
					<%if(showall==false){%>
					<td height="20" align=left><b><font face="Arial" size="2" >&nbsp;From&nbsp;:</font><font face="Arial" size="2" color="white"><%=common.convertoDisplayDate(dates[0])%></font></b></td>
					<td height="20" align=left><b><font face="Arial" size="2" >&nbsp;To&nbsp;:</font><font face="Arial" size="2" color="white"><%=common.convertoDisplayDate(dates[1])%></font></b></td>
					<td height="20" >&nbsp;</td>
					<%}%>
				</tr>
			</table>
			<table border="2" cellspacing="0" style="border-collapse:collapse;border-style:solid" width="100%">
				<tr bgcolor=#A8B8D1>
					<th width="40%"><font face="Arial" size="2">Name</font></th>
					<th width="15%"><font face="Arial" size="2">Last Attempted On</font></th>
					<th width="15%"><font face="Arial" size="2">Points&nbsp;Possible</font></th>	
					<th width="15%"><font face="Arial" size="2">Secured Points</font></th>									
					<th width="15%"><font face="Arial" size="2">To Date</font></th>
				</tr>
				<%
					float pp=0.0f,sp=0.0f,percentage=0.0f;
					if(!schoolid.equals(act_schoolid))
						tmpusr=act_schoolid+"_"+user_id;
					else
						tmpusr=user_id;
				String nas="",pretest="category_item_master.grading_system!=0 and ";								
				if(na==false)				//if By attempt based
					nas="and ((act.t_date between '"+dates[0]+"' and '"+dates[1]+"')or(cescores.submit_date between '"+dates[0]+"' and '"+dates[1]+"'))";	 
				else
					nas="and act.t_date between '"+dates[0]+"' and '"+dates[1]+"'";
				if(showall==true){
					pretest="";
					nas="";
				}
				query="SELECT act.activity_id,act.Activity_name, CASE WHEN category_item_master.grading_system=0 then '#A9A9A9' else 'Black' end as grading_system,CASE WHEN cescores.category_id='EC' THEN CONCAT('<strike>',cescores.total_marks,'</strike>') WHEN cescores.status=3 THEN CONCAT('<U>',cescores.total_marks,'</U>') else cescores.total_marks end as total_marks,CASE WHEN DATE_FORMAT(cescores.submit_date,'%m/%d/%Y')= '00/00/0000'  THEN '---' WHEN cescores.status='1'  THEN CONCAT(cescores.marks_secured,'*') WHEN cescores.status='3'  THEN '*' ELSE cescores.marks_secured  END AS marks_secured,IF(DATE_FORMAT(cescores.submit_date, '%m/%d/%Y')='00/00/0000' ,'Not Attempted',DATE_FORMAT(cescores.submit_date, '%m/%d/%Y')) as s_date,DATE_FORMAT(act.t_date, '%m/%d/%Y') as t_date  FROM "+schoolid+"_cescores as cescores,"+schoolid+"_activities act ,category_item_master WHERE cescores.work_id=act.activity_id and category_item_master.item_id=cescores.category_id and  category_item_master.school_id=cescores.school_id  and category_item_master.course_id=cescores.course_id and "+pretest+"  cescores.course_id=act.course_id and cescores.user_id='"+tmpusr+"' and cescores.course_id='"+courseId+"' and cescores.report_status=1 and cescores.school_id='"+schoolid+"' "+nas+" order by category_item_master.grading_system,act.Activity_name";
				rs1=st1.executeQuery(query);			
				if(!rs1.next()){
				%>
				<tr><td colspan=5 align=center><font face="Arial" size="2"><font color="#FF0000">No Activity is available in this course</font>.</font></td></tr>
				<%
				}else{
					do{	
						
							if(showall==false){
								try{
									pp=pp+Float.parseFloat(rs1.getString("total_marks"));
								}catch(Exception e){}
								try{
									sp=sp+Float.parseFloat(rs1.getString("marks_secured").replace('*','\0'));	
								}catch(Exception e){}
							}
						
												
					%>
					<tr style="color:<%=rs1.getString("grading_system")%>">
						<td width="40%" align=left><font face="Arial" size="2">&nbsp;&nbsp;&nbsp;<%=rs1.getString("Activity_name")%></td>
						<td width="15%" align=center><font face="Arial" size="2"><%=rs1.getString("s_date")%></font>&nbsp;</td>
						<td width="15%" align=center><font face="Arial" size="2"><%=rs1.getString("total_marks")%></font>&nbsp;</td>
						<td width="15%" align=center><font face="Arial" size="2"><%=rs1.getString("marks_secured")%></font>&nbsp;</td>
						<td width="15%" align=center><font face="Arial" size="2"><%=rs1.getString("t_date")%></font>&nbsp;</td>
					</tr>
					<%}while(rs1.next());
					if(showall==false){
						percentage=(sp/pp)*100;
					}
				}%>		
					
						<%if(showall==false){%>
						<tr>
							<th width="40%"><font face="Arial" size="2">&nbsp;</font></th>
							<th width="15%"><font face="Arial" size="2">&nbsp;</font></th>
							<th width="15%"><font face="Arial" size="2"><%=pp%></font>&nbsp;</th>	
							<th width="15%"><font face="Arial" size="2"><%=sp%></font>&nbsp;</th>									
							<th width="15%"><font face="Arial" size="2"><%=report.trimFloat(percentage)%>%</font></th>
						</tr>
						<%}%>
					</tr>
			</table>
			<br>
			</FORM>
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