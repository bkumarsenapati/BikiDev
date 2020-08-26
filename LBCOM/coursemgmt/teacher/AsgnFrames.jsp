<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page language="java" %>
<%
	String docName=request.getParameter("docname");
	String workId=request.getParameter("workid");
	String cat=request.getParameter("cat");
	String type=request.getParameter("type");
	String total=request.getParameter("totrecords");
//	String subsectionId=request.getParameter("subsectionid");
	String argSelIds=request.getParameter("checked");
	String argUnSelIds=request.getParameter("unchecked");  
	String enableMode=request.getParameter("enableMode");  
	if (enableMode==null)
		enableMode="1";
	

%>
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>
<frameset rows='98%,*' border="0" frameborder='0' framespacing="0">
   <frame name='disp' scrolling="no" marginwidth="0" marginheight="0" src="SelectSubsection.jsp?enableMode=<%=enableMode%>&checked=<%=argSelIds%>&unchecked=<%=argUnSelIds%>&docname=<%=docName%>&cat=<%=cat%>&workid=<%=workId%>&type=<%=type%>&total=<%=total%>">
 <!--  <frame name="stu" scrolling="auto" topmargin="0" leftmargin="0" src="AssStudentsList.jsp?start=0&totrecords=&checked=<%=argSelIds%>&unchecked=<%=argUnSelIds%>&docname=<%=docName%>&cat=<%=cat%>&workid=<%=workId%>&type=<%=type%>&total=<%=total%>&subsectionid=all">-->
 <frame name="stu" scrolling="auto" topmargin="0" leftmargin="0" src='about:blank' >
</frameset>
</HTML>
