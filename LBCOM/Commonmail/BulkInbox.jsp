<%@ page language="java" import="java.io.*,java.sql.*,java.util.SortedSet,java.util.StringTokenizer,coursemgmt.ExceptionsFile" %>
<%@ page import="java.util.Iterator,java.util.TreeSet,java.util.Vector,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
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
	String userId="",schoolId="",attachPath="";
	String emailId="", checkboxValue="",subjectString="";
	String deleteString="", readString="", unreadString="", moveString="",folderName="Inbox";
	String sortStr="",sortingBy="",sortingType="",linkStr="";
	int totRecords=0,start=0,end=0,c=0,pageSize=10,currentPage=0;
	String tuid="", ttime="", tdate="", tattach="";
	String flist[] = null;
	int newMail=0,totalMail=0;
	boolean flag = false, bflag = false, moveFlag=false;	
	String rStr="",urStr="",totStr="",cName="",sName="",emailUrl="",attachUrl="";
	SortedSet rSet=null, urSet=null;
	Vector rList=null,urList=null;
	ResultSet  rs=null;
	Connection con=null;
	Statement st=null;
	String sessId;
	sessId=(String)session.getAttribute("sessid");
			if(sessId==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
			}
	try
	{
		attachPath = application.getInitParameter("schools_path");
	    userId = (String)session.getAttribute("emailid");
	    if(userId.equals("Admin"))
			userId = "admin";
  	    schoolId = (String)session.getAttribute("schoolid");
	    emailId = userId + "@" + schoolId;
	    sortingBy=(String)request.getParameter("sortby");
	    if(sortingBy==null) 
		{
			sortingBy="rd";  
		}
	    sortingType=(String)request.getParameter("sorttype");
	    if (sortingType==null)
		{
			sortingType="D"; 
		}
	
	    if (sortingBy.equals("rd"))
		    sortStr="receive_date";
	    else if (sortingBy.equals("sb"))
		    sortStr="subject";
	    else if (sortingBy.equals("id"))
		    sortStr="from_user";
   			   
	     if (sortingType.equals("A"))
	   	    sortStr=sortStr+" asc";
	     else
		    sortStr=sortStr+" desc";
		
	   
	    deleteString = request.getParameter("delete");
	    readString = request.getParameter("read");
	    unreadString = request.getParameter("unread");
		moveString = request.getParameter("move");
	    	    
	    con=db.getConnection();
	    st=con.createStatement();
	    
		if((deleteString!=null)&&(!deleteString.equals("")))	    
	    {
			StringTokenizer sd1 = new StringTokenizer(deleteString, ",");
		    while(sd1.hasMoreTokens())
		    {
				String emailid = sd1.nextToken();
				String uid ="";
				int t=0,tot=0;
			  
				rs=st.executeQuery("select user_id,attachment,total_user from mail_bulk where email_id='"+emailid+"'");    
				if(rs.next())
				{
					uid = rs.getString("user_id");   
			        t = rs.getInt("attachment");
			        tot = rs.getInt("total_user");
				}
				
				rs = st.executeQuery("select * from mail_bulk_student where user_id='"+emailId+"'");
	    		
				if(rs.next())
	    		{ 
	       			rStr = rs.getString("read_bulk");   
	       			urStr = rs.getString("unread_bulk");
				}
	     	    
				rSet = new TreeSet();
	    		urSet = new TreeSet();
	            StringTokenizer stkrd = new StringTokenizer(rStr, ",");
	            while(stkrd.hasMoreTokens())
	            {
					rSet.add(stkrd.nextToken());
				}
	            StringTokenizer stkurd = new StringTokenizer(urStr, ",");
	            while(stkurd.hasMoreTokens())
	            {
					urSet.add(stkurd.nextToken());
				}     
				if(urSet.contains(emailid))
					urSet.remove(emailid);
				if(rSet.contains(emailid))
					rSet.remove(emailid);
			  
				rList = new Vector(rSet);
	    		urList = new Vector(urSet);
		 
				rStr="";
				urStr="";
	    		
				for(int i=0;i<rList.size();i++)
	    		{
					if(i==0)
		    			rStr = (String)rList.get(i);
					else
		    			rStr = rStr + "," + rList.get(i);
				}
	    		for(int i=0;i<urList.size();i++)
	    		{
	        		if(i==0)
		    			urStr = (String)urList.get(i);
					else
		    			urStr = urStr + "," + urList.get(i);
				}
	    	    	    
	            st.executeUpdate("update mail_bulk_student set read_bulk='"+rStr+"', unread_bulk='"+urStr+"' where user_id='"+emailId+"'");   
		
			   tot = tot-1;
			   if(tot==0)
			   {
			       st.executeUpdate("delete from mail_bulk where email_id='"+emailid+"'");
			       StringTokenizer stkdelete = new StringTokenizer(uid, "@");
			       if(stkdelete.hasMoreTokens())
				        cName = stkdelete.nextToken();
			       if(stkdelete.hasMoreTokens())
				        sName = stkdelete.nextToken();
			       emailUrl = attachPath + "/" + sName + "/bulkmail/" + cName+"/email/"+emailid+".html";
			       File emailFile = new File(emailUrl);
			       emailFile.delete();      
			       
			       if(t>0)
			  	{
				       	attachUrl = attachPath + "/" + sName + "/bulkmail/" + cName+"/attachments";		    
	                                File userFolder = new File(attachUrl);
					File f1 = new File(userFolder, emailid);
					if(f1.isDirectory())
					{
				      		flist = f1.list();
				      		for(int i=0;i<flist.length;i++)
				      		{
				          		File f2 = new File(f1, flist[i]);
					  		f2.delete();
				      		}
				      		f1.delete();
					}else
					   f1.delete();
			  	}   
			   }else{
			          st.executeUpdate("update mail_bulk set total_user='"+tot+"' where email_id='"+emailid+"'");   
			   }			    
		    }
	     }   	    
             
	    if((readString!=null)&&(!readString.equals("")))
	     {
	            rStr="";
	    	    urStr="";
	            StringTokenizer rd1 = new StringTokenizer(readString, ",");
		    SortedSet readSet = new TreeSet();
		    while(rd1.hasMoreTokens())
		    {
		        readSet.add(rd1.nextToken());		    
		    }
		          
		    rs=st.executeQuery("select * from mail_bulk_student where user_id='"+emailId+"'");
	    	    if(rs.next())
	    	    {
	       	      	     rStr = rs.getString("read_bulk");
	       		     urStr = rs.getString("unread_bulk");
	    	    }
	    
	    	    rSet = new TreeSet();
	    	    urSet = new TreeSet();
	    	    StringTokenizer stkread = new StringTokenizer(rStr, ",");
	    	    while(stkread.hasMoreTokens())
	    	    {
	         		rSet.add(stkread.nextToken());
	    	    }
	    	    StringTokenizer stkuread = new StringTokenizer(urStr, ",");
	    	    while(stkuread.hasMoreTokens())
	    	    {
	         		urSet.add(stkuread.nextToken());
	    	    }
		    Iterator itread = readSet.iterator();
		    String tempRead="";
		    while(itread.hasNext())
		    {
		        tempRead = (String)itread.next();
		        if(urSet.contains(tempRead))
	        	 	  urSet.remove(tempRead);
	    	        rSet.add(tempRead);		    
		    }
	    	    urSet.removeAll(rSet);	 
		    rStr="";
	    	    urStr="";
	    	    rList = new Vector(rSet);
	    	    urList = new Vector(urSet);
		    for(int i=0;i<rList.size();i++)
	    	    {
	        	       if(i==0)
		    		   	rStr = (String)rList.get(i);
				else
		    			rStr = rStr + "," + rList.get(i);
	    	    }
	    	    for(int i=0;i<urList.size();i++)
	    	    {
	        		if(i==0)
		    			urStr = (String)urList.get(i);
				else
		    			urStr = urStr + "," + urList.get(i);
	    	    }
	    	   st.executeUpdate("update mail_bulk_student set read_bulk='"+rStr+"', unread_bulk='"+urStr+"' where user_id='"+emailId+"'");   
			  	   
		    
	     }
	     
	    if((unreadString!=null)&&(!unreadString.equals("")))
	     {
	            rStr="";
	    	    urStr="";
	            StringTokenizer urd1 = new StringTokenizer(unreadString, ",");
		    SortedSet unreadSet = new TreeSet();
		    while(urd1.hasMoreTokens())
		    {
		        unreadSet.add(urd1.nextToken());		    
		    }
		          
		    rs=st.executeQuery("select * from mail_bulk_student where user_id='"+emailId+"'");
	    	    if(rs.next())
	    	    {
	       	      	     rStr = rs.getString("read_bulk");
	       		     urStr = rs.getString("unread_bulk");
	    	    }
	    
	    	    rSet = new TreeSet();
	    	    urSet = new TreeSet();
	    	    StringTokenizer stkreadu = new StringTokenizer(rStr, ",");
	    	    while(stkreadu.hasMoreTokens())
	    	    {
	         		rSet.add(stkreadu.nextToken());
	    	    }
	    	    StringTokenizer stkureadu = new StringTokenizer(urStr, ",");
	    	    while(stkureadu.hasMoreTokens())
	    	    {
	         		urSet.add(stkureadu.nextToken());
	    	    }
		    Iterator itunread = unreadSet.iterator();
		    String tempUnread="";
		    while(itunread.hasNext())
		    {
		        tempUnread = (String)itunread.next();
		        if(rSet.contains(tempUnread))
	        	 	  rSet.remove(tempUnread);
	    	        urSet.add(tempUnread);		    
		    }
	    	    urSet.removeAll(rSet);	 
		    rStr="";
	    	    urStr="";
	    	    rList = new Vector(rSet);
	    	    urList = new Vector(urSet);
		    for(int i=0;i<rList.size();i++)
	    	    {
	        	       if(i==0)
		    		   	rStr = (String)rList.get(i);
				else
		    			rStr = rStr + "," + rList.get(i);
	    	    }
	    	    for(int i=0;i<urList.size();i++)
	    	    {
	        		if(i==0)
		    			urStr = (String)urList.get(i);
				else
		    			urStr = urStr + "," + urList.get(i);
	    	    }
	    	   st.executeUpdate("update mail_bulk_student set read_bulk='"+rStr+"', unread_bulk='"+urStr+"' where user_id='"+emailId+"'");   
			
	     }
	     
	     if((moveString!=null)&&(!moveString.equals(""))) 
	     {
	            StringTokenizer md1 = new StringTokenizer(moveString, ",");
		    String mfolder = request.getParameter("mf");
		    String user_Id="",to_User="",from_User="",subject="",receive_Date="",receive_Time="",eId="";
		    int att=0, Id=0, total_User=0;
		    Calendar calendar = Calendar.getInstance();
		    String year = ""+calendar.get(Calendar.YEAR);
		    int tm = calendar.get(Calendar.MONTH) + 1;
		    String month = ""+tm;
		    rStr="";
		    urStr="";
		    rs = st.executeQuery("select * from mail_bulk_student where user_id='"+emailId+"'");
	    	    if(rs.next())
	    	    { 
	       		    rStr = rs.getString("read_bulk");   
	       		    urStr = rs.getString("unread_bulk");
	     	     }
	     	    rSet = new TreeSet();
	    	    urSet = new TreeSet();
	            StringTokenizer stkrm = new StringTokenizer(rStr, ",");
	            while(stkrm.hasMoreTokens())
	            {
	       		     rSet.add(stkrm.nextToken());
	             }
	            StringTokenizer stkurm = new StringTokenizer(urStr, ",");
	            while(stkurm.hasMoreTokens())
	            {
	                     urSet.add(stkurm.nextToken());
	            }			  
	            while(md1.hasMoreTokens())
		    {
		                // calculating that user is having enough space or not
	        	   int allMail=0;
			   float size=0.0f;
			   rs = st.executeQuery("select count(*) allmail from mail_box where user_id='"+emailId+"'");
	    		   if(rs.next())
	       			   allMail = rs.getInt("allmail"); 
	    		   size = 500*allMail;    
	    		   size += recursiveSizecount(attachPath + "/" + schoolId + "/" + userId + "/attachments");
	    		   size += recursiveSizecount(attachPath + "/" + schoolId + "/" + userId + "/email");
	    		   size /=1048576;
			   if(size > 500)      // user space size limit in MB
			   {
		  	   	moveFlag = true;
				break;
			   }		    
		    
			      // moving email from bulk to user space
		          String emailIdMove = md1.nextToken();
			  if(rSet.contains(emailIdMove))
			        rSet.remove(emailIdMove);
			  if(urSet.contains(emailIdMove))
			        urSet.remove(emailIdMove);
			  rs=st.executeQuery("select * from mail_bulk where email_id='"+emailIdMove+"'");
			  if(rs.next())
			  {
			        user_Id = rs.getString("user_id");
			        to_User = rs.getString("to_user");
				from_User = rs.getString("from_user");
				subject = rs.getString("subject");
				receive_Date = rs.getString("receive_date");
				receive_Time = rs.getString("receive_time");
				att = rs.getInt("attachment");
				total_User = rs.getInt("total_user");
			  }
			   // creating unique emailid
	      		  rs = st.executeQuery("select max(id) idnum from mail_box where month(receive_date)='"+month+"' and year(receive_date)='"+year+"' and user_id='"+emailId+"'");
	      		  if(rs.next())
		   	  	Id = rs.getInt("idnum");
	      		  rs.close();	   
	      		  Id = Id + 1;
              		  eId = year + month + Id;
			   // inserting email informatin into database
	      		  st.executeUpdate("insert into mail_box values('"+emailId+"','"+to_User+"','"+from_User+"','"+subject+"','"+receive_Date+"','"+receive_Time+"','"+mfolder+"','"+att+"','"+eId+"','"+Id+"',0)");
			  
			    // getting school and course/class id
			  StringTokenizer stkmove = new StringTokenizer(user_Id, "@");
			  if(stkmove.hasMoreTokens())
			          cName = stkmove.nextToken();
			  if(stkmove.hasMoreTokens())
			          sName = stkmove.nextToken();
			            			  
			   // copy email body file
	      		  String fromBodyUrl = attachPath + "/" + sName + "/bulkmail/" + cName + "/email";
	      		  String toBodyUrl = attachPath + "/" + schoolId + "/" + userId + "/email";
			  File fromFolder = new File(fromBodyUrl);
			  File toFolder = new File(toBodyUrl);
	      		  if(!fromFolder.isDirectory())
	           		fromFolder.mkdirs();
	      		  if(!toFolder.isDirectory())
	           		toFolder.mkdirs();
	      		  File fromFile = new File(fromFolder, emailIdMove+".html");
	      		  File toFile = new File(toFolder, eId+".html");
			  copyFile(fromFile, toFile);
	      
	       			// copy attachments
	      		  if(att>0)
	      		  {	  
		  		String fromUrl = attachPath + "/" + sName + "/bulkmail/" + cName + "/attachments/" + emailIdMove;
		  		String toUrl = attachPath + "/" + schoolId + "/" + userId + "/attachments/" + eId;
				File fromAttachFolder = new File(fromUrl);
		  		File toAttachFolder = new File(toUrl);
		  		toAttachFolder.mkdirs();
				String attachList[] = null;
				attachList = fromAttachFolder.list(); 
		  		for(int i=0;i<attachList.length;i++)  
	            		{
		       			File attachIn = new File(fromAttachFolder, attachList[i]);
		       			File attachOut = new File(toAttachFolder, attachList[i]);
		       			copyFile(attachIn, attachOut); 
		    		}
	      		  }			  
			  
			    // updating bulk email record
			   total_User = total_User - 1;
			   if(total_User==0)
			   {
			       st.executeUpdate("delete from mail_bulk where email_id='"+emailIdMove+"'");
			       fromFile.delete();			       
			       if(att>0)
			  	{
				      String attUrl = attachPath + "/" + sName + "/bulkmail/" + cName + "/attachments/" + emailIdMove;	    
	                              File atFolder = new File(attUrl);
				      if(atFolder.isDirectory())
				      {
				      		String atlist[] = atFolder.list();
				      		for(int k=0;k<atlist.length;k++)
				      		{
				          		File fileAt = new File(atFolder, atlist[k]);
					  		fileAt.delete();
				      		}
				       }
				      atFolder.delete();					 
			  	}   
			   }else{
			          st.executeUpdate("update mail_bulk set total_user='"+total_User+"' where email_id='"+emailIdMove+"'");   
			   }			  
		    }
		    // updating student bulk record
		     rList = new Vector(rSet);
	    	     urList = new Vector(urSet);
		     rStr="";
		     urStr="";
	    	     for(int i=0;i<rList.size();i++)
	    	     {
	           	  if(i==0)
		    		rStr = (String)rList.get(i);
			  else
		    		rStr = rStr + "," + rList.get(i);
	    	      }
	    	     for(int i=0;i<urList.size();i++)
	    	     {
	        	  if(i==0)
		    		urStr = (String)urList.get(i);
			  else
		    		urStr = urStr + "," + urList.get(i);
	              }
	    	    st.executeUpdate("update mail_bulk_student set read_bulk='"+rStr+"', unread_bulk='"+urStr+"' where user_id='"+emailId+"'");   
		
		    
	     }
	     
	     
	    rStr = "";
	    urStr = "";
	    rs = st.executeQuery("select * from mail_bulk_student where user_id='"+emailId+"'");
	    if(rs.next())
	    { 
	       rStr = rs.getString("read_bulk");   
	       urStr = rs.getString("unread_bulk");
	     }
	   
	    if((rStr==null)||(rStr.equals("")))
	    {
	       rStr="";
	       if((urStr==null)||(urStr.equals("")))   
	       {
	          totStr = "''";    
	       }else{
	                totStr = urStr;
	           }
	    }else{
	            if((urStr==null)||(urStr.equals("")))   
	       	    {
	          	totStr = rStr;    
	             }else{
	             	   totStr = rStr + "," + urStr;
	              }	              	    
	        }
	    
            rSet = new TreeSet();
	    urSet = new TreeSet();
	    StringTokenizer stkr = new StringTokenizer(rStr, ",");
	    while(stkr.hasMoreTokens())
	    {
	       rSet.add(stkr.nextToken());
	    }
	    StringTokenizer stkur = new StringTokenizer(urStr, ",");
	    while(stkur.hasMoreTokens())
	    {
	       urSet.add(stkur.nextToken());
	    }
		 
            newMail = urSet.size();
	    totalMail = rSet.size() + urSet.size();
	   	         
%>

<html>

<head>
<title></title>
<link href="images/style.css" rel="stylesheet" type="text/css" />
</head>

<body bgcolor="#f0f0f0" link="black" vlink="purple" alink="red" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0">
<form name="mailidslist">
 
 <%  
		if(moveFlag==true)
		{
%>
			<table bgcolor="#FAF0E6" width="100%">
			<tr>
				<td width="100%"><font face="verdana" size=1 color="#AA5303">No free space in your account</font></td> 
			</tr>
			</table>
<%      
		}
%>

<table bgcolor="#DCDCDE" width="100%">
<tr>
	<td width="50%" height="18" align="left">
		<font face="verdana" size="2" color="#000000"><b>Bulk-</b></font>
		<font face="verdana" size="2" color="#000000">&nbsp;<%=totalMail%>&nbsp;Mails (<%=newMail%>&nbsp;New)</font>
	</td>
</tr>
</table>

<% 
			String tempStart = (String)request.getParameter("start");
			if(tempStart==null)
				start=0;
			else	 
				start=Integer.parseInt(tempStart);
			c=start+pageSize;
			currentPage=c/pageSize;
			end=start+pageSize;
			totRecords = totalMail;
			if (c>=totRecords)
				end=totRecords;
%>
      
<table bgcolor="white" width="100%">
<tr>
	    
<% 
		if((start==0)&(totRecords==0))
		{
%>  
	        <td width="100%" align="right">
<%  
		}
		else
		{
%>			 
			<td width="100%" align="right">
				<font color="#000080" face="verdana" size="2">
				<%=(start+1)%> - <%=end%> of <%=totRecords%>&nbsp;Mails&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
<% 
		}
%>  
			<font color="#000080" face="verdana" size="2">
<%
		if(start==0)
		{ 
			               		if(totRecords>end){
				     	        out.println("Prev | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+sortingBy+"','"+sortingType+"');return false;\"> Next</a>");
		            	     		   }else
				      		     out.println("Prev | Next ");
                             	       }
		                      else{
                				linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+sortingBy+"','"+sortingType+"');return false;\">Prev</a> |";
                     				if(totRecords!=end){
			                       		linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+sortingBy+"','"+sortingType+"');return false;\"> Next</a>";
			                  	}else
				                	linkStr=linkStr+" Next";
	            		 		out.println(linkStr);
                                        }	
%>
			</font>
		</td>
	</tr>
	</table>
	
	<table bgcolor="#DCDCDE" width="100%" border="0">	
	<tr>
		<td width="10%">
			<input type="button" name="deletebtn" value="Delete" onclick="javascript: deletemail('<%=start%>','<%=sortingBy%>','<%=sortingType%>')">
		</td>
	    <td width="10%">
			<input type="button" name="readbtn" value="Mark as Read" onclick="javascript: readmail('<%=start%>','<%=sortingBy%>','<%=sortingType%>')">
		</td>
	    <td width="10%">
			<input type="button" name="unreadbtn" value="Mark as Unread" onclick="javascript: unreadmail('<%=start%>','<%=sortingBy%>','<%=sortingType%>')">
		</td>
	    <td width="7%"></td>
        <td width="10%" align="right">
			<select name="movelist">
				<option value="">Select</option>
		<%
            		rs = st.executeQuery("select distinct folder from mail_folder where user_id='"+emailId+"'");
            		while(rs.next()){
		%>					  
                        <option value='<%=rs.getString("folder")%>'><%=rs.getString("folder")%></option>
		<% } %>					  
	                                  </select></td>
	    	                                                                           
		<td width="10%" align="left">
			<input type="button" name="movebtn" value="Move" onclick="javascript: movemail('<%=start%>','<%=sortingBy%>','<%=sortingType%>')"></td>
	    
	    <td width="40%"></td>
	</tr>
 </table> 
 <table width="100%">
        <tr>
	
<%
		int i=0;		 
		String bgColor1="#DCDCDE",bgColor2="#DCDCDE",bgColor3="#DCDCDE",fColor1="black",fColor2="black";
		if(sortingBy.equals("id"))	 
		{
			bgColor1="#8C8C93";
			fColor1="white";
			fColor2="black";
			i=1;  
		}          
		if(sortingBy.equals("sb"))	 
		{
			bgColor2="#8C8C93";
			fColor1="white";
			fColor2="black";
			i=2;  
		} 
		if(sortingBy.equals("rd"))
		{
			bgColor3="#8C8C93";
			fColor1="white";
			fColor2="black";
			i=3;   
		}
%>	
		
		<td width="2%" align="right" bgcolor="#DCDCDE">
			<input type="checkbox" name="selectall" onclick="javascript:selectAll()" value="ON">
		</td>
	    <td width="20%" bgcolor='<%=bgColor1%>' height="25"><font face="verdana" size="2" color="#4B0082">
<%
		if((sortingType.equals("A"))&&(sortingBy.equals("id")))
        {
%>	    
		    <a href="BulkInbox.jsp?start=0&sorttype=D&sortby=id" target="_self">
			<font face='verdana' size='2' color="<%=fColor1%>"><b>From</b></font>
<%   
			if(i==1)
			{
%>
				<img border="0" src="images/sort_dn_1.gif">
<%   
			}
%>  
			</a>	
<%   
		}
		else
		{
%>   
		    <a href="BulkInbox.jsp?start=0&sorttype=A&sortby=id" target="_self">
			<font face='verdana' size='2' color="<%=fColor2%>"><b>From</b></font>
<%   
			if(i==1)
			{
%>
				<img border="0" src="images/sort_up_1.gif">
<%   
			}
%>  
			</a>
<%   
		}
%>
			</font>
		</td>
		<td width="50%" bgcolor='<%=bgColor2%>' height="25"><font face="verdana" size="2" color="#4B0082">
<%
		if((sortingType.equals("A"))&&(sortingBy.equals("sb")))
        {
%>	    
		     <a href="BulkInbox.jsp?start=0&sorttype=D&sortby=sb" target="_self">
			 <font face="verdana" size="2" color="<%=fColor1%>"><b>Subject</b></font>
<%
			if(i==2)
			{
%>
				<img border="0" src="images/sort_dn_1.gif">
<%  
			}
%>
			</a>
<%   
		}
		else
		{
%>   
		     <a href="BulkInbox.jsp?start=0&sorttype=A&sortby=sb" target="_self">
			 <font face="verdana" size="2" color="<%=fColor2%>"><b>Subject</b></font>
<%   
			if(i==2)
			{
%>
				<img border="0" src="images/sort_up_1.gif">
<%  
			}
%>
			</a>
<%   
		}
%>
			</font>
		</td>
		<td width="15%" bgcolor='<%=bgColor3%>' align="center" height="25">
		<font face="verdana" size="2" color="#4B0082"> 
<%
		if((sortingType.equals("A"))&&(sortingBy.equals("rd")))
        {
%>	    
		    <a href="BulkInbox.jsp?start=0&sorttype=D&sortby=rd" target="_self">
			<font face="verdana" size="2" color="<%=fColor1%>"><b>Date</b></font>
<%   
			if(i==3)
			{
%>
				<img border="0" src="images/sort_dn_1.gif">
<%  
			}
%>
			</a>
<%   
		}
		else
		{
%>
			<a href="BulkInbox.jsp?start=0&sorttype=A&sortby=rd" target="_self">
			<font face="verdana" size="2" color="<%=fColor2%>"><b>Date</b></font>
<%   
			if(i==3)
			{
%>
				<img border="0" src="images/sort_up_1.gif">
<%			
			}
%>
			</a>
<%   
		}
%>
			</font>
		</td>
	</tr>
<%	
//	 from_user, subject, receive_date,email_id, attachment, mark_read

//rs = st.executeQuery("select from_user, subject, receive_date, attachment, email_id from mail_bulk where email_id in("+totStr+") order by "+sortStr+" LIMIT "+start+","+pageSize);


rs = st.executeQuery("select from_user, subject, receive_date, attachment, email_id from mail_bulk where email_id in("+totStr+") order by "+sortStr+" LIMIT "+start+","+pageSize);

    while(rs.next())
    {
            String fromString=rs.getString("from_user");
			if(fromString.length()>26)
				fromString = fromString.substring(0,25) + "..."; 
			if(urSet.contains(rs.getString("email_id")))
                bflag = true;
	        else
	            bflag = false;	
		subjectString= rs.getString("subject");
	   if(subjectString.length()>37)
	         subjectString = subjectString.substring(0,36) + "...";
	   checkboxValue = rs.getString("email_id");
			  
%>	
	<tr>
	   <td align="right" bgcolor="#FFFFF0"><font face="verdana" size="2pt" color="#800080">
	         <%  if(rs.getInt("attachment")!=0){  %>
	                   <img border="0" src="images/attach.gif">
	         <%  }    %>      
		 </font>   <input type="checkbox" name="selids" value='<%=checkboxValue%>'>
           </td>
	   <td bgcolor="#FFFFF0"><font face="verdana" size="2pt" color="#800080">
	          <% if(bflag==true){%> 
		 <b>  <%=rs.getString("from_user")%> </b>
		  <% }else {%>
		   <%=rs.getString("from_user")%>
		  <%  }   %> 
		  </font>
	   </td>
	   <td bgcolor="#FFFFF0"><font face="verdana" size="2pt" color="#800080">
	           <% if(bflag==true){%> 
		 <b><a href="#" onclick="viewmail('<%=start%>','<%="Bulk"%>','<%=sortingBy%>','<%=sortingType%>','<%=checkboxValue%>')">  <%=subjectString%></a></b>
		  <% }else {%>
		 <a href="#" onclick="viewmail('<%=start%>','<%="Bulk"%>','<%=sortingBy%>','<%=sortingType%>','<%=checkboxValue%>')">  <%=subjectString%></a>
		  <%  }   %>
		  </font>
	   </td>
	   <td bgcolor="#FFFFF0"><font face="verdana" size="2pt" color="#800080">
	          <% if(bflag==true){%> 
		 <b>  <%=rs.getString("receive_date")%> </b>
		  <% }else {%>
		      <%=rs.getString("receive_date")%>
		  <%  }   %>
		  </font>
	   </td>
	</tr>
	
<%    
		flag = true;
		}
	
		if(flag==false)
		{
 %>
		<tr  bgcolor="#FFD89D">
			<td colspan="4">
				<font face="verdana" size="2pt" color="black">There are no mails in this folder.</font>
			</td>
		</tr>
<%  
		} 
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("BulkInbox.jsp","operations on database","Exception",e.getMessage());
		
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("BulkInbox.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
 
  %>   	
	
 </table>
 </form>
</body>

<SCRIPT LANGUAGE="JavaScript">

        var str = "";	
	
	function getSelectedIds()
   	{
	          str = "";
		  var obj=document.mailidslist;
		  	  
     		  for(i=0;i<obj.elements.length;i++)
		   {
		     	if (obj.elements[i].type=="checkbox"){
				 if(obj.elements[i].name=="selids" && obj.elements[i].checked==true)
	                  	   {
				         if(str=="")
				   	     str = obj.elements[i].value;
					 else
					     str = str + "," + obj.elements[i].value;    
				   }
			   }
		    }	   
   	}

   	function selectAll(){
		var obj=document.mailidslist.selids;
		if(document.mailidslist.selectall.checked==true){
			for(var i=0;i<obj.length;i++){
				obj[i].checked=true;
			}

		}else{
			for(var i=0;i<obj.length;i++){
				obj[i].checked=false;
			}

		}
	}

	function deletemail(start, sortby, sorttype)
	{
	     getSelectedIds();
	     if(str=="")
	     {
	         alert("select email to delete");
		 return false;
	     }
	     window.location.href="BulkInbox.jsp?start="+ start+"&sortby="+sortby+"&sorttype="+sorttype+"&delete="+str; 
	}

	function readmail(start, sortby, sorttype)
	{
	     getSelectedIds();
	     if(str=="")
	     {
	         alert("select email to mark read");
		 return false;
	     }
	     window.location.href="BulkInbox.jsp?start="+ start+"&sortby="+sortby+"&sorttype="+sorttype+"&read="+str; 
	}
	
	function unreadmail(start, sortby, sorttype)
	{
	     getSelectedIds();
	     if(str=="")
	     {
	         alert("select email to mark unread");
		 return false;
	     }
	     window.location.href="BulkInbox.jsp?start="+ start+"&sortby="+sortby+"&sorttype="+sorttype+"&unread="+str; 
	}
	
	function movemail(start, sortby, sorttype)
	{
	     var obj=document.mailidslist.movelist;
	     var mfolder = obj.value;
	     if(mfolder=="")
	     {
	         alert("Select a folder to move from list");
		 return false;
	     }
	     getSelectedIds();
	     if(str=="")
	     {
	         alert("select emails to move");
		 return false;
	     }
	     window.location.href="BulkInbox.jsp?start="+ start+"&sortby="+sortby+"&sorttype="+sorttype+"&move="+str+"&mf="+mfolder; 
	}
	
        function go(start, sortby, sorttype)
	{
	                window.location.href="BulkInbox.jsp?start="+ start+"&sortby="+sortby+"&sorttype="+sorttype;
		return false;
	}
	
	function viewmail(start, foldername, sortby, sorttype, detail){
	               window.location.href="BulkViewMail.jsp?start="+start+"&sortby="+sortby+"&sorttype="+sorttype+"&detail="+detail;	
	      return false;
	}

		
</SCRIPT>

</html>
