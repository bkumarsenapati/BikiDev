<html>
<head><title></title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<link rel="stylesheet" type="text/css" href="Forums/css/style.css" />
<SCRIPT LANGUAGE="JavaScript">
<!--
function redirect(user,school){
	alert("We are Sorry. You don't have access to this Forum");
	document.location.href="ShowDirTopics.jsp?emailid="+user+"&schoolid="+school;
}
//-->
</SCRIPT>
</head>
<body topmargin="0" leftmargin="0">
<%@  page language="java"  import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%!
String user,dir="",schoolid="",replycount="",user1="",topic="",maxdate="",topic1="",views="",one="",two="",three="",posteddate=" ",forumid,utype,acode="",temp="",message="",grade;
int sno=0;
String tStatus="",fcolor="",tMsgStatus="",status="";
String month[]={" ","Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Nov","Dec"};

private String check4Opostrophe(String s){
  StringBuffer stringbuffer = new StringBuffer(s);
        int i = 0;
        int j = 0;
        while(i < s.length()) 
            if(s.charAt(i++) == '\'')
            {
                stringbuffer.replace(j + i, j + i, "'");
                j++;
            }

        return stringbuffer.toString();
}
%>
<%
Connection con=null;
Statement stmt=null,stmt1=null;
ResultSet rs=null,rs1=null;
%>
<%
user=(String)session.getAttribute("emailid");
schoolid=(String)session.getAttribute("schoolid");
utype=(String)session.getAttribute("logintype");
forumid=request.getParameter("fid");
dir=request.getParameter("fname");
status=request.getParameter("status");
//System.out.println("status.."+status);
if(status==null || status.equals("null"))
{
	//System.out.println("if.."+status);
	status="1";
}
boolean flag=false;
%>

<span style="font-size:10pt;"><font color="#660033" face="Verdana" size=1><B>&nbsp;Date:&nbsp;<%=new java.util.Date()%></B></font></span><BR><BR>

<table width="100%">
<tr>
<td width="100%">

<table border="0" cellpadding="0" cellspacing="0" face='Arial' size='3' style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" align="left">
	  
<tr>
<td width="25%"><span style="font-size:10pt;"><font face="Arial" color="#429EDF"><a href="/LBCOM/teacherAdmin/Forums/ForumManagement.jsp?mode=findex&userid=<%=user%>&schoolid=<%=schoolid%>" style="color: blue;text-decoration:none"><b>Forum Index</b></a></font></span>
</td>
<td width="25%" align="left"><span style="font-size:10pt;"><font face="Arial" color="#996600"><b>Forum Management</b></font></span></td>
<td width="25%" align="right">&nbsp;</td>
<td width="25%" align="center"><a href="ForumMgmtIndex.jsp?emailid=<%= user %>&schoolid=<%= schoolid %>"><b>Back</b></a></td>
</tr>
<tr>
<td width="100%" colspan="4">&nbsp;</td>
</tr>
<tr>
  <td width="100%"  align="left" colspan="4"><span style="font-size:10pt;"><font face="Arial"><b>Forum Management</b> is where you can manage all aspects of your forums and threads. It is very intuitive and easy to use. To add new thread in a forun, click the <b>Add New Thread</b> link in that forum. To edit your thread, just click the Edit picture.</font></span>
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
  <td width="100%" align="left" colspan="4">
  <%
		if(!status.equals("0"))
		{
	%>
  <p align="center"><a href="PostNewThread.jsp?mode=add&fid=<%= forumid %>&fname=<%=dir%>" Title="Add new topic"><span style="font-size:9pt;"><font face="Arial"><b>Add New Topic</b></font></span></a></p>
  <%
	  } else {
	%>
	  <p align="center"><span style="font-size:9pt;"><font face="Arial" color="red"><b>Forum has been Inactivated</b></font></span></p>
	  <%}%>
		</td>
		</tr> 
	</table>
	</td>
</tr>

