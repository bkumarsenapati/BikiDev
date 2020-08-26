<%@  page language="java"  import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile,sqlbean.DbBean;" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%!
	String month[]={" ","Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Nov","Dec"};

	private String check4Opostrophe(String str)
	{
	 str=str.replaceAll("\'","\\\\\'");
	 str=str.replaceAll("\"","&quot;");
			return(str);
	}
	private String getThreads(Connection con,String sid,String forumid,String dir,String schoolid,String userid,String topic,String topic1,String posteddate,String posteduser,String temp,String crtby,String desc, String utype, String replycount,String topicid)
{
	
	String user="",views1="";
//Connection con=null;
Statement stmt=null,stmt1=null,stmt2=null,stmt3=null;
ResultSet rs=null,rs1=null,rs2=null,rs3=null;
//String posteduser="";
String message1="",reply1="",repldir="",reply="",attachFile="",str1="",f1="",f2="",f3="",sn01="";
StringTokenizer st1,st2;
int sno=0,mnr;
String topiccount="",ruser="",replydate="",rdate="";
//sqlbean.DbBean con1=new sqlbean.DbBean();
String Htmldata="";
try
{
		DbBean db=new DbBean();
			con=db.getConnection();	
			//return "satish";




Htmldata="<br><div id='div" + sid  + "' style='display:none'><table align='center' border='1' cellpadding='0' cellspacing='0' width='100%' bordercolor='#429EDF' bordercolordark='#429EDF' bordercolorlight='#429EDF'>";

String query2="select message,trans_date,user_id,sno,status,forumattachments from forum_post_topic_reply where forum_id='"+forumid+"' and topic='"+temp+"' and school_id='"+schoolid+"' and trans_type='2'  and topic_id='"+sid+"'";

		stmt3=con.createStatement();
		rs3=stmt3.executeQuery(query2);
		while(rs3.next())
		{
			replydate="";
			repldir=dir;
			reply=rs3.getString(1);
			reply=reply.replaceAll("\"","&#34;");
			reply=reply.replaceAll("\'","&#39;");

			//reply1=reply.replace('_','\'');
			sno=rs3.getInt(4);
			sn01=rs3.getString(4);
			rdate=rs3.getString(2);
			ruser=rs3.getString(3);
			attachFile=rs3.getString(6);
			if(attachFile==null)
			{
				attachFile="";
			}
			
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
			

			Htmldata= Htmldata + "<tr>        <td align='center' valign='top' height='25' colspan='2'>            <table align='center' cellspacing='0' width='100%' bordercolordark='#E3E3E3' bordercolorlight='#E3E3E3' style='border-collapse:collapse;' cellpadding='0' border='1'>                <tr>                    <td width='100%' bgcolor='white' style='border-width:1; border-color:rgb(227,227,227); border-style:double;' height='12' align='left'>                        <table align='center' border='0' cellpadding='4' cellspacing='0' width='100%' bordercolor='#429EDF' bordercolordark='#429EDF' bordercolorlight='#429EDF' border='1' height='61'>                            <tr>                                <td width='184' align='left' valign='top' bgcolor='#E1E1E1'>                                    <p><font face='Arial' color='#429EDF'><span style='font-size:9pt;'>on " + replydate+ " </span></font>&nbsp;<a href='/LBCOM/teacherAdmin/Forums/ThreadedReply.jsp?sno="+ sn01 +"&topicid="+ topicid +"&fid=" + forumid + " &fname=" + dir+ " &topic=" +  topic1+ " &user=" + userid+ " &postdate=" + posteddate+ " &auser=" + posteduser+ " &crtby=" + crtby+ " &utype=" + utype+ " &desc=" + desc+ " &topiccount=" + topiccount+ " &replycount=" + replycount+ " &ruser=" + ruser+ " &replydate=" + replydate+ " &reply=" + reply+ " &attachFile=" + attachFile+ " '><img src='images/icon_threaded_reply.gif' width='18' height='9' border='0'></a></p>                                </td>                                <td width='361' align='left' valign='top' bgcolor='#EEEEEE'>                                    <p><font face='Arial'><span style='font-size:10pt;'><b>Re: " +  topic1 + " </b></span></font></p>                                </td>                                <td width='361' align='left' valign='top' bgcolor='#EEEEEE'>";
			


			if(userid.equals("teacher") || userid.equals(posteduser) || userid.equals(ruser))
			{
			
			Htmldata= Htmldata + "&nbsp;<a href='/LBCOM/forums.DeleteForum?mode=delete&sno=" + sno+ "&topicid="+topicid+"&sid=" + schoolid+ "&fid=" + forumid+ " &topic=" + topic1+ " &user=" + ruser+ " &postdate=" +  posteddate + " &dir=" +  dir + "&puser=" + posteduser+ "&crtby=" + crtby+ " &utype=" + utype+ " &desc=" + desc+ " &topiccount=" + topiccount+ " &replycount=" + replycount+ " &ruser=" + ruser+ " &replydate=" + replydate+ " ' onclick=\"return confirm('Are you sure that you want to delete this Reply?')\"><img src='../../forums/images/button_delete_thread.gif' TITLE='Delete this Thread ' border=0></a>";
			}
			if(attachFile.equals("") || attachFile==null || attachFile.equals("null"))
			{
				
			
				Htmldata= Htmldata + "&nbsp;";
			}
			else
			{
				

				Htmldata= Htmldata + "  &nbsp;<a href='javascript://' onclick='return showFile('" + attachFile + "','" + ruser + "');'><img src='../../forums/images/button_attach.gif' TITLE='Attachments' border=0></a></font>";
				  
		}
			

Htmldata= Htmldata + "</td>                            </tr>                            <tr>                                <td width='184' valign='top' align='left' bgcolor='#E1E1E1'>                                   <p align='left'><span style='font-size:10pt;'><font face='Arial' color='#429EDF'>by</font></span><font face='Arial'><span style='font-size:10pt;'> </span></font><span style='font-size:10pt;'><font face='Arial' color='blue'>" +  ruser + " </font></span><font face='Arial'><span style='font-size:10pt;'><img src='images/icon_latest_reply.gif' width='18' height='9' border='0'><br></span></font></p>                                </td>                                <td width='730' valign='top' bgcolor='#EEEEEE' colspan='2'>                                    <p><font face='Arial' color='#429EDF'><span style='font-size:9pt;'>" + reply+ " </span></font></p>                                </td>                            </tr>                      ";

 query2="select count(sno) from forum_post_topic_reply where forum_id='"+forumid+"' and topic='"+temp+"' and school_id='"+schoolid+"' and trans_type='2'  and topic_id='"+sn01+"'";

		stmt1=con.createStatement();
		rs1=stmt1.executeQuery(query2);
		if(rs1.next())
			{
			if(rs1.getInt(1)>0)
				{

	

Htmldata= Htmldata +"<tr><td colspan='3'><font face='Arial' color='blue'><span id='span" + sn01 +"' style='cursor: hand;' onclick=\"if(getElementById('div" + sn01 +"').style.display=='inline') { getElementById('div" + sn01 +"').style.display='none'; getElementById('span" + sn01 +"').innerHTML ='+';} else {getElementById('div" +sn01 +"').style.display='inline';getElementById('span" + sn01 +"').innerHTML ='-';}\"> +</span></font>";
	

Htmldata= Htmldata + getThreads( con,sn01, forumid, dir, schoolid, userid, topic, topic1, posteddate,posteduser, temp, crtby, desc,  utype,  replycount,topicid);


Htmldata= Htmldata +"</td></tr>";
}


		}


Htmldata= Htmldata +"                 </table>						</td>					</tr>				</table>			</td>		</tr>";
			
			
		  }
			Htmldata= Htmldata + "</table></div>";

			
		
//return Htmldata;
			 
			 }
 catch(Exception ex) {
	 ExceptionsFile.postException("ShowReply.jsp","creating connection object","Exception",ex.getMessage());
	return(ex+" its first");
 }

finally
	{
		try
	    {
	        if(stmt1!=null)
		        stmt1.close();
			if(stmt3!=null)
		        stmt3.close();
			if(con!=null && !con.isClosed())
		        con.close();
		}catch(Exception e){
			ExceptionsFile.postException("ShowReply.jsp","closing connection and statement objects","Exception",e.getMessage());
			System.out.println("Connection close failed");
		}

	}

return Htmldata;


}
%>
<%
String user="",views1="";
Connection con=null;
Statement stmt=null,stmt1=null,stmt2=null,stmt3=null;
ResultSet rs=null,rs1=null,rs2=null,rs3=null;
String dir="",forumid="";
String schoolid="",emailid="";
String topic="",topic1="",message1="",reply1="",topicid="";
String posteddate=" ";
String posteduser="";
String userid="",temp="";
String one="",two="",three="";
String tStatus="",tStatusMsg="",tFStatusMsg="",tFStatus="";
String crtby="",topiccount="",ruser="",replydate="",desc="",rdate="",utype="",replycount="";

