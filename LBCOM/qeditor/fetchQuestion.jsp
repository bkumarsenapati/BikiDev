<%@ page language="java"  import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String qid="",classid="",courseid="",topicid="",subtopicid="",qtype="",urlattach="",pathname="",edittype="";
%>
<%
	session=request.getSession(false);
	String s=(String)session.getAttribute("sessid");
	if(s==null){
		out.println("<html><body><script>window.self.close();window.opener.location.reload(true)</script></body></html>");
		return;
	}
	qid=request.getParameter("qid");
	classid=request.getParameter("classid");
	courseid=request.getParameter("courseid");
	topicid=request.getParameter("topicid");
	subtopicid=request.getParameter("subtopicid");
	qtype=request.getParameter("qtype");
	pathname=request.getParameter("pathname");
	urlattach="?qid="+qid+"&classid="+classid+"&courseid="+courseid+"&topicid="+topicid+"&subtopicid="+subtopicid+"&qtype="+qtype+"&pathname="+pathname+"";
	switch (Integer.parseInt(qtype))  
		{
		case 0:
				 edittype="q_multi_choice";
				 break;
        case 1:
				edittype="q_multi_answer";
				break;
		case 2:
				edittype="q_yes_no";
				break;
		case 3:
				edittype="q_fill_blanks";
				break;
        case 4 :
			    edittype="q_match";
			    break;
		case 5:
				edittype="q_order";
				break;
		case 6:
				edittype="q_short_essay";
				break;
		case 51:
				edittype="q_assignment";
				break;
		default :
				edittype="q_general";
		}

 








%>
	
<HTML>
<HEAD>
<TITLE>Editor</TITLE>
</HEAD>
<frameset rows="*,0,0,0" border="1">
        <frame name="qed_fr" src="<%=edittype%>.jsp<%=urlattach%>" >
        <frame name="qa_fr" src="qa_f.html" noresize>
        <frame name="debug" noresize>
		<frame name="refresh" src="/LBCOM/refreshing.html" noresize>
  </frameset>   
</HTML>













<!--

#!/bin/bash

all="$QUERY_STRING"

echo "Content-type: text/html

<html>
<head>

  <meta http-equiv='Cache-Control' content='no-store'> 
  <meta http-equiv='Expires' content='Mon, 04 Dec 1999 21:29:02 GMT'>

<title>

</title>
</head>
	
  
</html>
-->
