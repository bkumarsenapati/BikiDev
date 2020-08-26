<%@page language="java" %>
<%@page import="java.sql.*,java.io.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<HTML>
<HEAD>
<TITLE>.:: Welcome to www.learnbeyond.com ::. [ for quality eLearning experience ]</TITLE>
<!-- <script type="text/javascript" src="/LBCOM/common/left_frame/launch.js"></script>
<script type="text/javascript" src="/LBCOM/studentAdmin/stateMonitor.js"></script> -->

</HEAD>
<%

	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	%>
	<div id="frames">
	    <iframe name="usage" width="0" height="0"></iframe>
			<iframe name="studenttopframe" marginwidth="0" marginheight="0" scrolling="no" target="_self" height="0"></iframe>
			<iframe name="left" scrolling="no" marginwidth="0" marginheight="0" height="0" src="UsageReport.jsp"></iframe>
			<iframe name="main" scrolling="auto" height="0"></iframe>
	</div>
<script type="text/javascript">
	var sessid="<%=sessid%>";
	var schoolid="<%=(String)session.getAttribute("schoolid")%>";
	var studentid="<%=(String)session.getAttribute("emailid")%>";
	var classid="<%=(String)session.getAttribute("classid")%>";
	</script>
</form>
</HTML>

