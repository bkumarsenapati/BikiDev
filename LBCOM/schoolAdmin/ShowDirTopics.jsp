<%@  page language="java"  import="java.sql.*,java.util.*,java.lang.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<% 
	String user="",schoolid="",topiccount="",replycount="",maxdate="",dir="",forumid="",crtby="",utype="";
	Connection con=null;
	ResultSet rs=null,rs1=null,rs2=null;
	Statement st=null,st1=null,st2=null;
%>
<%
	String emailid = request.getParameter("emailid");
	user = emailid;
	schoolid = request.getParameter("schoolid");
	if(emailid==null)
	{
		emailid=(String)session.getAttribute("emailid");
		schoolid=(String)session.getAttribute("schoolid");
	}
	boolean flag=false;
	try
	{
		 con = con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
	}
	catch(Exception ex)
	{
		ExceptionsFile.postException("ShowDirTopics.jsp","creating statement and connection objects","Exception",ex.getMessage());
		out.println(ex+" its first");
	}
%>

<html>
<head>
<title></title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<SCRIPT LANGUAGE="JavaScript">
<!--
	function cantEditNow()
	{
		alert("This feature will be added soon.");
		return false;
	}
//-->
</SCRIPT>
</head>
<body topmargin="0" leftmargin="0" link="blue" vlink="blue" alink="red">
	<br><b>
	<center><font face="Verdana" size="3" color="red">Manage Forums</font></center>
	<table width="100%">
	<tr>
		<td width="50%" align="left">
			<font face="Verdana" size="2" color="blue">
			<a href="CreateForum.jsp?utype=admin&tag=1"><b>Create New Forum</b></a></font>
		</td>
		<td width="50%" align="right">
			<font face="Verdana" size="2" color="blue">
			<a href="ForFrame.jsp?schoolid=<%=schoolid%>&userid=Admin"><b>Privilege Controller</b></a></font>
		</td>
	</tr>
	</table>
	<table border="0" width="100%" cellpadding="0" cellspacing="1">
		<tr>
			<td width="2%" align="center" bgcolor="#F0B850">&nbsp;</td>
			<td width="2%" align="center" bgcolor="#F0B850">&nbsp;</td>
			<td width="2%" align="center" bgcolor="#F0B850">&nbsp;</td>
			<td width="24%" align="center" bgcolor="#F0B850">
				<b><font face='Arial' size='2'>Forum Name</td>
			<td width="15%" align="center" bgcolor="#F0B850">
				<b><font face='Arial' size='2'>Creator</td>
			<td width="12%" align="center" bgcolor="#F0B850">
				<b><font face='Arial' size='2'>Role</td>
		    <td width="11%" align="center" bgcolor="#F0B850">
				<b><font face='Arial' size='2'>Topics</td>
			<td width="13%" align="center" bgcolor="#F0B850">
				<b><font face='Arial' size='2'>Replies</td>
			<td width="15%" align="center" bgcolor="#F0B850">
				<b><font face='Arial' size='2'>Last Topic Posted On</td>
		</tr>
