<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<html>
<head><title></title></head>
<body>
<form name="show">
<%!
				String[] ItemNames;
%>
<%
	String courseId="",questionId="",aIds="";
	String schoolId="",examId="";
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	int i=0,k=0;

	try
	{   
		//aIds=request.getParameter("selids");

		if(request.getParameter("selids") != null)
		{
			
				ItemNames = request.getParameterValues("selids");
				for(k = 0; k < ItemNames.length; k++)
				{
					System.out.println(" ItemNames[k] ..."+ ItemNames[k] );
					aIds=ItemNames[k];			
			
				
				}
		}
		
			
		con=con1.getConnection();
		st=con.createStatement();
		schoolId=request.getParameter("schoolid");
		examId=request.getParameter("examid");	
		courseId=request.getParameter("courseid");
		questionId=request.getParameter("questionid");
	
		i=st.executeUpdate("update pretest_lms set assessment_ids= '"+aIds+"' where school_id='"+schoolId+"' and course_id='"+courseId+"' and exam_id='"+examId+"' and q_id='"+questionId+"'");

		response.sendRedirect("QuestionMapping.jsp?schoolid="+schoolId+"&examid="+examId+"&courseid="+courseId);

	}
	catch(SQLException e)
	{
		System.out.println("EXception in SaveAssessments.jsp is..."+e.getMessage());			
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
