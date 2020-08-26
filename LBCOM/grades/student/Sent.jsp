<%@ page language="java" import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile,java.util.StringTokenizer"%>
<%@ page import="java.util.SortedSet,java.util.TreeSet,java.util.Iterator,java.util.Calendar"%>
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
%>
<%!
	synchronized float recursiveSizecount(String fileString)  /* to find the size of the files/folders */
	{
		float size=0.0f;
		try{
			File file = new File(fileString);
			String filedocs[]=file.list();
			
			if(filedocs.length>0) /* directory is not empty*/
			{
				for(int j=0;j<filedocs.length;j++)
				{
					File f1=new File(fileString+"/"+filedocs[j]);
					if(f1.isDirectory())
					{
						if((f1.list()).length != 0)
							size+=recursiveSizecount(fileString+"/"+filedocs[j]);
					}
					else 
					{
						size+=(new File(fileString+"/"+filedocs[j])).length();
					}			
				}	
			} 	
			size+=(new File(fileString)).length();
		}catch(Exception e){
		        ExceptionsFile.postException("CourseFileManager.jsp","recursiveSizeCount()","Exception",e.getMessage());
		}
		return size;
	}
	
	

%>

<%
	String userId="",schoolId="",toUser="",fromUser="",message="",toUserString="",subject="",studentId="";
	String attachPath="",sentString="";
	String tempUrl="", sid="", uid ="";
	String fwdMsgPath="";                                  // variable for forwarded msg
	String year="",month="",emailId="",school="",teacherId="";
	int len=0, Id=0, attachId=0, attach=0, m=0, allMail=0;
	float size=0.0f;
	SortedSet userSet = new TreeSet();
	SortedSet stuSet = new TreeSet();
	SortedSet schoolSet = new TreeSet();
	Calendar calendar=null;
	String flist[]=null;
	Connection con=null;
	Statement st=null, st1=null;
	ResultSet rs=null, rs1=null;
	
