<%@ page language="java" import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile,java.util.StringTokenizer"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
        synchronized public void copyFile(File fin, File fout) throws Exception 
         {
                  FileInputStream fis = new FileInputStream(fin);
                  FileOutputStream fos = new FileOutputStream(fout);
                  byte[] buf = new byte[1024];
                  int i = 0;
                  while((i=fis.read(buf))!=-1) {
                         fos.write(buf, 0, i);
                    }
                  fis.close();
                  fos.close();
         }
     
       synchronized public void copyFolder(File fin, File fout) throws Exception
     	{
                fout.mkdir();
                String[] children = fin.list();
 		if (children == null) {
		 // Either dir does not exist or is not a directory
 		} else {
 			for(int p=0;p<children.length;p++){
 				File f = new File(fin+"/"+children[p]);
 				File f1 = new File(fout+"/"+children[p]);
				if(f.isDirectory())
				    copyFolder(f,f1);		
				else
				    copyFile(f,f1);
			}
 		}
        }

%>
<%
	String userId="",schoolId="",attachFlag="",fromUser="",loginType="", teacherId="";
	String attachmentString ="";
	String flist[] = null;
	String tempUrl="";
	String type="", eId="", message="", subject="", epath="", apath="", spath="", timeStr="",bulkId=""; // reply and forward variables
	String attachStr="",attachedMsgPath="";         // reply and forward variables
	int len = 0;
	Connection con = null;
	Statement st = null;
	ResultSet rs = null;
%>
<%
try{
	session = request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	teacherId=request.getParameter("teacherid");
	if(sessid==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	schoolId = (String)session.getAttribute("schoolid");
	userId = (String)session.getAttribute("emailid");
	loginType = (String)session.getAttribute("logintype");
	if(userId.equals("Admin"))
	        userId = "admin";
	attachFlag = request.getParameter("attach");
	fromUser = request.getParameter("fromuser");
	if(fromUser==null)
	     fromUser = "";

	tempUrl = application.getInitParameter("schools_path");
	tempUrl = tempUrl + "/" + schoolId + "/" + userId + "/attachments/temp";
	File tempFolder = new File(tempUrl);
	
	if(attachFlag!=null)	
	{
		if(tempFolder.isDirectory())
			 flist = tempFolder.list();
		for(int i=0;i<flist.length;i++)
		{
		      if(i==0)
		          attachmentString = flist[i];
		      else
		          attachmentString = attachmentString + "," + flist[i];	  
		}	 
	}else {
	             if(tempFolder.isDirectory())
		      {   flist = tempFolder.list();
	                  for(int i=0;i<flist.length;i++)
		            {
		                 File file = new File(tempFolder,flist[i]);
				 file.delete();
		            }
			   tempFolder.delete(); 
		       }else
		             tempFolder.delete();	
	      }	

	     

}catch(IOException ioe){
                System.out.println("error is "+ioe);
	ExceptionsFile.postException("Compose.jsp","IOException","Exception",ioe.getMessage());
}
catch(Exception e){
	System.out.println("error is "+e);
	ExceptionsFile.postException("Compose.jsp","some exception","Exception",e.getMessage());

}
finally{
		try
		{
			if(st!=null)
				st.close();
		
			if(con!=null && !con.isClosed())
				con.close();
			
		
		}
		catch(SQLException se){
			ExceptionsFile.postException("InstantMessage.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }

%>

<html>

<head>
<title></title>
<script language="javascript" src="/LBCOM/validationscripts.js"></script>
<script language="JavaScript">
<!--
    
 function validate()
	{
	              var subject=document.getElementById("subject").value;
				    var toadd=document.getElementById("toaddress").value;
	                  var teacherId=document.getElementById("teacherid").value;
				  if(subject.length==0||subject==null){
					  alert("subject can not empty");
					  return false;
				  }
				   else{  
		            document.composeform.action = "Sent.jsp?subject="+subject+"&teacherid="+teacherId+"&toadd="+toadd;	 
	        return true;
				   }
	}      
	function attachwin()
	{
	   var attach_window;
	   attach_window = window.open("/LBCOM/Commonmail/Attachment.jsp","attach_window","width=400,height=300");
	   attach_window.moveTo(200,150);
	}
// -->
</script>
<link href="images/style.css" rel="stylesheet" type="text/css" />
</head>

<body leftmargin="0" marginwidth="0" topmargin="0" marginheight="0">
<form name="composeform" method="post" onsubmit=" validate();">
<input type="hidden" name="teacherid" value="<%=teacherId%>">
<table width="90%" align="center">
<tr>
	<td width="90%" height="18" align="center">
	</td>
</tr>
<tr>
	<td width="90%" height="18" align="center"  bgcolor="#EEE5DE">
		<font face="verdana" size="2" color="#000000"><b>Instant Mail - </b></font>
		<font face="verdana" size="1">Plain Text</font>
	</td>
</tr>
</table>

<table width="90%" bgcolor="#96C8ED" align="center">
<tr>
	<td width="90%" align="left">
		<input type="submit" name="submit" value="Send">&nbsp;&nbsp;
		<input type="button" name="cancelbtn" value="Cancel" onClick="javascript: history.back();">
	</td>
</tr>
</table>

<table width="90%" border="0" align="center">
<tr>
	<td width="15%" align="right"><font face="verdana" size="2">To:</font></td>
	<td width="85%">
		<input type="text" name="toadd" id="toaddress" value="<%=teacherId%>@<%=schoolId%>" size="60" readonly>
		&nbsp;&nbsp;&nbsp; &nbsp;
 </td>
</tr>
<tr>
	<td width="15%" align="right"><font face="verdana" size="2">Subject:</font></td>
	<td width="85%">
		<input type="text" name="subject" value="Instant Message to <%=request.getParameter("lname")%> <%=request.getParameter("fname")%>" size="60" id="subject" >&nbsp;&nbsp;
		<input type="checkbox" name="sentcheck" value="sent" checked>&nbsp;
		<font face="verdana" size="1">Save in Sent Mails</font>
	</td>
</tr>
<tr>
	<td width="15%" align="right"><font face="verdana" size="2">Attachments:</font></td>
	<td width="85%">
		<input type="text" name="attachment" id="attachid" size="60" value="<%=attachStr%>" readonly>&nbsp;&nbsp;
		<input type="button" name="attachbtn" value="Add/Remove Attachment" onclick="javascript: attachwin()" style="width: 200; height: 20">
	</td>
</tr>
<tr>
	<td width="15%"></td>
	<td width="85%"><textarea cols="70" rows="13" name="message" wrap="hard" id="mess"><%=message%></textarea></td>
</tr>
</table>



<table width="90%" bgcolor="#96C8ED" align="center">
<tr>
	<td width="90%" align="left">
		<input type="submit" name="submit" value="Send">&nbsp;&nbsp;
		<input type="button" name="cancelbtn" value="Cancel" onClick="javascript: history.back();">
	</td>
</tr>
</table>

<input type="hidden" id="rtype" name="rtype" value="normal">
  
</form>
<p>&nbsp;&nbsp;&nbsp; </p>
</body>
</html>