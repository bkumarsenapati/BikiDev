<%@ page language="java" import="java.sql.*,java.util.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<%
	File deletedoc=null;
	String emailid="",schoolid="",foldername="",docname="";
	String totaldocs[];
%>
<%
	session = request.getSession(true);
	String pfpath = application.getInitParameter("schools_path");
	foldername = request.getParameter("foldername");
	docname = request.getParameter("docname");
	emailid = request.getParameter("emailid");
	schoolid = request.getParameter("schoolid");
	try
	{
		deletedoc = new File(pfpath+"/"+schoolid+"/"+emailid+"/PersonalFolders/"+foldername+"/"+docname+"");
		boolean del=deletedoc.delete();
		if(del)
		{
			response.sendRedirect("DeleteDocument.jsp?foldername="+foldername+"&emailid="+emailid+"&schoolid="+schoolid+"");
		}
		else
		{
			response.sendRedirect("FileNotDeleted.jsp?foldername="+foldername+"&emailid="+emailid+"&schoolid="+schoolid+"");
		}
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("DeletePersonalFile.jsp"," Operations on File Objects","Exception",e.getMessage());
		out.println(e);
	}
%>
