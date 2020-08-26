<%@ page language="java" import="java.io.*,java.sql.*,java.util.SortedSet,java.util.StringTokenizer,coursemgmt.ExceptionsFile" %>
<%@ page import="java.util.Iterator,java.util.TreeSet,java.util.Vector" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>

<%!
	synchronized float recursiveSizecount(String fileString)  /* to find the size of the files/folders */
	{
		float size=0.0f;
		try{
		
			File file = new File(fileString);
			String filedocs[]=file.list();
			if(filedocs==null)return size;
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
		        ExceptionsFile.postException("Commonmail/Inbox.jsp","recursiveSizeCount()","Exception",e.getMessage());
		}
		return size;
	}

%>
<%
    String userId="",schoolId="",queryString="",folderName="",attachPath="";
	String emailId="", timeString="", checkboxValue="",subjectString="",fromString="";
	String deleteString="", readString="", unreadString="", moveString="";
	String sortStr="",sortingBy="",sortingType="",linkStr="";
	int totRecords=0,start=0,end=0,c=0,pageSize=10,currentPage=0;
	String tuid="", ttime="", tdate="", tattach="";
	String emailUrl="",attachUrl="",space="";
	String flist[] = null;
	int newMail=0,totalMail=0,allMail=0;
	float size = 0.0f;
	boolean flag = false, bflag = false, spaceFlag=false;	
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
	    folderName = request.getParameter("folder");
	    sortingBy=(String)request.getParameter("sortby");
	    if(sortingBy==null) {    sortingBy="rd";  }
	    sortingType=(String)request.getParameter("sorttype");
	    if (sortingType==null){  sortingType="D"; }
	
	    if (sortingBy.equals("rd"))
		    sortStr="receive_date";
	    else if (sortingBy.equals("sb"))
		    sortStr="subject";
	    else if (sortingBy.equals("id"))
		   { 
		       if(folderName.equals("Sent"))
		                 sortStr="to_user";
			else
			         sortStr="from_user";
		   }
   			   
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
	    
	    attachUrl = attachPath + "/" + schoolId + "/" + userId+"/attachments";		    
	    emailUrl = attachPath + "/" + schoolId + "/" + userId+"/email";
	    
	                        	        
	    if((deleteString!=null)&&(!deleteString.equals("")))	    
	     {
	            StringTokenizer sd1 = new StringTokenizer(deleteString, ",");
		    while(sd1.hasMoreTokens())
		    {
		          int t=0;
			  String emailid = sd1.nextToken();
			  rs=st.executeQuery("select attachment from mail_box where user_id='"+emailId+"' and email_id='"+emailid+"'");
			  if(rs.next())
			       t=rs.getInt("attachment");
			  st.executeUpdate("delete from mail_box where user_id='"+emailId+"' and email_id='"+emailid+"'");
			
			  File userEmailFolder = new File(emailUrl);
			  File emailFile = new File(userEmailFolder, emailid+".html");
			       emailFile.delete();
	            
			  if(t>0)
			  {
			        File userAttachFolder = new File(attachUrl);
				File f1 = new File(userAttachFolder, emailid);
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
			  
			      // displaying new hidden emails space space is enough
			       // first calculating whole space used in Bytes
			  int allmail=0;
			  rs = st.executeQuery("select count(*) allmail from mail_box where user_id='"+emailId+"'");	      
			  if(rs.next())
	       			  allmail = rs.getInt("allmail");
			  float size1=0.0f;
			  size1 = 100*allmail;    
	    		  size1 += recursiveSizecount(attachUrl);
	    		  size1 += recursiveSizecount(emailUrl);
	    		  	    
			     // substracting hidden mails space 
			  Vector hiddenList = new Vector();
			  rs=st.executeQuery("select email_id, attachment from mail_box where user_id='"+emailId+"' and mark_read=3 order by receive_date");
			  while(rs.next())
			  {
			       hiddenList.add(rs.getString("email_id"));
			       if((rs.getInt("attachment"))==1)
			               size1 -= recursiveSizecount(attachUrl+"/"+rs.getString("email_id"));
	    		       size1 -= recursiveSizecount(emailUrl+"/"+rs.getString("email_id")+".html"); 
			       size1 -= 100;
			  }
			  		
			  for(int z=0;z<hiddenList.size();z++)
			  {
			             // calculating that user is having enough space or not
				    String e_mail= (String)hiddenList.get(z);
	        	   	    if((size1/1048576) < 10)      // user space size limit is 10MB
			   	    {
		  	   		st.executeUpdate("update mail_box set mark_read=0 where user_id='"+emailId+"' and email_id='"+e_mail+"'");	
					File f3 = new File(attachUrl+"/"+e_mail);
					if(f3.isDirectory())
					    size1 += recursiveSizecount(attachUrl+"/"+e_mail);
	    		                else
					     f3.delete();
					size1 += recursiveSizecount(emailUrl+"/"+e_mail+".html");
					size1 += 100;	    		  
			   	     }else 
				        { break;   }		    
			  }			  
		    }
	     }   	    
             
	    if((readString!=null)&&(!readString.equals("")))
	     {
	            StringTokenizer rd1 = new StringTokenizer(readString, ",");
		    while(rd1.hasMoreTokens())
		    {
		          String rd2 = rd1.nextToken();
			  st.executeUpdate("update  mail_box set mark_read='1' where user_id='"+emailId+"' and email_id='"+rd2+"'");
		    }
	     }
	     
	    if((unreadString!=null)&&(!unreadString.equals("")))
	     {
	            StringTokenizer ud1 = new StringTokenizer(unreadString, ",");
	            while(ud1.hasMoreTokens())
		    {
		          String ud2 = ud1.nextToken();
			  st.executeUpdate("update mail_box set mark_read='0' where user_id='"+emailId+"' and email_id='"+ud2+"'");
		    }
	     }
	     
	     if((moveString!=null)&&(!moveString.equals(""))) 
	     {
	            StringTokenizer md1 = new StringTokenizer(moveString, ",");
		    String mfolder = request.getParameter("mf");
	            while(md1.hasMoreTokens())
		    {
		          String md2 = md1.nextToken();
			  st.executeUpdate("update mail_box set folder='"+mfolder+"', mark_read='0' where user_id='"+emailId+"' and email_id='"+md2+"'");
		    }
	     }
	     
            rs = st.executeQuery("select count(*) newmail from mail_box where user_id='"+emailId+"' and folder='"+folderName+"' and mark_read='0'");
	    if(rs.next())
	        newMail = rs.getInt("newmail");
		
	    rs = st.executeQuery("select count(*) totalmail from mail_box where user_id='"+emailId+"' and folder='"+folderName+"' and mark_read in(0,1)");
	    if(rs.next())
	       totalMail = rs.getInt("totalmail");
	   	         
	   // calculating user space information   
	    rs = st.executeQuery("select count(*) allmail from mail_box where user_id='"+emailId+"'");
	    if(rs.next())
	       allMail = rs.getInt("allmail"); 
	    size = 100*allMail;    
	    size += recursiveSizecount(attachUrl);
	    size += recursiveSizecount(emailUrl);
	    String str1[]=null;
	    if(size>1048576)
	    { 
	        size /=1048576;
		if(size>10)
		    spaceFlag=true;
		space = size+"";
		space = space.replace('.','_');
		str1 = space.split("_");
	        space = str1[0]+"."+((str1[1].length()<9)?str1[1].substring(0,1):str1[1].substring(0,2)) + "MB";		
	    }else if(size>1024)
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

<html>

<head>
<title></title>
<link href="images/style.css" rel="stylesheet" type="text/css" />
</head>

<body bgcolor="white" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0">
<form name="mailidslist">
<table bgcolor="#DCDCDE" width="100%">
<tr>
	<td width="50%" height="18" align="left">
		<font face="verdana" size="2" color="#000000"><b><%=folderName%>-</b></font>
		<font face="verdana" size="2" color="#000000">&nbsp;<%=totalMail%>&nbsp;Mails (<%=newMail%>&nbsp;New)</font>
	</td>
<%  
	if(spaceFlag==false)
	{
%>
		<td width="50%" height="20" align="right">
			<font face="verdana" size=1 color="#000000"><b>&nbsp;&nbsp;&nbsp; <%=space%> used  of total 10MB</b></font>
		</td>
<%  
	}
	else
	{
%>
		<td width="350" height="20">
			<font face="verdana" size=1 color="#000000"><b>&nbsp;&nbsp;&nbsp;**No free space(make space to get new emails)</b></font>
		</td>
<% 
	}
%>
</tr>
</table>
 
<table bgcolor="white" width="100%">
<tr>

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
			<font color="#000080" face="verdana" size="2"><%= (start+1) %> - <%= end %> of <%= totRecords %>&nbsp;Mails&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
<% 
	}
