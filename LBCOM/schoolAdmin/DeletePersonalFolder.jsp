<jsp:useBean id="con1" class="sqlbean.DbBean" scope="session" />

<%@ page language="java" import="java.sql.*,java.util.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<%
	Statement st=null;
	Connection con=null;

	File deletefile=null,deletedoc=null;
	String adminid="",schoolid="",foldername="";
	String totaldocs[];
%>
<%
	String pfpath = application.getInitParameter("schools_path");
	session = request.getSession(true);
	foldername = request.getParameter("foldername");
	adminid = (String)session.getAttribute("adminid");
	schoolid = (String)session.getAttribute("schoolid");
	try
	{
		con = con1.getConnection();
		con.setAutoCommit(false);
		st=con.createStatement();
		
		int i=st.executeUpdate("delete from personaldocs where adminid='"+adminid+"' and schoolid='"+schoolid+"' and foldername='"+foldername+"'");
		con.commit();
		if(i==1)
		{
			deletefile = new File(pfpath+"/"+schoolid+"/"+adminid+"/PersonalFolders/"+foldername+"");
			totaldocs = deletefile.list();
			if(totaldocs.length>0)  //********** If Directory is not empty*************//
			{
				for(int j=0; j<totaldocs.length; j++)
				{
					deletedoc = new File(pfpath+"/"+schoolid+"/"+adminid+"/PersonalFolders/"+foldername+"/"+totaldocs[j]+"");
					deletedoc.delete();
				}
				boolean del=deletefile.delete();
				if(del)
				{
					out.println("<font face=verdana size=2><b>Your file has been Successfully Deleted</b></font>");
					response.sendRedirect("/LBCOM/schoolAdmin/LeftDir.jsp?adminid="+adminid+"&schoolid="+schoolid+"&tag=del&status=success");
				}
				else
				{
					out.println("<font face=verdana size=2><b>Your file is not Deleted</b></font>");
					response.sendRedirect("/LBCOM/asm/LeftDir.jsp?adminid="+adminid+"&schoolid="+schoolid+"&tag=del&status=failed");
				}
			}
			else                    //********** If Directory is empty*************// 
			{
				
				boolean del1=deletefile.delete();
				if(del1)
				{
					out.println("<font face=verdana size=2><b>Your file has been Successfully Deleted</b></font>");					response.sendRedirect("/LBCOM/schoolAdmin/LeftDir.jsp?adminid="+adminid+"&schoolid="+schoolid+"&tag=del&status=success");
				}
				else
				{
					out.println("<font face=verdana size=2><b>Folder could not be deleted</b></font>");
					response.sendRedirect("/LBCOM/asm/LeftDir.jsp?adminid="+adminid+"&schoolid="+schoolid+"&tag=del&status=failed");
				}
			}
        }
		else
		{
			out.println("<font face=verdana size=2><b>Folder could not be deleted</b></font>");
			response.sendRedirect("/LBCOM/schoolAdmin/LeftDir.jsp?adminid="+adminid+"&schoolid="+schoolid+"&tag=del");
		}
	}
	catch(SQLException e)
	{
		ExceptionsFile.postException("DeletePersonalFolder.jsp","Operations on database ","SQLException",e.getMessage());
		out.println(e);
	}
	finally
		{
			try
				{
					if(st!=null)
						st.close();
					if(con!=null)
						con.close();
				}catch(Exception e){
					ExceptionsFile.postException("dletepersonalfolder.jsp","closing connection and statement objects","Exception",e.getMessage());
					System.out.println("Connection close failed");
				}
		}

%>