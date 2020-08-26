<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="java.sql.*,java.util.*,java.io.*,java.lang.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
   String folderName="",docName="",tag="",categoryId="",workId="",sessid="";
   String fileName="",fileContent="",schoolId="",teacherId="",courseId="",filedata="";
   String fPath="";
   boolean flag=true;
%>
<%
	String schoolPath = application.getInitParameter("schools_path");
	teacherId = (String)session.getAttribute("emailid");
    schoolId = (String)session.getAttribute("schoolid");
	courseId=(String)session.getAttribute("courseid");

  folderName=request.getParameter("foldername");
  workId= request.getParameter("workid");
  docName=request.getParameter("docname");
  categoryId=request.getParameter("cat");
  fileName=request.getParameter("ftitle");
  fileContent=request.getParameter("filecontent");

  System.out.println("fileContent..."+fileContent);


  fPath=request.getParameter("fpath");

  	sessid=(String)session.getAttribute("sessid");
			if(sessid==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
			}
%>


<!-- <form name="desc" method="post" action="/LBCOM/coursemgmt/teacher/CreateFile.jsp?workid=<%=workId%>&cat=<%=categoryId%>&docname=<%=docName%>&foldername=<%=folderName%>" onsubmit=" return check();"> -->
 

<%
		System.out.println("fPath..."+fPath);

		File myFile = new File(fPath);
		FileOutputStream fooStream = new FileOutputStream(myFile, false); // true to append
																		 // false to overwrite.
		byte[] myBytes = fileContent.getBytes(); 
		fooStream.write(myBytes);
		fooStream.close();
%>
<!-- </form> -->
<script language='javascript'>

	<% if (flag==true) {%>
		alert("File is created successfully.");
	<% }else { %>
		alert("File upload failed.");
	<% } %>
	
	window.location.href="/LBCOM/coursemgmt/teacher/CourseFileManager.jsp?workid=<%=workId%>&foldername=<%=folderName%>&docname=<%=docName%>&cat=<%=categoryId%>";

</script>
