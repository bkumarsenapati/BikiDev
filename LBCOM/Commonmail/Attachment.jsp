<%@ page language="java" import="java.io.*,coursemgmt.ExceptionsFile,utility.FileUtility"%>
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
	tempUrl = tempUrl + "/" + schoolId + "/" + userId + "/attachments/temp";
	File tempFolder = new File(tempUrl);
		
	if(tempFolder.exists())
	{	if(tempFolder.isDirectory())
	 	{
	   		flist = tempFolder.list();
	   		len = flist.length;
         }
	}
	if(len>0)
	{
	       for(int i=0;i<flist.length;i++)
	       {
	             
				 // Santhosh added from here on July 28, 13

				 FileUtility fu=new FileUtility();
		   
		   String renName=flist[i];
		   renName=renName.replace('#','_');
		   renName=renName.replaceAll("'","_");
		   renName=renName.replaceAll("&","_");
		   fu.renameFile(tempUrl+"/"+flist[i],tempUrl+"/"+renName);
		   
		   flist[i]=renName;
				 
				 
				 if(i==0)
	                    attachString = flist[i];
	             else
	                    attachString = attachString + "," + flist[i];	  
	       }
	}	
%>
<html>
<head>
<title></title>
<script language="JavaScript">
<!--
     function remove(fileName)
     {
          window.location.href="AttachmentRemove.jsp?filename="+fileName;
     }

     function closewindow()
     {
          var tempattach = opener.window.document.getElementById("attachid");
	  tempattach.value = '<%=attachString%>';
	  window.close();
     }
    
// -->
</script>

</head>

<body bgcolor="#FAF0E6" link="black" vlink="purple" alink="red" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0">
<form name="attachmentform" method="post" enctype="multipart/form-data" action="/LBCOM/Commonmail/AttachmentUpload.jsp">
  <table>
       <tr>
           <td width="350"><font face="arial" size="2">*Maximum Size of attachments can be is 5MB</font></td>
       </tr>  
       <tr>
           <td width="350"><font face="arial" size="2">*You can Attach Maximum five files</font></td>
       </tr>
  </table>
  <table>
  <%    int i=0;
        for(i=0;i<len;i++){
	            
	          File tempFile = new File(tempFolder, flist[i]);
		  float size = 0.0f;
		  String space = "";
		  String str1[] =null;
		  size = tempFile.length();
		 if(size>1048576)
	          {
			    size /=1048576;
			    space = size+"";
				space = space.replace('.','_');
				str1 = space.split("_");
			    space = str1[0]+"."+((str1[1].length()<9)?str1[1].substring(0,1):str1[1].substring(0,2)) + "MB";
			  }
			  else if(size>1024)
			   {
	       		size /= 1024;
	       		space = size+"";
	       		space = space.replace('.','_');
	       		str1 = space.split("_");
	       		space = str1[0]+"."+((str1[1].length()<9)?str1[1].substring(0,1):str1[1].substring(0,2)) + "KB";
	    	  }else {
	       		space = size + "B";
	    	  }
   %>     
	<tr>
	    <td width="75" align="right"><font face="arial" size="2">File<%=i+1%>&nbsp;:</font></td>
	    <td width="100" align="center"><font face="arial" size="2">&nbsp;<%=flist[i]%></font></td>
	    <td width="75"><font face="arial" size="2">&nbsp;<%=space%></font></td>
	    <td width="100" align="left"><input type="button" name="removebtn" value="Remove" onclick="javascript: remove('<%=flist[i]%>')"></td>
	</tr>
   <%  } 
        len = 5-len;
       for(int j=0;j<len;j++,i++){
           if(j==0){
    %>	
        <tr>
	    <td width="75" align="right"><font face="arial" size="2">File<%=i+1%>&nbsp;:</font></td>
	    <td width="100" align="center"><input type="hidden" name="MAX_FILE_SIZE" value="1024"><input type="file" name='file<%=i+1%>'></td>
	    <td width="75"></td>
	    <td width="100" align="left"></td>
	</tr>
   <%  
             }
			else
		   {
				%>
				<tr>
	    <td width="75" align="right"><font face="arial" size="2">File<%=i+1%>&nbsp;:</font></td>
	    <td width="100" align="center"><input type="hidden" name="MAX_FILE_SIZE" value="1024"><input type="file" name='file<%=i+1%>'></td>
	    <td width="75"></td>
	    <td width="100" align="left"></td>
	</tr>
	<%
		   }
	       // break;
   }
      
}catch(Exception e){
	System.out.println("error is "+e);
	ExceptionsFile.postException("Attachment.jsp","Unknown exception","Exception",e.getMessage());
}
   
      %>	
</table>	
<table>	
	<tr>
	    <td width="175" align="right"><input type="submit" name="submit" value="Attach"></td>
	    <td width="175" align="left"><input type="button" name="cancel" value="Cancel" onclick="javascript: closewindow()"></td>
	</tr>
  </table>
  
</form>
</body>
</html>
