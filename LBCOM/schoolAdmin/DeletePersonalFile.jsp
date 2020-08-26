<jsp:useBean id="con1" class="sqlbean.DbBean" scope="session" />

<%@ page language="java" import="java.sql.*,java.util.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<%
	Statement st=null;
	Connection con=null;
	ResultSet rs=null;
	File deletedoc=null;
	String adminid=null,schoolid=null,foldername=null,docname=null;
	String totaldocs[];
%>
<%
	String pfpath = application.getInitParameter("schools_path");
	session = request.getSession(true);
	foldername = request.getParameter("foldername");
	docname = request.getParameter("docname");
	adminid = request.getParameter("adminid");
	schoolid = request.getParameter("schoolid");
	try
	{
		con = con1.getConnection();
		deletedoc = new File(pfpath+"/"+schoolid+"/"+adminid+"/PersonalFolders/"+foldername+"/"+docname+"");
		boolean del=deletedoc.delete();
		if(del)
		{
			response.sendRedirect("DeleteDocument.jsp?foldername="+foldername+"&adminid="+adminid+"&schoolid="+schoolid+"");
		}
		else
		{
			response.sendRedirect("FileNotDeleted.jsp?foldername="+foldername+"&adminid="+adminid+"&schoolid="+schoolid+"");
		}
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("DeletePersonalFile.jsp","Operations on database ","Exception",e.getMessage());
		out.println(e);
	}
	finally{
		try{
			if(con!=null)
				con.close();
		}catch(Exception e){
			ExceptionsFile.postException("DeletePersonalFile.jsp","closing connection file","Exception",e.getMessage());
			System.out.println("Connection close failed");
		}
	}
%>
