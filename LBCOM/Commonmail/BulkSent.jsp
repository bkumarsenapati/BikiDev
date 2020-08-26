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
	String userId="",schoolId="",toUser="",fromUser="",message="",toUserString="",subject="";
	String success="",unsuccess="",attachPath="",sentString="";
	String tempUrl="", sid="", uid ="";
	String fwdMsgPath="";                                  // variable for forwarded msg
	String year="",month="",emailId="",school="",unreadEmail="";
	int len=0, Id=0, attach=0, attachId=0,m=0;
	SortedSet userSet = new TreeSet();
	SortedSet stuSet = null, teaSet = null;
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
	fromUser = userId + "@" +schoolId;
	subject = request.getParameter("subject");
	if((subject==null)||(subject.equals("")))
	   subject = "No Subject";
	
	        // code for the case when message is a forwarded message starts
	fwdMsgPath = request.getParameter("amsg");
	if(fwdMsgPath!=null)
	{
	       File fwdMsgFile = new File(attachPath + "/" + fwdMsgPath +".html");
	       if((fwdMsgFile.exists())&&(fwdMsgFile.isFile()))
	       {
	                Reader fr = new FileReader(fwdMsgFile); 
		 	BufferedReader br = new BufferedReader(fr);
		 	String buff = br.readLine();
		 	while(buff!=null) {
                        	 message = message + "\n" + buff;
			 	 buff = br.readLine();
                 	}
	       }else{
	                fwdMsgFile.delete();
	       }
	}
	                     // code for case of forwarded message ends
		
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
	//fout.write("<html><body>");
	//fout.write("<table width='770'><tr><td width='750'>");
	//fout.write("<pre><font face='arial' size='4pt' color='#4B0082'>");
	fout.write(message);
	//fout.write("</font></pre>");
	//fout.write("</td></tr></table>");
	//fout.write("</body></html>");
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
	{  schoolSet.add(rs1.getString("schoolid"));         }
	
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
	stuSet = new TreeSet();
	teaSet = new TreeSet();
	while(itr.hasNext())
	{     Id = 0;
	      emailId = "";
	      uid = (String)itr.next();
	      toUser = uid + "@" + schoolId;
	      
	      if(uid.startsWith("c"))
	      {
	         rs=st.executeQuery("select student_id from coursewareinfo_det where course_id='"+uid+"' and school_id='"+schoolId+"' and student_id not in(select username from studentprofile where crossregister_flag>2)");
		 while(rs.next())
		 {
		     stuSet.add(rs.getString("student_id"));
		 }
		 rs=st.executeQuery("select teacher_id from coursewareinfo where course_id='"+uid+"' and school_id='"+schoolId+"'");
		 while(rs.next())
		 {
		     teaSet.add(rs.getString("teacher_id"));
		 }
	      }else if(uid.startsWith("C"))
	        {
		   rs=st.executeQuery("select username from studentprofile where grade='"+uid+"' and schoolid='"+schoolId+"' and crossregister_flag in (0,1,2)");
		   while(rs.next())
		   {
		       stuSet.add(rs.getString("username"));
		   } 
		   rs=st.executeQuery("select username from teachprofile where class_id='"+uid+"' and schoolid='"+schoolId+"'");
		   while(rs.next())
		   {
		       teaSet.add(rs.getString("username"));
		   }
	       }else{
	              continue;
	       }
	      
	      int user_no = stuSet.size()+teaSet.size();
	      if(user_no==0)
	             continue;
	      
	      //Delete from here
		  // creating unique emailid
	     // rs = st.executeQuery("select max(id) idnum from mail_bulk where month(receive_date)='"+month+"' and year(receive_date)='"+year+"'");
	     // if(rs.next())
		  // Id = rs.getInt("idnum");
	     // rs.close();	   
	     // Id = Id + 1;
         //     emailId = year + month + Id;
	      
	      // inserting email informatin into database
	     // st.executeUpdate("insert into mail_bulk values('"+toUser+"','"+toUserString+"','"+fromUser+"','"+subject+"',curdate(),curtime(),'"+attach+"','"+emailId+"','"+Id+"','"+user_no+"')");
	      
	      // copy email body file
	      //String copyBodyUrl = attachPath + "/" + schoolId + "/bulkmail/" + uid + "/email";
	      //File toFolder = new File(copyBodyUrl);
	      //if(!toFolder.isDirectory())
	      //     toFolder.mkdirs();
	     // File cpFile = new File(toFolder, emailId+".html");
	      //copyFile(tempFile, cpFile);
	      
	      // copy attachments
	     // if(len>0)
	     // {	  
		 // String copyUrl = attachPath + "/" + schoolId + "/bulkmail/" + uid + "/attachments/" + emailId;
		 // File copyFolder = new File(copyUrl);
		 // copyFolder.mkdirs();
		 // for(int i=0;i<len;i++)  
	      //      {
		   //    File fut = new File(copyFolder, flist[i]);
		    //   File fin = new File(tempFolder, flist[i]);
		    //   copyFile(fin, fut); 
		    //}
	     // }
	      
	      // update each student bulk mail record
	      //Iterator itr1 =  stuSet.iterator();
	      //while(itr1.hasNext())
	      //{
	      //   String stuId = (String)itr1.next();
		// rs=st.executeQuery("select crossregister_flag from studentprofile where username='"+stuId+"' and schoolid='"+schoolId+"'");
	      //   if(rs.next())
		 //{
		 //               // checking if the student is cross registered: crossregistedid is schoolid_studentid
		  //   if(rs.getInt("crossregister_flag")==2)
		  //   {
		   //  		Iterator itrs = schoolSet.iterator();
		    // 		while(itrs.hasNext())
		     //		{
		      //   		school = (String)itrs.next();
			//		if(stuId.startsWith(school+"_"))
			//  		{
			 //      			m = school.length()+1;
			  //     			stuId = stuId.substring(m);
			  //     			stuId = stuId + "@" + school;
				//		break;
			  //		}  
		     //		}
				
		  //    }else{
		 //             stuId = stuId + "@" + schoolId;
		 //      }
	//	 }
	//	 rs=st.executeQuery("select user_id, unread_bulk from mail_bulk_student where user_id='"+stuId+"'");
	//	 if(rs.next())
	//	 {
	//	       unreadEmail = rs.getString("unread_bulk");
	//	       if((unreadEmail==null)||(unreadEmail.equals("")))
		//        {
		//	   st1.executeUpdate("update mail_bulk_student set unread_bulk='"+emailId+"' where user_id='"+stuId+"'");
		//	}else{
		//     		st1.executeUpdate("update mail_bulk_student set unread_bulk='"+unreadEmail+","+emailId+"' where //user_id='"+stuId+"'");
	//		  }
		//  }else{
		//          st1.executeUpdate("insert into mail_bulk_student values('"+stuId+"','"+emailId+"','')");
		//   }		  
	   //   }
	      
	       // update each teacher bulk mail record
	    //  Iterator itr2 =  teaSet.iterator();
	    //  while(itr2.hasNext())
	  //    {
	    //     String teaId = (String)itr2.next();
		// teaId = teaId + "@" + schoolId;
		// rs=st.executeQuery("select user_id, unread_bulk from mail_bulk_student where user_id='"+teaId+"'");
		// if(rs.next())
		// {
		//       unreadEmail = rs.getString("unread_bulk");
		 //      if((unreadEmail==null)||(unreadEmail.equals("")))
		 //       {
		//	   st1.executeUpdate("update mail_bulk_student set unread_bulk='"+emailId+"' where user_id='"+teaId+"'");
		//	}else{
		 //    		st1.executeUpdate("update mail_bulk_student set unread_bulk='"+unreadEmail+","+emailId+"' where user_id='"+teaId+"'");
		//	  }
			

		 // }else{
		//          st1.executeUpdate("insert into mail_bulk_student values('"+teaId+"','"+emailId+"','')");
		 //  }		  
	     // } 
	       
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
	     
		 //Insert Into mail box
String cpSentUrl1,cpUrl1;
		  int allMail=0;
		  float size=0.0f;
		File toSent1,cpSentFile1,cpFolder1,fout11,fin11;
	Iterator itr3 =  stuSet.iterator();

	      while(itr3.hasNext())
	      {
	        String  stuId = (String)itr3.next();
			   userId=stuId;
		 rs=st.executeQuery("select crossregister_flag from studentprofile where username='"+stuId+"' and schoolid='"+schoolId+"'");
	         if(rs.next())
		 {
		                // checking if the student is cross registered: crossregistedid is schoolid_studentid
		     if(rs.getInt("crossregister_flag")==2)
		     {
		     		Iterator itrs = schoolSet.iterator();
		     		while(itrs.hasNext())
		     		{
		         		school = (String)itrs.next();
					if(stuId.startsWith(school+"_"))
			  		{
			       			m = school.length()+1;
			       			stuId = stuId.substring(m);
			       			stuId = stuId + "@" + school;
						break;
			  		}  
		     		}
				
		      }else{
		              stuId = stuId + "@" + schoolId;
		       }
		 }
		
					 //  Id=0;
	       emailId="";
		   		          
		   rs = st.executeQuery("select max(id) idnum from mail_box where user_id='"+stuId+"' and month(receive_date)='"+month+"' and year(receive_date)='"+year+"'");
	       if(rs.next())
			Id = rs.getInt("idnum");
		   
		   Id = Id + 1;
	       emailId = year + month + Id;
	      	       
	     // inserting in to database
		 
	      st.executeUpdate("insert into mail_box values('"+stuId+"','"+stuId+"','"+fromUser+"','"+subject+"',curdate(),curtime(),'Inbox','"+attach+"','"+emailId+"','"+Id+"',0)");
		        
	      
	        // copy email body file
	       cpSentUrl1 = attachPath + "/" + schoolId + "/" + userId + "/email";
	       toSent1 = new File(cpSentUrl1);
	      if(!toSent1.isDirectory())
	           toSent1.mkdirs();
	       cpSentFile1 = new File(toSent1, emailId+".html");
	      copyFile(tempFile, cpSentFile1);
	      
	           // copy attachments	       
	       if(len>0)
	       {
	           cpUrl1 = attachPath + "/" + schoolId + "/" + userId + "/attachments/" + emailId;
		   cpFolder1 = new File(cpUrl1);
		   cpFolder1.mkdirs();
		   for(int i=0;i<len;i++)  
	            {
		        fout11 = new File(cpFolder1, flist[i]);
		        fin11 = new File(tempFolder, flist[i]);
		       copyFile(fin11, fout11); 
		    }
	      }

				  // calculating user private space
	        rs = st.executeQuery("select count(*) allmail from mail_box where user_id='"+userId+"'");
	    	if(rs.next())
	       		allMail = rs.getInt("allmail"); 
	    	size = 500*allMail;    
	    	size += recursiveSizecount(attachPath + "/" + schoolId + "/" + userId + "/attachments");
	    	size += recursiveSizecount(attachPath + "/" + schoolId + "/" + userId + "/email");
	    	size /=1048576;
		if(size > 500)      // user space size limit in MB
		{
		   st.executeUpdate("update mail_box set mark_read=3 where user_id='"+toUser+"' and email_id='"+emailId+"'");
		}
				 
	      }
	      
	       // update each teacher bulk mail record
	      Iterator itr4 =  teaSet.iterator();
	      while(itr4.hasNext())
	      {
	         String teaId = (String)itr4.next();
			 userId=teaId;
		 teaId = teaId + "@" + schoolId;
		
		     if(teaId.equals(fromUser))
			  {
					Id=0;
	       
				   rs = st.executeQuery("select max(id) idnum from mail_box where user_id='"+fromUser+"' and month(receive_date)='"+month+"' and year(receive_date)='"+year+"'");
				   if(rs.next())
					 Id = rs.getInt("idnum");
				   Id = Id + 1;
			  }
			  else
			  {
				  Id=0;
	       
				   rs = st.executeQuery("select max(id) idnum from mail_box where user_id='"+teaId+"' and month(receive_date)='"+month+"' and year(receive_date)='"+year+"'");
				   if(rs.next())
					 Id = rs.getInt("idnum");
				   Id = Id + 1;
			  }
		  emailId="";
	       emailId = year + month + Id;
	      	       
	     // inserting in to database
		 
		 st.executeUpdate("insert into mail_box values('"+teaId+"','"+teaId+"','"+fromUser+"','"+subject+"',curdate(),curtime(),'Inbox','"+attach+"','"+emailId+"','"+Id+"',0)");

		        
	        // copy email body file
	       cpSentUrl1 = attachPath + "/" + schoolId + "/" + userId + "/email";
	       toSent1 = new File(cpSentUrl1);
	      if(!toSent1.isDirectory())
	           toSent1.mkdirs();
	       cpSentFile1 = new File(toSent1, emailId+".html");
	      copyFile(tempFile, cpSentFile1);
	      
	           // copy attachments	       
	       if(len>0)
	       {
	           cpUrl1 = attachPath + "/" + schoolId + "/" + userId + "/attachments/" + emailId;
		   cpFolder1 = new File(cpUrl1);
		   cpFolder1.mkdirs();
		   for(int i=0;i<len;i++)  
	            {
		        fout11 = new File(cpFolder1, flist[i]);
		        fin11 = new File(tempFolder, flist[i]);
		       copyFile(fin11, fout11); 
		    }
	      }
				  // calculating user private space
	        rs = st.executeQuery("select count(*) allmail from mail_box where user_id='"+uid+"'");
	    	if(rs.next())
	       		allMail = rs.getInt("allmail"); 
	    	size = 500*allMail;    
	    	size += recursiveSizecount(attachPath + "/" + sid + "/" + uid + "/attachments");
	    	size += recursiveSizecount(attachPath + "/" + sid + "/" + uid + "/email");
	    	size /=1048576;
		if(size > 500)      // user space size limit in MB
		{
		   st.executeUpdate("update mail_box set mark_read=3 where user_id='"+toUser+"' and email_id='"+emailId+"'");
		}

		  }  
	      
	       
	
		 //end insert
	     
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
	out.println("Sorry, Try again");
	ExceptionsFile.postException("BulkSent.jsp","closing statement and connection  objects","SQLException",e.getMessage());

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
			ExceptionsFile.postException("BulkSent.jsp","closing statement and connection  objects","SQLException",se.getMessage());
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
 <table  width="770">
       <tr>
           <td width="150" height="50"></td>
	   <td width="400" height="50">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
           <td width="200" height="50" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
       </tr>
       <tr>
	   <td></td>
	   <td><font face="arial" size="2">Email sent successfully</font></td>
	   <td></td>
       </tr>
        <tr>
	    <td></td>
	    <td><font face="arial" size="2"><a href="Compose.jsp">Compose another email</a></font> </td>
	    <td>&nbsp;</td>
	</tr>        
  </table>
  
  
</form>
</body>
</html>
