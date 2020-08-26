<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<html>
<head>
<title></title>
</head>
<body>
<form name="show" method="POST">
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;

	String schoolId="",courseId="",studentId="",ansStr="";
	String uId="",uIds="",lIds="",asgnIds="",assessIds="";
	int i=0,j=0;

	try
	{   
		courseId=request.getParameter("courseid");
		studentId=request.getParameter("studentid");

		uIds=request.getParameter("unitids");
//		out.println("uids is........"+uIds);
		lIds=request.getParameter("lessonids");
//		out.println("lids is........"+lIds);
		asgnIds=request.getParameter("asgnids");
//		out.println("asgnds is........"+asgnIds);
		assessIds=request.getParameter("assessids");
//		out.println("assessids is........"+assessIds);
	
		con=con1.getConnection();
		st=con.createStatement();
		
		StringTokenizer idsTkn=new StringTokenizer(uIds,",");
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
		
		i=st.executeUpdate("update pretest_student_material_distribution set unit_ids= '"+uIds+"',lesson_ids='"+lIds+"' ,assignment_ids='"+asgnIds+"' ,assessment_ids='"+assessIds+"' ,status='2' where course_id='"+courseId+"' and student_id='"+studentId+"'");
	}
	catch(SQLException e)
	{
		System.out.println("EXception in MakeDistribution.jsp is..."+e.getMessage());			
	}
	finally
	{	
		if (con!=null && ! con.isClosed())
			con.close();
	}
%>
</form>
<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>
<center>
	<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
    <tr>
		<td width="50%">&nbsp;</td>
    </tr>
    <tr>
		<td width="50%" align="center">
			<b><font face="Verdana" size="2" color="#934900">You have successfully distributed the course.</font></b>
		</td>
    </tr>
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