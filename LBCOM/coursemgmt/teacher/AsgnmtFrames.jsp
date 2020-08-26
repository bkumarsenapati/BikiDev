<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page language="java" %>
<%
	String cat=request.getParameter("cat");
	String type=request.getParameter("type");
	String workIds="",enableMode="",argSelIds="",argUnSelIds="",docName="",workId="";
	int total=Integer.parseInt(request.getParameter("total"));
	
	if(total > 1)
	{
		workIds=request.getParameter("checked");

	}
	else
	{
		docName=request.getParameter("docname");
		workId=request.getParameter("workid");
		String subsectionId=request.getParameter("subsectionid");
		argSelIds=request.getParameter("checked");
		argUnSelIds=request.getParameter("unchecked");  
		enableMode=request.getParameter("enableMode");  
		if (enableMode==null)
			enableMode="1";
	}
%>
<HTML>
<HEAD>
<TITLE></TITLE>
</HEAD>
<%
	if(total > 1)
	{
%>
		<frameset rows='98%,*' border="0" frameborder='0' framespacing="0">
			<frame name='disp' scrolling="no" marginwidth="0" marginheight="0" src="AsmtStudentList.jsp?start=0&totrecords=&workids=<%=workIds%>&cat=<%=cat%>&type=<%=type%>&total=<%=total%>">
			<frame name="stu" scrolling="auto" topmargin="0" leftmargin="0" src='about:blank' >
		</frameset>
<%
	}
	else
	{
%>
		<frameset rows='27,*' border="0" frameborder='0' framespacing="0">
			<frame name='disp' scrolling="no" marginwidth="0" marginheight="0" src="SelectSubsection.jsp?enableMode=<%=enableMode%>&checked=<%=argSelIds%>&unchecked=<%=argUnSelIds%>&docname=<%=docName%>&cat=<%=cat%>&workid=<%=workId%>&type=<%=type%>&total=<%=total%>">
			<frame name="stu" scrolling="auto" topmargin="0" leftmargin="0" src='about:blank' >
		</frameset>
<%
	}	
%>
</HTML>
