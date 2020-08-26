<%@  page language="java"  import="java.sql.*,java.util.*,java.lang.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<% 
	String user="",schoolid="",topiccount="",replycount="",maxdate="",dir="",forumid="",crtby="",utype="";
	String forumdesc="",crtDate="",fStatus="",fcolor="",fStatusMsg="";
	int noofThreads=0;
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
	 if(emailid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
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
		ExceptionsFile.postException("ForumMgmtIndex.jsp","creating statement and connection objects","Exception",ex.getMessage());
		out.println(ex+" its first");
	}
%>
<html>

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Forum Management</title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<link rel="stylesheet" type="text/css" href="Forums/css/style.css" />
<SCRIPT LANGUAGE="JavaScript">
<!--
	function cantEditNow()
	{
		
	}
//-->
</SCRIPT>
</head>

<body>

<span style="font-size:10pt;"><font color="#660033" face="Verdana" size=1><B>&nbsp;Date:&nbsp;<%=new java.util.Date()%></B></font></span><BR><BR>

<table width="100%">
<tr>
<td width="100%">

<table border="0" cellpadding="0" cellspacing="0" face='Arial' size='3' style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" align="left">
	  
<tr>
<td width="25%"><span style="font-size:10pt;"><font face="Arial" color="blue"><a href="/LBCOM/schoolAdmin/Forums/ForumManagement.jsp?mode=findex&userid=<%=emailid%>&schoolid=<%=schoolid%>" style="color: blue;text-decoration:none"><b>Forum Index</b></a></font></span>
</td>
<td width="25%" align="left"><span style="font-size:10pt;"><font face="Arial" color="#996600"><b>Forum Management</b></font></span></td>
<td width="25%" align="right">&nbsp;</td>
<td width="25%" align="right">&nbsp;</td>
</tr>
<tr>
<td width="100%" colspan="4">&nbsp;</td>
</tr>
<tr>
  <td width="100%"  align="left" colspan="4"><span style="font-size:10pt;"><font face="Arial"><b>Forum Management</b> is where you can manage all aspects of your forums and threads. It is very intuitive and easy to use. To add new thread in a forum, click the Add New Thread link in that forum. To edit your forum, just click the Edit picture.</font></span>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td width="100%" colspan="4">&nbsp;</td>
</tr>

<tr>
<td width="100%">
<table border="2" cellpadding="0" cellspacing="0" face='Arial' size='3' style="border-collapse: collapse" bordercolor="#660033" width="100%" id="AutoNumber1" align="left">

  <tr>
  <td width="50%" align="left" colspan="4">
  <p align="center"><a href="CreateForum.jsp?utype=admin&tag=1" Title="Add new forum"><span style="font-size:9pt;"><font face="Arial"><b>Add New Forum</b></font></span></a></p>
		</td>
		<!-- <td width="50%" align="left" colspan="2">
			<p align="center"><a href="PostNewThread.jsp?mode=add&fname=&main=yes" title="Add new thread"><span style="font-size:9pt;"><font face="Arial"><b>Add New Thread</b></font></span></a></p>
		</td> -->
	  </tr> 
	</table>
	</td>
</tr>

<table align="center" border="8" cellpadding="0" cellspacing="0" width="100%" bordercolor="#EEBA4D" bordercolordark="#EEBA4D" bordercolorlight="#EEBA4D">
  <tr>
    <td width="7%" bgcolor="#EEBA4D" height="24" colspan="2">&nbsp;</td>
    <td width="44%" bgcolor="#EEBA4D" height="24">
            <p align="left"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Forum Name/Desc</b></span></font></td>
    <td width="10%" bgcolor="#EEBA4D" height="24">
            <p align="center"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Author</b></span></font></td>
	<td width="10%" bgcolor="#EEBA4D" height="24">
            <p align="center"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Role</b></font></td>
	<td width="8%" bgcolor="#EEBA4D" height="24">
            <p align="center"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Threads</b></span></font></td>
	<td width="10%" bgcolor="#EEBA4D" height="24">
            <p align="center"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Created Date</b></span></font></td>
	<td width="8%" bgcolor="#EEBA4D" height="24">
            <p align="center"><font face="Arial" color="white"><span style="font-size:10pt;"><b>New Thread</b></span></font></td>
	<td width="8%" bgcolor="#EEBA4D" height="24">
            <p align="center"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Status</b></span></font></td>
  </tr>