int sno=0;


%>
<%  
forumid = request.getParameter("fid");
dir = request.getParameter("dir");
topicid=request.getParameter("sno");
schoolid=(String)session.getAttribute("schoolid");
emailid = (String)session.getAttribute("emailid");
topic=request.getParameter("topic");
topic=topic.replaceAll("\"","&#34;");
topic=topic.replaceAll("\'","&#39;");

posteduser=request.getParameter("user");
userid = emailid;
posteddate=request.getParameter("postdate");

crtby=request.getParameter("crtby");
	utype=request.getParameter("utype");
	topiccount=request.getParameter("topiccount");
	replycount=request.getParameter("replycount");
	ruser=request.getParameter("ruser");
	replydate=request.getParameter("replydate");
	desc=request.getParameter("desc");
	//desc=desc.replaceAll("\"","&#34;");
	//desc=desc.replaceAll("\'","&#39;");

	views1=request.getParameter("views");

try
{
		con = con1.getConnection();
 }
 catch(Exception ex) {
	 ExceptionsFile.postException("ShowReply.jsp","creating connection object","Exception",ex.getMessage());
	 out.println(ex+" its first");
 }
%>

<html>
<head><title>Show Reply</title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<link rel="stylesheet" type="text/css" href="css/style.css" />
<SCRIPT LANGUAGE="JavaScript">

