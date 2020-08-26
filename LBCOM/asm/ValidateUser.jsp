<!-- Checks for the validity of the user   -->

<%
String user=null;
%>

<%
	session=request.getSession();
	user =(String)session.getAttribute("user");
	if(user == null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
%>
