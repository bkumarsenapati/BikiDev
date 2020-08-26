<html>
<head><title></title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
</head>
<body topmargin="0" leftmargin="0">
<%@  page language="java"  import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%!
	String month[]={" ","Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Nov","Dec"};

private String check4Opostrophe(String str){
 str=str.replaceAll("\'","\\\\\'");
 str=str.replaceAll("\"","&quot;");
		return(str);
}

%>
<%
String user="";
Connection con=null;
Statement stmt=null;
ResultSet rs=null,rs1=null;
String dir="",forumid="";
String schoolid="",emailid="";
String topic="",topic1="",message1="",reply1="";
String posteddate=" ";
String posteduser="";
String userid="",temp="";
String one="",two="",three="";

%>
<%  
String sessid=(String)session.getAttribute("sessid");
if(sessid==null){
	out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
	return;
}
forumid = request.getParameter("fid");
dir = request.getParameter("dir");
schoolid=(String)session.getAttribute("schoolid");
emailid = (String)session.getAttribute("emailid");
topic=request.getParameter("topic");
posteduser=request.getParameter("user");
userid = emailid;
posteddate=request.getParameter("postdate");
try
{
	con = con1.getConnection();
 }
 catch(Exception ex) {
	ExceptionsFile.postException("ShowReply.jsp","creating connection objects","Exception",ex.getMessage());
	 out.println(ex+" its first");}
%>
<table border="0" cellPadding="0" cellSpacing="0" width="100%" align=center>
  <tr> 
    <td width="35%" align=center bgcolor="#A8B8D0"><font face="Arial" size="2" color="#000000"><b><a href="ShowDirTopics.jsp?emailid=<%= userid %>&schoolid=<%= schoolid %>" style="color: #000000;text-decoration:none">Forums</a></b></font></td>
    <td width="30%" align=center bgcolor="#A8B8D0"><b><font color="#000000" size="2" face="Arial"><a href="PostNewTopic.jsp?fid=<%= forumid %>&fname=<%=dir%>" style="color: #000000;text-decoration:none">Post 
      New Topic</a></font></b></td>
    <td width="35%" align=center bgcolor="#A8B8D0"><font face="Arial" size="2" color="#000000"><b><a href="PostSug.jsp?fid=<%= forumid %>&fname=<%=dir%>" style="color: #000000;text-decoration:none">Post 
      Suggestions</a></b></font></td>
</tr>
<tr>
    <td colspan=3 align=right> <b><font color="#000080" size="2" face="Arial" align="right"><a href="ShowTopics.jsp?fid=<%= forumid %>&fname=<%= dir %>" style="text-decoration:none;color: #000080"><font face="Arial, Arial, Helvetica, sans-serif" color="#000000">Back</font></a></font></b> 
    </td>
</tr>
<tr>
    <td bgcolor="#40A0E0" width="35%" align="center"><b><font size="2" face=Arial color="#000000">Forum:&nbsp;</font><font face="Arial" size="2" color="#800080"><%= dir %></font></b></td>
    <td bgcolor="#40A0E0" width="30%" align="center"><b><font color="#000000" face="Arial" size="2">School:&nbsp;</font><font face="Arial" size="2" color="#800080"><%= schoolid %></font></b></td>

<%
int nod=0;
try
{
	temp=check4Opostrophe(topic);
	stmt=con.createStatement();
	ResultSet condrs=stmt.executeQuery("select (to_days(curdate())-to_days('"+posteddate+"')) from forum_post_topic_reply where school_id='"+schoolid+"' and forum_id='"+forumid+"' and topic='"+temp+"' and user_id='"+posteduser+"' and trans_type='1'");
	if(condrs.next())
	{
		String nod1=condrs.getString(1);
		nod=Integer.parseInt(nod1);
	}
}
catch(Exception e)
{
	ExceptionsFile.postException("ShowReply.jsp","operations on database","Exception",e.getMessage());
	nod=0;
}
if(nod<=30)
{
	%>
	<td bgcolor="#40A0E0" width="35%" align="center"><a href="PostReply.jsp?fid=<%= forumid %>&fname=<%=dir%>&topic=<%= topic %>" target="_self"><b><font size="2" face="Arial" color="#800080">Post your reply to this Topic</font></b></a></td>
  </tr></table>
<br>
	<%
}
else
{
	out.println("&nbsp;");
}
      
StringTokenizer stz1=new StringTokenizer(posteddate,"-");
String yy=stz1.nextToken();
String mn=stz1.nextToken();
String dd=stz1.nextToken();
int mn1=Integer.parseInt(mn);
String postdate=month[mn1]+" "+dd+","+yy;
String query="select message from forum_post_topic_reply where forum_id='"+forumid+"' and topic='"+temp+"' and user_id='"+posteduser+"' and school_id='"+schoolid+"' and trans_type='1'";
      