function showFile(attachfile,user)
{
	var x=window.open("/LBCOM/schoolAdmin/Forums/Attachments/"+user+"/"+attachfile,"Document","width=750,height=600,scrollbars");
	
	return false;
}


</SCRIPT>

</head>
<body topmargin="0" leftmargin="0">
<FORM METHOD="POST" enctype="multipart/form-data" NAME="ShowReply" >
<b>
		<font color="#660033" face="Verdana" size=1>Date:&nbsp;<%=new java.util.Date()%>
</b><BR><BR>

<font face="Arial" color="#7F7F7F"><span style="font-size:10pt;"><a href="/LBCOM/teacherAdmin/Forums/ForumManagement.jsp?emailid=<%=userid%>&schoolid=<%=schoolid%>&mode=findex">Forum Index</a> &gt; <a href="ShowThreads.jsp?fid=<%=forumid%>&fname=<%=dir%>&crtby=<%=crtby%>&utype=<%=utype%>&desc=<%=desc%>&topiccount=<%=topiccount%>&views=<%=views1%>&replycount=<%=replycount%>&ruser=<%=ruser%>&replydate=<%=replydate%>&mode=tindex"><%=dir%>&gt; <a href="ShowReply.jsp?sid=<%=schoolid%>&fid=<%=forumid%>&user=<%=posteduser%>&dir=<%=dir%>&topic=<%=topic%>&postdate=<%=posteddate%>&crtby=<%=crtby%>&views=<%=views1%>&utype=<%=utype%>&desc=<%=desc%>&topiccount=<%=topiccount%>&replycount=<%=replycount%>&ruser=<%=ruser%>&replydate=<%=replydate%>"><%=topic%></a></span>
</font><BR><BR>

<%
try
{
	temp=check4Opostrophe(topic);
	stmt=con.createStatement();
	
	ResultSet condrs=stmt.executeQuery("select (to_days(curdate())-to_days('"+posteddate+"')) from forum_post_topic_reply where school_id='"+schoolid+"' and forum_id='"+forumid+"' and topic='"+temp+"' and user_id='"+posteduser+"' and trans_type='1'");
	
}
catch(Exception e)
{
	ExceptionsFile.postException("ShowReply.jsp","select query","Exception",e.getMessage());
	
}
	 String temp1=topic.replaceAll("\"","&quot;");
