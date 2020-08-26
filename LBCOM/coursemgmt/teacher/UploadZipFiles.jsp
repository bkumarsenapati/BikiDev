<html>

<%@page import="java.io.*,coursemgmt.FileHandler,java.util.*,coursemgmt.ExceptionsFile"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String url="",folderName="",schoolId="",teacherId="",courseName="",courseId="",categoryId="",docName="",workId="",sessid="";
	FileHandler fh=null;
	boolean flag=false;
%>

<%
	String schoolPath = application.getInitParameter("schools_path");
	try{
			sessid=(String)session.getAttribute("sessid");
			if(sessid==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			    return;
			}

		teacherId = (String)session.getAttribute("emailid");
    	schoolId = (String)session.getAttribute("schoolid");
		//courseName=(String)session.getAttribute("coursename");
	    courseId=(String)session.getAttribute("courseid");


	    workId=request.getParameter("workid");
		categoryId=request.getParameter("cat");
		folderName=request.getParameter("foldername");
		docName=request.getParameter("docname");		      
		fh=new FileHandler();
		fh.setFileSize((500*1048576));
	
		url=schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+folderName;

//		String files[]=request.getParameterValues("ip");

//		String newPath=url+"/"+mreques  t.getFilesystemName("ip");

		flag=fh.uploadFile(request,url);

	 }catch(IOException e){
		 ExceptionsFile.postException("UploadZipFiles.jsp","uploading zip file","IOException",e.getMessage());
	
//		out.println("<script>");
//		out.println("alert('File is too big.');");
//		out.println("history.go(-1);");	
//		out.println("</script>");
	 }
	
%>

<head>

<script language='javascript'>

	<% if (flag==true) {%>
		alert("File has been uploaded successfully.");
	<% }else { %>
		alert("File upload failed.");
	<% } %>

	window.close();
 

</script>
</head>
<body>
</body>
</html>
