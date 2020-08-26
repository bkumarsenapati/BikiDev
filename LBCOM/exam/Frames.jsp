<%@ page errorPage="/ErrorPage.jsp" %>
<%
  String workFile="",examId="",teacherId="",courseId="",schoolId="",studentId="",tableName="",examType="",totrecords="",examName="";
  String status="",count="",marksScheme="",totalMarks="",sessid="";
  float shortAnsMarks=0.0f;
%>
<%
	 sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	teacherId=(String)session.getAttribute("emailid");
	schoolId=(String)session.getAttribute("schoolid");
	courseId=(String)session.getAttribute("courseid");
	examId=request.getParameter("examid");
	studentId=request.getParameter("studentid");
	tableName=request.getParameter("tablename");
	examType=request.getParameter("examtype");
	examName=request.getParameter("examname");
	totrecords=request.getParameter("totrecords");
	status=request.getParameter("status");
	count=request.getParameter("count");
	marksScheme=request.getParameter("scheme");
	shortAnsMarks=Float.parseFloat(request.getParameter("shortansmarks"));
	totalMarks=request.getParameter("totalmarks");	
	workFile=(String)session.getAttribute("schoolpath")+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/responses/"+studentId+"_"+count+".html";
%>
<HTML>
<HEAD>
<title></title>
</HEAD>
   <frameset rows="7%,*,25%" border="0">
	  <FRAME name="first" scrolling="no" src="Navigation.jsp?examname=<%=examName%>&tablename=<%=tableName%>&examid=<%=examId%>&examtype=<%=examType%>&totrecords=<%=totrecords%>&scheme=<%=marksScheme%>">
	  <frame name="second" src="<%=workFile%>"> 
	  <frame name="third" scrolling="auto" src="CheckMarks.jsp?examid=<%=examId%>&studentid=<%=studentId%>&examname=<%=examName%>&tablename=<%=tableName%>&examtype=<%=examType%>&totrecords=<%=totrecords%>&status=<%=status%>&count=<%=count%>&shortansmarks=<%=shortAnsMarks%>&scheme=<%=marksScheme%>&totalmarks=<%=totalMarks%>">
	  
</FRAMESET>
</HTML>

