<!--
/**
 * Divides the parent window in to 2 frames
 * first frame is again divided in to 2  vertical forms for displaying the directories in one frame
 * and other is for displaying files in the selected directory
 * second frame contains Ok & Cancel buttons
 */

-->

<%
	String lnk=null;
%>
<%

//	String s=(String)session.getAttribute("sessid");
	
//	if(s==null){
//			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
//			return;
//	}
	lnk=request.getParameter("lnk");
%>
<html>
<head>
<meta name="GENERATOR" content="Namo WebEditor v5.0"><meta name="author" content="Hotsschools.net">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Content Resources</title>
</head>

	<frameset rows="75,*" framespacing="1">
		<frame name="top" src="CRTop.jsp" scrolling=no>
	    <frame name="bottom" src="<%=lnk%>">
	 </frameset>

  <noframes>
  <body>
  <p>This page uses frames, but your browser doesn't support them.</p>
  </body>
  </noframes>

  </frameset> 

</html>