%>  
			<font color="#000080" face="verdana" size="2">
<%
	if(start==0)
	{ 
		if(totRecords>end)
		{
			out.println("Prev | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+folderName+"','"+sortingBy+"','"+sortingType+"');return false;\"> Next</a>");
		}
		else
			out.println("Prev | Next ");
	}
	else
	{
		linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+folderName+"','"+sortingBy+"','"+sortingType+"');return false;\">Prev</a> |";
        if(totRecords!=end)
		{
			linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+folderName+"','"+sortingBy+"','"+sortingType+"');return false;\"> Next</a>";
		}
		else
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
		<input type="button" name="deletebtn" value="Delete" onclick="javascript: deletemail('<%=start%>','<%=folderName%>','<%=sortingBy%>','<%=sortingType%>')">
	</td>
	<td width="10%">
		<input type="button" name="readbtn" value="Mark as Read" onclick="javascript: readmail('<%=start%>','<%=folderName%>','<%=sortingBy%>','<%=sortingType%>')">
	</td>
	<td width="10%">
		<input type="button" name="unreadbtn" value="Mark as Unread" onclick="javascript: unreadmail('<%=start%>','<%=folderName%>','<%=sortingBy%>','<%=sortingType%>')">
	</td>
	<td width="7%"></td>
    <td width="10%" align="left">
		<select name="movelist">
		<option value="">Select</option>
<%
		rs = st.executeQuery("select distinct folder from mail_folder where user_id='"+emailId+"'");
        while(rs.next())
		{
%>					  
		<option value='<%=rs.getString("folder")%>'><%=rs.getString("folder")%></option>
<% 
		}
%>					  
		</select>
	</td>
	<td width="10%" align="left">
		<input type="button" name="movebtn" value="Move" onclick="javascript: movemail('<%=start%>','<%=folderName%>','<%=sortingBy%>','<%=sortingType%>')">
	</td>
	
	<td width="40%">&nbsp;</td>
</tr>
</table> 
<table width="100%" border="0">
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
		<a href="Inbox.jsp?start=0&folder=<%=folderName%>&sorttype=D&sortby=id" target="_self">
<%   
		if(folderName.equals("Sent"))
		{
%>
			<font face='verdana' size='2' color="<%=fColor1%>"><b>To</b></font>
<%
		}
		else
		{
%>
			<font face='verdana' size='2' color="<%=fColor1%>"><b>From</b></font>
<%
		}
		if(i==1)
		{
%>
			<img border="0" src="images/sort_dn_1.gif" width="12" height="11">
<%   
		}
%>  
		</a>	
<%   
	}
	else
	{
%>   
		<a href="Inbox.jsp?start=0&folder=<%=folderName%>&sorttype=A&sortby=id" target="_self">
<%   			       
		if(folderName.equals("Sent"))
		{
%>
			<font face='verdana' size='2' color="<%=fColor2%>"><b>To</b></font>
<%
		}
		else
		{
%>
			<font face='verdana' size='2' color="<%=fColor2%>"><b>From</b></font>
<%
		}
		if(i==1)
		{
%>
			<img border="0" src="images/sort_up_1.gif" width="12" height="11">
<%   
		}
%>  
		</a>
<%
	}
%>
</font>
	    </td>
		<td width="60%" bgcolor='<%=bgColor2%>' height="25">
			<font face="verdana" size="2" color="#4B0082">
<%
	if((sortingType.equals("A"))&&(sortingBy.equals("sb")))
    {
%>	    
		<a href="Inbox.jsp?start=0&folder=<%=folderName%>&sorttype=D&sortby=sb" target="_self">
		<font face="verdana" size="2" color="<%=fColor1%>"><b>Subject</b></font>
<%   
		if(i==2)
		{
%>
			<img border="0" src="images/sort_dn_1.gif" width="12" height="11">
<%  
		}
%>
		</a>
<%   
	}
	else
	{
%>   
		<a href="Inbox.jsp?start=0&folder=<%=folderName%>&sorttype=A&sortby=sb" target="_self">
		<font face="verdana" size="2" color="<%=fColor2%>"><b>Subject</b></font>
<%   
		if(i==2)
		{
%>
			<img border="0" src="images/sort_up_1.gif" width="12" height="11">
<%  
		}
%>
		</a>
<%   
	}
%>
	</font>
	</td>
	<td width="18%" bgcolor='<%=bgColor3%>'  align="center" height="25"><font face="verdana" size="2" color="#4B0082"> 

<%
	if((sortingType.equals("A"))&&(sortingBy.equals("rd")))
	{
%>	    
		<a href="Inbox.jsp?start=0&folder=<%=folderName%>&sorttype=D&sortby=rd" target="_self">
		<font face="verdana" size="2" color="<%=fColor1%>"><b>Date</b></font>
<%   
		if(i==3)
		{
%>
			<img border="0" src="images/sort_dn_1.gif" width="12" height="11">
<%  
		}
%>
		</a>
<%   
	}
	else
	{
%>
		<a href="Inbox.jsp?start=0&folder=<%=folderName%>&sorttype=A&sortby=rd" target="_self">
		<font face="verdana" size="2" color="<%=fColor2%>"><b>Date</b></font>
<%   
		if(i==3)
		{
%>
			<img border="0" src="images/sort_up_1.gif" width="12" height="11">
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
	rs = st.executeQuery("select from_user,to_user, subject, receive_date,email_id, attachment, mark_read from mail_box where   user_id='"+emailId+"' and folder='"+folderName+"' and mark_read in(0,1) order by "+sortStr+" LIMIT "+start+","+pageSize);

		while(rs.next())
		{
			if(rs.getInt("mark_read")==0)
				bflag = true;
			else
				bflag = false;	
			
			subjectString= rs.getString("subject");

			if(subjectString.length()>37)
				subjectString = subjectString.substring(0,36) + "...";
			if(folderName.equals("Sent"))
				fromString = rs.getString("to_user");		
			else
				fromString = rs.getString("from_user");
			
			if(fromString.length()>26)
				fromString = fromString.substring(0,25) + "..."; 
			// Below line is to remove the schoolid from the from user string. ex: teacher1 from teacher1@school1
			fromString = fromString.substring(0,fromString.indexOf('@'));
			
			checkboxValue = rs.getString("email_id");
%>	
			<tr bgcolor="#FFD89D">
			<td align="right">
				<font face="verdana" size="2pt" color="black">

<%  
			if(rs.getInt("attachment")!=0)
			{
%>
				<img border="0" src="images/attach.gif" width="6" height="11">
<%  
			}
%>      
			</font>
			<input type="checkbox" name="selids" value='<%=checkboxValue%>'>
		</td>
		<td><font face="verdana" size="2pt" color="black">

<% 
			if(bflag==true)
			{
%> 
				<b><%=fromString%></b>
<% 
			}
			else 
			{
%>
				<%=fromString%>
<%  
			}
%> 
				</font>
			</td>
			<td>
				<font face="verdana" size="2pt" color="black">
<% 
			if(bflag==true)
			{
%> 
				<a href="#" onclick="viewmail('<%=start%>','<%=folderName%>','<%=sortingBy%>','<%=sortingType%>','<%=checkboxValue%>')">  <b><%=subjectString%></b></a>
<% 
			}
			else
			{
%>
				<a href="#" onclick="viewmail('<%=start%>','<%=folderName%>','<%=sortingBy%>','<%=sortingType%>','<%=checkboxValue%>')">  <%=subjectString%></a>
<%  
			}
%>
			</font>
			</td>
			<td align="center"><font face="verdana" size="2pt" color="black">
<% 
			if(bflag==true)
			{
%> 
				<b><%=rs.getString("receive_date")%> </b>
<% 
			}
			else
			{
%>
				<%=rs.getString("receive_date")%>
<%  
			}
%>
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
		ExceptionsFile.postException("Inbox.jsp","operations on database","Exception",e.getMessage());
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("Inbox.jsp","closing statement and connection  objects","SQLException",se.getMessage());
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

	function deletemail(start, foldername, sortby, sorttype)
	{
	     getSelectedIds();
	     if(str=="")
	     {
	         alert("select email to delete");
		 return false;
	     }
	     window.location.href="Inbox.jsp?start="+ start+"&sortby="+sortby+"&sorttype="+sorttype+"&folder="+foldername+"&delete="+str; 
	}

	function readmail(start, foldername, sortby, sorttype)
	{
	     getSelectedIds();
	     if(str=="")
	     {
	         alert("select email to mark read");
		 return false;
	     }
	     window.location.href="Inbox.jsp?start="+ start+"&sortby="+sortby+"&sorttype="+sorttype+"&folder="+foldername+"&read="+str; 
	}
	
	function unreadmail(start, foldername, sortby, sorttype)
	{
	     getSelectedIds();
	     if(str=="")
	     {
	         alert("select email to mark unread");
		 return false;
	     }
	     window.location.href="Inbox.jsp?start="+ start+"&sortby="+sortby+"&sorttype="+sorttype+"&folder="+foldername+"&unread="+str; 
	}
	
	function movemail(start, foldername, sortby, sorttype)
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
	     window.location.href="Inbox.jsp?start="+ start+"&sortby="+sortby+"&sorttype="+sorttype+"&folder="+foldername+"&move="+str+"&mf="+mfolder; 
	}
	
        function go(start, foldername, sortby, sorttype)
	{
	                window.location.href="Inbox.jsp?start="+ start+"&sortby="+sortby+"&sorttype="+sorttype+"&folder="+foldername;
		return false;
	}
	
	function viewmail(start, foldername, sortby, sorttype, detail){
	               window.location.href="ViewMail.jsp?start="+start+"&sortby="+sortby+"&sorttype="+sorttype+"&folder="+foldername+"&detail="+detail;	
	      return false;
	}

		
 </SCRIPT>


</html>