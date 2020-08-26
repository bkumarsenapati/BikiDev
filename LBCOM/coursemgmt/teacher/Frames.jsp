<%@ page errorPage="/ErrorPage.jsp" %>
<%
  String start="",courseName="",docName="",workFile="",workId="",categoryId="",studentId="",courseId="",schoolId="",comments="",wFile="",remarks="";
  String submitDate="",marksSecured="",maxMarks="",count="",sessid="";
  int status=0,totRecords=0;

%>
<%
	 sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	schoolId=(String)session.getAttribute("schoolid");
	courseId=(String)session.getAttribute("courseid");

	categoryId=request.getParameter("cat");
	workId=request.getParameter("workid");
	studentId=request.getParameter("studentid");
	docName=request.getParameter("docname");
	workFile=request.getParameter("workfile");
	comments=request.getParameter("comments");
	maxMarks=request.getParameter("maxmarks");
	marksSecured=request.getParameter("marks");

	status=Integer.parseInt(request.getParameter("status"));
	totRecords=Integer.parseInt(request.getParameter("totrecords"));

	remarks=request.getParameter("remarks");
	submitDate=request.getParameter("submitdate");
	count=request.getParameter("count");
	wFile=workFile;	
	workFile=(String)session.getAttribute("schoolpath")+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+workFile;
%>
<HTML>
<HEAD>
<TITLE>A frameset document</TITLE>
</HEAD>

<frameset rows="20%,70%,*" border="2" bordercolor="red">
	<FRAME name="first" scrolling="no" src="Navigation.jsp?&cat=<%=categoryId%>&workid=<%=workId%>&docname=<%=docName%>&totrecords=<%=totRecords%>&maxmarks=<%=maxMarks%>&studentid=<%=studentId%>">
<%  
	if(status<3) 
	{
%>
		<frame name="second" src="TeacherChangeStatus.jsp?workfile=<%=workFile%>&workid=<%=workId%>&cat=<%=categoryId%>&studentid=<%=studentId%>&count=<%=count%>">
<% 
	}
	else
	{
%>
		<frame name="second" src="<%=workFile%>"> 
<%
	}
%>
	<frame name="third" scrolling="no" src="TeacherSubmitButton.jsp?workid=<%=workId%>&workfile=<%=wFile%>&cat=<%=categoryId%>&coursename=<%=courseName%>&studentid=<%=studentId%>&status=<%=status%>&maxmarks=<%=maxMarks%>&marks=<%=marksSecured%>&comments=<%=comments%>&docname=<%=docName%>&remarks=<%=remarks%>&submitdate=<%=submitDate%>&count=<%=count%>">
</FRAMESET>
</HTML>
