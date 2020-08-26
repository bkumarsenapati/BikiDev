<%@ page language="java" import="java.io.File"%>
<%@ page errorPage="/ErrorPage.jsp" %>

<%
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}

	String examId=request.getParameter("examid");
	String examName=request.getParameter("examname");
	String maxAttempts=request.getParameter("maxattempts");
	String createdDate=request.getParameter("crdate");	
	String teacherId=request.getParameter("teacherid");
	String courseId=request.getParameter("courseid");
	String version=request.getParameter("version");
	String submissionNo=request.getParameter("submission_no");
	
	String schoolId=(String)session.getAttribute("schoolid");
	String studentId=(String)session.getAttribute("emailid");
	String stuPassword=request.getParameter("stupassword");
	String resScriptFilePath="";
	String dispPath=(String)session.getAttribute("schoolpath")+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId;
	String path=application.getInitParameter("schools_path")+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId;
	File resScriptFile=new File(path+"/responses/"+studentId+"/"+submissionNo+"/"+submissionNo+".html");
	if(!resScriptFile.exists()){

		resScriptFilePath="resScriptFile.jsp?examid="+examId+"&createddate="+createdDate+"&stupassword="+stuPassword+"&version="+version;
	}else{
		resScriptFilePath=dispPath+"/responses/"+studentId+"/"+submissionNo+"/"+submissionNo+".html";
	}
	//resScriptFilePath=dispPath+"/responses/"+studentId+"/"+submissionNo+"/"+submissionNo+".html";

%>
<HTML>
<HEAD>
<title>.:: Welcome to www.hotschools.net ::. [ for quality eLearning experience ]</title>
<SCRIPT LANGUAGE="JavaScript">
 <!--
 var versn='<%=version%>';
 var chances='<%=maxAttempts%>';
 var subAllowed='<%=maxAttempts%>';



 //-->
 </SCRIPT>
</HEAD>


	  <FRAMESET ROWS="20%,70%,*" BORDER=0>
		<FRAME NAME='top_f' src="<%=dispPath%>/top.html" scrolling="no">
		<FRAME NAME='mid_f' src="<%=dispPath%>/1.html" scrolling="auto">
		<FRAME NAME='btm_f' src="<%=resScriptFilePath%>" scrolling=yes>
	  </FRAMESET>
	  
	  
</FRAMESET>
</HTML>

