<%@ page language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String categoryId="",classId="",courseName="",filePath="",workId="",studentId="";
	int status=0;
	int maxMarks=0;
%>
<%
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
//	courseName=(String)session.getAttribute("coursename");
	studentId=request.getParameter("studentid");
	categoryId=request.getParameter("cat");
	filePath=request.getParameter("filepath");
	
	maxMarks=Integer.parseInt(request.getParameter("maxmarks"));
	workId=request.getParameter("workid");
	status=Integer.parseInt(request.getParameter("status"));
%>
<html>
<head>
<title></title><meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>

<frameset rows="80%,*" noborders framespacing="0" border="0" frameborder="0" topmargin="0" >

  <% if (status>=4) {	  %>
	    <frame name="first" src="<%=filePath%>" scrolling="yes" marginwidth="0" marginheight="0"> 
	    <frame name="second" src="about:blank" marginwidth="0" marginheight="0" scrolling="auto">   <% }
	 else {   
	     if (status==2) {%>
            <frame name="first" src="TeacherChangeStatus.jsp?workfile=<%=filePath%>&workid=<%=workId%>&studentid=<%=studentId%>" scrolling="yes" marginwidth="0" marginheight="0">       <%}
         if (status==3) { %>
			<frame name="first" src="<%=filePath%>" scrolling="yes" marginwidth="0" marginheight="0"> <%}%>

         <frame name="second" src="TeacherSubmitButton.jsp?maxmarks=<%=maxMarks%>&cat=<%=categoryId%>&workid=<%=workId%>&studentid=<%=studentId%>" marginwidth="0" marginheight="0" scrolling="auto">    
		<%}%>
  
  <noframes>
  <body topmargin="0" leftmargin="0">

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</frameset>

</html>
