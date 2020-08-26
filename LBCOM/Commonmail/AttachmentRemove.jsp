<%@ page language="java" import="java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String userId="",schoolId="",fileName="";
	String tempUrl="";
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
	userId = (String)session.getAttribute("emailid");
	if(userId.equals("Admin"))
	            userId = "admin";
	fileName = request.getParameter("filename");
	tempUrl = application.getInitParameter("schools_path");
	tempUrl = tempUrl + "/" + schoolId + "/" + userId + "/attachments/temp";
	File tempFolder = new File(tempUrl);
	if(tempFolder.isDirectory())
	{
	     File newfile = new File(tempFolder,fileName);
	     newfile.delete();
	}	 
	
		
}catch(IOException ioe){
                System.out.println("error is "+ioe);
	ExceptionsFile.postException("AttachmentRemove.jsp","IOException","Exception",ioe.getMessage());
}
catch(Exception e){
	System.out.println("error is "+e);
	ExceptionsFile.postException("AttachmentRemove.jsp","some exception","Exception",e.getMessage());

}
%>

<jsp:forward page="Attachment.jsp"></jsp:forward>

<html>

<head>
<title></title>
</head>

<body>

</body>
</html>
