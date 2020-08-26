<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page" />
<%@ include file="/common/checksession.jsp" %> 	
<html>
<head>
<%
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet  rs=null,rs1=null;
	String marking_id=request.getParameter("m_id");
	String courseId=request.getParameter("courseid");
	String studentName=(String)session.getAttribute("studentname");
	String classId=(String)session.getAttribute("classid");	
	String user_id=(String)session.getAttribute("emailid");
	String schoolid=(String)session.getAttribute("schoolid");
	String classname=(String)session.getAttribute("classname");
	String courseName=null,query=null,ex="0",as="0",tmp_usr="";
	boolean wb=true,ba=true;
	float total_Points=0.0f,total_waitages=0.0f,percent=0.0f;
	con=con1.getConnection();	
	st=con.createStatement();
	st1=con.createStatement();
	report.setConnection(con);  // This function will send connection to the reports bean
	String sel_wb=request.getParameter("wb");
	String sel_ba=request.getParameter("ba");
	if((sel_wb==null)||(sel_wb.equals("false")))
		wb=false;
	if((sel_ba!=null)&&(sel_ba.equals("false")))
		ba=false;
	%>
<SCRIPT LANGUAGE="JavaScript">
<!--
function selectgrade(){
	var course=document.getElementById("course").value;
	var wb=document.getElementById("wb").checked;
	var ba=document.getElementById("attempted").checked;
	window.location="Bycourse.jsp?m_id=<%=marking_id%>&courseid="+course+"&wb="+wb+"&ba="+ba;
	return false;
}
function onld(){
	document.getElementById("wb").checked=<%=wb%>;
	document.getElementById("attempted").checked=<%=ba%>;
	if("<%=courseId%>"==="null")return false;
	document.getElementById("course").value="<%=courseId%>";
}
//-->
</SCRIPT>
</head>
<%try{%>
<body onload=onld()>
	<table border="1" cellpadding="0" width="823" id="AutoNumber2" cellspacing="0" height="24">
		<tr>			
			<%
				query="select c.course_name,c.course_id,c.school_id,c.teacher_id,sp.student_id student_id from (select schoolid,grade,username student_id from studentprofile where (username='"+user_id+"' and schoolid='"+schoolid+"')OR(username='"+schoolid+"_"+user_id+"' and crossregister_flag='2')) sp,coursewareinfo c,coursewareinfo_det d where c.course_id=d.course_id and c.school_id=d.school_id and d.student_id=sp.student_id and c.status=1 and c.school_id=sp.schoolid and c.class_id=sp.grade ";
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
						courseId=rs.getString("course_id");//+"_"+rs.getString("school_id");
						schoolid=rs.getString("school_id");
						tmp_usr=rs.getString("student_id");
						courseName=rs.getString("course_name");
					}else{
						schoolid=courseId.substring(courseId.indexOf("_")+1);
						courseId=courseId.substring(0,courseId.indexOf("_"));								
					}
					%>
					<td width="68"	height="22"><b><font face="Arial" size="2">&nbsp;Course:</font></b></td>
					<td width="200"	height="22"><font face="Arial">
					<select size="1" id="course" name="course" onchange="selectgrade()">
					<%
					do{	
						if((courseId.equals(rs.getString("course_id")))&&(schoolid.equals(rs.getString("school_id")))){
							tmp_usr=rs.getString("student_id");
							courseName=rs.getString("course_name");
						}
					%>
					<option value="<%=rs.getString("course_id")+"_"+rs.getString("school_id")%>"><%=rs.getString("course_name")%></option>
					<%
					}while(rs.next());
				}
				rs.close();
				%>			
			</select>&nbsp;&nbsp;&nbsp; </font>
			</td>
			<td width="119" height="22">
				<b><font face="Arial" size="2">
					<font face="Arial">
					<input type="checkbox" name="wb" id="wb" onclick="selectgrade()" style="visibility:hidden"></font><!-- &nbsp;Based&nbsp;on&nbsp;Weightage&nbsp;&nbsp;&nbsp; -->
				</font></b>
			</td>
			<td width="204" height="22">
				<b><font face="Arial" size="2">&nbsp;
					<font face="Arial">
					<input type="checkbox" name="attempted" id="attempted" onclick="selectgrade()"></font>&nbsp;&nbsp;Attempted
				</font></b>
			</td>
			<td width="247" height="22" align="right">
			<font face="Arial" size="2">&nbsp;<a href="javascript:window.print()">Print</a>&nbsp;&nbsp;</font></td>
		</tr>
	</table><BR>
	<%  
			//courseId=rs.getString("course_id");
			String[] dates=new String[2];
			String cflag="";
			total_Points=0;total_waitages=0;percent=0;
			dates=report.getMarkingDates(schoolid,marking_id,courseId);
			Vector rep_vector=report.getCountByACategoryType(schoolid,tmp_usr,courseId,dates,wb,ba);
			String temp=(String)rep_vector.lastElement();
			
	%>
	
	<table border="0" cellspacing="0" id="AutoNumber3" width="824" bgcolor="#E08443" bordercolor="#C0C0C0" cellpadding="0" style="border-collapse: collapse" height="20">
		<tr>
			<td height="20" width="419" wrap colspan=2><b><font face="Arial" size="2" >&nbsp;Course:&nbsp;</font><font face="Arial" size="2" color="white"><%=courseName%></font></b></td>
			<td height="20" width="419" wrap colspan=2><b><font face="Arial" size="2"><div id="grand"><div></font></b></td>
			<td height="20" width="209"><b><font face="Arial" size="2">From:&nbsp;<%=common.convertoDisplayDate(dates[0])%></font></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b><font face="Arial" size="2">To:&nbsp;<%=common.convertoDisplayDate(dates[1])%></font></b></td>
		</tr>
	</table>
	<table border="0" cellspacing="1" width="824" id="AutoNumber1" height="45" bordercolor="#C0C0C0">
		<tr>
			<td width="156" height="21" bgcolor="#B0A890">
			<p align="center"><b><font face="Arial" size="2">Category Name</font></b></td>
			<td width="156" height="21" align="center" bgcolor="#B0A890">
			<p align="center"><b><font face="Arial" size="2">Points Possible</font></b></td>
			<td width="141" height="21" align="center" bgcolor="#B0A890">
			<p align="center"><b><font face="Arial" size="2">Secured Points</font></b></td>
			<!-- <td width="206" height="21" align="center" bgcolor="#B0A890">
			<p align="center"><b><font face="Arial" size="2">weighted Points</font></b></td>
			<td width="148" height="21" align="center" bgcolor="#B0A890">
			<p align="center"><b><font face="Arial" size="2">Weightage</font></b></td> -->
		</tr>
		<%
			float pp=0.0f,sp=0.0f,percentage=0.0f;
			for(int i=0;i<rep_vector.size()-1;i++){
			String[] cat_details=(String[])rep_vector.get(i);
			
			String ss="",se="";
			if(cat_details[1].equals("EC")){
				ss="<strike>";se="</strike>";
			}
		%>
		<tr>
			<td width="156" height="21" align="center">
			<p align="left"><font face="Arial" size="2"><%=cat_details[2]%></font></td>
			<td width="156" height="21" align="center">
			<%=ss%><font face="Arial" size="2"><%=report.trimFloat(Float.parseFloat(cat_details[3]))%></font><%=se%></td>
			<td width="141" height="21" align="center">
			<font face="Arial" size="2"><%=report.trimFloat(Float.parseFloat(cat_details[4]))%></font></td>
			<!-- <td width="206" height="21" align="center">
			<font face="Arial" size="2"><%=cat_details[6]%></font></td>
			<td width="148" height="21" align="center">
			<font face="Arial" size="2"><%=cat_details[5]%>%</font></td> -->
		</tr>
		<%		
			if(cat_details[1].equals("EC"))cat_details[3]="0";
			pp=pp+Float.parseFloat(cat_details[3]);	
			sp=sp+Float.parseFloat(cat_details[4]);	
		}
		percentage=(sp/pp)*100;
		%>
			
		<tr>
			<td width="156" height="21" bgcolor="#B0A890">
			<p align="center"><b><font face="Arial" size="2"></font></b></td>
			<td width="156" height="21" align="center" bgcolor="#B0A890">
			<p align="center"><b><font face="Arial" size="2"><%=pp%></font></b></td>
			<td width="141" height="21" align="center" bgcolor="#B0A890">
			<p align="center"><b><font face="Arial" size="2"><%=sp%></font></b></td>
			<!-- <td width="206" height="21" align="center" bgcolor="#B0A890">
			<p align="center"><b><font face="Arial" size="2">weighted Points</font></b></td>
			<td width="148" height="21" align="center" bgcolor="#B0A890">
			<p align="center"><b><font face="Arial" size="2">Weightage</font></b></td> -->
		</tr>
	</table>
	<hr color="#000000" align="left" width="825" size="1">
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	document.getElementById("grand").innerHTML="Grand&nbsp;Percentage:&nbsp;<%=report.trimFloat(percentage)%>";
	//-->
	</SCRIPT>
		
</body>
<%}catch(Exception e){
	System.out.println("Exception in student/ByCourse.jsp"+e);
}finally
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
</html>