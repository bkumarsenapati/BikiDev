<%@ page language="java" import="java.io.*,java.sql.*,java.util.SortedSet,java.util.StringTokenizer,coursemgmt.ExceptionsFile" %>
<%@ page import="java.util.Iterator,java.util.TreeSet" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%
        String userId="",schoolId="",emailId="",tempFolder="",df="",cf="";
        ResultSet  rs=null;
	Connection con=null;
	Statement st=null;
        SortedSet folderSet = new TreeSet();
	int newMail=0,totalMail=0, t=0;
	boolean flag=false;
	
        String sessId;
	sessId=(String)session.getAttribute("sessid");
			if(sessId==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
			}
	
%>
<%
  try{
            userId = (String)session.getAttribute("emailid");
  	    schoolId = (String)session.getAttribute("schoolid");
	    if(userId.equals("Admin"))
	            userId = "admin";
	    emailId = userId + "@" + schoolId;
	    	    
            con=db.getConnection();
	    st=con.createStatement();
	    
	    cf=request.getParameter("cf");
	    if(cf!=null)
	    {
	       st.executeUpdate("insert into mail_folder values('"+emailId+"','"+cf+"')");	    
	    }
	    
	    
	    df=request.getParameter("df");
	    if(df!=null)
	     {
	         rs=st.executeQuery("select count(*) mail from mail_box where user_id='"+emailId+"' and folder='"+df+"'");
	         if(rs.next())
		 {
		     t = rs.getInt("mail");
		 }
		 if(t==0)
		    st.executeUpdate("delete from mail_folder where user_id='"+emailId+"' and folder='"+df+"'");      
		 else
		   flag = true;			 
	     }   
	    
	    rs =st.executeQuery("select folder from mail_folder where user_id='"+emailId+"'");
            while(rs.next())
	    {
	       folderSet.add(rs.getString("folder"));
	    }
%>
<html>
<head>
<title></title>
<script language="JavaScript">
<!--
     function deletefolder(foldername)
	{
	    window.location.href="Folder.jsp?df="+foldername; 
	}

	function createfolder()
	{
	    window.location.href="CreateFolder.html"; 
	}
		
// -->
</script>
<link href="images/style.css" rel="stylesheet" type="text/css" />
</head>

<body  bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form>

<%
	if(flag==true)
	{
%>
		<table bgcolor="#FFFAFA" width="100%">
        <tr>
			<td><font face="verdana" size="1" color="#FF4500">***<%=df%> folder is not empty(Make it empty to delete)</font></td>
		</tr>
		</table>
<% 
	}
%>  


<table bgcolor="#DCDCDE" width="100%">
<tr>
	<td width="50%" height="18" align="left">
		<font face="verdana" size="2" color="#000000"><b>Folders</b></font>
	</td>
</tr>
</table>

<table bgcolor="#DCDCDE" width="100%" border="0">	
<tr>
	<td width="100%" bgcolor="white">&nbsp;</td>
</tr>
<tr>
	<td width="100%"><input type="button" name="createbtn" value="Create Folder" onclick="javascript: createfolder()"></td>
</tr>
</table>

<table width="100%" border="0" bgcolor="white">
<tr>
	<td width="15%" bgcolor="#FFD89D" align="center"><font face="verdana" size="2" color="#000000"><b>Folders</b></font></td>
	<td width="15%" bgcolor="#FFD89D" align="center"><font face="verdana" size="2" color="#000000"><b>Mails</b></font></td>
	<td width="15%" bgcolor="#FFD89D" align="center"><font face="verdana" size="2" color="#000000"><b>New</b></font></td>
	<td colspan="2" bgcolor="#FFD89D" width="55%">&nbsp;</td>
</tr>
</table>
<table width="100%" border="0" bgcolor="#FFD89D">
<%
		totalMail = newMail = 0;
        rs=st.executeQuery("select count(*) newmail from mail_box where user_id='"+emailId+"' and folder='Inbox' and mark_read='0'");
		if(rs.next())
			newMail = rs.getInt("newmail");
		
		rs=st.executeQuery("select count(*) totalmail from mail_box where user_id='"+emailId+"' and folder='Inbox' and mark_read in(0,1)");
		
		if(rs.next())
			totalMail = rs.getInt("totalmail");
%>	
<tr>
	<td width="15%" bgcolor="white" align="center"><font face="verdana" size="2"><a href='Inbox.jsp?folder=Inbox'>Inbox</a></font></td>
	<td width="15%" bgcolor="white" align="center"><font face="verdana" size="2"><%=totalMail%></font></td>
	<td width="15%" bgcolor="white" align="center"><font face="verdana" size="2"><%=newMail%></font></td>
	<td colspan="2" bgcolor="white" width="55%">&nbsp;</td>
</tr>

<%
		totalMail = newMail = 0;
        
		rs=st.executeQuery("select count(*) newmail from mail_box where user_id='"+emailId+"' and folder='Sent' and mark_read='0'");
		if(rs.next())
			newMail = rs.getInt("newmail");
		
		rs=st.executeQuery("select count(*) totalmail from mail_box where user_id='"+emailId+"' and folder='Sent' and mark_read in(0,1)");

		if(rs.next())
			totalMail = rs.getInt("totalmail");
%>	
<tr>
	<td width="15%" bgcolor="white" align="center"><font face="verdana" size="2"><a href='Inbox.jsp?folder=Sent'>Sent</a></font></td>
	<td width="15%" bgcolor="white" align="center"><font face="verdana" size="2"><%=totalMail%></font></td>
	<td width="15%" bgcolor="white" align="center"><font face="verdana" size="2"><%=newMail%></font></td>
	<td colspan="2" bgcolor="white" width="55%">&nbsp;</td>
</tr>
<%
		String rStr = "", urStr = "";
	    rs = st.executeQuery("select * from mail_bulk_student where user_id='"+emailId+"'");
	    if(rs.next())
	    { 
			rStr = rs.getString("read_bulk");   
			urStr = rs.getString("unread_bulk");
		}
	    SortedSet rSet = new TreeSet();
	    SortedSet urSet = new TreeSet();
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
<tr>
	<td width="15%" bgcolor="white" align="center"><font face="verdana" size="2"><a href='BulkInbox.jsp'>Bulk</a></font></td>
	<td width="15%" bgcolor="white" align="center"><font face="verdana" size="2"><%=totalMail%></font></td>
	<td width="15%" bgcolor="white" align="center"><font face="verdana" size="2"><%=newMail%></font></td>
	<td colspan="2" bgcolor="white" width="55%">&nbsp;</td>
</tr>
<%
        Iterator itr = folderSet.iterator();
		while(itr.hasNext())
		{
			tempFolder = (String)itr.next();
			rs=st.executeQuery("select count(*) newmail from mail_box where user_id='"+emailId+"' and folder='"+tempFolder+"' and mark_read='0' order by folder");
			if(rs.next())
	   			newMail = rs.getInt("newmail");
			rs=st.executeQuery("select count(*) totalmail from mail_box where user_id='"+emailId+"' and folder='"+tempFolder+"' order by folder");
			if(rs.next())
				totalMail = rs.getInt("totalmail");
%>	
<tr>
	<td width="15%" bgcolor="white" align="center">
		<font face="verdana" size="2"><a href='Inbox.jsp?folder=<%=tempFolder%>'><%=tempFolder%></a></font>
	</td>
	<td width="15%" bgcolor="white" align="center"><font face="verdana" size="2"><%=totalMail%></font></td>
	<td width="15%" bgcolor="white" align="center"><font face="verdana" size="2"><%=newMail%></font></td>
	<td width="55%" bgcolor="white" align="left" colspan="2">
		<input type="button" value="Delete" onclick="javascript: deletefolder('<%=tempFolder%>')">
	</td>
</tr>
<%  
		}
%>
</table>
  
<%
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("Folder.jsp","operations on database","Exception",e.getMessage());
		out.println("Exception in Commonmail/Folder.jsp is...."+e);
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
			ExceptionsFile.postException("Folder.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
%>  
  
</form>
</body>
</html>
