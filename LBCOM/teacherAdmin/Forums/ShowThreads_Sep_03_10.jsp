<html>
<head><title></title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<link rel="stylesheet" type="text/css" href="css/style.css" />
<SCRIPT LANGUAGE="JavaScript">
<!--
function redirect(user,school){
	alert("We are Sorry. You don't have access to this Forum");
	document.location.href="ForumManagement.jsp?emailid="+user+"&schoolid="+school+"&mode=findex;
}
//-->
</SCRIPT>
</head>
<body topmargin="0" leftmargin="0">
<%@  page language="java"  import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
String user,dir="",schoolid="",replycount="",user1="",topic="",maxdate="",topic1="",views="",views1="",one="",two="",three="",posteddate=" ",forumid,utype,acode="",temp="",grade="",UAruser="",fStatusMsg="",fStatus="",fAltMsg="";
String crtby="",topiccount="",ruser="",replydate="",ruser1="",replydate1="",desc="",rdate="",mode1=null,message1="",user2="",sno="";

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
Statement stmt=null,stmt1=null,st4=null,st5=null,st6=null;
ResultSet rs=null,rs1=null,rs4=null,rs5=null,rs6=null;

user=(String)session.getAttribute("emailid");
schoolid=(String)session.getAttribute("schoolid");
utype=(String)session.getAttribute("logintype");
forumid=request.getParameter("fid");
dir=request.getParameter("fname");
	crtby=request.getParameter("crtby");
	utype=request.getParameter("utype");
	topiccount=request.getParameter("topiccount");
	replycount=request.getParameter("replycount");
	ruser=request.getParameter("ruser");
	replydate=request.getParameter("replydate");
	desc=request.getParameter("desc");
	views1=request.getParameter("views");
	mode1=request.getParameter("mode");
	if(mode1==null)
	{
		mode1="";
	}

