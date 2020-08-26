<%@ page errorPage="/ErrorPage.jsp" %>
<%
  String examName="",examId="",stuTableName="",examType="",scheme="";
  int totRecords=0,maxMarks=0;
%>
<%
	
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	examName=request.getParameter("examname");
	
	stuTableName=request.getParameter("tablename");
	examId=request.getParameter("examid");
	examType=request.getParameter("examtype");
	scheme=request.getParameter("scheme");
	totRecords=Integer.parseInt(request.getParameter("totrecords").trim());




%>


<head>
<title></title><meta name="GENERATOR" content="Microsoft FrontPage 4.0"><meta name="author" content="Think-And-Learn.com">
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" topmargin="1" leftmargin="0">

<table border="0" width="100%" cellspacing="1">
    <tr>
      <td width="24%" valign="middle" align="left" bgcolor="#E8ECF4"><font color="#800000" face="Arial" size="2"><b><a href="examTakenStu.jsp?examname=<%=examName%>&tablename=<%=stuTableName%>&examid=<%=examId%>&examtype=<%=examType%>&totrecords=<%=totRecords%>&start=0&scheme=<%=scheme%>" target="bottompanel"%><%=examName%></a>
      </b></font></td>
	
    </tr>
  </table>
  </body>
  </html>
