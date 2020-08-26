<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<html>
<head><title></title></head>
<body>
<form name="show">

<%
	String courseId="",questionId="",aIds="";
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	int i=0;

	try
	{   
		aIds=request.getParameter("selids");
			
		con=con1.getConnection();
		st=con.createStatement();
	
		courseId=request.getParameter("courseid");
		questionId=request.getParameter("questionid");
	
		i=st.executeUpdate("update pretest set assignment_ids= '"+aIds+"' where course_id='"+courseId+"' and question_id="+questionId);
		response.sendRedirect("QuestionMapping.jsp?courseid="+courseId);
	}
	catch(SQLException e)
	{
		System.out.println("EXception in SaveAssignments.jsp is..."+e.getMessage());			
	}
	finally
	{
		if (con!=null && ! con.isClosed())
			con.close();
	}
%>

<H3>..........Successfully Updated............. </H3>

</form>
</body>
</html>
