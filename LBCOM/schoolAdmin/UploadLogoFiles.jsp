<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<head>
<title>Upload Logo</title>
</head>

<%@ page language="java" contentType="text/html" import = "java.io.*" import  = 'com.oreilly.servlet.*' %>
<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.util.*,utility.FileUtility,java.lang.String,com.oreilly.servlet.MultipartRequest,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String url="",attachFileName="",schoolId="",sessid="",fileName="",mode=""; 
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs1=null;
	boolean flag=false;
	int j=0;
%>

<% 
    String schoolPath = application.getInitParameter("app_path");
    try
    {	

			sessid=(String)session.getAttribute("sessid");
			if(sessid==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			

			con=con1.getConnection();
			st=con.createStatement();
			st1=con.createStatement();
			schoolId = (String)session.getAttribute("schoolid");
			mode=request.getParameter("mode");

		  
		   
		   if(!mode.equals("cancel"))
			{
				   url=schoolPath+"/images/hsn/";
				   FileUtility fu=new FileUtility();
			   
				MultipartRequest mreq = new MultipartRequest(request, url,10*1024*1024);
				 attachFileName=mreq.getFilesystemName("logofile");
			   if(attachFileName==null)
				{
					attachFileName="";							//Not selected the attach file
				}
				else
				{
					attachFileName=attachFileName.replace('#','_');
					fileName=attachFileName;
																			//rename the uploaded file to uploadNo_fileName
					attachFileName=schoolId+"_"+attachFileName;
					fu.renameFile(url+"/"+fileName,url+"/"+attachFileName);
				}
				
				

				//response.sendRedirect("../coursemgmt/CourseFileManager.jsp?foldername="+folderName);
					rs1=st1.executeQuery("select school_id from cobrand_logo where school_id='"+schoolId+"'");
					 if(rs1.next())
					{
						//logo_name=attachFileName;
						flag=true;
						
					}
					if(flag==false)
					{
						 j=st.executeUpdate("insert into cobrand_logo(school_id,logo_name) values ('"+schoolId+"','"+attachFileName+"')");
				   //response.sendRedirect("/LBCOM/schoolAdmin/schooladmin1.jsp");

			}
			else
			{

				j=st.executeUpdate("update cobrand_logo set logo_name='"+attachFileName+"' where school_id='"+schoolId+"'");
			}
			rs1.close();
			%>
				<script>
					parent.banner.location.reload(true);
					parent.main.location.href="setupmain.jsp";
				</script>
				<%
		}
		else
		{
				j=st.executeUpdate("delete from cobrand_logo where school_id='"+schoolId+"'");
				%>
				<script>
					opener.location.reload();
				</script>
				<%
				
		}

		

      
       
    }
	catch(Exception e)
	{
		
		ExceptionsFile.postException("UploadLogoFile.jsp"," uploading","Exception",e.getMessage());
		
		
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			System.out.println("Error:  in finally of UploadLogoFile.jsp : pretest -"+se.getMessage());
		}
	}
%>



<body>
<form>
<script>


self.close();

</script>
Logo Successfully Uploaded!!!
</form>
</BODY>
</HTML>
