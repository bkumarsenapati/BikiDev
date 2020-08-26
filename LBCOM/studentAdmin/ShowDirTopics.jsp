<html>
<head><title></title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
</head>
<body topmargin="0" leftmargin="0" link="blue" vlink="blue" alink="red">
<%@  page language="java"  import="java.sql.*,java.util.*,java.lang.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<% 
	String user=null,schoolid=null,sId=null,topiccount="",replycount="",maxdate="",dir="";
	String forumid=null,crtby=null,utype=null,logtype=null,prvlg=null;
	Connection con=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null;
	Statement st=null,st1=null,st2=null,st3=null;
%>
<%
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	String emailid =(String)session.getAttribute("emailid");
	user = emailid;
	schoolid =(String)session.getAttribute("schoolid");
	logtype=(String)session.getAttribute("logintype");
	boolean flag=false;

	try
	{
		con = con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		rs=st.executeQuery("select privilege from studentprofile where username='"+emailid+"' and schoolid='"+schoolid+"'");
		if(rs.next())
			prvlg=rs.getString(1);
	}
	catch(Exception ex)
	{
		ExceptionsFile.postException("ShowDirTopics.jsp","operations on database","Exception",ex.getMessage());
		out.println(ex+" its first");
		try
		{
			if(con!=null)
				con.close();
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("ShowDirTopics.jsp","closing resultset,statement and connection objects","Exception",e.getMessage());
			System.out.println("Connection close failed");
		}
	}
%>	
	<b>
		<font color="#660033" face="Verdana" size=1>Date:&nbsp;<%=new java.util.Date()%>
		<br><font size="1" face="Verdana">Click on the Forum of your Interest to Continue....</font></font><br>
<%
	if(prvlg.equals("1"))
	{
%>
		<a href="CreateForum.jsp?utype=student&tag=1">Create Forum</a></b>
<%
	}	
	else
	{
%>
		</b>
<%
	}
%>
<table border="0" width="100%" cellpadding="0" cellspacing="1">
    <tr>
      <td width="5%" align="center" bgcolor="#E0D1E0">
		<img src="images/std_viewsug.gif" height=25 width=25 TITLE="View Suggestions"></td>
      <td width="5%" align="center" bgcolor="#E0D1E0">
		<img src="images/std_del.gif" height=25 width=25 TITLE="Delete"></td>
      <td width="24%" align="left" bgcolor="#E0D1E0">
		<b><font face='Arial' size='2'>&nbsp;Forum Name</td>
      <td width="15%" align="left" bgcolor="#E0D1E0">
		<b><font face='Arial' size='2'>&nbsp;Author</td>
      <td width="12%" align="left" bgcolor="#E0D1E0">
		<b><font face='Arial' size='2'>&nbsp;Role</td>
      <td width="11%" align="center" bgcolor="#E0D1E0">
		<b><font face='Arial' size='2'>Topics</td>
      <td width="13%" align="center" bgcolor="#E0D1E0">
		<b><font face='Arial' size='2'>Replies</td>
      <td width="15%" align="center" bgcolor="#E0D1E0">
		<b><font face='Arial' size='2'>Last Topic Posted</td>
    </tr>

<%
	try
	{
		String queryStr="";
		rs3=st3.executeQuery("select schoolid from studentprofile where username='"+schoolid+"_"+user+"'");
		while(rs3.next())
		{
			queryStr+="or school_id='"+rs3.getString("schoolid")+"' ";
		}

		rs=st.executeQuery("select forum_name,forum_id,created_by,creator_type,school_id from forum_master where school_id='"+schoolid+"' "+queryStr+" order by forum_id");
    
		while(rs.next())
		{
			sId=rs.getString("school_id");
			dir=(rs.getString("forum_name")).trim();
			forumid=(rs.getString("forum_id")).trim();
			crtby=(rs.getString("created_by")).trim();
			utype=rs.getString("creator_type");
			utype=(utype.substring(0,1)).toUpperCase() + utype.substring(1,utype.length());
			flag=true;
		
			rs1=st1.executeQuery("select count(forum_id),max(trans_date) from forum_post_topic_reply where school_id='"+sId+"' and forum_id='"+forumid+"' and trans_type='1'");
		    if(rs1.next())
			{ 
				topiccount=rs1.getString(1);
				maxdate=rs1.getString(2);
	        }
        
			rs2=st2.executeQuery("select count(*) from forum_post_topic_reply where school_id='"+sId+"' and forum_id='"+forumid+"' and trans_type='2'"); 
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
				<td width="5%" align="center" bgcolor="#E2E2E2">
<%	
			if(crtby.equals(emailid) && utype.equalsIgnoreCase(logtype))
			{
%>
					<a href="ShowSuggestion.jsp?sid=<%=sId%>&fid=<%=forumid%>&fname=<%=dir%>">
					<img src="../forums/images/viewsug.gif" height=15 width=15 TITLE="View Suggestions" border=0></a>
				</td>
<%
			}
			else
			{
%>
				&nbsp;</td>
<%
			}
%>
				<td width="5%" align="center" bgcolor="#E2E2E2">
<%
			if(crtby.equals(emailid) && utype.equalsIgnoreCase(logtype))
			{
%>
				<a href="/LBCOM/forums.CreateForum?sid=<%=sId%>&fid=<%=forumid%>&fname=<%=dir%>&mode=delete" onclick="return confirm('Are you sure that you want to delete this Forum')">
				<img src="../forums/images/del.gif" height=15 width=15 TITLE="Delete" border=0></a></td>
<%
			}
			else
			{
				out.println("&nbsp;</td>");
			}
%>
			<td width="24%" align="left" bgcolor="#E2E2E2">
				<font face='Arial' size='2'>&nbsp;
				<a href="ShowTopics.jsp?sid=<%=sId%>&fid=<%=forumid%>&fname=<%=dir%>" style="color: #000000;text-decoration:none"><%=dir%></td>
			<td width="15%" align="left" bgcolor="#E2E2E2">
				<font face='Arial' size='2'>&nbsp;<%=crtby%></td>
			<td width="12%" align="left" bgcolor="#E2E2E2">
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
			<tr><td bgColor="#E2E2E2" colspan=8>&nbsp;</td></tr>
			<tr><td bgColor="#E2E2E2" colspan=8 align=center><-- No Forums Available --></td></tr>
<%
		}	
%>
			<tr><td bgColor="#E2E2E2" colspan=8>&nbsp;</td></tr>
			<tr><td colspan=8 bgcolor='#E0D1E0' width="100%">&nbsp;</td></tr>
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
			if(rs2!=null)
				rs2.close();
			if(rs!=null)
				rs.close();
			if(rs1!=null)
				rs.close();
			if(st2!=null)
		        st2.close();
			if(st1!=null)
				st1.close();
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
	    }
		catch(Exception e)
		{
			ExceptionsFile.postException("ShowDirTopics.jsp","closing resultset,statement and connection objects","Exception",e.getMessage());
			System.out.println("Connection close failed"+e);
		}
	}
%>

</body>
</html>

