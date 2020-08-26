<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>

<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String classId="",schoolId="",workId="",createDate="";
	Connection con=null;
	Statement st1=null,st2=null,st3=null;
	ResultSet rs=null,rs1=null;
%>
<%
	try
	{
		classId=(String)session.getAttribute("classid");
		schoolId = (String)session.getAttribute("schoolid");
		workId=request.getParameter("workid");
		createDate=request.getParameter("createdate");
		String selIds[]=request.getParameterValues("selids");
					
		con=con1.getConnection();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		
		for(int i=0;i<selIds.length;i++)
		{
			st1.executeUpdate("delete from "+schoolId+"_"+workId+"_"+createDate+" where exam_id='"+workId+"' and student_id='"+selIds[i]+"' and count>1");
			st2.executeUpdate("update "+schoolId+"_"+workId+"_"+createDate+" set count=0,status=0 where exam_id='"+workId+"' and student_id='"+selIds[i]+"'");
			st3.executeUpdate("update "+schoolId+"_"+selIds[i]+" set count=0,reassign_status='1' where exam_id='"+workId+"'");
		}
%>
<html>
<body>
<table>
<tr>
<td><b>You have successfully reassigned.</b></td>
</tr>
</table>
</body>
</html>
<%
	}
	catch(Exception e)
	{
		 out.println("Exception Raised in ReAssigning is..."+e+".<a href='javascript:history.go(-1);'>Back</a>");
		 System.out.println("Exception in Reassigning.jsp is"+e);
		//out.println(e.getMessage());
	}
	finally
	{
		try
		{
			if(con!=null)
				con.close();
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("ReAssigning.jsp","clsoing statment object","Exception",e.getMessage());
			System.out.println("Exception in ReAssigning.jsp at the last");
		}
	}
%>
