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

	String schoolId="",teacherId="",courseName="",classId="",courseId="",questionId="";
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	int i=0,j=0;
	String uIds="",lIds="",uId="";

	try
	{   
		String ids=request.getParameter("selids");
	
		out.println("ids are........."+ids);
	
		con=con1.getConnection();
		st=con.createStatement();
	
		courseId=request.getParameter("courseid");
		questionId=request.getParameter("questionid");
	
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
		
		i=st.executeUpdate("update pretest set unit_ids= '"+uIds+"',lesson_ids='"+lIds+"' where course_id='"+courseId+"' and question_id="+questionId);
		response.sendRedirect("QuestionMapping.jsp?courseid="+courseId);
	}
catch(SQLException e)
{
	System.out.println("EXception in AddSlideCB.jsp is..."+e.getMessage());			
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