<%
	try
	{
		rs=st.executeQuery("select forum_name,forum_id,created_by,creator_type from forum_master where school_id='"+schoolid+"' order by forum_id");
		
		while(rs.next())
		{
			dir=(rs.getString(1)).trim();
			forumid=(rs.getString(2)).trim();
			crtby=(rs.getString(3)).trim();
			utype = rs.getString(4);
			utype = (utype.substring(0,1)).toUpperCase() + utype.substring(1,utype.length());
			flag=true;
			rs1=st1.executeQuery("select count(forum_id),max(trans_date) from forum_post_topic_reply where school_id='"+schoolid+"' and forum_id='"+forumid+"' and trans_type='1'");
			if(rs1.next())
			{ 
				topiccount=rs1.getString(1);
				maxdate=rs1.getString(2);
			}
			
			rs2=st2.executeQuery("select count(*) from forum_post_topic_reply where school_id='"+schoolid+"' and forum_id='"+forumid+"' and trans_type='2'"); 
			if(rs2.next())
				replycount=rs2.getString(1);

			String lastdate="";
			String month[]={"Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Nov","Dec"};
			if((maxdate==null)||(maxdate.equals("0")))
			{
				maxdate="  ";
				lastdate="No Postings";
			}
			else
			{
				try
				{
					StringTokenizer stk1=new StringTokenizer(maxdate," ");
					String str1=stk1.nextToken();
					StringTokenizer stk2=new StringTokenizer(str1,"-");
					String f1=stk2.nextToken();
					String f2=stk2.nextToken();
					String f3=stk2.nextToken();
					int mn1=Integer.parseInt(f2);
					lastdate=month[(mn1-1)]+" "+f3+","+f1;
				}
				catch(Exception e)
				{	
					ExceptionsFile.postException("ShowDirTopics.jsp","tokenizing the string","Exception",e.getMessage());
					lastdate="No Postings";
				}
			}
%>
	<tr>
		<td width="2%" align="center" bgcolor="#E2E2E2">
			<a href="ShowSuggestion.jsp?fid=<%=forumid%>&fname=<%=dir%>">
			<img src="../forums/images/viewsug.gif" TITLE="View Suggestions" border=0></a>
		</td>
<!-- 		<td width="2%" align="center" bgcolor="#E2E2E2">
			<a href="/LBCOM/forums.EditForum?fid=<%=forumid%>&fname=<%=dir%>&mode=edit">
			<img src="../forums/images/iedit.gif" TITLE="Edit Forum" border=0></a>
		</td>
 -->
		<td width="2%" align="center" bgcolor="#E2E2E2">
			<a href="#" onclick="return cantEditNow();">
			<img src="../forums/images/iedit.gif" TITLE="Edit Forum" border=0></a>
		</td>
		<td width="2%" align="center" bgcolor="#E2E2E2">
			<a href="/LBCOM/forums.CreateForum?fid=<%=forumid%>&fname=<%=dir%>&mode=delete" onclick="return confirm('Are you sure that you want to delete this forum?')">
			<img src="../forums/images/del.gif" TITLE="Delete Forum" border=0></a>
		</td>
		<td width="24%" align="left" bgcolor="#E2E2E2">
			<font face='Arial' size='2'>&nbsp;
			<a href="../schoolAdmin/ShowTopics.jsp?fid=<%=forumid%>&fname=<%=dir%>" style="color: #000000;text-decoration:none"><%=dir%></td>
		<td width="15%" align="left" bgcolor="#E2E2E2">
			<font face='Arial' size='2'>&nbsp;<%=crtby%></td>
		<td width="12%" align="center" bgcolor="#E2E2E2">
			<font face='Arial' size='2'>&nbsp;<%=utype%></td>
		<td width="11%" align="center" bgcolor="#E2E2E2">
			<font face='Arial' size='2'><%=topiccount%></td>
		<td width="13%" align="center" bgcolor="#E2E2E2">
			<font face='Arial' size='2'><%=replycount%></td>
		<td width="15%" align="center" bgcolor="#E2E2E2">
			<font face='Arial' size='2'><%=lastdate%></td>
	</tr>
<%
		}
		if(flag==false)
		{
%>
			<tr>
				<td bgColor="#E2E2E2" colspan="9">&nbsp;</td>
			</tr>
			<tr>
				<td bgColor="#E2E2E2" colspan="9" align="center"><-- No Forums Available --></td>
			</tr>
			<tr>
				<td bgColor="#E2E2E2" colspan="9">&nbsp;</td>
			</tr>
<%
		}
%>
		<tr>
			<td colspan="9" bgcolor="#F0B850">&nbsp;</td>
		</tr>
	</table>
<%
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("ShowDirTopics.jsp","operations on database","Exception",e.getMessage());
		out.println(e+" second");
	}
	finally
	{
		try
		{
			if(con!=null)
				con.close();
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("ShowDirTopics.jsp","operations on database","Exception",e.getMessage());
			System.out.println("Connection close failed");
		}
	}
%>

</body>
</html>
