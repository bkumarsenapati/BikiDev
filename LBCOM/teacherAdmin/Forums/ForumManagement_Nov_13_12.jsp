<%@  page language="java"  import="java.sql.*,java.util.*,java.lang.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<% 
	String user="",schoolid="",topiccount="",replycount="",views="",maxdate="",dir="",forumid="",crtby="",utype="",classId="";
	String fStatusMsg="",fStatus="",fAltMsg="",mode1="",desc="",ruser="",rdate="",UAruser=null,replydate="",accessCode="";
	Connection con=null;
	ResultSet rs=null,rs1=null,rs2=null,rs4=null,rs5=null,rs6=null;
	Statement st=null,st1=null,st2=null,st4=null,st5=null,st6=null;
	boolean acC=false;
	String classIds="";
%>
<%
	mode1=request.getParameter("mode");
	if(mode1==null)
	{
		mode1="";
	}
	String emailid = request.getParameter("emailid");
	classId=(String)session.getAttribute("classid");
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
		st4=con.createStatement();
		st5=con.createStatement();
	}
	catch(Exception ex)
	{
		ExceptionsFile.postException("ForumManagement.jsp","creating statement and connection objects","Exception",ex.getMessage());
		out.println(ex+" its first");
	}
%>

<html>
<head>
<title></title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<link rel="stylesheet" type="text/css" href="css/style.css" />  
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
<table width="100%">
<tr>
<td width="100%">
	<table border="0" cellpadding="0" cellspacing="0" face='Arial' size='3' style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" align="left">
	  <tr>
		<td width="100%" colspan="2">
		<p align="right"><span style="font-size:10pt;"><font face="Arial" color="blue"><a href="/LBCOM/teacherAdmin/ForumMgmtIndex.jsp?userid=<%=emailid%>&schoolid=<%=schoolid%>" ><b>Forum Management</b></font></span></td>

	  </tr>
	  <tr><td width="100%" colspan="2">&nbsp;</td></tr>
	  <tr>
<td width="50%"><span style="font-size:10pt;"><font face="Arial" color="blue"><A href="ForumManagement.jsp?mode=sree">View unanswered posts</a><font  color="#7F7F7F"> / </font><span style="font-size:10pt;"><font face="Arial" color="blue"><A href="ForumManagement.jsp?mode=act">View active posts</A></font></span>
</td>
<td width="50%" align="right"><A href="ForumManagement.jsp?mode=own"><span style="font-size:10pt;"><font face="Arial">View your posts</font></span></A>
</td>
</tr>
</table>
</td>
</tr>
</table>

<span style="font-size:10pt;"><font color="#660033" face="Verdana" size=1>&nbsp;Date:&nbsp;<%=new java.util.Date()%></font></span><BR><BR>

<font face="Arial" color="#7F7F7F"><span style="font-size:10pt;"><a href="ForumManagement.jsp?mode=findex">Forum Index</a> &gt;</span></font><BR><BR>

<table align="center" border="8" cellpadding="0" cellspacing="0" width="100%" bordercolor="#429EDF" bordercolordark="#429EDF" bordercolorlight="#429EDF">
    <tr>
        <td width="35%" bgcolor="#429EDF" height="24">
            <p align="left"><font face="Arial" color="white"><span style="font-size:10pt;">
			<%

	if(mode1.equals("sree"))
			{
%>
<b>Forum Name&nbsp;&nbsp;&nbsp;[UnAnswered Forums]</b>
<%
}
else if(mode1.equals("findex"))
{
	%>
	<b>Forum Name&nbsp;&nbsp;&nbsp;[All Forums]</b>
	<%
	}else if(mode1.equals("own"))
{
	%>
	<b>Forum Name&nbsp;&nbsp;&nbsp;[Your Forums]</b>
	<%
	}else if(mode1.equals("act"))
{
	%>
	<b>Forum Name&nbsp;&nbsp;&nbsp;[Active Forums]</b>
	<%
	}
	%>
	</span></font></p>
        </td>
        <td width="10%" bgcolor="#429EDF" height="24">
            <p align="center"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Author</b></span></font></p>
        </td>
        <td width="10%" bgcolor="#429EDF" height="24">
            <p align="center"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Role</b></span></font></p>
        </td>
        <td width="10%" bgcolor="#429EDF" height="24">
            <p align="center"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Topics</b></span></font></p>
        </td>
        <td width="10%" bgcolor="#429EDF" height="24">
            <p align="center"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Replies</b></span></font></p>
        </td>
		<td width="10%" bgcolor="#429EDF" height="24">
            <p align="center"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Views</b>
			</span></font></p>
        </td>
        <td width="15%" bgcolor="#429EDF" height="24">
            <p align="center"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Last Reply Posted</b></span></font></p>
        </td>
    </tr>
	
