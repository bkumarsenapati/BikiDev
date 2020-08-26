<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome to HelloWord</title>
</head>
<body>
Welcome to HelloWord!



 <%@ page language="java" import="java.io.*,coursemgmt.ExceptionsFile,utility.FileUtility"%>
<%-- <%@ page language="java" import="coursemgmt.ExceptionsFile;"%>  --%>
<%-- <%@ page language="java" import="coursemgmt.ExceptionsFile"%> --%>

<%@ page errorPage="/ErrorPage.jsp" %>

<%
	String userId="",schoolId="",sizeError="",tempUrl="",attachString="";
	String flist[] = null;
	int len=0;
%>
<%
try{
       
	session = request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	schoolId = (String)session.getAttribute("schoolid");
	System.out.println("Attachment jsp file - schoolId is: "+schoolId);
	userId = (String)session.getAttribute("emailid");
	System.out.println("Attachment jsp file - userId is: "+userId);
	

	if(userId.equals("Admin"))
	            userId = "admin";
	sizeError = request.getParameter("sizeerror");
	
	tempUrl = application.getInitParameter("schools_path");
	System.out.println("Attachment jsp file - tempUrl is: "+tempUrl);
	tempUrl = tempUrl + "/" + schoolId + "/" + userId + "/attachments/temp";
	System.out.println("Attachment jsp file - tempUrl is: "+tempUrl);
	//File tempFolder = new File(tempUrl);
	
	
    
}catch(Exception e){
	System.out.println("error is "+e);
	//ExceptionsFile.postException("Attachment.jsp","Unknown exception","Exception",e.getMessage());
}

%>

</body>
</html>