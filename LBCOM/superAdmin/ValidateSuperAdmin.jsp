<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page"/>

<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;

	String userName="",password="",sessId="";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<SCRIPT LANGUAGE="JavaScript">
<!--

//-->
</SCRIPT>
</HEAD>

<BODY topmargin=0 leftmargin=1>
<form name="workdocs">
<% 
	try
	{
		con=db.getConnection();
		st=con.createStatement();
			
		userName=request.getParameter("superadminid");
		password=request.getParameter("password");	 

		rs=st.executeQuery("select password from superadmin_profile where username='"+userName+"' and status=1");
		if(rs.next())
		{
			if(rs.getString("password").equals(password))
			{
				session.setAttribute("sessid",sessId);
				response.sendRedirect("/LBCOM/superAdmin/adminHome.jsp?superid="+userName);
			}
			else
				out.println("Password is wrong");
		}
		else
		{
			out.println("Username does not exist");
			response.sendRedirect("/LBCOM/superAdmin/");
		}
	}
	catch(Exception e)
	{
	   ExceptionsFile.postException("SelectWork.jsp","operations on database","Exception",e.getMessage());
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("SelectWork.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}
	}	
%>

</form>
</BODY>

</HTML>
