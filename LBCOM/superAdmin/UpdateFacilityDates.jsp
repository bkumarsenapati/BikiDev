<%@  page language="java"  import="java.sql.*,coursemgmt.ExceptionsFile" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null;

	String facilityId="",newEndDate="";

	try
	{
		facilityId=request.getParameter("fid");

		newEndDate=request.getParameter("yyyy")+"-"+request.getParameter("mm")+"-"+request.getParameter("dd");

		con = con1.getConnection();    
		st = con.createStatement();
		
		st.executeUpdate("update school_profile set end_date='"+newEndDate+"' where schoolid='"+facilityId+"'");

		response.sendRedirect("FacilityHome.jsp");
	}
	catch(Exception e)
	{
		System.out.println(e);
		ExceptionsFile.postException("Contactst.jsp","Operations on database ","Exception",e.getMessage());
		out.println("<b>There is an error raised in the search. Please try once again.</b>");
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
			ExceptionsFile.postException("Contactst.jsp","Closing connection objects","Exception",e.getMessage());
			System.out.println("Connection close failed");
		}
	}
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Sl</title>
