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
        while((i=fis.read(buf))!=-1) 
		{
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
		try
		{
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
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("CourseFileManager.jsp","recursiveSizeCount()","Exception",e.getMessage());
		}
		return size;
	}
%>

<%
	String userId="",schoolId="",toUser="",fromUser="",message="",toUserString="",subject="";
	String attachPath="",sentString="";
	String tempUrl="", sid="", uid ="";
	String year="",month="",emailId="",school="";
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
	try
	{
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
				
		toUserString = request.getParameter("toaddress");
		fromUser = userId + "@" +schoolId;
		subject = request.getParameter("subject");
		if((subject==null)||(subject.equals("")))
		   subject = "No Subject";
		message = request.getParameter("message");
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
		fout.write("<html><body>");
		fout.write("<table width='770'><tr><td width='750'>");
		fout.write("<pre><font face='arial' size='4pt' color='#4B0082'>");
		fout.write(message);
		fout.write("</font></pre>");
		fout.write("</td></tr></table>");
		fout.write("</body></html>");
		fout.close();
		tempFile = null;
		tempFile = new File(emailDir, "temp.html");
			
		sentString = request.getParameter("sentcheck");
			   
		con = con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		con.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
				
		rs1=st1.executeQuery("select schoolid from school_profile");

		while(rs1.next())
		{
			schoolSet.add(rs1.getString("schoolid"));         
		}
		
		rs1=st1.executeQuery("select distinct username from studentprofile where crossregister_flag=2");
		while(rs1.next())
		{
			stuSet.add(rs1.getString("username"));            
		}
		
		StringTokenizer stk = new StringTokenizer(toUserString, ",");
		while(stk.hasMoreTokens())
		{
			userSet.add(stk.nextToken());
		}
		
		calendar = Calendar.getInstance();
		year = ""+calendar.get(Calendar.YEAR);
		int tm = calendar.get(Calendar.MONTH) + 1;
		month = ""+tm;
		
		Iterator itr = userSet.iterator();
		
		while(itr.hasNext())
		{
			Id = 0;
			emailId = "";
			allMail=0;
			size=0.0f;
			toUser = (String)itr.next();
			StringTokenizer stk1 = new StringTokenizer(toUser, "@");
			if(stk1.hasMoreTokens())
				uid = stk1.nextToken();
			if(stk1.hasMoreTokens())
				sid = stk1.nextToken();
				
			if(stuSet.contains(uid))
			{
				Iterator itrs = schoolSet.iterator();
				while(itrs.hasNext())
				{
					school = (String)itrs.next();
					if(uid.startsWith(school+"_"))
					{
						m = school.length()+1;
						uid = uid.substring(m);
						sid = school;
						toUser = uid + "@" + sid;
						break;
					}  
				}	       
			}			
		
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
			String copyBodyUrl = attachPath + "/" + sid + "/" + uid + "/email";
			File toFolder = new File(copyBodyUrl);
			if(!toFolder.isDirectory())
				toFolder.mkdirs();
			File cpFile = new File(toFolder, emailId+".html");
				copyFile(tempFile, cpFile);
			  
			// copy attachments
			if(len>0)
			{	  
				String copyUrl = attachPath + "/" + sid + "/" + uid + "/attachments/" + emailId;
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
			rs = st.executeQuery("select count(*) allmail from mail_box where user_id='"+uid+"'");
			if(rs.next())
				allMail = rs.getInt("allmail"); 
			size = 100*allMail;    
			size += recursiveSizecount(attachPath + "/" + sid + "/" + uid + "/attachments");
			size += recursiveSizecount(attachPath + "/" + sid + "/" + uid + "/email");
			size /=1048576;
			
			if(size > 10)      // user space size limit in MB
			{
			   st.executeUpdate("update mail_box set mark_read=3 where user_id='"+toUser+"' and email_id='"+emailId+"'");
			}
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

<form name="composeform" action="Sent.jsp" method="post">

<br><br><br><br><br><br><br><br>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="100%" align="center">
			<b><font face="Verdana" size="2" color="#000080">
			The feedback is sent as a mail successfully.</font></b>
		</td>
	</tr>
	<tr>
		<td width="100%" align="center">&nbsp;</td>
	</tr>
	<!-- <tr>
		<td width="100%" align="center">
	    	<input type="button" value="Close the Window" onclick="window.close();" name="B3">
		</td>
	</tr> -->
			<script>

					window.close();
			</script>
</table>
 
</form>
</body>
</html>
