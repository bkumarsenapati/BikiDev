<%-- START Code for Session Handling  --%><%@ page session="false"%><%@ page errorPage="/ErrorPage.jsp" %><jsp:useBean id="css" class="common.JspCheckSessionBean" scope="page" /><%
	HttpSession session = request.getSession(false);
	css.checkSession(session,response);
	%><%-- END Code for Session Handling  --%>