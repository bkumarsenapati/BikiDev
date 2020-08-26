<%@ page language="java" import="java.sql.*,java.util.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Statement st=null;
	ResultSet rs=null;
	Connection con=null;
	File renamefolder=null,destinationfolder=null;
	boolean bool=false;
	boolean exist=false;
	String emailid="",schoolid="",foldername="",newfoldername="",idx="";
%>


<%
	session = request.getSession(true);
	String pfpath = application.getInitParameter("schools_path");
	foldername = request.getParameter("foldername");
	newfoldername = request.getParameter("newfoldername");
	emailid = (String)session.getAttribute("emailid");
	schoolid = (String)session.getAttribute("schoolid");
	idx=request.getParameter("idx");

	try
	{
		con = con1.getConnection();
		st=con.createStatement();

		rs=st.executeQuery("select count(*) as c  from teacherpersonaldocs where emailid='"+emailid+"' and schoolid='"+schoolid+"' and foldername='"+newfoldername+"'");
		
		if(rs.next()){

			if (rs.getInt("c")>0)
				exist=true;
			else
				exist=false;
		
	    }

		if (exist==false){

			int renameinfo=st.executeUpdate("update teacherpersonaldocs set foldername='"+newfoldername+"' where emailid='"+emailid+"' and schoolid='"+schoolid+"' and foldername='"+foldername+"'");

			if(renameinfo==1)
			{
				renamefolder = new File(pfpath+"/"+schoolid+"/"+emailid+"/PersonalFolders/"+foldername+"");
	destinationfolder = new File(pfpath+"/"+schoolid+"/"+emailid+"/PersonalFolders/"+newfoldername+"");
				renamefolder.renameTo(destinationfolder);
				out.println("<font face=verdana size=2><b>Successfully Done</font></b>");
				response.sendRedirect("/LBCOM/asm/LeftDir.jsp?emailid="+emailid+"&schoolid="+schoolid+"&tag=ren&newfoldername="+newfoldername+"&idx="+idx+"&status=success");

			}
			else{
				out.println("<font face=verdana size=2><b>Not Done</font></b>");
				response.sendRedirect("/LBCOM/asm/LeftDir.jsp?emailid="+emailid+"&schoolid="+schoolid+"&tag=ren&idx="+idx+"&status=failed");
			}

		}
		else{
			out.println("<font face=verdana size=2><b>Already exists</font></b>");			response.sendRedirect("/LBCOM/asm/LeftDir.jsp?emailid="+emailid+"&schoolid="+schoolid+"&tag=ren&idx="+idx+"&status=failed");
		}

	}
	catch(Exception e)
	{
		ExceptionsFile.postException("RenameFolder.jsp","Operations on database and files ","Exception",e.getMessage());
		out.println(e);
	}
	finally
		{
			try
				{
					if(st!=null)
						st.close();
					if(con!=null && !con.isClosed())				
						con.close();
				}catch(Exception ex){
					ExceptionsFile.postException("GradeCourse.jsp","closing connection, statement and resultset objects ","Exception",ex.getMessage());
					
				}
		}
%>