boolean flag=false;
try{
	con = con1.getConnection();
	stmt=con.createStatement();
	st4=con.createStatement();
	st5=con.createStatement();
	st6=con.createStatement();

%>
<table width="100%">
<tr>
<td width="100%">
	<table border="0" cellpadding="0" cellspacing="0" face='Arial' size='3' style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" align="left">
	  
	  <tr>
<td width="50%"><span style="font-size:10pt;"><font face="Arial" color="blue"><A href="ShowThreads.jsp?fid=<%=forumid%>&fname=<%=dir%>&crtby=<%=crtby%>&utype=<%=utype%>&desc=<%=desc%>&topiccount=<%=topiccount%>&replycount=<%=replycount%>&views=<%=views1%>&ruser=<%=ruser%>&replydate=<%=replydate%>&mode=sree1">View unanswered topics</a><font  color="#7F7F7F"> / </font><span style="font-size:10pt;"><font face="Arial" color="blue"><A href="ShowThreads.jsp?fid=<%=forumid%>&fname=<%=dir%>&crtby=<%=crtby%>&utype=<%=utype%>&desc=<%=desc%>&topiccount=<%=topiccount%>&views=<%=views1%>&replycount=<%=replycount%>&ruser=<%=ruser%>&replydate=<%=replydate%>&mode=act1">View active topics</A></font></span>
</td>
<td width="50%" align="right"><A href="#"><span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span></A>
</td>
</tr>
</table>
</td>
</tr>
</table>

<span style="font-size:10pt;"><font color="#660033" face="Verdana" size=1>&nbsp;Date:&nbsp;<%=new java.util.Date()%></font></span><BR><BR>

<font face="Arial" color="#7F7F7F"><span style="font-size:10pt;"><a href="ForumManagement.jsp?mode=findex">Forum Index</a> &gt;<a href="ShowThreads.jsp?fid=<%=forumid%>&fname=<%=dir%>&crtby=<%=crtby%>&utype=<%=utype%>&desc=<%=desc%>&topiccount=<%=topiccount%>&views=<%=views1%>&replycount=<%=replycount%>&ruser=<%=ruser%>&replydate=<%=replydate%>&mode=tindex">&nbsp;<%=dir%></a></span></font><BR><BR>


<%

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
//-->
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
<table align="center" border="8" cellpadding="0" cellspacing="0" width="100%" bordercolor="#429EDF" bordercolordark="#429EDF" bordercolorlight="#429EDF">
    <tr>
        <td width="35%" bgcolor="#429EDF" height="24">
            <p align="left"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Forum Name</b></span></font></p>
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
                                    <p align="left"><span style="font-size:10pt;"><b><%=dir%></font></b></span><font face="Arial"><span style="font-size:10pt;"><br>
</span></font><font face="Arial" color="#429EDF"><span style="font-size:9pt;"><%=desc%></span></font></p>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#429EDF"><%=crtby%></font></span></td>
                    <td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#429EDF"><%=utype%></font></span></td>
                    <td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#429EDF"><%=topiccount%></font></span></td>
                    <td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#429EDF"><%=replycount%></font></span></td>
					<td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#429EDF"><%=views1%></font></span></td>
                    <td width="15%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27">
                        <p align="center"><span style="font-size:10pt;"><font face="Arial" color="#429EDF">by</font></span><font face="Arial"><span style="font-size:10pt;"> </span></font><span style="font-size:10pt;"><font face="Arial" color="blue"><%=ruser%></font></span><font face="Arial"><span style="font-size:10pt;"><img src="images/icon_latest_reply.gif" width="18" height="9" border="0"><br>
</span></font><font face="Arial" color="#429EDF"><span style="font-size:9pt;">on&nbsp;<%=replydate%></span></font></p>
                    </td>
                </tr>
				</table>
		</td>
    </tr>
</table>
<BR>
<table align="center" border="0" cellpadding="0" cellspacing="5" width="100%" bordercolor="black" bordercolordark="black" bordercolorlight="black">
    <tr>
        <td width="50%">
            <P><img src="images/button_topic_new.gif" width="96" height="25" border="0"></P>
        </td>
        <td width="50%">&nbsp;</td>
    </tr>
</table><BR>

<table align="center" border="8" cellpadding="0" cellspacing="0" width="100%" bordercolor="#429EDF" bordercolordark="#429EDF" bordercolorlight="#429EDF">
    <tr>
        <td width="39%" bgcolor="#429EDF" height="24">
            <p align="left"><font face="Arial" color="white"><span style="font-size:10pt;">
<%

	if(mode1.equals("sree1"))
			{
%>
<b>Topics&nbsp;&nbsp;&nbsp;[UnAnswered Topics]</b>
<%
}
else if(mode1.equals("tindex"))
{
%>
<b>Topics&nbsp;&nbsp;&nbsp;[All Topics]</b>
<%
}
else if(mode1.equals("act1"))
{
%>
<b>Topics&nbsp;&nbsp;&nbsp;[Active Topics]</b>
<%
	}
%>
</span></font></p>
        </td>
        <td width="10%" bgcolor="#429EDF" height="24">
            <p align="center"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Posted By</b></span></font></p>
        </td>
        <td width="10%" bgcolor="#429EDF" height="24">
            <p align="center"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Replies</b></span></font></p>
        </td>
        <td width="10%" bgcolor="#429EDF" height="24">
            <p align="center"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Views</b></span></font></p>
        </td>
        <td width="25%" bgcolor="#429EDF" height="24">
            <p align="center"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Last Reply Posted</b></span></font></p>
        </td>
    </tr>

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
			user1=rs.getString(4);
			topic=rs.getString(6);
			views=rs.getString("nov");
			message1=rs.getString("message");
			sno=rs.getString("sno");
			message1=message1.replaceAll("\"","&#34;");
		    message1=message1.replaceAll("\'","&#39;");

			String temp=check4Opostrophe(topic);
			topic1=topic.replace('_','\'');
			topic1=topic1.replaceAll("\"","&#34;");
		    topic1=topic1.replaceAll("\'","&#39;");

			maxdate=rs.getString(8);
            replycount="0";
			flag=true;
			fStatus=rs.getString("status");
			if(fStatus.equals("1"))
			{
				fStatusMsg="#E2E2E2";
				fAltMsg=dir;
			}
			else
			{
				fStatusMsg="#E2E2E2";
				fAltMsg="Topic has been Inactivated";
			}
			if(mode1.equals("act1") && fStatus.equals("2"))
				{
					flag=false;
				}
            String query1="select count(*) from forum_post_topic_reply where forum_id='"+forumid+"' and topic='"+temp+"' and trans_type='2' and school_id='"+schoolid+"'";
			rs1=stmt1.executeQuery(query1);         
			if(rs1.next()){				
			    replycount=rs1.getString(1);			
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

			rs5=st5.executeQuery("select trans_date,user_id from forum_post_topic_reply where school_id='"+schoolid+"' and forum_id='"+forumid+"' and topic='"+topic1+"' and trans_type='2' order by sno desc LIMIT 1");
		    if(rs5.next())
			{ 
				ruser1=rs5.getString("user_id");
				rdate=rs5.getString("trans_date");

			StringTokenizer stz1=new StringTokenizer(rdate," ");
			String str1=stz1.nextToken();
			StringTokenizer stz2=new StringTokenizer(str1,"-");
			String f1=stz2.nextToken();
			String f2=stz2.nextToken();
			String f3=stz2.nextToken();
			int mnr=Integer.parseInt(f2);
			replydate=month[(mnr-1)]+" "+f3+","+f1;
			
			replydate1=month[(mnr)]+" "+f3+","+f1;
	        }

			rs6=st6.executeQuery("select user_id from forum_post_topic_reply where  forum_id='"+forumid+"' and school_id='"+schoolid+"' and topic='"+topic1+"' and trans_type='2'");

			 if(rs6.next())
			{ 
				user2=rs6.getString("user_id");
			}
			rs4=st4.executeQuery("select user_id from forum_post_topic_reply where  forum_id='"+forumid+"' and school_id='"+schoolid+"' order by sno desc");

			 if(rs4.next())
			{ 
				UAruser=rs4.getString("user_id");
			}

%>
<%
	
	if((mode1.equals("sree1") && replycount.equals("0")) || (mode1.equals("sree1") && !UAruser.equals(user)) || (mode1.equals("act1") && fStatus.equals("1")))
			{
%>
	<tr>
        <td colspan="5" align="center" valign="top" height="25">
            <table align="center" cellspacing="0" width="100%" bordercolordark="#E3E3E3" bordercolorlight="#E3E3E3" style="border-collapse:collapse;" cellpadding="0">
                <tr>
                    <td width="39%" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27" align="left">
                        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%" bordercolor="#429EDF" bordercolordark="#429EDF" bordercolorlight="#429EDF">
                            <tr>
                                <td width="14%">
                                    <p><img src="images/folder_big.gif" width="46" height="25" border="0"></p>
                                </td>
                                <td width="86%">
                                    <p align="left"><span style="font-size:10pt;"><b><a href="ShowReply1.jsp?sno=<%= sno %>&fid=<%= forumid %>&user=<%= user1 %>&dir=<%=dir%>&topic=<%= topic1 %>&postdate=<%= maxdate %>&crtby=<%=crtby%>&utype=<%=utype%>&views=<%=views1%>&desc=<%=desc%>&topiccount=<%=topiccount%>&replycount=<%=replycount%>&ruser=<%=ruser1%>&replydate=<%=replydate1%>"><font face="Arial" color="black"><%= topic1 %></font></a></b></span><font face="Arial"><span style="font-size:10pt;"><br>
</span></font><font face="Arial" color="#429EDF"><span style="font-size:9pt;">&nbsp;<!-- <%= message1 %> --></span></font></p>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27">
                   <p align="center"><span style="font-size:10pt;">
				   <font face="Arial" color="#429EDF"><%= user1 %></font></span></p>
                    </td>
                    <td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#429EDF"><%= replycount %></font></span></td>
                    <td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#429EDF"><%= views %></font></span></td>
                    <td width="25%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27">
<%
						if((ruser1)!="")
				{
%>
                        <p align="center"><span style="font-size:10pt;"><font face="Arial" color="#429EDF">by</font></span><font face="Arial"><span style="font-size:10pt;"> </span></font><span style="font-size:10pt;"><font face="Arial" color="blue"><%=ruser1%></font></span><font face="Arial"><span style="font-size:10pt;"><img src="images/icon_latest_reply.gif" width="18" height="9" border="0"><br>
</span></font><font face="Arial" color="#429EDF"><span style="font-size:9pt;">on&nbsp;<%=replydate1%></span></font></p>
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
	ruser1="";
	replydate1="";
}else if(mode1.equals("tindex") && Integer.parseInt(replycount) >=0)
			  {
	%>
		<tr>
        <td colspan="5" align="center" valign="top" height="25">
            <table align="center" cellspacing="0" width="100%" bordercolordark="#E3E3E3" bordercolorlight="#E3E3E3" style="border-collapse:collapse;" cellpadding="0">
                <tr>
                    <td width="39%" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27" align="left">
                        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%" bordercolor="#429EDF" bordercolordark="#429EDF" bordercolorlight="#429EDF">
                            <tr>
                                <td width="14%">
                                    <p><img src="images/folder_big.gif" width="46" height="25" border="0"></p>
                                </td>
                                <td width="86%">
                                    <p align="left"><span style="font-size:10pt;"><b><a href="ShowReply1.jsp?sno=<%= sno %>&fid=<%= forumid %>&user=<%= user1 %>&dir=<%=dir%>&topic=<%= topic1 %>&postdate=<%= maxdate %>&crtby=<%=crtby%>&utype=<%=utype%>&views=<%=views1%>&desc=<%=desc%>&topiccount=<%=topiccount%>&replycount=<%=replycount%>&ruser=<%=ruser1%>&replydate=<%=replydate1%>"><font face="Arial" color="black"><%= topic1 %></font></a></b></span><font face="Arial"><span style="font-size:10pt;"><br>
</span></font><font face="Arial" color="#429EDF"><span style="font-size:9pt;"><%= message1 %></span></font></p>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27">
                   <p align="center"><span style="font-size:10pt;">
				   <font face="Arial" color="#429EDF"><%= user1 %></font></span></p>
                    </td>
                    <td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#429EDF"><%= replycount %></font></span></td>
                    <td width="10%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27"><span style="font-size:10pt;"><font face="Arial" color="#429EDF"><%= views %></font></span></td>
                    <td width="25%" align="center" valign="middle" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="27">
<%
						if((ruser1)!="")
				{
%>
                        <p align="center"><span style="font-size:10pt;"><font face="Arial" color="#429EDF">by</font></span><font face="Arial"><span style="font-size:10pt;"> </span></font><span style="font-size:10pt;"><font face="Arial" color="blue"><%=ruser1%></font></span><font face="Arial"><span style="font-size:10pt;"><img src="images/icon_latest_reply.gif" width="18" height="9" border="0"><br>
					</span></font><font face="Arial" color="#429EDF"><span style="font-size:9pt;">on&nbsp;<%=replydate1%></span></font></p>
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
	ruser1="";
	replydate1="";
	}
}
	 if(flag==false)
			{
	 %>
		 <tr><td  colspan=5>
            <span style="font-size:10pt;">&nbsp;</span></td></tr>
			<tr><td  colspan=5>
                                    <p align="center"><span style="font-size:10pt;"><-- No Topics Available --></span></td>
</tr>
</table>
        </td>
    </tr>
</table>
		
<%     
			}
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
</body>
</html>
