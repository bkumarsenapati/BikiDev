<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

<%@ page language="java" contentType="text/html" import = "java.io.*" import  = 'com.oreilly.servlet.*' %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String url="",folderName="",schoolId="",teacherId="",courseName="",categoryId="",docName="",courseId="",workId="",sessid="";  
%>

<% 
    String schoolPath = application.getInitParameter("schools_path");
    try
    {	

			sessid=(String)session.getAttribute("sessid");
			if(sessid==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}

		teacherId = (String)session.getAttribute("emailid");
    	schoolId = (String)session.getAttribute("schoolid");
	   // courseName=(String)session.getAttribute("coursename");
	    courseId=(String)session.getAttribute("courseid");

		workId=request.getParameter("workid");
		categoryId=request.getParameter("cat");
		folderName=request.getParameter("foldername");
		docName=request.getParameter("docname");
		
		url=schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+folderName;
       
		MultipartRequest mrequest = new MultipartRequest(request, url,10*1048576);

      	//response.sendRedirect("../coursemgmt/CourseFileManager.jsp?foldername="+folderName);
       
       
    }
	catch(Exception e)
	{
		
		ExceptionsFile.postException("uploadMultipleFile.jsp"," uploading","Exception",e.getMessage());
		out.println("<script>");
		out.println("alert('File is bigger than 10 MB. Upload failed.');");
		out.println("history.go(-1);");
		
		out.println("</script>");
	}
%>
</head>

<script>

// top.frames[0].frames[1].location.href="../coursemgmt/CourseFileManager.jsp?foldername=<%=folderName%>";
window.opener.location.href="CourseFileManager.jsp?workid=<%=workId%>&foldername=<%=folderName%>&docname=<%=docName%>&cat=<%=categoryId%>";
 window.close();
 

</script>

<BODY>

</BODY>
</HTML>
