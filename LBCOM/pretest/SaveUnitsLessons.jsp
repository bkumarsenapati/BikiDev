<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<html>
<head>
<title></title>
</head>
<body>
<form name="show">
<%!
				String[] ItemNames;
			%>
<%

	String schoolId="",teacherId="",courseName="",classId="",courseId="",questionId="",devCourseId="",examId="";
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null;
	int i=0,j=0,l=0,m=0;
	String uIds="",lIds="",uId="";
	

	try
	{   
		String ids=request.getParameter("selids");

		System.out.println("ids..."+ids);
	
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
	
		courseId=request.getParameter("courseid");
		devCourseId=request.getParameter("cbcourseid");

		questionId=request.getParameter("questionid");
		schoolId=request.getParameter("schoolid");
		examId=request.getParameter("examid");

		//	issue on post data  ....resolved with getParameterValues
		
		if(request.getParameter("selids") != null)
		{
			
				ItemNames = request.getParameterValues("selids");
				for(int k = 0; k < ItemNames.length; k++)
				{
					System.out.println(" ItemNames[k] ..."+ ItemNames[k] );
			
				
				}
		}


		//




	
		StringTokenizer idsTkn=new StringTokenizer(ids,",");
		while(idsTkn.hasMoreTokens())
		{
			uId=idsTkn.nextToken();
			if(uId.indexOf("DU")!=-1)
			{
				if(i==0)
				{
					uIds=uId;
				}
				else
					uIds=uIds+","+uId;
				i++;
			}
			else if(uId.indexOf("DL")!=-1)
			{
				if(j==0)
				{
					lIds=uId;
				}
				else
					lIds=lIds+","+uId;
				j++;			
			}
			uId="";	
		}
		//System.out.println("update pretest_lms set cb_courseid='"+devCourseId+"',unit_ids= '"+uIds+"',lesson_ids='"+lIds+"' where school_id='"+schoolId+"' and exam_id='"+examId+"' and course_id='"+courseId+"' and q_id='"+questionId+"'");
				
		l=st.executeUpdate("update pretest_lms set cb_courseid='"+devCourseId+"',unit_ids= '"+uIds+"',lesson_ids='"+lIds+"' where school_id='"+schoolId+"' and exam_id='"+examId+"' and course_id='"+courseId+"' and q_id='"+questionId+"'");
		m=st1.executeUpdate("update pretest_lms set cb_courseid='"+devCourseId+"' where school_id='"+schoolId+"' and exam_id='"+examId+"' and course_id='"+courseId+"'");
		response.sendRedirect("QuestionMapping.jsp?schoolid="+schoolId+"&examid="+examId+"&courseid="+courseId);
	}
catch(SQLException e)
{
	System.out.println("EXception in SaveUnitsLessons.jsp is..."+e.getMessage());			
}
finally
{
	if(st!=null)
		st.close();
	if(st1!=null)
		st1.close();
	if (con!=null && ! con.isClosed())
		con.close();
}
%>

<H3>..........Successfully Updated............. </H3>

</form>
</body>
</html>