%>
<%
try{
	session = request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	sid=(String)session.getAttribute("school_id");
	uid=(String)session.getAttribute("user_id");
	schoolId = (String)session.getAttribute("schoolid");
	userId = (String)session.getAttribute("emailid");
	if(userId.equals("Admin"))
	       userId = "admin";
		
	attachPath = application.getInitParameter("schools_path");
	tempUrl = attachPath + "/" + schoolId + "/" + userId + "/attachments/temp";
	File tempFolder = new File(tempUrl);
	if(tempFolder.isDirectory())
	 {
	   	flist = tempFolder.list();
	   	len = flist.length;	   					
	 } 
	if(len>0)
	   attach=1;	
			
	toUserString = request.getParameter("toadd");
	teacherId= request.getParameter("teacherid");
	fromUser = userId + "@" +schoolId;
	//int k=toUserString.indexOf('@');
	//toUser=toUserString.substring(0,k)+ "@" +schoolId;
	toUser=teacherId+ "@" +schoolId;
	subject = request.getParameter("subject");
	
	message = request.getParameter("message") + "\n" + message;
        if((message==null)||(message.equals("")))
	   message = "";
	
	                     // creating temp email body file   
	String emailPath = attachPath + "/" + schoolId + "/" + userId + "/email";
	File emailDir = new File(emailPath);
	if(!emailDir.isDirectory())
	       emailDir.mkdirs();
	File tempFile = new File(emailDir, "temp.html");
	if(tempFile.exists())                 
	 {
	    tempFile.delete();
	    tempFile = new File(emailDir, "temp.html");
	 }	
	FileWriter fout = new FileWriter(tempFile);
	fout.write(message);            
	fout.close();
	tempFile = null;
	tempFile = new File(emailDir, "temp.html");
		
	sentString = request.getParameter("sentcheck");
		   
	con = con1.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
	con.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
	                
	calendar = Calendar.getInstance();
	year = ""+calendar.get(Calendar.YEAR);
	int tm = calendar.get(Calendar.MONTH) + 1;
	month = ""+tm;	          	      
		   // creating unique emailid
	      rs = st.executeQuery("select max(id) idnum from mail_box where month(receive_date)='"+month+"' and year(receive_date)='"+year+"' and user_id='"+toUser+"'");
	      if(rs.next())
		   Id = rs.getInt("idnum");
	      rs.close();	   
	      Id = Id + 1;
              emailId = year + month + Id;
	      
	       // inserting email informatin into database
	      st.executeUpdate("insert into mail_box values('"+toUser+"','"+toUserString+"','"+fromUser+"','"+subject+"',curdate(),curtime(),'Inbox','"+attach+"','"+emailId+"','"+Id+"',0)");
	      
	      // copy email body file
	      String copyBodyUrl = attachPath + "/" + schoolId + "/" + teacherId + "/email";
	      File toFolder = new File(copyBodyUrl);
	      if(!toFolder.isDirectory())
	           toFolder.mkdirs();
	      File cpFile = new File(toFolder, emailId+".html");
	      copyFile(tempFile, cpFile);
	      
	       // copy attachments
	      if(len>0)
	      {	  
		  String copyUrl = attachPath + "/" + schoolId + "/" + teacherId + "/attachments/" + emailId;
		  File copyFolder = new File(copyUrl);
		  copyFolder.mkdirs();
		  for(int i=0;i<len;i++)  
	            {
		       File fut = new File(copyFolder, flist[i]);
		       File fin = new File(tempFolder, flist[i]);
		       copyFile(fin, fut); 
		    }
	      }	
	      
	         // calculating user private space
	        rs = st.executeQuery("select count(*) allmail from mail_box where user_id='"+teacherId+"'");
	    	if(rs.next())
	       		allMail = rs.getInt("allmail"); 
	    	size = 250*allMail;    
	    	size += recursiveSizecount(attachPath + "/" + schoolId + "/" + teacherId + "/attachments");
	    	size += recursiveSizecount(attachPath + "/" + schoolId + "/" + teacherId + "/email");
	    	size /=1048576;
		if(size > 250)      // user space size limit in MB
		{
		   st.executeUpdate("update mail_box set mark_read=3 where user_id='"+toUser+"' and email_id='"+emailId+"'");
		}
	
	
	if(sentString!=null)
	{
	       Id=0;
	       emailId="";
	       rs = st.executeQuery("select max(id) idnum from mail_box where user_id='"+fromUser+"' and month(receive_date)='"+month+"' and year(receive_date)='"+year+"'");
	       if(rs.next())
		     Id = rs.getInt("idnum");
	       Id = Id + 1;
	       emailId = year + month + Id;
	      	       
	     // inserting in to database
	      st.executeUpdate("insert into mail_box values('"+fromUser+"','"+toUserString+"','"+fromUser+"','"+subject+"',curdate(),curtime(),'Sent','"+attach+"','"+emailId+"','"+Id+"',0)");
	      
	      
	        // copy email body file
	      String cpSentUrl = attachPath + "/" + schoolId + "/" + userId + "/email";
	      File toSent = new File(cpSentUrl);
	      if(!toSent.isDirectory())
	           toSent.mkdirs();
	      File cpSentFile = new File(toSent, emailId+".html");
	      copyFile(tempFile, cpSentFile);
	      
	           // copy attachments	       
	       if(len>0)
	       {
	          String cpUrl = attachPath + "/" + schoolId + "/" + userId + "/attachments/" + emailId;
		  File cpFolder = new File(cpUrl);
		   cpFolder.mkdirs();
		   for(int i=0;i<len;i++)  
	            {
		       File fout1 = new File(cpFolder, flist[i]);
		       File fin1 = new File(tempFolder, flist[i]);
		       copyFile(fin1, fout1); 
		    }
	      }
	}
	tempFile.delete();
	
	if(len>0)
	{
	    for(int j=0;j<len;j++)
	    {
	       File f1 = new File(tempFolder, flist[j]);
	       f1.delete();
	    }
	    tempFolder.delete();
	}
	
	}
	catch(Exception e){
	ExceptionsFile.postException("Sent.jsp","closing statement and connection  objects","SQLException",e.getMessage());

}
finally{
	try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("Sent.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
}
%>



<html>

<head>
<title></title>
<script language="JavaScript">
<!--

// -->
</script>

</head>

<body link="black" vlink="purple" alink="red" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0">
<form name="composeform" method="post">
 <table  width="770" height="185">
       <tr>
           <td width="18" height="46"></td>
	   <td width="536" height="46">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
           <td width="202" height="46" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
       </tr>
       <tr>
	   <td width="18" height="57"></td>
	   <td width="536" height="57"><b>
       <font face="Verdana" size="2" color="#E25F38">Your mail has been sent successfully!</font></b></td>
	   <td width="202" height="57"></td>
       </tr>
		<tr>
		<td width="18" height="57"></td>
	   <td width="536" height="57"><b>
		<input type="button" name="backbtn" value="Back to StudentProfile" onClick="javascript:history.go(-2);"></td>
		<td width="202" height="57"></td>
		</tr>

  </table>
  
  
</form>
</body>
</html>