<%
	try
	{
		
		rs=st.executeQuery("select forum_name,forum_id,created_by,creator_type,status,nov,forum_desc,access_code from forum_master where school_id='"+schoolid+"' order by forum_id");
		
		while(rs.next())
		{
			
			dir=(rs.getString(1)).trim();
			forumid=(rs.getString(2)).trim();
			crtby=(rs.getString(3)).trim();
			views=rs.getString("nov");
			desc=rs.getString("forum_desc");
			if(desc==null)
			{
				desc="";
			}
			utype = rs.getString(4);
			fStatus=rs.getString("status");
			if(fStatus.equals("1"))
			{
				fStatusMsg="#E2E2E2";
				fAltMsg=dir;
			}
			else
			{
				fStatusMsg="#E2E2E2";
				fAltMsg="Forum has been Inactivated";
			}
			acC=false;
			
			accessCode=rs.getString("access_code");
			st6=con.createStatement();
		
			rs6=st6.executeQuery("select class_id from coursewareinfo where teacher_id='"+emailid+"' and school_id='"+schoolid+"'");
			while(rs6.next())
			{
				classId=rs6.getString("class_id");
				if(accessCode.indexOf(classId)!=-1)
				{
					//System.out.println("accessCode..."+accessCode+"...classId..."+classId);
					acC=true;
				}
			}
			rs6.close();
			st6.close();
			
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
					ExceptionsFile.postException("ForumManagement.jsp","tokenizing the string","Exception",e.getMessage());
					lastdate="No Postings";
				}
			}

			rs4=st4.executeQuery("select trans_date,user_id from forum_post_topic_reply where school_id='"+schoolid+"' and forum_id='"+forumid+"' and trans_type='2' ORDER BY sno DESC LIMIT 1");
		    if(rs4.next())
			{ 
				ruser=rs4.getString("user_id");
				rdate=rs4.getString("trans_date");

			StringTokenizer stz1=new StringTokenizer(rdate," ");
			String str1=stz1.nextToken();
			StringTokenizer stz2=new StringTokenizer(str1,"-");
			String f1=stz2.nextToken();
			String f2=stz2.nextToken();
			String f3=stz2.nextToken();
			int mnr=Integer.parseInt(f2);
			replydate=month[(mnr-1)]+" "+f3+","+f1;
			
			//replydate=month[(mnr)]+" "+f3+","+f1;
	        }

			rs5=st5.executeQuery("select user_id from forum_post_topic_reply where  forum_id='"+forumid+"' and school_id='"+schoolid+"' order by sno desc");

			 if(rs5.next())
			{ 
				UAruser=rs5.getString("user_id");
			}
%>

