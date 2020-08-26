<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ page language="java" import="java.sql.*,java.util.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<%
	String schoolid="";
	String adminid="";
	String foldername="";
	Statement st=null;
	Connection con=null;
	ResultSet rs=null;
%>

<%
	String pfpath = application.getInitParameter("schools_path");
	adminid = (String)session.getAttribute("adminid");
	schoolid = (String)session.getAttribute("schoolid");
	foldername = request.getParameter("foldername");
	File createfolder;
	try
	{
		con = con1.getConnection();
		st=con.createStatement();
		rs=st.executeQuery("select * from personaldocs where adminid='"+adminid+"' and schoolid='"+schoolid+"' and foldername='"+foldername+"'");
		if(!rs.next())
		{
			int insertinfo=st.executeUpdate("insert into personaldocs values ('"+adminid+"','"+schoolid+"','"+foldername+"')");
			if(insertinfo==1)
			{
				//createfolder =new File("C:/Tomcat 5.0/webapps/LBCOM/schools/PersonalFolders/"+schoolid+"/"+adminid+"/"+foldername+"");
				createfolder =new File(pfpath+"/"+schoolid+"/"+adminid+"/PersonalFolders/"+foldername+"");
				createfolder.mkdirs();
			}
			out.println("Succesfully Created");
			response.sendRedirect("LeftDir.jsp?adminid="+adminid+"&schoolid="+schoolid+"&tag=new&status=created");
		}
		else
			response.sendRedirect("LeftDir.jsp?adminid="+adminid+"&schoolid="+schoolid+"&tag=new&status=exist" );
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("CreatePersonalFolder.jsp","Operations on database ","Exception",e.getMessage());
		out.println("Session has been expired...You need to login again.. ");
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
					ExceptionsFile.postException("CreatePersonalFolder.jsp","clsoing statement,resultset and connection objects ","Exception",e.getMessage());
					System.out.println("Connection close failed");
				}
		}

%>
