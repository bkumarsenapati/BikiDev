<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
   String folderName="",docName="",tag="",categoryId="",workId="",sessid="";
   String fileName="",fileContent="",schoolId="",teacherId="",courseId="",filedata="";
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

  	sessid=(String)session.getAttribute("sessid");
			if(sessid==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
			}
%>

<HTML>
<HEAD>
<TITLE><%=application.getInitParameter("title")%></TITLE>
<script language="javascript" src="../../validationscripts.js"></script> 

</HEAD>

<BODY>
<form name="desc" method="post" action="/LBCOM/coursemgmt/teacher/CreateFile.jsp?workid=<%=workId%>&cat=<%=categoryId%>&docname=<%=docName%>&foldername=<%=folderName%>" onsubmit=" return check();">
 

<%
		RandomAccessFile outData=null;
		outData=new RandomAccessFile(schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+folderName+"/"+fileName+".html","rw");
		filedata="<HTML><HEAD><TITLE>.::www.learnbeynd.com::.</TITLE></head><BODY>";

		filedata+=fileContent;
		filedata+="</BODY></HTML>";
		outData.writeBytes(filedata);
		//out.print(filedata);
		outData.close();
%>
</form>
<script language='javascript'>

	<% if (flag==true) {%>
		alert("File is created successfully.");
	<% }else { %>
		alert("File upload failed.");
	<% } %>
	
	window.opener.location.href="/LBCOM/coursemgmt/teacher/CourseFileManager.jsp?workid=<%=workId%>&foldername=<%=folderName%>&docname=<%=docName%>&cat=<%=categoryId%>";
	
	window.close();
 

</script>
</BODY>
</HTML>
