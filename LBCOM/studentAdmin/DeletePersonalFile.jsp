<%@ page language="java" import="java.sql.*,java.util.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Statement st=null;
	Connection con=null;
	ResultSet rs=null;
	File deletedoc=null;
	String emailid=null,schoolid=null,foldername=null,docname=null;
	String totaldocs[];
%>
<%
	String pfpath = application.getInitParameter("schools_path");
	session = request.getSession(true);
	foldername = request.getParameter("foldername");
	docname = request.getParameter("docname");
	emailid = request.getParameter("emailid");
	schoolid = request.getParameter("schoolid");
	try
	{
		con = con1.getConnection();		
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
		ExceptionsFile.postException("DeletePersonalFile.jsp","operations on database","Exception",e.getMessage());
		out.println(e);
	}finally{
		try{
			if(con!=null &!con.isClosed())
				con.close();
		}catch(Exception e){
			ExceptionsFile.postException("DeletePersonalFile.jsp","closing connection object","Exception",e.getMessage());
			System.out.println("Connection close failed");
		}
	}
%>
