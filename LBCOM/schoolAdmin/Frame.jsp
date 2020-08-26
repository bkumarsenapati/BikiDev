<HTML>
<HEAD>
<TITLE>A frameset document</TITLE>
</HEAD>
<%@ page errorPage="/ErrorPage.jsp" %>
<%String schoolid="",userid="",mode="";%>
<form name="frm">
<%
schoolid=request.getParameter("schoolid");
userid=request.getParameter("userid");
mode=request.getParameter("mode");
out.println("<frameset cols='20%,80%' border='0'>");

out.println("<frame name='one' src='GradeSelection.jsp?schoolid="+schoolid+"&userid="+userid+"&mode="+mode+"'>");
out.println("<frame name='sec'>");
out.println("</FRAMESET>");
%>
</form>
</HTML>

