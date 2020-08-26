<jsp:useBean id="connection" class="sqlbean.DbBean" scope="page" />

<html>
<head><title></title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<link rel="stylesheet" type="text/css" href="css/style.css" />
<SCRIPT LANGUAGE="JavaScript">
<!--
	function cantPostTopic()
	{
		alert("Sorry! You can't post a new topic in this forum as this forum is closed by the creator.");
		return false;
	}
	function cantPostSuggestion()
	{
		alert("Sorry! You can't post your suggestion as this forum is closed by the creator.");
		return false;
	}
	function cantPostReply()
	{
		alert("Sorry! You can't post your reply as this forum is closed by the creator.");
		return false;
	}
	function showFile(attachfile,user)
{
	var x=window.open("/LBCOM/schoolAdmin/Forums/Attachments/"+user+"/"+attachfile,"Document","width=750,height=600,scrollbars");
	
	return false;
}
//-->
</SCRIPT>
</head>
<body topmargin="0" leftmargin="0">
<%@  page language="java"  import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%!
	String month[]={" ","Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Nov","Dec"};

	private String check4Opostrophe(String str)
	{
		str=str.replaceAll("\'","\\\\\'");
		str=str.replaceAll("\"","&quot;");
		return(str);
	}
%>
<%
	String user=null;
	Connection con=null;
	Statement stmt=null,st=null;
	ResultSet rs=null,rs1=null,rs2=null;
	String dir=null,forumid=null;
	String schoolid="",sId="",emailid="",status="",sno="",tStatus="",tStatusMsg="",tFStatusMsg="",sFStatusMsg="",sFStatus="";
	String topic="",topic1="",message1="",reply1="";
	String posteddate=" ";
	String posteduser="";
	String userid="",temp=null;
	String one="",two="",three="",attachFile="";
	String crtby="",topiccount="",ruser="",replydate="",desc="",rdate="",utype="",replycount="";
%>
<%
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	sno=request.getParameter("sno");
	sId=request.getParameter("sid");
	forumid=request.getParameter("fid");
	dir=request.getParameter("dir");
	schoolid=(String)session.getAttribute("schoolid");
	emailid=(String)session.getAttribute("emailid");
	topic=request.getParameter("topic");
	topic=topic.replaceAll("\"","&#34;");
	topic=topic.replaceAll("\'","&#39;");

	posteduser=request.getParameter("user");
	userid=emailid;
	posteddate=request.getParameter("postdate");

	crtby=request.getParameter("crtby");
	utype=request.getParameter("utype");
	//out.println(utype);
	topiccount=request.getParameter("topiccount");
	replycount=request.getParameter("replycount");
	ruser=request.getParameter("ruser");
	replydate=request.getParameter("replydate");
	desc=request.getParameter("desc");
	

	try
	{
		con=connection.getConnection();
	}
	catch(Exception ex) 
	{
		 ExceptionsFile.postException("ShowReply.jsp","creating connection object","Exception",ex.getMessage());
		 out.println(ex+" its first");
	 }
%>
<%
	int nod=0;
	try
	{
		st=con.createStatement();
		rs2=st.executeQuery("select status from forum_master where school_id='"+sId+"' and forum_id='"+forumid+"'");
		if(rs2.next())
		{
			status=rs2.getString("status");
		}
		rs2.close();
%>
	<b>
		<font color="#660033" face="Verdana" size=1>Date:&nbsp;<%=new java.util.Date()%>
</b><BR><BR>
<font face="Arial" color="#7F7F7F"><span style="font-size:10pt;">
<a href="/LBCOM/studentAdmin/Forums/ShowDirTopics.jsp?emailid=<%=userid%>&schoolid=<%=schoolid%>&mode=findex">Forum Index</a> &gt; <a href="ShowTopics.jsp?sid=<%=schoolid%>&fid=<%=forumid%>&fname=<%=dir%>&crtby=<%=crtby%>&utype=<%=utype%>&desc=<%=desc%>&topiccount=<%=topiccount%>&replycount=<%=replycount%>&ruser=<%=ruser%>&replydate=<%=replydate%>&mode=tindex"><%=dir%></a>&gt; <a href="ShowReply.jsp?sno=<%=sno%>&sid=<%=sId%>&fid=<%=forumid%>&user=<%=posteduser%>&dir=<%=dir%>&topic=<%=topic%>&postdate=<%=posteddate%>&crtby=<%=crtby%>&utype=<%=utype%>&desc=<%=desc%>&topiccount=<%=topiccount%>&replycount=<%=replycount%>&ruser=<%=ruser%>&replydate=<%=replydate%>"><%=topic%></a></span>
</font>
	
<%
		temp=check4Opostrophe(topic);
		stmt=con.createStatement();
		ResultSet condrs=stmt.executeQuery("select (to_days(curdate())-to_days('"+posteddate+"')) from forum_post_topic_reply where school_id='"+sId+"' and forum_id='"+forumid+"' and topic='"+temp+"' and user_id='"+posteduser+"' and trans_type='1'");
		if(condrs.next())
		{
			//String nod1=condrs.getString(1);
			//nod=Integer.parseInt(nod1);
		}
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("ShowReply.jsp","creating statement object","Exception",e.getMessage());
		//nod=0;
	}
	
