<%@ page language="java" import="java.sql.*,java.util.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Statement st=null;
	Connection con=null;

	File deletefile=null,deletedoc=null;
	String emailid="",schoolid="",foldername="";
	String totaldocs[];
%>
<%
	session = request.getSession(true);
	String spath = application.getInitParameter("schools_path");
	foldername = request.getParameter("foldername");
	emailid = (String)session.getAttribute("emailid");
	schoolid = (String)session.getAttribute("schoolid");
	try
	{
		con = con1.getConnection();
		st=con.createStatement();
		int i=st.executeUpdate("delete from teacherpersonaldocs where emailid='"+emailid+"' and schoolid='"+schoolid+"' and foldername='"+foldername+"'");
		if(i==1)
		{
deletefile = new File(spath+"/"+schoolid+"/"+emailid+"/PersonalFolders/"+foldername+"");
			totaldocs = deletefile.list();
			if(totaldocs.length>0)  //********** If Directory is not empty*************//
			{
				for(int j=0; j<totaldocs.length; j++)
				{
					deletedoc = new File(spath+"/"+schoolid+"/"+emailid+"/PersonalFolders/"+foldername+"/"+totaldocs[j]+"");
					deletedoc.delete();
				}
				boolean del=deletefile.delete();
				if(del)
				{
					out.println("<font face=verdana size=2><b>Your file has been Successfully Deleted</b></font>");					response.sendRedirect("/LBCOM/asm/LeftDir.jsp?emailid="+emailid+"&schoolid="+schoolid+"&tag=del&status=success");

				}
				else
				{
					out.println("<font face=verdana size=2><b>Your file is not Deleted</b></font>");
					response.sendRedirect("/LBCOM/asm/LeftDir.jsp?emailid="+emailid+"&schoolid="+schoolid+"&tag=del&status=failed");				}
			}
			else                    //********** If Directory is empty*************// 
			{
				
				boolean del1=deletefile.delete();
				if(del1)
				{
					out.println("<font face=verdana size=2><b>Your file has been Successfully Deleted</b></font>");					response.sendRedirect("/LBCOM/asm/LeftDir.jsp?emailid="+emailid+"&schoolid="+schoolid+"&tag=del&status=success");
				}
				else
				{
					out.println("<font face=verdana size=2><b>Folder could not be deleted</b></font>");
					response.sendRedirect("/LBCOM/asm/LeftDir.jsp?emailid="+emailid+"&schoolid="+schoolid+"&tag=del&status=failed");				}
			}
        }
		else
		{
			out.println("<font face=verdana size=2><b>Folder could not be deleted</b></font>");
			response.sendRedirect("/LBCOM/asm/LeftDir.jsp?emailid="+emailid+"&schoolid="+schoolid+"&tag=del");
		}
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("DeletePersonalFolder.jsp","Creating connection and statement objects","Exception",e.getMessage());
		out.println(e);
	}
		finally
		{
			try
				{
				    if(st!=null)
						st.close();	
					if(con!=null && ! con.isClosed())
						con.close();
				}catch(Exception _ex){
					ExceptionsFile.postException("DeletePersonalFolder.jsp","closing connection and statement objects","Exception",_ex.getMessage());
					
		}

%>