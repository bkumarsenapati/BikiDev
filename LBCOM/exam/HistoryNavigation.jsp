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
	String examId=request.getParameter("examid");
	String examName=request.getParameter("examname");
	String maxAttempts=request.getParameter("maxattempts");
	String createdDate=request.getParameter("crdate");
	
	String teacherId=request.getParameter("teacherid");
	String courseId=request.getParameter("courseid");



%>


<head>
<title></title><meta name="GENERATOR" content="Microsoft FrontPage 4.0"><meta name="author" content="Think-And-Learn.com">
<SCRIPT LANGUAGE="JavaScript">
<!--
 function change(){
	// alert(top.second.document.q_paper);
	// alert(top.second.document.getElementById('fileLayer'));
	
	 top.second.document.getElementById("fileLayer").style.visibility='visible';
	 top.second.document.getElementById("file1").value="Correct";
  var msgstring="Correct";
	 if(document.layers)
{
 //thisbrowser="NN4";
	fredlayer =  top.second.document.layers["fileLayer"];
	fredlayer.document.open();
	fredlayer.document.write(msgstring);
	fredlayer.document.close();
  }

 if(document.all)
 {
	//thisbrowser="ie"
	fredlayer =  top.second.document.all["fileLayer"];
	fredlayer.innerHTML=msgstring;
   }
if(document.getElementById)
{
	//thisbrowser="NN6";
	fredlayer = top.second.document.getElementById("fileLayer");
	fredlayer.innerHTML =msgstring;

 }
             
}
//-->
</SCRIPT>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" topmargin="1" leftmargin="0">

<table border="0" width="100%" cellspacing="1">
    <tr>
      <td width="24%" valign="middle" align="left" bgcolor="#E8ECF4"><font color="#800000" face="Arial" size="2"><b><a href="StuExamHistory.jsp?examid=<%=examId%>&examname=<%=examName%>&maxattempts=<%=maxAttempts%>&crdate=<%=createdDate%>&teacherid=<%=teacherId%>&courseid=<%=courseId%>" target="mid_f"%>History of <%=examName%></a>
      </b></font></td>
	
    </tr>
  </table>
  </body>
  </html>
