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
out.println("<frameset rows='12%,88%' border='0'>");
out.println("<frame name='one' src='GradingList.jsp?schoolid="+schoolid+"&mode=editGrades'>");
out.println("<frame name='sec'>");
out.println("</FRAMESET>");
%>
</form>
</HTML>

