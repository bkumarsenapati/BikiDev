<HTML>
<HEAD>
<TITLE>A frameset document</TITLE>
</HEAD>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String schoolid="",user="";
	
	String sessId;
	sessId=(String)session.getAttribute("sessid");
			if(sessId==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
			}

	
	String userType=(String)session.getAttribute("logintype");	
	
%>

<form name="reportframe">
<frameset rows='50,*' border='0'>
<frame name="report" scrolling="no" src="/LBCOM/Commonmail/BulkAddressTop.jsp">
<frame name="sec">
</FRAMESET>
</form>
</HTML>

