<%@ page language="Java" errorPage="/ErrorPage.jsp" %>
<%
  String courseId="",courseName="",schoolId="",studentId="",classId="",categoryId="",categoryType="",desc="",wtg="",className="";
%>
<%
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	
	schoolId=(String)session.getAttribute("schoolid");
	
	desc=request.getParameter("desc");
	classId= request.getParameter("classid");
	courseId=request.getParameter("courseid");
	categoryId=request.getParameter("categoryid");
	categoryType=request.getParameter("categorytype");
	courseName=request.getParameter("coursename");
	className=request.getParameter("classname");
	wtg=request.getParameter("wtg");	
	
%>
<HTML>
<HEAD>
<title></title>
</HEAD>
<frameset rows="10%,*" border="0">
	  <FRAME name="first" scrolling="no" src="SelectWork.jsp?coursename=<%=courseName%>&classid=<%=classId%>&courseid=<%=courseId%>&categoryid=<%=categoryId%>&wtg=<%=wtg%>&categorytype=<%=categoryType%>&desc=<%=desc%>&classname=<%=className%>">
	  <frame name="second" src="about:blank"> 
	  
	  
</FRAMESET>
</HTML>

