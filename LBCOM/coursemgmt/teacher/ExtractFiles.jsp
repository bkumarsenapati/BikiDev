<%@page import="coursemgmt.FileHandler"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String folderName="",fileName="",url="",courseId="",categoryId="",teacherId="",schoolId="",sessid="",workId="",docName="";
	FileHandler fh=null;
	boolean flag=false;
%>
<%
	String schoolPath = application.getInitParameter("schools_path");
	sessid=(String)session.getAttribute("sessid");
	
	if(sessid==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	schoolId=(String)session.getAttribute("schoolid");
	teacherId=(String)session.getAttribute("emailid");
	courseId=(String)session.getAttribute("courseid");

	fileName=request.getParameter("filename");
	folderName=request.getParameter("foldername");
	categoryId=request.getParameter("cat");
	workId=request.getParameter("workid");
	docName=request.getParameter("docname");
	

	fh=new FileHandler();

	url=schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+folderName;
	

	flag=fh.extractZipFile(fileName,url);

	%>	
	
	<script language="javascript">

	<%

		if (flag==false)	
			out.println("alert(\"File extraction failed.\");");

		out.println("parent.bottompanel.location.href='CourseFileManager.jsp?workid="+workId+"&foldername="+folderName+"&docname="+docName+"&cat="+categoryId+"';");

	%>
	</script>