<%
	try
	{
		rs=st.executeQuery("select * from forum_master where school_id='"+schoolid+"' order by forum_id");
		
		while(rs.next())
		{
			dir=(rs.getString("forum_name")).trim();
			forumid=(rs.getString("forum_id")).trim();
			forumdesc=rs.getString("forum_desc");
			crtby=(rs.getString("created_by")).trim();
			utype = rs.getString("creator_type");
			utype = (utype.substring(0,1)).toUpperCase() + utype.substring(1,utype.length());
			crtDate = rs.getString("CREATEd_on");
			fStatus = rs.getString("status");

			String query1="select count(*) from forum_post_topic_reply where forum_id='"+forumid+"' and school_id='"+schoolid+"'";
			rs1=st1.executeQuery(query1);
			if(rs1.next())
			{
				noofThreads=rs1.getInt(1);
			}
			rs1.close();
			if(fStatus.equals("1"))
			{
				fcolor="#008000";
				fStatusMsg="<img src=\"../forums/images/refresh_icon.jpg\" TITLE=\"Make Inactive \"   height=\"20\" width=\"20\" border=0>";
			}
			else if(fStatus.equals("0"))
			{
				fcolor="red";
				fStatusMsg="<img src=\"../forums/images/refresh_icon.jpg\" TITLE=\"Make Active\"   height=\"20\" width=\"20\" border=0>";
			}
			if(crtDate==null || crtDate.equals("null"))
			{
				crtDate="-";
			}
			utype = (utype.substring(0,1)).toUpperCase() + utype.substring(1,utype.length());
			flag=true;
%>
		  <tr>
        <td colspan="9" align="center" valign="top" height="25">
            <table align="center" cellspacing="0" width="100%" bordercolordark="#E3E3E3" bordercolorlight="#EEBA4D" style="border-collapse:collapse;" cellpadding="0">
                <tr>
				<td width="7%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27">
			<table><tr>
			<td width="4%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><a href="/LBCOM/forums/EditForum.jsp?utype=<%=utype%>&fid=<%=forumid%>&fname=<%=dir%>&mode=edit">
			<img border="0" src="images/button_edit.gif" width="35" height="25" title="Edit Forum" border=0></a></td>
			<td width="3%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><a href="/LBCOM/forums.CreateForum?fid=<%=forumid%>&fname=<%=dir%>&mode=delete" onclick="return confirm('Are you sure that you want to delete this forum?')"><img border="0" src="images/Tea_del.gif" width="19" height="21" TITLE="Delete Forum" border=0></a></td>
			</tr></table>
			</td>
			<td width="44%" align="left" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#546878"><a href="../schoolAdmin/ShowThreads.jsp?fid=<%=forumid%>&fname=<%=dir%>&status=<%=fStatus%>" style="color: #120000;text-decoration:none" title="<%=dir%>"><b><%=dir%></b></a><br><font face='Arial' size='1' color="#002288">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=forumdesc%><br>&nbsp;</font></span></td>
			<td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#546878"><%=crtby%></font> </span></td>
			<td width="8%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#546878"><%=utype%></font></span></td>			
			<td width="8%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#546878"><%=noofThreads%></font></span></td>
			<td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#546878"><%=crtDate%></font></span></td>
			<td width="8%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#546878"> 
				<%
				if(!fStatus.equals("0"))
				{%>
					<b><a href="PostNewThread.jsp?mode=add&fid=<%= forumid %>&fname=<%=dir%>" face='Arial' size='2' style="color: #008000;text-decoration:none" title="Add new Thread in the category '<%=dir%>'">Add</font></span></a>
				<%
				}
				else
				{
				%>	
					<b><font face='Arial' size='2' style="color: red;text-decoration:none" title="'<%=dir%>' forum has been closed">Inactive</font></span></a>
				<%
				}
				%>
			</td>
			<td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="<%=fcolor%>" title="Change Forum Status">
			<a href="/LBCOM/forums/ChangeForumStatus.jsp?fid=<%=forumid%>&status=<%=fStatus%>" style="color: #000000;text-decoration:none"><%=fStatusMsg%></font></span></a>&nbsp;</td>
		  </tr>
		  </table>
		  </td>
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
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("ForumMgmtIndex.jsp","operations on database","Exception",e.getMessage());
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
			ExceptionsFile.postException("ForumMgmtIndex.jsp","operations on database","Exception",e.getMessage());
			System.out.println("Connection close failed");
		}
	}
%>

</table>

</body>

</html>