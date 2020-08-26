<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<html>
<head>
<title></title>
</head>
<body>
<%
	Connection con=null;
	Statement st=null;
	
	String questionId="";

	questionId=request.getParameter("questionid");
	
	try
	{   
		con=con1.getConnection();
		st=con.createStatement();
	
		int i=st.executeUpdate("delete from pretest where question_id='"+questionId+"'");

		if(i>0)
		{
			response.sendRedirect("index.jsp");
		}
	}
	catch(SQLException e)
	{	
		out.println("EXception in DeleteQuestion.jsp is..."+e.getMessage());			
	}
	finally
	{
		if (con!=null && ! con.isClosed())
			con.close();
	}
%>

</body>
</html>
