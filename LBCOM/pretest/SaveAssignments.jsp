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
	String schoolId="",examId="";
	int i=0;

	try
	{   
		aIds=request.getParameter("selids");
			
		con=con1.getConnection();
		st=con.createStatement();
	
		schoolId=request.getParameter("schoolid");
		examId=request.getParameter("examid");
		courseId=request.getParameter("courseid");
		questionId=request.getParameter("questionid");
		System.out.println("update pretest_lms set assignment_ids= '"+aIds+"' where school_id='"+schoolId+"' and course_id='"+courseId+"' and exam_id='"+examId+"' and q_id='"+questionId+"'");
	
		i=st.executeUpdate("update pretest_lms set assignment_ids= '"+aIds+"' where school_id='"+schoolId+"' and course_id='"+courseId+"' and exam_id='"+examId+"' and q_id='"+questionId+"'");
		response.sendRedirect("QuestionMapping.jsp?schoolid="+schoolId+"&examid="+examId+"&courseid="+courseId);
	}
	catch(SQLException e)
	{
		System.out.println("EXception in SaveAssignments.jsp is..."+e.getMessage());			
	}
	finally
	{
		if(st!=null)
		st.close();
		if (con!=null && ! con.isClosed())
			con.close();
	}
%>

<H3>..........Successfully Updated............. </H3>

</form>
</body>
</html>