<table align="center" border="8" cellpadding="0" cellspacing="0" width="100%" bordercolor="#429EDF" bordercolordark="#429EDF" bordercolorlight="#429EDF">
<tr>
<td width="5%" align="center" valign="middle" bgcolor="#429EDF" height="24">&nbsp;</td>
<td width="2%" align="center" valign="middle" bgcolor="#429EDF" height="24">&nbsp;</td>
<td width="35%" align="left" valign="middle" bgcolor="#429EDF" height="24"><span style="font-size:10pt;"><font face="Arial" color="white"><b>&nbsp;<%= dir %></b>
</font></span></td>
<td width="8%" align="center" valign="middle" bgcolor="#429EDF" height="24"><span style="font-size:10pt;"><font face="Arial" color="white"><b>Author</b>
</font></span></td>
<td width="8%" align="center" valign="middle" bgcolor="#429EDF" height="24"><span style="font-size:10pt;"><font face="Arial" color="white"><b>Replies</b>
</font></span></td>
<td width="10%" align="center" valign="middle" bgcolor="#429EDF" height="24"><span style="font-size:10pt;"><font face="Arial" color="white"><b>Views</b>
</font></span></td>
<td width="25%" align="center" valign="middle" bgcolor="#429EDF" height="24"><span style="font-size:10pt;"><font face="Arial" color="white"><b>Created Date</b>
</font></span></td>
<td width="8%" align="center" valign="middle" bgcolor="#429EDF" height="24"><span style="font-size:10pt;"><font face="Arial" color="white"><b>Status</b>
</font></span></td>
</tr>

