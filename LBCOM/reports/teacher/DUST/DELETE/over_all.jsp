<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
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
%>
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>New Page 1</title>
</head>

<body bgcolor="#FFFFFF">

  <BR>
<table border="0" cellspacing="0" width="813"  bordercolor="#EEBA4D" cellpadding="0" bgcolor="#EEBA4D" >
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
    <b><font face="Verdana" size="2">&nbsp;<font color="#FFFFFF"></font></font></b></td>
    <td width="116" height="19" align="center">
    <p align="left"><b><font color="#0000FF" face="Verdana" size="2">&nbsp;</font><font face="Verdana" size="2"></font></b></td>
  </tr>
  </table>
  <%try{
		Connection con=null;
		Statement st=null,st1=null;
		ResultSet  rs=null,rs1=null;
		String courseId=null,courseName=null,query=null;
		Hashtable courses=new Hashtable();	
		con=con1.getConnection();	
		st=con.createStatement();
		st1=con.createStatement();
		rs=st.executeQuery("select c.course_name,c.course_id from coursewareinfo c left join coursewareinfo_det d on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+user_id+"' and c.status=1 and d.school_id='"+schoolid+"'");		
		while (rs.next()) {	
			courses.put(rs.getString("course_id"),rs.getString("course_name"));			
		}
			
  %>
  <br>
  <table border="0" cellspacing="1" width="813" bordercolor="#C0C0C0">
  <tr>
    <td width="202" height="24" bgcolor="#EEE0A1">
    <b><font face="Verdana" size="2">Course Name</font></b></td>
    <td width="146" height="24" bgcolor="#EEE0A1" align="center">
    <p align="center"><b><font face="Verdana" size="2">&nbsp;Assignments</font></b></td>
    <td width="136" height="24" align="center" bgcolor="#EEE0A1">
    <b><font face="Verdana" size="2">Assessments</font></b></td>
    <td width="150" height="24" align="center" bgcolor="#EEE0A1">
    <b><font face="Verdana" size="2">Max. Points</font></b></td>
    <td width="187" height="24" align="center" bgcolor="#EEE0A1">
    <p align="center"><b><font face="Verdana" size="2">Secured Points</font></b></td>
    <!-- <td width="220" height="24" align="center" bgcolor="#EEE0A1">
    <b><font face="Verdana" size="2">Grade</font></b></td> -->
  </tr>
	<%if(courses.size()<=0){
		out.println("<tr><td colspan='5' width='100%' height='28' align='center'><font color=''><b>No course is created</b></font></td></tr>");
		return;
	}
	Enumeration courseNames=courses.keys();    
	int j=0;
	while(courseNames.hasMoreElements()){
		String ex="0",as="0",s_date=null,e_date=null,marks_secred="0";
		float maxmarks=0;
		courseId=(String)courseNames.nextElement();
		courseName=(String)courses.get(courseId);
		query="SELECT s_date,e_date FROM marking_course WHERE schoolid='"+schoolid+"' and courseid='"+courseId+"' and m_id='"+marking_id+"'";
		rs1=st1.executeQuery(query);
		if(rs1.next()){
			s_date=rs1.getString("s_date");
			e_date=rs1.getString("e_date");	
			System.out.println("Dates from teacher"+courseId);
		}else{
			query="SELECT s_date,e_date FROM marking_admin WHERE schoolid='"+schoolid+"' and m_id='"+marking_id+"'";
			rs1=st1.executeQuery(query);
			if(rs1.next()){
				s_date=rs1.getString("s_date");
				e_date=rs1.getString("e_date");
			}
		}
		query="SELECT count('activity_id'),SUM(total_marks) FROM "+schoolid+"_activities where course_id='"+courseId+"' group by activity_type";
		rs1=st1.executeQuery(query);
		if(rs1.next()){
			as=rs1.getString(1);
			maxmarks=rs1.getFloat(2);
		}
		if(rs1.next()){
			ex=rs1.getString(1);
			maxmarks+=rs1.getFloat(2);
		}
		query="SELECT SUM(marks_secured) FROM "+schoolid+"_cescores WHERE school_id='"+schoolid+"' and user_id='"+user_id+"' and course_id='"+courseId+"' GROUP by course_id ";
		rs1=st1.executeQuery(query);
		if(rs1.next()){
			marks_secred=rs1.getString(1);
			
		}
	%>
  <tr>
    <td width="202" height="21" align="center">
    <p align="left"><font face="Verdana" size="2"><a href="#1"><%=courseName%></a></font></td>
    <td width="146" height="21" align="center"><font size="2"><%=as%></font></td>
	<td width="136" height="21" align="center"><font face="Verdana" size="2"><%=ex%></font></td>
    <td width="150" height="21" align="center"><font face="Verdana" size="2"><%=maxmarks%></font></td>
    <td width="187" height="21" align="center"><font face="Verdana" size="2"><%=marks_secred%></font></td>
	<!-- <td width="220" height="21" align="center"><font face="Verdana" size="2">A</font></td> -->
  </tr> 
  <%}%>
</table>
</body>
<%}catch(Exception e){
	System.out.println("Exception in reports/student/over_all.jsp"+e);
  }
%>

</html>