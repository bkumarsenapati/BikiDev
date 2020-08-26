<%@ page language="java" import="java.io.*,coursemgmt.ExceptionsFile,com.oreilly.servlet.MultipartRequest,java.util.Enumeration"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String userId="",schoolId="";
	String tempUrl="",attachString="";
	String flist[] = null;
	Enumeration enumFiles = null;
	float attachSize=0.0f;
	int len = 0;
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
	
	tempUrl = application.getInitParameter("schools_path");
	tempUrl = tempUrl + "/" + schoolId + "/" + userId + "/attachments/temp";
	File tempFolder = new File(tempUrl);
	if(!tempFolder.isDirectory())
		 tempFolder.mkdirs();
	
	MultipartRequest mreq = new MultipartRequest(request,tempUrl,5*1024*1024);
	
	   // checking the total attachment size if more then deleting the uploaded file
	flist = tempFolder.list();
	for(int i=0;i<flist.length;i++)
	     attachSize += (new File(tempFolder, flist[i])).length(); 
	
	enumFiles = mreq.getFileNames();
	String upload="";
	System.out.println("&&&&&&&&&&&&&&Before while");
	while(enumFiles.hasMoreElements())
	{
			System.out.println("In while");
	       if(attachSize > 5242880)
	       {
		       upload = (String)enumFiles.nextElement();

			   System.out.println("********* IF upload file name is.."+upload);

	           File uploadedFile = mreq.getFile(upload);
		       attachSize -= uploadedFile.length();
		       uploadedFile.delete();		       
	        }
			else
			{
				  System.out.println("********* Else upload file name is.."+upload);

				 break;	
			}
    }
       
       flist = tempFolder.list();
       for(int i=0;i<flist.length;i++)
		{
		   System.out.println("attachString..."+flist[i]);
		   //flist[i]="santhosh.doc";
		  	  flist[i]=flist[i].replace('#','_');
			  flist[i]=flist[i].replaceAll("'","_");
			  flist[i]=flist[i].replaceAll("&","_");
			  if(i==0)
				  attachString = flist[i];
			   else
				  attachString = attachString + "," + flist[i];	  
		}	
	
}catch(IOException ioe){
        
}
catch(Exception e){
	ExceptionsFile.postException("AttachmentUpload.jsp","some exception","Exception",e.getMessage());
}
%>



<html>

<head>
<title></title>
<SCRIPT LANGUAGE="JavaScript">
<!--
         function reloadcompose()
	 {
	       var tempattach = opener.window.document.getElementById("attachid");
	       tempattach.value = '<%=attachString%>';
	       
          }
// -->
</SCRIPT>
</head>

<body onUnload="reloadcompose();">
<form name="uploadform">
  <table bgcolor="#CC99CC">
       <tr>
           <td width="30%" height="50">&nbsp;&nbsp;&nbsp;&nbsp;</td>
	   <td width="35%" height="50">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
           <td width="35%" height="50" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
       </tr>
  </table>
  
</form>
</body>
<script>
	  window.close();
</script>

</html>
