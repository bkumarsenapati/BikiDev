<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page" />
<%@ include file="/common/checksession.jsp" %> 	
<%
	String bgclr="#E1DED5";
	String marking_id=request.getParameter("m_id");
	String studentName=request.getParameter("uname");
	String classId=request.getParameter("classid");
	String user_id=request.getParameter("uid");
	String schoolid=(String)session.getAttribute("schoolid");
	boolean wb=true,ba=true;
	String oschoolid=schoolid;
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet  rs=null,rs1=null;	
	String sel_wb=request.getParameter("wb");
	String sel_ba=request.getParameter("ba");
	if((sel_wb==null)||(sel_wb.equals("false")))
		wb=false;
	if((sel_ba!=null)&&(sel_ba.equals("false")))
		ba=false;
%>
<html>
<head>
<SCRIPT LANGUAGE="JavaScript">
<!--
function selectgrade(){
	var wb=document.getElementById("wb").checked;
	var ba=document.getElementById("attempted").checked;
	window.location="summary.jsp?m_id=<%=marking_id%>&uid=<%=user_id%>&uname=<%=studentName%>&classid=<%=classId%>&wb="+wb+"&ba="+ba;
	return false;
}
function onld(){
	document.getElementById("wb").checked=<%=wb%>;
	document.getElementById("attempted").checked=<%=ba%>;
}
//-->
</SCRIPT>
</head>
<body bgcolor="#FFFFFF" onload=onld()>
<BR>
<table border="0" cellspacing="0" width="813"  bordercolor="#EEBA4D" cellpadding="0" bgcolor="#EEE0A1" >
  <tr>
    <td height="19" >
    <b><font face="Arial" size="2">&nbsp;<font color="blue">Student&nbsp;Name&nbsp;:</font></font></b></td>
    <td height="19" align="center">
     <font face="Arial" size="2">&nbsp;<b><%=studentName%></b></font></td>
    <td width="329" height="22">
		<b><font face="Arial" size="2"  COLOR="white">
			<input type="checkbox" name="wb" id="wb" onclick="selectgrade()" style="visibility:hidden"> <!-- &nbsp;Based&nbsp;on&nbsp;Weightage&nbsp;&nbsp;&nbsp; -->
		</font></b>
	</td>
	<td width="204" height="22">
		<b><font face="Arial" size="2"  COLOR="blue">&nbsp;
			<input type="checkbox" name="attempted" id="attempted" onclick="selectgrade()">&nbsp;Attempted
		</font></b>
	</td>
	<td width="74" height="19" align="center">
    <p align="left">
    <b>&nbsp;<a href="javascript:window.print()">
	<font color="#FFFFFF" face="Arial" size="2"></font><font color="blue" size="1" face="Arial">Print</font></a></b></td>
	<td width="74" height="19" align="center">
    <p align="left">
    <b>&nbsp;<a href="javascript:history.go(-1)">
	<font color="#FFFFFF" face="Arial" size="2"></font><font color="blue" size="2" face="Arial">Back</font></a></b></td>
    
  </tr>
  </table>
  <%try{
		String courseId=null,courseName=null,query=null;
		Hashtable courses=new Hashtable();	
		con=con1.getConnection();	
		st=con.createStatement();
		st1=con.createStatement();

		report.setConnection(con);  // This function will send connection to the reports bean		
		query="select c.course_name,c.course_id,c.school_id,c.teacher_id,sp.student_id from (select schoolid,grade,username student_id from studentprofile where (username='"+user_id+"' and schoolid='"+schoolid+"')OR(username='"+schoolid+"_"+user_id+"' and crossregister_flag='2')) sp,coursewareinfo c,coursewareinfo_det d where c.course_id=d.course_id and c.school_id=d.school_id and d.student_id=sp.student_id and c.status=1 and c.school_id=sp.schoolid and c.class_id=sp.grade ";
		rs=st.executeQuery(query);		
  %>
  <br>
  <table border="0" cellspacing="1" width="813" bordercolor="#C0C0C0">
  <tr>
    <td width="400" height="24" bgcolor="#EEBA4D">
    <b><font face="Arial" size="2">Course Name</font></b></td>
    <td width="134" height="24" bgcolor="#EEBA4D" align="center">
    <p align="center"><b><font face="Arial" size="2">&nbsp;Assignments</font></b></td>
    <td width="135" height="24" align="center" bgcolor="#EEBA4D">
    <b><font face="Arial" size="2">Assessments</font></b></td>
    <td width="142" height="24" align="center" bgcolor="#EEBA4D">
    <b><font face="Arial" size="2">Points&nbsp;Possible</font></b></td>
    <td width="216" height="24" align="right" bgcolor="#EEBA4D">
    <p align="center"><b><font face="Arial" size="2">Points&nbsp;Secured</font></b></td>
	<td width="216" height="24" align="right" bgcolor="#EEBA4D">
    <p align="center"><b><font face="Arial" size="2">Percentage&nbsp;(%)</font></b></td>
   </tr>
	<%if(!rs.next()){
		out.println("<tr><td colspan='5' width='100%' height='28' align='center'><font color=''><b>No course is created</b></font></td></tr>");
		return;
	}else{
		Hashtable result = new Hashtable();
		String cflag="";
		String[] dates=new String[2];
		do{
			courseId=rs.getString("course_id");
			courseName=rs.getString("course_name");
			schoolid=rs.getString("school_id");
			user_id=rs.getString("student_id");
			cflag="yes";
			if(oschoolid.equals(schoolid))cflag="";
			dates=report.getMarkingDates(oschoolid,marking_id,courseId+cflag);
			result=report.getActivityTypeGrade(courseId,classId,user_id,schoolid,dates,wb,ba);		
	%>
  <tr>
    <td width="174" height="21" align="center">
    <p align="left"><font face="Arial" size="2"><%=courseName%></font></td>
    <td width="134" height="21" align="center"><font face="Arial" size="2"><%=result.get("as")%></font></td>
	<td width="135" height="21" align="center"><font face="Arial" size="2"><%=result.get("ex")%></font></td>
    <td width="142" height="21" align="center"><font face="Arial" size="2"><%=result.get("maxmarks")%></font></td>
    <td width="216" height="21" align="center"><font face="Arial" size="2"><%=result.get("marks_secred")%></font></td>
	<td width="216" height="21" align="center"><font face="Arial" size="2"><%=result.get("percent")%></font></td>
	<!-- <td width="220" height="21" align="center"><font face="Arial" size="2">A</font></td> -->
  </tr> 
  <%}while(rs.next());
}%>
</table>
</body>
<%}catch(Exception e){
	 ExceptionsFile.postException("reports/student/over_all.jsp","closing statement,resultset and connection objects","Exception",e.getMessage());
	
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