<%
try{
	con = con1.getConnection();
	stmt=con.createStatement();
	rs=stmt.executeQuery("select * from forum_master where school_id='"+schoolid+"' and forum_id='"+forumid+"' and created_by='"+user+"' and creator_type='"+utype+"'");
	if(!rs.next()){
	if(utype.equals("student")){
		rs=stmt.executeQuery("select grade from studentprofile where username='"+user+"' and schoolid='"+schoolid+"'");
		if(rs.next())
			grade=rs.getString(1);
		
		temp=grade;
		acode="-S:"+temp+":ALL-";
	}
	if(utype.equals("teacher")){
		rs=stmt.executeQuery("select class_id from teachprofile where username='"+user+"' and schoolid='"+schoolid+"'");
		if(rs.next())
			grade=rs.getString(1);
		
		temp=grade;
		acode="-T:"+temp+":ALL-";
	}
	if(!utype.equals("admin")){
		rs=stmt.executeQuery("select * from forum_master where school_id='"+schoolid+"' and forum_id='"+forumid+"' and access_code like '%"+acode+"%'");
		if(!rs.next()){
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
redirect('<%=user%>','<%=schoolid%>');
</SCRIPT>
<%
		}
	}}
}
catch(Exception ex){
	ExceptionsFile.postException("ShowThreads.jsp","operations on database","Exception",ex.getMessage());
	out.println(ex+" its first");
}
%>
<%
        String d1=new java.util.Date().toString();
        StringTokenizer stz=new StringTokenizer(d1," ");
        String dd,mon,yy,d;
        mon=stz.nextToken();
        mon=stz.nextToken();
        dd=stz.nextToken();
        yy=stz.nextToken();
        yy=stz.nextToken();
        yy=stz.nextToken();
        d=yy+"-"+mon+"-"+dd;
		try
        {
          stmt1=con.createStatement(); 
          rs=stmt.executeQuery("select * from forum_post_topic_reply where forum_id='"+forumid+"' and school_id='"+schoolid+"' and trans_type='1'");
          while (rs.next())
          {
			sno=rs.getInt(1);
			user1=rs.getString(4);
			topic=rs.getString(6);
			message=rs.getString(7);
			views=rs.getString("nov");
			String temp=check4Opostrophe(topic);
			topic1=topic.replace('_','\'');
			topic1=topic1.replaceAll("\"","&#34;");
		    topic1=topic1.replaceAll("\'","&#39;");

			message=message.replaceAll("\"","&#34;");
		    message=message.replaceAll("\'","&#39;");

			maxdate=rs.getString(8);
            replycount="0";
			flag=true;
            String query1="select count(*) from forum_post_topic_reply where forum_id='"+forumid+"' and topic='"+temp+"' and trans_type='2' and school_id='"+schoolid+"'";
			rs1=stmt1.executeQuery(query1);         
			if(rs1.next()){				
			    replycount=rs1.getString(1);
				tStatus=rs.getString("status");
				if(tStatus.equals("1"))
				{
					fcolor="#008000";
					tMsgStatus="Active";
				}
				else if(tStatus.equals("0"))
				{
					fcolor="red";
					tMsgStatus="Inactive";
				}
				else if(tStatus.equals("2"))
				{
					fcolor="red";
					tMsgStatus="Inactive";
				}
				//System.out.println("tStatus...&&&&&&&"+tStatus);
				//System.out.println("sree...&&&&&&&"+topic);
			}
            try
			{
				StringTokenizer stzd1=new StringTokenizer(maxdate," ");
			    if(stzd1.hasMoreTokens())
				{
					maxdate=stzd1.nextToken();
				}
		        StringTokenizer stzd=new StringTokenizer(maxdate,"-");
		        one=stzd.nextToken();
				two=stzd.nextToken();
		        three=stzd.nextToken();
		        int m=Integer.parseInt(two);
		        posteddate=month[m]+" "+three+","+one;
			}
	        catch(Exception ee)
		    {
				ExceptionsFile.postException("ShowThreads.jsp","tokenizing the string","Exception",ee.getMessage());
	           out.println(ee+" hhh");
		    }
			%>

<tr>
        <td colspan="8" align="center" valign="top" height="25">
            <table align="center" cellspacing="0" width="100%" bordercolordark="#E3E3E3" bordercolorlight="#429EDF" style="border-collapse:collapse;" cellpadding="0">
                <tr>

	 <td width="5%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><a href="/LBCOM/teacherAdmin/PostNewThread.jsp?sno=<%=sno%>&utype=<%=utype%>&fid=<%=forumid%>&fname=<%=dir%>&tid=<%=topic1%>&mode=edit">
			<img border="0" src="images/button_edit.gif" width="35" height="25" title="Edit Forum" border=0></a></td>
		<td width="2%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><a href="/LBCOM/teacherAdmin/DeleteThread.jsp?mode=delete&sno=<%=sno%>&sid=<%=schoolid%>&fid=<%=forumid%>&topic=<%=topic1%>&user=<%=user1%>&postdate=<%= posteddate %>&dir=<%= dir %>&status=<%=tStatus%>" onclick="return confirm('Are you sure that you want to delete this thread?')"><img border="0" src="images/Tea_del.gif" width="19" height="21" TITLE="Delete Forum" border=0></a></td>
	  <td width="35%" align="left" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#0000000">&nbsp;<%= topic1 %></font></span></td>
      <td width="8%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#0000000"><%= user1 %></font></span></td>
      <td width="8%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#0000000"><%= replycount %></font></span></td>
	  <td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#0000000"><%= views %></font></span></td>
      <td width="25%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#0000000"><%= posteddate %></font></span></td>
	  <td width="8%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27">
	  <%
		  if(status.equals("0"))
			  {
		    if(!tStatus.equals("2"))
		{%>
		<span style="font-size:10pt;"><font face="Arial" color="green" title="Change Topic Status"><%=tMsgStatus%></font></span>
	  
	  <%
		}
		else
		{%>
		<span style="font-size:10pt;"><font face="Arial" color="red" title="Change Topic Status"><%=tMsgStatus%></font></span>
		
		<%}
			  }
			  else
			  {
		  
	  if(!tStatus.equals("2"))
		{%>
		<span style="font-size:10pt;"><font face="Arial" color="green" title="Change Topic Status"><a href="/LBCOM/forums/ChangeThreadStatus.jsp?fid=<%=forumid%>&fname=<%=dir%>&status=<%=tStatus%>&status1=<%=status%>&userid=<%=user1%>&sno=<%=sno%>&topic=<%= topic %>"><%=tMsgStatus%></font></span></a>
	  
	  <%
		}
		else
		{%>
		<span style="font-size:10pt;"><font face="Arial" color="red" title="Change Forum Status"><a href="/LBCOM/forums/ChangeThreadStatus.jsp?fid=<%=forumid%>&fname=<%=dir%>&status=<%=tStatus%>&status1=<%=status%>&userid=<%=user1%>&sno=<%=sno%>&topic=<%= topic %>"><%=tMsgStatus%></font></span></a>
		
		<%}}%>

	   </td>
    </tr>
	</table>
</td>
</tr>
<%
      }
	 if(flag==false)
		out.println("<tr><td bgColor=\"#E2E2E2\" colspan=8 width=\"100%\">&nbsp;</td></tr><tr><td bgColor=\"#E2E2E2\" colspan=8 align=center width=\"100%\"><-- No Topics Available --></td></tr><tr><td bgColor=\"#E2E2E2\" colspan=8 width=\"100%\">&nbsp;</td></tr>");
          
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("ShowThreads.jsp","operations on database","Exception",e.getMessage());
		out.println(e);
	}
	finally
    {
		try
        {
			if(stmt1!=null)
				stmt1.close();
			if(stmt!=null)
		        stmt.close();
			if(con!=null)
		        con.close();
        }catch(Exception e){
			ExceptionsFile.postException("ShowThreads.jsp","closing the resultset ,statment and connection object","Exception",e.getMessage());
			System.out.println("Connection close failed");
		}

    }
%>
</table>
</body>
</html>
