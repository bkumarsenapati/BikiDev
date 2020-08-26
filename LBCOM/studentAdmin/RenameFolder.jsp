

<%
	Statement st=null;
	ResultSet rs=null;
	Connection con=null;
	File renamefolder=null,destinationfolder=null;
	boolean bool=false;
	boolean exist=false;
	String emailid=null,schoolid=null,foldername=null,newfoldername=null,idx=null;
%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%@ page language="java" import="java.sql.*,java.util.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String pfpath = application.getInitParameter("schools_path");
	session = request.getSession(true);
	foldername = request.getParameter("foldername");

	newfoldername = request.getParameter("newfoldername").trim();
	idx=request.getParameter("idx");
	emailid = (String)session.getAttribute("emailid");
	schoolid = (String)session.getAttribute("schoolid");
	try
	{
		con = con1.getConnection();
		st=con.createStatement();
		
		rs=st.executeQuery("select count(*) as c  from studentpersonaldocs where emailid='"+emailid+"' and schoolid='"+schoolid+"' and foldername='"+newfoldername+"'");

	
		
		if(rs.next()){

			if (rs.getInt("c")>0)
				exist=true;
			else
				exist=false;
		
	    }

		if (exist==false){

			int renameinfo=st.executeUpdate("update studentpersonaldocs set foldername='"+newfoldername+"' where emailid='"+emailid+"' and schoolid='"+schoolid+"' and foldername='"+foldername+"'");
			if(renameinfo==1)
			{
renamefolder = new File(pfpath+"/"+schoolid+"/"+emailid+"/PersonalFolders/"+foldername+"");
destinationfolder = new File(pfpath+"/"+schoolid+"/"+emailid+"/PersonalFolders/"+newfoldername+"");
				renamefolder.renameTo(destinationfolder);
				out.println("<font face=verdana size=2><b>Successfully Done</font></b>");			
				response.sendRedirect("/LBCOM/studentAdmin/LeftDir.jsp?emailid="+emailid+"&schoolid="+schoolid+"&tag=ren&newfoldername="+newfoldername+"&idx="+idx+"&status=success");

			}
			else
			{
				out.println("<font face=verdana size=2><b>Not Done</font></b>");			response.sendRedirect("/LBCOM/studentAdmin/LeftDir.jsp?emailid="+emailid+"&schoolid="+schoolid+"&tag=ren&idx="+idx+"&status=failed");
			}

		}
		else
		{
					out.println("<font face=verdana size=2><b>Already exists</font></b>");			response.sendRedirect("/LBCOM/studentAdmin/LeftDir.jsp?emailid="+emailid+"&schoolid="+schoolid+"&tag=ren&idx="+idx+"&status=failed");
		}
	}
	catch(Exception e)
	{
		 ExceptionsFile.postException("RenameFolder.jsp","operations on database","Exception",e.getMessage());
		out.println(e);
	}
	
	finally
		{
			try
				{
					if(rs!=null)
						rs.close();
					if(st!=null)
						st.close();
					
					if(con!=null && !con.isClosed())
						con.close();
				}catch(Exception e){
					ExceptionsFile.postException("RenameFolder.jsp","closing statement,resultset and connection objects","Exception",e.getMessage());
					System.out.println("Connection close failed");
				}
		}

%>