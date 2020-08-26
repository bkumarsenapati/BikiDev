<%@ page language="java" import="java.sql.*,java.util.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String schoolid="";
	String emailid="";
	String foldername="";
	String sess="";
	Statement st=null;
	Connection con=null;
	ResultSet rs=null;
%>

<%
	session=request.getSession();
	sess =(String)session.getAttribute("sessid");
	if(sess == null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;

	}

	emailid = (String)session.getAttribute("emailid");
	schoolid = (String)session.getAttribute("schoolid");
	out.println("Entered into the try block...");
	foldername = request.getParameter("foldername");
	File createfolder;
	String pfpath = application.getInitParameter("schools_path");
	try
	{
		con=con1.getConnection();
		st=con.createStatement();
		rs=st.executeQuery("select * from teacherpersonaldocs where emailid='"+emailid+"' and schoolid='"+schoolid+"' and foldername='"+foldername+"'");
		if(!rs.next())
		{
			int insertinfo=st.executeUpdate("insert into teacherpersonaldocs values ('"+emailid+"','"+schoolid+"','"+foldername+"')");
			if(insertinfo==1)
			{
				createfolder =new File(pfpath+"/"+schoolid+"/"+emailid+"/PersonalFolders/"+foldername+"");				
				createfolder.mkdirs();
			}
			out.println("Succesfully Created");
			response.sendRedirect("/LBCOM/asm/LeftDir.jsp?emailid="+emailid+"&schoolid="+schoolid+"&tag=new&status=created");
		}
		else
			response.sendRedirect("/LBCOM/asm/LeftDir.jsp?emailid="+emailid+"&schoolid="+schoolid+"&tag=new&status=exist" );
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("CreatePersonalFolder.jsp","operations on database","Exception",e.getMessage());
		
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
		}catch(Exception ex){
			ExceptionsFile.postException("CreatePersonalFolder.jsp","Closing connection and statement objects","Exception",ex.getMessage());
		}
	}
%>