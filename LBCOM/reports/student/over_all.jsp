<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page" />
<!-- CODE FOR SESSION HANDELING -->
<%@ include file="/common/checksession.jsp" %> 	
<!-- CODE FOR SESSION HANDELING -->
<%
	String bgclr="#E1DED5";
	String marking_id=request.getParameter("m_id");
	String studentName=(String)session.getAttribute("studentname");
	String classId=(String)session.getAttribute("classid");
	String user_id=(String)session.getAttribute("emailid");
	String schoolid=(String)session.getAttribute("schoolid");
	String classname=(String)session.getAttribute("classname");
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet  rs=null,rs1=null;
	
%>
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>New Page 1</title>
</head>

<body bgcolor="#FFFFFF">

  

  <BR>
<table border="0" cellspacing="0" width="813"  bordercolor="#EEBA4D" cellpadding="0" bgcolor="#E08443" >
  <tr>
    <td width="131" height="19" >
    <b><font face="Verdana" size="2">&nbsp;<font color="#FFFFFF">Student Name :</font></font></b></td>
    <td width="173" height="19" align="center">
    <p align="left">
    <font face="Verdana" size="2">&nbsp;<b><%=user_id%></b></font></td>
    <td width="75" height="19" align="center" >
    <p align="left">
    <b><font face="Verdana" size="2">&nbsp;<font color="#FFFFFF">Class :</font></font></b></td>
    <td width="144" height="19" align="center">
    <p align="left">
    <font face="Verdana" size="2">&nbsp;<b><%=classname%></b></font></td>
    <td width="74" height="19" align="center">
    <p align="left">
    <b><a href="javascript:window.print()">
	<font color="#FFFFFF" face="Verdana" size="2">&nbsp;</font><font color="#FFFFFF" size="1" face="Verdana">Print</font></a></b></td>
    <td width="116" height="19" align="center">
    <p align="left"><b><font color="#0000FF" face="Verdana" size="2">&nbsp;</font><font face="Verdana" size="2"></font></b></td>
  </tr>
  </table>
  <%try{
		String courseId=null,courseName=null,query=null;
		Hashtable courses=new Hashtable();	
		con=con1.getConnection();	
		st=con.createStatement();
		st1=con.createStatement();

		report.setConnection(con);  // This function will send connection to the reports bean

		rs=st.executeQuery("select c.course_name,c.course_id from coursewareinfo c left join coursewareinfo_det d on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+user_id+"' and c.status=1 and d.school_id='"+schoolid+"'");		
		while (rs.next()) {	
			courses.put(rs.getString("course_id"),rs.getString("course_name"));			
		}
			
  %>
  <br>
  <table border="0" cellspacing="1" width="813" bordercolor="#C0C0C0">
  <tr>
    <td width="174" height="24" bgcolor="#B0A890">
    <b><font face="Verdana" size="2">Course Name</font></b></td>
    <td width="134" height="24" bgcolor="#B0A890" align="center">
    <p align="center"><b><font face="Verdana" size="2">&nbsp;Assignments</font></b></td>
    <td width="135" height="24" align="center" bgcolor="#B0A890">
    <b><font face="Verdana" size="2">Assessments</font></b></td>
    <td width="142" height="24" align="right" bgcolor="#B0A890">
    <b><font face="Verdana" size="2">Maximum Points</font></b></td>
    <td width="216" height="24" align="right" bgcolor="#B0A890">
    <p align="center"><b><font face="Verdana" size="2">Points Secured</font></b></td>
   </tr>
	<%if(courses.size()<=0){
		out.println("<tr><td colspan='5' width='100%' height='28' align='center'><font color=''><b>No course is created</b></font></td></tr>");
		return;
	}
	Enumeration courseNames=courses.keys();    
	int j=0;
	Hashtable result = new Hashtable();
	while(courseNames.hasMoreElements()){
		courseId=(String)courseNames.nextElement();
		courseName=(String)courses.get(courseId);
		result=report.getActivityTypeGrade(courseId,classId,user_id,schoolid,marking_id);		
	%>
  <tr>
    <td width="174" height="21" align="center">
    <p align="left"><font face="Verdana" size="2"><%=courseName%></font></td>
    <td width="134" height="21" align="center"><font face="Verdana" size="2"><%=result.get("as")%></font></td>
	<td width="135" height="21" align="center"><font face="Verdana" size="2"><%=result.get("ex")%></font></td>
    <td width="142" height="21" align="right"><font face="Verdana" size="2"><%=result.get("maxmarks")%></font></td>
    <td width="216" height="21" align="right"><font face="Verdana" size="2"><%=result.get("marks_secred")%></font></td>
	<!-- <td width="220" height="21" align="center"><font face="Verdana" size="2">A</font></td> -->
  </tr> 
  <%}%>
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