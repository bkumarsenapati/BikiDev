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

	String schoolId="",courseId="",studentId="",password="";
	int i=0,j=0;

	try
	{   
		con=con1.getConnection();
		st=con.createStatement();
	
		schoolId="mahoning";
		courseId=request.getParameter("courseid");
		studentId=request.getParameter("studentid");
		password=request.getParameter("password");

//		i=st.executeUpdate("update pretest_student_material_distribution set answer_string= '"+ansStr+"' where courseid='"+courseId+"' and studentid='"+studentId+"'");

		response.sendRedirect("StudentExamPaper.jsp?courseid="+courseId+"&studentid="+studentId);
	}
	catch(SQLException e)
	{
		System.out.println("EXception in ValidatePretestStudent.jsp is..."+e.getMessage());			
	}
	finally
	{	
		if (con!=null && ! con.isClosed())
			con.close();
	}
%>

</form>
</body>
</html>