<%
	user = emailid;
	if(acC==true)
	{
		
	if((mode1.equals("sree") && replycount.equals("0")) || (mode1.equals("sree") && !UAruser.equals(user)) ||  (mode1.equals("own") && crtby.equals(user)) || (mode1.equals("act") && fStatus.equals("1")))
			{
%>
<tr>
        <td colspan="7" align="center" valign="top" height="25">
            <table align="center" cellspacing="0" width="100%" bordercolordark="#E3E3E3" bordercolorlight="#E3E3E3" style="border-collapse:collapse;" cellpadding="0">
                <tr>
                    <td width="35%" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27" align="left">
                        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%" bordercolor="#429EDF" bordercolordark="#429EDF" bordercolorlight="#429EDF">
                            <tr>
                                <td width="14%">
                                    <p><img src="images/folder_big.gif" width="46" height="25" border="0"></p>
                                </td>
                                <td width="86%">
                                    <p align="left"><span style="font-size:10pt;"><b><a href="ShowThreads.jsp?fid=<%=forumid%>&fname=<%=dir%>&crtby=<%=crtby%>&utype=<%=utype%>&desc=<%=desc%>&topiccount=<%=topiccount%>&replycount=<%=replycount%>&ruser=<%=ruser%>&replydate=<%=replydate%>&views=<%=views%>&mode=sree1"><font face="Arial" color="black"><%=dir%></font></a></b></span><font face="Arial"><span style="font-size:10pt;"><br>
</span></font><font face="Arial" color="#429EDF"><span style="font-size:9pt;"><%=desc%></span></font></p>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#429EDF"><%=crtby%></font></span></td>
                    <td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#429EDF"><%=utype%></font></span></td>
                    <td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#429EDF"><%=topiccount%></font></span></td>
                    <td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#429EDF"><%=replycount%></font></span></td>
					<td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#429EDF"><%=views%></font></span></td>
                    <td width="15%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27">
<%
						if((ruser)!="")
				{
%>
                        <p align="center"><span style="font-size:10pt;"><font face="Arial" color="#429EDF">by</font></span><font face="Arial"><span style="font-size:10pt;"> </span></font><span style="font-size:10pt;"><font face="Arial" color="blue"><%=ruser%></font></span><font face="Arial"><span style="font-size:10pt;"><img src="images/icon_latest_reply.gif" width="18" height="9" border="0"><br>
</span></font><font face="Arial" color="#429EDF"><span style="font-size:9pt;">on&nbsp;<%=replydate%></span></font></p>
<%
				}else{
%>
					<p align="center"><span style="font-size:10pt;"><font face="Arial" color="#429EDF">&nbsp;</font></span><font face="Arial"><span style="font-size:10pt;"> </span></font><span style="font-size:10pt;"><font face="Arial" color="blue">No Postings</font></span><font face="Arial"><span style="font-size:10pt;"><img src="images/icon_latest_reply.gif" width="18" height="9" border="0"><br>
					</span></font><font face="Arial" color="#429EDF"><span style="font-size:9pt;">&nbsp;</span></font></p>
<%
				}
%>
           </td>
     </tr>
				

<%
	ruser="";
	replydate="";
}else if(mode1.equals("findex") && Integer.parseInt(replycount) >=0)
			{
	%>
	<tr>
        <td colspan="7" align="center" valign="top" height="25">
            <table align="center" cellspacing="0" width="100%" bordercolordark="#E3E3E3" bordercolorlight="#E3E3E3" style="border-collapse:collapse;" cellpadding="0">
                <tr>
                    <td width="35%" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27" align="left">
                        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%" bordercolor="#429EDF" bordercolordark="#429EDF" bordercolorlight="#429EDF">
                            <tr>
                                <td width="14%">
                                    <p><img src="images/folder_big.gif" width="46" height="25" border="0"></p>
                                </td>
                                <td width="86%">
                                    <p align="left"><span style="font-size:10pt;"><b><a href="ShowThreads.jsp?fid=<%=forumid%>&fname=<%=dir%>&crtby=<%=crtby%>&utype=<%=utype%>&desc=<%=desc%>&topiccount=<%=topiccount%>&replycount=<%=replycount%>&ruser=<%=ruser%>&replydate=<%=replydate%>&views=<%=views%>&mode=tindex"><font face="Arial" color="black"><%=dir%></font></a></b></span><font face="Arial"><span style="font-size:10pt;"><br>
</span></font><font face="Arial" color="#429EDF"><span style="font-size:9pt;"><%=desc%></span></font></p>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#429EDF"><%=crtby%></font></span></td>
                    <td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#429EDF"><%=utype%></font></span></td>
                    <td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#429EDF"><%=topiccount%></font></span></td>
                    <td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#429EDF"><%=replycount%></font></span></td>
					<td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#429EDF"><%=views%></font></span></td>
                    <td width="15%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27">
<%
						if((ruser)!="")
				{
%>
                        <p align="center"><span style="font-size:10pt;"><font face="Arial" color="#429EDF">by</font></span><font face="Arial"><span style="font-size:10pt;"> </span></font><span style="font-size:10pt;"><font face="Arial" color="blue"><%=ruser%></font></span><font face="Arial"><span style="font-size:10pt;"><img src="images/icon_latest_reply.gif" width="18" height="9" border="0"><br>
</span></font><font face="Arial" color="#429EDF"><span style="font-size:9pt;">on&nbsp;<%=replydate%></span></font></p>
<%
				}else{
%>
					<p align="center"><span style="font-size:10pt;"><font face="Arial" color="#429EDF">&nbsp;</font></span><font face="Arial"><span style="font-size:10pt;"> </span></font><span style="font-size:10pt;"><font face="Arial" color="blue">No Postings</font></span><font face="Arial"><span style="font-size:10pt;"><img src="images/icon_latest_reply.gif" width="18" height="9" border="0"><br>
					</span></font><font face="Arial" color="#429EDF"><span style="font-size:9pt;">&nbsp;</span></font></p>
<%
				}
%>
        </td>
   </tr>

	<%
		ruser="";
	replydate="";
	}
		}
		}
		if(flag==false)
		{
%>
			<tr>
				<td bgColor="#E2E2E2" colspan="7">&nbsp;</td>
			</tr>
			<tr>
				<td bgColor="#E2E2E2" colspan="7" align="center"><-- No Forums Available --></td>
			</tr>
			<tr>
				<td bgColor="#E2E2E2" colspan="7">&nbsp;</td>
			</tr>
<%
		}
%>
		</table>
<%
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("ForumManagement.jsp","operations on database","Exception",e.getMessage());
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
			ExceptionsFile.postException("ForumManagement.jsp","operations on database","Exception",e.getMessage());
			System.out.println("Connection close failed");
		}
	}
%>

</body>
</html>
