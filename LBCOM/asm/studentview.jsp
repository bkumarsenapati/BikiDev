<%@ page import = "java.sql.*,java.io.*,java.util.Hashtable,coursemgmt.ExceptionsFile" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
	<jsp:setProperty name="db" property="*" />
</jsp:useBean>
<!-- CODE FOR SESSION HANDELING -->
<%@ include file="/common/checksession.jsp" %> 	
<!-- CODE FOR SESSION HANDELING -->
<%
String mode=request.getParameter("mode");

if(mode.equals("student")){
	try{
		String schoolId=(String)session.getAttribute("schoolid");
		String classid=(String)session.getAttribute("grade");
		String teachId=request.getParameter("teacherid");
		session.setAttribute("emailid",classid+"_vstudent");
		session.setAttribute("logintype","student");	
		session.setAttribute("studentname","Virtual Student");	
		if(!(request.getParameter("show").equals("no")))
		{
			response.sendRedirect("/LBCOM/studentAdmin/index.jsp?teacherid="+teachId+"");
			//response.sendRedirect("/LBCOM/studentAdmin/StudentAdmin.jsp");
		}
	}catch(Exception e){
		System.out.println("Exception in asm/studentpriview.jsp"+e);
	}
}else{
	session.setAttribute("emailid",request.getParameter("emailid"));
	
	session.setAttribute("logintype","teacher");		
}
%>

	