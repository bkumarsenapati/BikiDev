<%@ page language="java"%>
<%
String stateName=(String)session.getAttribute("statestandard");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>
<!--<Frameset rows="12%,10%,*" border="0">
	<frame name="states" src="/LBCOM/StateStandards?doctype=allstates" scrolling="auto"/>
	<frame name="otherdetails" src="about:blank" scrolling="auto"/>
	<frame name="courseinformation" src="CreateCourse.jsp" scrolling="auto"/>
</Frameset>-->
<Frameset rows="13%,*" border="0">
	<frame name="otherdetails" src="/LBCOM/StateStandards?doctype=onestate&statename=<%=stateName%>" scrolling="auto"/>
	<frame name="courseinformation" src="CreateCourse.jsp" scrolling="auto"/>
	<!--<frame name="courseinformation" scrolling="auto"/>-->
</Frameset>
<noframes>

<body topmargin="0" leftmargin="0">
	<p>This page uses frames, but your browser doesn't support them.</p>
</body>

</noframes>

</HTML>