%>
<%
String temp1=topic.replaceAll("\"","&quot;");
		
	StringTokenizer stz1=new StringTokenizer(posteddate,"-");
	String yy=stz1.nextToken();
	String mn=stz1.nextToken();
	String dd=stz1.nextToken();
	int mn1=Integer.parseInt(mn);
	String postdate=month[mn1]+" "+dd+","+yy;
	String query="select message,status  from forum_post_topic_reply where forum_id='"+forumid+"' and topic='"+temp+"' and user_id='"+posteduser+"' and school_id='"+sId+"' and trans_type='1'";
		  
	try
	{
		rs=stmt.executeQuery(query);
		while(rs.next())
		{
			String msg=rs.getString(1);
			message1=msg;
			topic1=topic;
			sFStatus=rs.getString("status");
		if(sFStatus.equals("1"))
		{
			sFStatusMsg="<img src=\"../../forums/images/button_reply.gif\" TITLE=\"Post your reply to this Topic \" border=0>";
		}
		else
		{
			sFStatusMsg="";
		}
%>

<table align="center" border="8" cellpadding="0" cellspacing="0" width="100%" bordercolor="#546878" bordercolordark="#546878" bordercolorlight="#546878">
    <tr>
        <td width="468" bgcolor="#546878" height="24">
            <p align="left"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Author of &nbsp;the Topic</b></span></font></p>
        </td>
        <td width="468" height="24" bgcolor="#546878">&nbsp;</td>
    </tr>
	<tr>
        <td align="center" valign="top" height="25" colspan="2">
            <table align="center" cellspacing="0" width="100%" bordercolordark="#E3E3E3" bordercolorlight="#E3E3E3" style="border-collapse:collapse;" cellpadding="3" height="12">
                <tr>
                    <td width="100%" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="12" align="left">
                        <table align="center" border="0" cellpadding="4" cellspacing="0" width="100%" bordercolor="#546878" bordercolordark="#546878" bordercolorlight="#546878" height="61">
                            <tr>
                                <td width="184" align="left" valign="top" bgcolor="#E1E1E1">
                                    <p><font face="Arial" color="#546878"><span style="font-size:9pt;">on <%=postdate%></span></font></p>
                                </td>
                                <td width="361" align="left" valign="top" bgcolor="#EEEEEE">
                                    <p><font face="Arial"><span style="font-size:10pt;"><b><%=topic1%></b></span></font></p>
                                </td>
                                <td width="361" align="left" valign="top" bgcolor="#EEEEEE">&nbsp;</td>
                            </tr>
							<tr>
                                <td width="184" valign="top" align="left" bgcolor="#E1E1E1">
                                    <p align="left"><span style="font-size:10pt;"><font face="Arial" color="#546878">by</font></span><font face="Arial"><span style="font-size:10pt;"> </span></font><span style="font-size:10pt;"><font face="Arial" color="blue"><%=posteduser%></font></span><font face="Arial"><span style="font-size:10pt;"><img src="images/icon_latest_reply.gif" width="18" height="9" border="0"><br>
								</span></font></p>
                                </td>
                                <td width="730" valign="top" bgcolor="#EEEEEE" colspan="2">
                                    <p><font face="Arial" color="#546878"><span style="font-size:9pt;">
									<%= message1%></span></font></p>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table><br>

<table align="center" border="0" cellpadding="0" cellspacing="5" width="100%" bordercolor="black" bordercolordark="black" bordercolorlight="black">
    <tr>
        <td width="50%">
            <P><a href="/LBCOM/studentAdmin/Forums/PostReply.jsp?sno=<%=sno%>&fid=<%= forumid %>&fname=<%=dir%>&topic=<%= temp1 %>&user=<%=userid%>&puser=<%=posteduser%>&postdate=<%= posteddate%>&crtby=<%=crtby%>&utype=<%=utype%>&desc=<%=desc%>&topiccount=<%=topiccount%>&replycount=<%=replycount%>&ruser=<%=ruser%>&replydate=<%=replydate%>"><img src="images/button_topic_reply.gif" width="96" height="25" border="0"></a></P>
        </td>
        <td width="50%">&nbsp;</td>
    </tr>
</table>

<%
		}
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("ShowSubjects.jsp","operations on database","Exception",e.getMessage());
		out.println(e);
		try
		{
			if(stmt!=null)
				stmt.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(Exception se)
		{
			ExceptionsFile.postException("ShowReply.jsp","closing resultset,statement and  connection objects","Exception",se.getMessage());
			System.out.println("Connection close failed in studentAdmin/ShowReply.jsp");
		}
	}
	try
	{
		String query1="select message,trans_date,user_id,sno,status,forumattachments from forum_post_topic_reply where forum_id='"+forumid+"' and topic='"+temp+"' and school_id='"+sId+"'  and trans_type='2' order by sno desc";
		rs1=stmt.executeQuery(query1);
		if(rs1.next())
		{
			//String replydate="";
			String repldir=dir;
			String reply=rs1.getString(1);
			reply1=reply.replace('_','\'');
			reply1=reply1.replaceAll("\"","&#34;");
			reply1=reply1.replaceAll("\'","&#39;");

			sno=rs1.getString("sno");
		
			rdate=rs1.getString(2);
			ruser=rs1.getString(3);
			attachFile=rs1.getString(6);
			
			if(attachFile==null)
			{
				
				attachFile="";
			}
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

<table align="center" border="8" cellpadding="0" cellspacing="0" width="100%" bordercolor="#546878" bordercolordark="#546878" bordercolorlight="#546878">
    <tr>
        <td width="468" bgcolor="#546878" height="24">
            <p align="left"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Replies Received:</b></span></font></p>
        </td>
        <td width="468" height="24" bgcolor="#546878">
            <p align="right">&nbsp;</p>
        </td>
    </tr>
    <tr>
        <td align="center" valign="top" height="25" colspan="2">
            <table align="center" cellspacing="0" width="100%" bordercolordark="#E3E3E3" bordercolorlight="#E3E3E3" style="border-collapse:collapse;" cellpadding="0">
                <tr>
                    <td width="100%" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="12" align="left">
                        <table align="center" border="0" cellpadding="4" cellspacing="0" width="100%" bordercolor="#546878" bordercolordark="#546878" bordercolorlight="#546878" height="61">
                            <tr>
                                <td width="184" align="left" valign="top" bgcolor="#E1E1E1">
                                    <p><font face="Arial" color="#546878"><span style="font-size:9pt;">on <%=replydate%></span></font></p>
                                </td>
                                <td width="361" align="left" valign="top" bgcolor="#EEEEEE">
                                    <p><font face="Arial"><span style="font-size:10pt;"><b>Re: <%= topic1 %></b></span></font></p>
                                </td>
                                <td width="361" align="left" valign="top" bgcolor="#EEEEEE">
<%
			if(userid.equals(ruser))
			{
			%>&nbsp;<a href="/LBCOM/forums.DeleteForum?mode=delete&sno=<%=sno%>&sid=<%=schoolid%>&fid=<%=forumid%>&topic=<%=topic1%>&user=<%=ruser%>&puser=<%=posteduser%>&postdate=<%= posteddate %>&dir=<%= dir %>&crtby=<%=crtby%>&utype=<%=utype%>&desc=<%=desc%>&topiccount=<%=topiccount%>&replycount=<%=replycount%>&ruser=<%=ruser%>&replydate=<%=replydate%>" onclick="return confirm('Are you sure that you want to delete this Reply?')"><img src="../../forums/images/button_delete_thread.gif" TITLE="Delete this Thread " border=0></a>
			<%}
			if(attachFile.equals("") || attachFile==null || attachFile.equals("null"))
			{
								
%>				
				&nbsp;
<%			}
			else
			{
				
%>
				  &nbsp;<a href="javascript://" onclick="return showFile('<%=attachFile%>','<%=ruser%>');"><img src="../../forums/images/button_attach.gif" TITLE="Attachments" border=0></a></font>
				  
<%			}
			

%>

								</td>
                            </tr>
                            <tr>
                                <td width="184" valign="top" align="left" bgcolor="#E1E1E1">
                                    <p align="left"><span style="font-size:10pt;"><font face="Arial" color="#546878">by</font></span><font face="Arial"><span style="font-size:10pt;"> </span></font><span style="font-size:10pt;"><font face="Arial" color="blue"><%= ruser %></font></span><font face="Arial"><span style="font-size:10pt;"><img src="images/icon_latest_reply.gif" width="18" height="9" border="0"><br>
</span></font></p>
                                </td>
                                <td width="730" valign="top" bgcolor="#EEEEEE" colspan="2">
                                    <p><font face="Arial" color="#546878"><span style="font-size:9pt;"><%=reply1%></span></font></p>
                                </td>
                            </tr>
                            <tr>
                                <td width="100%" align="left" valign="top" colspan="3">
                                    <hr>
                                </td>
                            </tr>
                        </table>

<%
			while(rs1.next())
			{
				replydate="";
				repldir=dir;
				reply=rs1.getString(1);
				reply1=reply.replace('_','\'');
				reply1=reply1.replaceAll("\"","&#34;");
				reply1=reply1.replaceAll("\'","&#39;");

				rdate=rs1.getString(2);
				ruser=rs1.getString(3);
				attachFile=rs1.getString(6);
				sno=rs1.getString("sno");
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
				
    <tr>
        <td align="center" valign="top" height="25" colspan="2">
            <table align="center" cellspacing="0" width="100%" bordercolordark="#E3E3E3" bordercolorlight="#E3E3E3" style="border-collapse:collapse;" cellpadding="0">
                <tr>
                    <td width="100%" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="12" align="left">
                        <table align="center" border="0" cellpadding="4" cellspacing="0" width="100%" bordercolor="#546878" bordercolordark="#546878" bordercolorlight="#546878" height="61">
                            <tr>
                                <td width="184" align="left" valign="top" bgcolor="#E1E1E1">
                                    <p><font face="Arial" color="#546878"><span style="font-size:9pt;">on <%=replydate%></span></font></p>
                                </td>
                                <td width="361" align="left" valign="top" bgcolor="#EEEEEE">
                                    <p><font face="Arial"><span style="font-size:10pt;"><b>Re: <%= topic1 %></b></span></font></p>
                                </td>
                                <td width="361" align="left" valign="top" bgcolor="#EEEEEE">
<%
			if(userid.equals(ruser))
			{
			%>&nbsp;<a href="/LBCOM/forums.DeleteForum?mode=delete&sno=<%=sno%>&sid=<%=schoolid%>&fid=<%=forumid%>&topic=<%=topic1%>&user=<%=ruser%>&puser=<%=posteduser%>&postdate=<%= posteddate %>&dir=<%= dir %>" onclick="return confirm('Are you sure that you want to delete this Reply?')"><img src="../../forums/images/button_delete_thread.gif" TITLE="Delete this Thread " border=0></a>
			<%}
			if(attachFile.equals("") || attachFile==null || attachFile.equals("null"))
			{
								
%>				
				&nbsp;
<%			}
			else
			{
				
%>
				  &nbsp;<a href="javascript://" onclick="return showFile('<%=attachFile%>','<%=ruser%>');"><img src="../../forums/images/button_attach.gif" TITLE="Attachments" border=0></a></font>
				  
<%			}
			

%>

								</td>
                            </tr>
                            <tr>
                                <td width="184" valign="top" align="left" bgcolor="#E1E1E1">
                                    <p align="left"><span style="font-size:10pt;"><font face="Arial" color="#546878">by</font></span><font face="Arial"><span style="font-size:10pt;"> </span></font><span style="font-size:10pt;"><font face="Arial" color="blue"><%= ruser %></font></span><font face="Arial"><span style="font-size:10pt;"><img src="images/icon_latest_reply.gif" width="18" height="9" border="0"><br>
</span></font></p>
                                </td>
                                <td width="730" valign="top" bgcolor="#EEEEEE" colspan="2">
                                    <p><font face="Arial" color="#546878"><span style="font-size:9pt;"><%=reply1%></span></font></p>
                                </td>
                            </tr>
                            <tr>
                                <td width="100%" align="left" valign="top" colspan="3">
                                    <hr>
                                </td>
                            </tr>
                        </table>
<%
			}
		}
		else
		{
%>
			<table border="0" cellSpacing="0" align="center" width="100%">
				<tr>
					<td align="center" bgColor="#FFFFFF"><b>
						<font face="Arial" size="2" color="#0000FF">No Replies Received</font></b></td>
				</tr>
			<table>
<%
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
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("ShowReply.jsp","closing resultset,statement and  connection objects","Exception",e.getMessage());
			System.out.println("Connection close failed");
		}
	}
%>
</body>
</html>
