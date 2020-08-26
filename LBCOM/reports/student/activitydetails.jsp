<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<%@ include file="/common/checksession.jsp" %> 	
<html>
<head>

<title>.:: Welcome to www.hotschools.net ::. [ for quality eLearning experience ]</title>
</head>

<body style="font-family: Arial">
<!-- name=1-003%20Internet%20Basics&max=100&school=demoschool)&user=student&aid=R03 -->

<table border="1" cellspacing="0" style="border-collapse: collapse" width="100%" id="table1">
	<tr>
		<td colspan="2">
		<table border="1" cellspacing="0" style="border-collapse: collapse" width="100%" id="table2">
			<tr>
				<td width="133"><b>Activity: </b></td>
				<td><%=request.getParameter("name")%></td>
			</tr>
			<tr>
				<td width="133"><b>Possible Points :</b></td>
				<td><%=request.getParameter("max")%></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td align="center"><font color="#FF6666"><b>Attempt Number</b></font></td>
		<td align="center"><font color="#FF6666"><b>Secured points</b></font></td>
	</tr>
	<%
		try{
		Connection con=null;
		Statement st=null;
		ResultSet  rs=null;
		con=con1.getConnection();	
		st=con.createStatement();
		String query="select c.course_name,c.course_id,c.school_id,c.teacher_id from (select schoolid,grade,username student_id from studentprofile where (username='"+user_id+"' and schoolid='"+schoolid+"')OR(username='"+schoolid+"_"+user_id+"' and crossregister_flag='2')) sp,coursewareinfo c,coursewareinfo_det d where c.course_id=d.course_id and c.school_id=d.school_id and d.student_id=sp.student_id and c.status=1 and c.school_id=sp.schoolid and c.class_id=sp.grade ";
		rs=st.executeQuery(query);	
	%>
	<tr>
		<td align="center">&nbsp;</td>
		<td align="center">&nbsp;</td>
	</tr>
</table>

</body>

</html>