%>
<%
StringTokenizer stz1=new StringTokenizer(posteddate,"-");
String yy=stz1.nextToken();
String mn=stz1.nextToken();
String dd=stz1.nextToken();
int mn1=Integer.parseInt(mn);
String postdate=month[mn1]+" "+dd+","+yy;
String query="select message,status,forumattachments,user_id from forum_post_topic_reply where forum_id='"+forumid+"' and topic='"+temp+"' and user_id='"+posteduser+"' and school_id='"+schoolid+"' and trans_type='1' and sno='" + topicid +"'";
      
try
{
	rs=stmt.executeQuery(query);
	while(rs.next())
	{
		String msg=rs.getString(1);
		message1=msg;
		//message1=message1.replaceAll("\"","&#34;");
		//message1=message1.replaceAll("\'","&#39;");

		topic1=topic;
		//topic1=topic1.replaceAll("\"","&#34;");
		//topic1=topic1.replaceAll("\'","&#39;");

		tFStatus=rs.getString("status");
		if(tFStatus.equals("1"))
		{
			tFStatusMsg="<img src=\"../../forums/images/button_reply.gif\" TITLE=\"Post your reply to this Thread \" border=0>";
		}
		else
		{
			tFStatusMsg="";
		}
		ruser=rs.getString("user_id");
		String attachFile=rs.getString(3);
		if(attachFile==null)
		{
			attachFile="";
		}
		
	%>

<table align="center" border="8" cellpadding="0" cellspacing="0" width="100%" bordercolor="#429EDF" bordercolordark="#429EDF" bordercolorlight="#429EDF">
    <tr>
        <td width="468" bgcolor="#429EDF" height="24">
            <p align="left"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Author of &nbsp;the Topic</b></span></font></p>
        </td>
        <td width="468" height="24" bgcolor="#429EDF">&nbsp;</td>
    </tr>
    <tr>
        <td align="center" valign="top" height="25" colspan="2">
            <table align="center" cellspacing="0" width="100%" bordercolordark="#E3E3E3" bordercolorlight="#E3E3E3" style="border-collapse:collapse;" cellpadding="0">
                <tr>
                    <td width="100%" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="12" align="left">
                        <table align="center" border="0" cellpadding="4" cellspacing="0" width="100%" bordercolor="#429EDF" bordercolordark="#429EDF" bordercolorlight="#429EDF" height="61">
                            <tr>
                                <td width="184" align="left" valign="top" bgcolor="#E1E1E1">
                                    <p><font face="Arial" color="#429EDF"><span style="font-size:9pt;">on <%=postdate%></span></font></p>
                                </td>
                                <td width="361" align="left" valign="top" bgcolor="#EEEEEE">
                                    <p><font face="Arial"><span style="font-size:10pt;"><b><%=topic1%></b></span></font></p>
                                </td>
								<td width="361" align="left" valign="top" bgcolor="#EEEEEE">
<%
							if(userid.equals("teacher") || userid.equals(posteduser) || userid.equals(ruser))
							{
%>								&nbsp;
<%							}
							if(attachFile.equals("") || attachFile==null || attachFile.equals("null"))
							{
				
%>				
									&nbsp;
<%							}
							else
							{				
%>
									 &nbsp;<a href="javascript://" onclick="return showFile('<%=attachFile%>','<%=ruser%>');"><img src="../../forums/images/button_attach.gif" TITLE="Attachments" border=0></a></font>			  
<%							}
			

%>
							</td>
                            </tr>
                            <tr>
                                <td width="184" valign="top" align="left" bgcolor="#E1E1E1">
                                    <p align="left"><span style="font-size:10pt;"><font face="Arial" color="#429EDF">by</font></span><font face="Arial"><span style="font-size:10pt;"> </span></font><span style="font-size:10pt;"><font face="Arial" color="blue"><%=posteduser%></font></span><font face="Arial"><span style="font-size:10pt;"><img src="images/icon_latest_reply.gif" width="18" height="9" border="0"><br>
</span></font></p>
                                </td>
                                <td width="730" valign="top" bgcolor="#EEEEEE" colspan="2">
                                    <p><font face="Arial" color="#429EDF"><span style="font-size:9pt;"><%= message1%></span></font></p>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table><BR>
<%
	if(tFStatus.equals("1"))
		{
	%>
<table align="center" border="0" cellpadding="0" cellspacing="5" width="100%" bordercolor="black" bordercolordark="black" bordercolorlight="black">
    <tr>
        <td width="50%">
            <P><a href="/LBCOM/teacherAdmin/Forums/PostReply.jsp?sno=<%= topicid %>&fid=<%= forumid %>&fname=<%=dir%>&topic=<%= topic1%>&user=<%=userid%>&postdate=<%=posteddate%>&auser=<%=posteduser%>&crtby=<%=crtby%>&utype=<%=utype%>&desc=<%=desc%>&topiccount=<%=topiccount%>&replycount=<%=replycount%>&ruser=<%=ruser%>&replydate=<%=replydate%>"><img src="images/button_topic_reply.gif" width="96" height="25" border="0"></a></P>
        </td>
        <td width="50%">&nbsp;</td>
    </tr>
</table>
<%}else{
				%>
				<table align="center" border="0" cellpadding="0" cellspacing="5" width="100%" bordercolor="black" bordercolordark="black" bordercolorlight="black">
    <tr>
        <td width="50%">
            <P><img src="images/button_topic_reply.gif" width="96" height="25" border="0"></P>
        </td>
        <td width="50%">&nbsp;</td>
    </tr>
</table>

<%
			}
	}
}
catch(Exception e)
{
	ExceptionsFile.postException("ShowReply.jsp","select query","Exception",e.getMessage());
	out.println(e);
}
try
{
	String query1="select count(sno)  from forum_post_topic_reply where forum_id='"+forumid+"' and topic='"+temp+"' and school_id='"+schoolid+"' and trans_type='2' and topic_id='"+topicid+"'";

		
	rs1=stmt.executeQuery(query1);
	if(rs1.next())
	{
		if(rs1.getInt(1)>0)
			{
		//String replydate="";
		String repldir=dir;
		String reply="";
		
		String sn01="";
		
		String attachFile="";
		
		
		StringTokenizer st1;
        String str1="";
        StringTokenizer st2;
        String f1="";
        String f2="";
        String f3="";
        int mnr=0;
		
		%>

<table align="center" border="8" cellpadding="0" cellspacing="0" width="100%" bordercolor="#429EDF" bordercolordark="#429EDF" bordercolorlight="#429EDF">
    <tr>
        <td width="468" bgcolor="#429EDF" height="24">
            <p align="left"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Replies Received:</b></span></font></p>
        </td>
        <td width="468" height="24" bgcolor="#429EDF">
            <p align="right">&nbsp;</p>
        </td>
    </tr>
	

<%
String query2="select message,trans_date,user_id,sno,status,forumattachments from forum_post_topic_reply where forum_id='"+forumid+"' and topic='"+temp+"' and school_id='"+schoolid+"' and trans_type='2'  and topic_id='"+topicid+"'";
		stmt1=con.createStatement();
		rs2=stmt1.executeQuery(query2);
		while(rs2.next())
		{

			replydate="";
			repldir=dir;
			reply=rs2.getString(1);
			reply=reply.replaceAll("\"","&#34;");
			reply=reply.replaceAll("\'","&#39;");

			//reply1=reply.replace('_','\'');
			sno=rs2.getInt(4);
			sn01=rs2.getString(4);
			rdate=rs2.getString(2);
			ruser=rs2.getString(3);
			attachFile=rs2.getString(6);
			if(attachFile==null)
			{
				attachFile="";
			}
			
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
                        <table align="center" border="0" cellpadding="4" cellspacing="0" width="100%" bordercolor="#429EDF" bordercolordark="#429EDF" bordercolorlight="#429EDF" height="61">
                            <tr>
                                <td width="184" align="left" valign="top" bgcolor="#E1E1E1">
                                    <p><font face="Arial" color="#429EDF"><span style="font-size:9pt;">on <%=replydate%></span></font>&nbsp;<a href="/LBCOM/teacherAdmin/Forums/ThreadedReply.jsp?sno=<%= sn01 %>&topicid=<%= topicid %>&fid=<%= forumid %>&fname=<%=dir%>&topic=<%= topic1%>&user=<%=userid%>&postdate=<%=posteddate%>&auser=<%=posteduser%>&crtby=<%=crtby%>&utype=<%=utype%>&desc=<%=desc%>&topiccount=<%=topiccount%>&replycount=<%=replycount%>&ruser=<%=ruser%>&replydate=<%=replydate%>&reply=<%=reply%>&attachFile=<%=attachFile%>"><img src="images/icon_threaded_reply.gif" width="18" height="9" border="0"></a></p>
                                </td>
                                <td width="361" align="left" valign="top" bgcolor="#EEEEEE">
                                    <p><font face="Arial"><span style="font-size:10pt;"><b>Re: <%= topic1 %></b></span></font></p>
                                </td>
                                <td width="361" align="left" valign="top" bgcolor="#EEEEEE">
<%
			if(userid.equals("teacher") || userid.equals(posteduser) || userid.equals(ruser))
			{
			%>&nbsp;<a href="/LBCOM/forums.DeleteForum?mode=delete&sno=<%=sno%>&topicid=<%= topicid %>&sid=<%=schoolid%>&fid=<%=forumid%>&topic=<%=topic1%>&user=<%=ruser%>&postdate=<%= posteddate %>&dir=<%= dir %>&puser=<%=posteduser%>&crtby=<%=crtby%>&utype=<%=utype%>&desc=<%=desc%>&topiccount=<%=topiccount%>&replycount=<%=replycount%>&ruser=<%=ruser%>&replydate=<%=replydate%>" onclick="return confirm('Are you sure that you want to delete this Reply?')"><img src="../../forums/images/button_delete_thread.gif" TITLE="Delete this Thread " border=0></a>
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
                                    <p align="left"><span style="font-size:10pt;"><font face="Arial" color="#429EDF">by</font></span><font face="Arial"><span style="font-size:10pt;"> </span></font><span style="font-size:10pt;"><font face="Arial" color="blue"><%= ruser %></font></span><font face="Arial"><span style="font-size:10pt;"><img src="images/icon_latest_reply.gif" width="18" height="9" border="0"><br>
</span></font></p>
                                </td>
                                <td width="730" valign="top" bgcolor="#EEEEEE" colspan="2">
                                    <p><font face="Arial" color="#429EDF"><span style="font-size:9pt;"><%=reply%></span></font></p>
                                </td>
                            </tr>
							<%


	 query2="select count(sno) from forum_post_topic_reply where forum_id='"+forumid+"' and topic='"+temp+"' and school_id='"+schoolid+"' and trans_type='2'  and topic_id='"+sno+"'";

		stmt3=con.createStatement();
		rs3=stmt3.executeQuery(query2);
		if(rs3.next())
			{
			if(rs3.getInt(1)>0)
				{

	%>

<tr ><td colspan="3"><font face='Arial' color='blue'><span id='span<%= rs2.getString(4)%>' style='cursor: hand;' onclick="if(getElementById('div<%= rs2.getString(4)%>').style.display=='inline') { getElementById('div<%= rs2.getString(4)%>').style.display='none';getElementById('span<%= rs2.getString(4)%>').innerHTML ='+';} else {getElementById('div<%= rs2.getString(4)%>').style.display='inline';getElementById('span<%= rs2.getString(4)%>').innerHTML ='-';}"> +</span></font>
			<%
	

out.println(getThreads( con,rs2.getString(4), forumid, dir, schoolid, userid, topic, topic1, posteddate,posteduser, temp, crtby, desc,  utype,  replycount,topicid));
}

%></td></tr>


<%
		
		}
		%>
                            <tr>
                                <!-- <td width="100%" align="left" valign="top" colspan="3">
									<hr>
                                </td> -->
                            </tr>
                        </table>
						</td>
					</tr>
				</table>
			</td>
		</tr>

<%

//
		  }
%>			</table>
<%
		  
		}
		else
		{
%>

			<table border="0" cellSpacing="0" align="center" width="100%">
				<tr>
					<td align="center" bgColor="#FFFFFF"><b>
						<font face="Arial" size="2" color="#0000FF">No Replies Received</font></b></td>
				</tr>
			</table>
<%
		}
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
			ExceptionsFile.postException("ShowReply.jsp","closing connection and statement objects","Exception",e.getMessage());
			System.out.println("Connection close failed");
		}
}
%>
</body>
</html>
