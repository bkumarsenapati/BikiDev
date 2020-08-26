<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<html>
<head>
<title></title>
</head>
<body>
<form name="show">
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	boolean insertStatus=false;

	String schoolId="",courseId="",studentId="",ansStr="";
	int i=0;

	try
	{   
		schoolId=(String)session.getAttribute("Login_school");
		courseId=request.getParameter("courseid");
		studentId=request.getParameter("studentid");

		con=con1.getConnection();
		st=con.createStatement();

		rs=st.executeQuery("select * from pretest_student_material_distribution where school_id='"+schoolId+"' and course_id='"+courseId+"' and student_id='"+studentId+"'");
		if(rs.next())
		{
			insertStatus=true;
		}

		if(insertStatus==false)
		{
			i=st.executeUpdate("insert into pretest_student_material_distribution(school_id,student_id,course_id,status) values ('"+schoolId+"','"+studentId+"','"+courseId+"','0')");
		}
	}
	catch(SQLException e)
	{
		System.out.println("EXception in AssignPretest.jsp is..."+e.getMessage());			
	}
	finally
	{	
		if (con!=null && ! con.isClosed())
			con.close();
	}
%>
</form>
<p>&nbsp;</p><p>&nbsp;</p>
<center>
	<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
    <tr>
		<td width="50%">&nbsp;</td>
    </tr>
<%
	if(insertStatus==true)
	{
%>
    <tr>
		<td width="50%" align="center">
			<b><font face="Verdana" size="2" color="#934900">You have already assigned the pretest to <%=studentId%>.</font></b>
		</td>
    </tr>
<%
	}
	else
	{
%>
    <tr>
		<td width="50%" align="center">
			<b><font face="Verdana" size="2" color="#934900">You have successfully assigned the pretest to <%=studentId%>.</font></b>
		</td>
    </tr>
<%
	}	
%>
	<tr>
		<td width="50%">&nbsp;</td>
    </tr>
    <tr>
		<td width="50%" align="center">
			<font face="Verdana" size="2"><a href="ListOfStudents.jsp?courseid=<%=courseId%>">Click here to go back to the Students page</a></font>
		</td>
    </tr>
	</table>
</center>
</body>
</html>