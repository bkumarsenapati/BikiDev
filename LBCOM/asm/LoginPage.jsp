<%@ page language="java" %>

<%
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{%>
		<jsp:forward page="index.html"/>
	
	<%
	}
%>