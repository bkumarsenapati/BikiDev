<%@page language="java"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String docName="",topicId="",subTopicId="",maxMarks="",maxAttempts="",markScheme="",cat="",fromDate="",toDate="",workFile="",workId="",comments="",mode="",qtype="",sessionId="",classId="",courseId="";
	int submit=0;
%>
<%
	cat=request.getParameter("categoryid");
	mode=request.getParameter("mode");
	docName=request.getParameter("docname");
	topicId=request.getParameter("topicid");
	subTopicId=request.getParameter("subtopicid");
	maxMarks=request.getParameter("totmarks");
	maxAttempts=request.getParameter("maxattempts");
	markScheme=request.getParameter("markscheme");
	fromDate=request.getParameter("fromdate");
	toDate=request.getParameter("lastdate");
	if(mode.equals("edit")){
		workFile=request.getParameter("workfile");
		workId=request.getParameter("workid");
		comments=request.getParameter("comments");
		submit=Integer.parseInt(request.getParameter("subcount"));
	}
	sessionId=(String)session.getAttribute("sessid");
	classId=(String)session.getAttribute("classid");
	courseId=(String)session.getAttribute("courseid");
	qtype="51";
%>
<html>
<head>
<title></title>
<frameset rows="6%,72%,*" border="0">
	<frame name="tone" scrolling="no" src="editorTop.jsp?docname=<%=docName%>"/>
	<%if(mode.equals("add")){%>
	
	
	<%
		String qepath = application.getInitParameter("q_editor_path");
	%>
	<frame name="ttwo" scrolling="auto" src="/LBCOM/qeditor/fetchQuestion.jsp?sessionid=<%=sessionId%>&qid=new&classid=<%=classId%>&courseid=<%=courseId%>&topicid=<%=topicId%>&subtopicid=<%=subTopicId%>&qtype=<%=qtype%>"/>

	<frame name="tthree" scrolling="auto" src="creatework2.jsp?categoryid=<%=cat%>&docname=<%=docName%>&topicid=<%=topicId%>&subtopicid=<%=subTopicId%>&totmarks=<%=maxMarks%>&maxattempts=<%=maxAttempts%>&markscheme=<%=markScheme%>&fromdate=<%=fromDate%>&lastdate=<%=toDate%>"/>
	<%}else{%>
	<frame name="tthree" scrolling="auto" src="editWork2.jsp?categoryid=<%=cat%>&docname=<%=docName%>&topicid=<%=topicId%>&subtopicid=<%=subTopicId%>&totmarks=<%=maxMarks%>&maxattempts=<%=maxAttempts%>&markscheme=<%=markScheme%>&fromdate=<%=fromDate%>&lastdate=<%=toDate%>&workfile=<%=workFile%>&workid=<%=workId%>&comments=<%=comments%>&subcount=<%=submit%>"/>
	<%}%>
</frameset>
</head>
</html>
