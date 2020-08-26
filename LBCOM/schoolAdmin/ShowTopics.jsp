<html>
<head><title></title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
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
String user,dir="",schoolid="",replycount="",user1="",topic="",maxdate="",topic1="",one="",two="",three="",posteddate=" ",forumid,utype,acode="",temp="",grade;
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
boolean flag=false;
try{
	con = con1.getConnection();
	stmt=con.createStatement();
	rs=stmt.executeQuery("select * from forum_master where school_id='"+schoolid+"' and forum_id='"+forumid+"' and created_by='"+user+"' and creator_type='"+utype+"'");
	if(!rs.next()){
	if(utype.equals("student")){
		rs=stmt.executeQuery("select grade from studentprofile where username='"+user+"' and schoolid='"+schoolid+"'");
		if(rs.next())
			grade=rs.getString(1);
		/*if(!grade.equals("GradeK")){
			temp=grade.substring(0,grade.indexOf('G'));
			if(temp.length()>3)
				temp=temp.substring(0,2);
			else
				temp=temp.substring(0,1);
		}
		else 
			temp = "K";*/
		temp=grade;
		acode="-S:"+temp+":ALL-";
	}
	if(utype.equals("teacher")){
		rs=stmt.executeQuery("select class_id from teachprofile where username='"+user+"' and schoolid='"+schoolid+"'");
		if(rs.next())
			grade=rs.getString(1);
		/*if(!grade.equals("GradeK")){
			temp=grade.substring(0,grade.indexOf('G'));
			if(temp.length()>3)
				temp=temp.substring(0,2);
			else
				temp=temp.substring(0,1);
		}
		else 
			temp = "K";*/
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
	ExceptionsFile.postException("ShowTopics.jsp","operations on database","Exception",ex.getMessage());
	out.println(ex+" its first");
}
%>
<center>
<table  align=center border="0" cellPadding="0" cellSpacing="0" width="100%">
  <tr>
    <td bgColor="#F0E0A0" align=center><font face="Arial" size="2" color="#000000"><b><a href="ShowDirTopics.jsp?emailid=<%= user %>&schoolid=<%= schoolid %>" style="color: #000000;text-decoration:none">Forums</a></b></font></td>
    <td bgColor="#F0E0A0" align=center><font color="#000000" size="2" face="Arial, Arial, Helvetica, sans-serif"> 
      <b><a href="PostNewTopic.jsp?fid=<%= forumid %>&fname=<%=dir%>" style="color: #000000;text-decoration:none">Post New Topic</a></b></font></td>
    <td bgColor="#F0E0A0" align=center><font face="Arial" size="2" color="#000000"><b><a href="PostSug.jsp?fid=<%= forumid %>&fname=<%=dir%>" style="color: #000000;text-decoration:none">Post Suggestions</a></b></font></td>
  </tr>
  <tr>
    <td colspan=3 align="center"> 
      <font face="Arial" size="2" color="#660033">A Topic is active for 30 
        days from the day of its posting. You cannot participate in a closed Topic. You can however view all the questions and replies posted for that Topic. An active Topic is open for participation. </font>
    </td>
  </tr>
  <tr> 
    <td bgColor="#F0B850" align=center width="35%"><font color=black face="Arial" size="2"><b>Forum: 
      <%= dir %></b></font></td>
    <td bgColor="#F0B850" align=center width="35%"><font color=black face="Arial" size="2"><b>School: 
      <%= schoolid %></b></font></td>
    <td bgColor="#F0B850" align="right" width="30%"><a href="ShowDirTopics.jsp?emailid=<%= user %>&schoolid=<%= schoolid %>" style="COLOR: #000080; TEXT-DECORATION: none"><b><font face="Arial" color=black size="2">Back</font></b></a></td>
  </tr>
</table>

<table align=center border="0" cellPadding="0" cellSpacing="1" width="100%">
    <tr>
	  <td bgColor="#F0E0A0" align=left width="25%"><font color="#000000" face="Arial" size="2"><b>&nbsp;Topic</b></font></td>
      <td bgColor="#F0E0A0" align=center width="25%"><font color="#000000" face="Arial" size="2"><b>Posted by</b></font></td>
      <td bgColor="#F0E0A0" align="center" width="25%"><font color="#000000" face="Arial" size="2"><b>Replies</b></font></td>
      <td bgColor="#F0E0A0" align=center width="25%"><font color="#000000" face="Arial" size="2"><b>Posted on</b></font></td>
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
			user1=rs.getString(3);
			topic=rs.getString(5);
			String temp=check4Opostrophe(topic);
			topic1=topic.replace('_','\'');
			maxdate=rs.getString(7);
            replycount="0";
			flag=true;
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
				ExceptionsFile.postException("ShowTopics.jsp","tokenizing the string","Exception",ee.getMessage());
	           out.println(ee+" hhh");
		    }
			%>
     <tr>
	   <td bgColor="#E2E2E2" align=left width="25%">
     <font size="2" color="#000000" face="Arial">&nbsp;<a href="ShowReply.jsp?fid=<%= forumid %>&user=<%= user1 %>&dir=<%=dir%>&topic=<%= topic %>&postdate=<%= maxdate %>" style="COLOR: #000000; TEXT-DECORATION: none">
      <%= topic1 %></a></font></td>
      <td bgColor="#E2E2E2" align=center width="25%"><font color="#000000" size="2" face="Arial"><%= user1 %></font></td>
      <td bgColor="#E2E2E2" align="center" width="25%"><font color="#000000" size="2" face="Arial"><%= replycount %></font></td>
      <td bgColor="#E2E2E2" align=center width="25%"><font color="#000000" size="2" face="Arial"><%= posteddate %></font></td>
    </tr>
<%
      }
	 if(flag==false)
		out.println("<tr><td bgColor=\"#E2E2E2\" colspan=4>&nbsp;</td></tr><tr><td bgColor=\"#E2E2E2\" colspan=4 align=center><-- No Topics Available --></td></tr><tr><td bgColor=\"#E2E2E2\" colspan=4>&nbsp;</td></tr>");
          
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("ShowTopics.jsp","operations on database","Exception",e.getMessage());
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
			ExceptionsFile.postException("ShowTopics.jsp","closing the resultset ,statment and connection object","Exception",e.getMessage());
			System.out.println("Connection close failed");
		}

    }
%>
<tr>
	  <td bgColor="#F0B850" colspan=4 align=left>&nbsp;</td>
</tr>
</table>
</center>
</body>
</html>
