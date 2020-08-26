<HTML>
<%@ page import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
    Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String qId=null,qBody=null,schoolId=null,classId=null,courseId=null;
	String qType=null;
	
%>
<%
		
	try
	{
		schoolId = request.getParameter("schoolid");
		classId = request.getParameter("classid");
		courseId = request.getParameter("courseid");
		qType = request.getParameter("q_type");
		qId = request.getParameter("q_id");
		qBody=request.getParameter("qbody");
		con=con1.getConnection();
		st=con.createStatement();
		st.executeUpdate("update "+schoolId+"_"+classId+"_"+courseId+"_quesbody set q_body='"+qBody+"' where q_id='"+qId+"'");
						
	}
	catch(Exception e)
	{
		System.out.println("Exception in SubmitQuestion.jsp is..."+e);
		ExceptionsFile.postException("SubmitQuestion.jsp","Operations on database","Exception",e.getMessage());
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();			//finally close the statement object
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("SubmitQuestion.jsp","closing connection object","SQLException",se.getMessage());
			System.out.println("Exception in SubmitQuestion.jsp is..."+se.getMessage());
		}
	}
%>

<head><title></title>
</head>
<SCRIPT LANGUAGE="JavaScript" src="../teacher/validationscripts.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" src="/LBCOM/validationscripts.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">

</SCRIPT>

<BODY topmargin="3" leftmargin="3" bgcolor="#EBF3FB">
<hr>
<center>
</center>
</form>
</BODY>
</HTML>
