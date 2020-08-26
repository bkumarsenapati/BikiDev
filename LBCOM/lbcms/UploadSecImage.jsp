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
	String url="",attachFileName="",sessid="",fileName="",mode="",schoolId=""; 
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",developerId="";
	String secTitle="";
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs1=null;
	boolean flag=false;
	int j=0;
%>

<% 
    String devPath= application.getInitParameter("lbcms_dev_path");
    try
    {	

			sessid=(String)session.getAttribute("sessid");
			if(sessid==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			

			con=con1.getConnection();
			st=con.createStatement();
			schoolId = "psk";
			mode=request.getParameter("mode");
			courseId=request.getParameter("courseid");
			courseName=request.getParameter("coursename");
			developerId=request.getParameter("userid");
			unitId=request.getParameter("unitid");
			unitName=request.getParameter("unitname");
			lessonId=request.getParameter("lessonid");
			lessonName=request.getParameter("lessonname");
			secTitle=request.getParameter("sectitle");
			System.out.println("mode is ..."+mode);

		  
		   
		   if(!mode.equals("cancel"))
			{
				   url=devPath+"/coursebuilder/SectionImages/";
				   System.out.println("url...."+url);
				   FileUtility fu=new FileUtility();
			    System.out.println("before Multipart");
				MultipartRequest mreq = new MultipartRequest(request, url,10*1024*1024);
				 System.out.println("after Multipart");
				 attachFileName=mreq.getFilesystemName("logofile");
				 System.out.println("attachFileName...."+attachFileName);
			   if(attachFileName==null)
				{
					attachFileName="";							//Not selected the attach file
				}
				else
				{
					attachFileName=attachFileName.replace('#','_');
					fileName=attachFileName;
					 System.out.println("before attachFileName...."+attachFileName);
																			//rename the uploaded file to uploadNo_fileName
					attachFileName=schoolId+"_"+attachFileName;
					fu.renameFile(url+"/"+fileName,url+"/"+attachFileName);
					 System.out.println(" after attachFileName...."+attachFileName);
				}
				
				
				 j=st.executeUpdate("insert into lbcms_dev_sec_icons_master(image_name) values ('"+attachFileName+"')");
				 				
			}
			else
			{
				j=st.executeUpdate("delete from lbcms_dev_sec_icons_master where image_id=1");
							
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

Image Successfully Uploaded!!!
		<script>
					window.location.href="SelectAllImages.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&sectitle=<%=secTitle%>";
		</script>
</form>
</BODY>
</HTML>
