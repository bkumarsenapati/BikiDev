<%@ page language="java" import="java.sql.*,java.util.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String schoolid=null;
	String emailid=null;
	String foldername=null;
	Statement st=null;
	Connection con=null;
	ResultSet rs=null;
%>

<%
	String pfpath = application.getInitParameter("schools_path");
	emailid = (String)session.getAttribute("emailid");
	schoolid = (String)session.getAttribute("schoolid");
	foldername = request.getParameter("foldername");
	File createfolder;
	try
	{
		con = con1.getConnection();
		st=con.createStatement();
		rs=st.executeQuery("select * from studentpersonaldocs where emailid='"+emailid+"' and schoolid='"+schoolid+"' and foldername='"+foldername+"'");
		if(!rs.next())
		{
			
			int insertinfo=st.executeUpdate("insert into studentpersonaldocs values ('"+emailid+"','"+schoolid+"','"+foldername+"')");
			if(insertinfo==1)
			{
				createfolder =new File(pfpath+"/"+schoolid+"/"+emailid+"/PersonalFolders/"+foldername+"");
				createfolder.mkdirs();
			}
			out.println("Succesfully Created");
			response.sendRedirect("/LBCOM/studentAdmin/LeftDir.jsp?emailid="+emailid+"&schoolid="+schoolid+"&tag=new&status=created");
		}
		else{
			response.sendRedirect("/LBCOM/studentAdmin/LeftDir.jsp?emailid="+emailid+"&schoolid="+schoolid+"&tag=new&status=exist");
		}

	}
	catch(Exception e)
	{
		ExceptionsFile.postException("CreatePersonalFolder.jsp","operations on database","Exception",e.getMessage());
		out.println("Sessin has been expired...You need to login again.. ");
	}

	finally
		{
			try
				{
					if(rs!=null)
						rs.close();
					if(st!=null)
						st.close();
					
					if(con!=null)
						con.close();
				}catch(Exception e){
					ExceptionsFile.postException("CreatePersonalFolder.jsp","closing statement,result and connection objects","Exception",e.getMessage());
					System.out.println("Connection close failed");
				}
		}
%>