try
{
	rs=stmt.executeQuery(query);
	while(rs.next())
	{
		String msg=rs.getString(1);
		message1=msg;
		topic1=topic;
		%>
		
<table align=center border="1" cellpadding="0" cellspacing="0"  width="100%" bordercolor="#FFFFFF">
  <tr>
		<td bgColor="#40A0E0" align="center" width="25%"><b><font color="#000000" face="Arial" size="2">Author of the Topic</font></b></td>
		
    <td bgColor="#40A0E0" vAlign="center" width="75%"><b><font color="#000000" size="2" face="Arial, Arial, Helvetica, sans-serif">Topic:&nbsp;&nbsp;<%= topic1 %></font></b></td>
        </tr>
	    <tr>
		<td bgColor="#A8B8D0" vAlign="middle" align="center" width="25%"><b><font face="Arial" size="2"><%= posteduser %></font></b></td>
		<td bgColor="#A8B8D0" width="75%"><font face="Arial"><font face="Arial, Arial" size="2">
		</font><font color="#800080" face="Arial, Arial" size="1">Posted on:&nbsp;<%= postdate %></font>
      <hr>
		<font face="Arial" size="2">&nbsp;<%= message1 %></font></font></td>
		</tr>
		</table>
		<%
	}
}
catch(Exception e)
{
	ExceptionsFile.postException("ShowReply.jsp","operations on database","Exception",e.getMessage());
	out.println(e);
}
try
{
	String query1="select message,trans_date,user_id from forum_post_topic_reply where forum_id='"+forumid+"' and topic='"+temp+"' and school_id='"+schoolid+"' and trans_type='2'";
	rs1=stmt.executeQuery(query1);
	if(rs1.next())
	{
		String replydate="";
		String repldir=dir;
		String reply=rs1.getString(1);
		reply1=reply.replace('_','\'');
		String rdate=rs1.getString(2);
		String ruser=rs1.getString(3);
		StringTokenizer st1=new StringTokenizer(rdate," ");
        String str1=st1.nextToken();
        StringTokenizer st2=new StringTokenizer(str1,"-");
        String f1=st2.nextToken();
        String f2=st2.nextToken();
        String f3=st2.nextToken();
        int mnr=Integer.parseInt(f2);
		replydate=month[(mnr-1)]+" "+f3+","+f1;
		//changed on 28-feb regarding problem in displaying month showing prevoius month instead current.
		//          replydate=month[(mnr-1)]+" "+f3+","+f1;
		replydate=month[(mnr)]+" "+f3+","+f1;
		%>
		<table border="0" cellSpacing="0" width="100%" align=center>
		<tr>
        <td align="left" bgColor="#FFFFFF"><b><font color="#000000" face="Arial" size="2">Replies Received:</font></b></td>
		</tr>
		</table>
		
       
<table border="1" cellpadding="0" cellspacing="0" width="100%" align="center" bordercolor="#FFFFFF">
  <tr>
	   <td bgColor="#40A0E0" vAlign="center" width="25%" align="center"><b><font color="#000000" face="Arial" size="2">Reply by</font></b></td>
       <td bgColor="#40A0E0" vAlign="center" width="75%"><b><font color="#000000" face="Arial" size="2"><%= topic1 %></font></b></td>
	   </tr>
	   <tr>
	   <td bgColor="#A8B8D0" vAlign="middle" width="25%" align="center"><b><font face="Arial" size="2"><%= ruser %></font></b></td>
       <td bgColor="#A8B8D0" width="588"><font face="Arial"><font size="2"></font><font color="#800080" face="Arial, Arial" size="1">Replied on:&nbsp;<%= replydate %>&nbsp;&nbsp;</font>
      <hr>
      <font face="Arial" size="2"><%= reply1 %></font></font></td>
	  </tr>
	  </table>

		<%
		while(rs1.next())
		{
			replydate="";
			repldir=dir;
			reply=rs1.getString(1);
			//reply1=reply.replace('_','\'');
			rdate=rs1.getString(2);
			ruser=rs1.getString(3);
			st1=new StringTokenizer(rdate," ");
	        str1=st1.nextToken();
		    st2=new StringTokenizer(str1,"-");
		    f1=st2.nextToken();
	        f2=st2.nextToken();
		    f3=st2.nextToken();
	        mnr=Integer.parseInt(f2);

			//changed on 28-feb regarding problem in displaying month showing prevoius month instead current.
			//          replydate=month[(mnr-1)]+" "+f3+","+f1;
			replydate=month[(mnr)]+" "+f3+","+f1;
			%>
			
<table border="1" cellpadding="0" cellspacing="0" width="100%" align=center bordercolor="#FFFFFF">
  <tr>
			<td bgColor="#40A0E0" vAlign="center" width="25%" align="center"><b><font color="#000000" face="Arial" size="2">Reply by</font></b></td>
			<td bgColor="#40A0E0" vAlign="center" width="75%"><b><font color="#000000" face="Arial" size="2"><%= topic1 %></font></b></td>
			</tr>
			<tr>
			<td bgColor="#A8B8D0" vAlign="middle" width="25%" align="center"><b><font face="Arial" size="2"><%= ruser %></font>
			</b></td>
			<td bgColor="#A8B8D0" width="588"><font face="Arial"><font size="2"></font><font color="#800080" face="Arial, Arial" size="1">Replied on:&nbsp;<%= replydate %>&nbsp;&nbsp;</font>
      <hr>
      <font face="Arial" size="2"><%= reply %></font></td>
			</tr>
			</table>
			<%
		  }
		}
		else
		{
			out.println("<table border=\"0\" cellSpacing=\"0\" align=\"center\" width=\"100%\">");
			out.println("<tr><td align=\"center\" bgColor=\"#FFFFFF\"><b><font face=\"Arial\" size=\"2\" color=\"#0000FF\">No Replies Received</font></b></td>");
			out.println("</tr><table>");
		}
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("ShowReply.jsp","operations on database","Exception",e.getMessage());
		out.println(e);
	}
	finally
	{
		try
	    {
	        
	        if(stmt!=null)
		        stmt.close();
			if(con!=null && !con.isClosed())
		        con.close();
		}catch(Exception e){
			ExceptionsFile.postException("ShowReply.jsp","closing connection,statement and resultset objects","Exception",e.getMessage());
			System.out.println("Connection close failed "+e);
		}

	}
%>
</body>
</html>
