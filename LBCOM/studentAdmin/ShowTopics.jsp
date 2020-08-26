<%@page language="java"  import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile"%>
<%@page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<html>
<head>
<title></title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<SCRIPT LANGUAGE="JavaScript">
<!--
	function redirect(user,school)
	{
		alert("Sorry! You don't have the access to this Forum.");
		document.location.href="ShowDirTopics.jsp?emailid="+user+"&schoolid="+school;
	}
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
//-->
</SCRIPT>
</head>
<body topmargin="0" leftmargin="0">

<%!
	public String check4Opostrophe(String s)
	{
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

	String month[]={" ","Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Nov","Dec"};
%>
<%
	String user,dir="",schoolid="",sId="",replycount="",user1="",topic="",maxdate="",topic1="",one="",two="",three="";
	String posteddate=" ",forumid,utype,acode="",temp="",grade="";
	String aCode="",accCode="",status="";
	boolean crsFlag=false;
	Connection con=null;
	Statement stmt=null,stmt1=null,stmt2=null,stmt3=null,stmt4=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null;
%>

<%
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	
	user=(String)session.getAttribute("emailid");
	schoolid=(String)session.getAttribute("schoolid");
	utype=(String)session.getAttribute("logintype");
	sId=request.getParameter("sid");
	forumid=request.getParameter("fid");
	dir=request.getParameter("fname");
	boolean flag=false;

	try
	{
		con = con1.getConnection();
		stmt1=con.createStatement();
		stmt2=con.createStatement();
		stmt3=con.createStatement();
		stmt4=con.createStatement();

		rs1=stmt1.executeQuery("select * from forum_master where school_id='"+sId+"' and forum_id='"+forumid+"' and created_by='"+user+"' and creator_type='"+utype+"'");
		
		if(!rs1.next())
		{
			if(utype.equals("student"))
			{
				rs2=stmt2.executeQuery("select grade from studentprofile where username='"+user+"' and schoolid='"+schoolid+"'");
				if(rs2.next())
				{
					grade=rs2.getString(1);
				}
				rs2.close();

				acode="-S:"+grade+":ALL-";
				
				rs3=stmt3.executeQuery("select access_code,status from forum_master where school_id='"+sId+"' and forum_id='"+forumid+"'");	
				
				if(rs3.next())
				{
					accCode=rs3.getString("access_code");
					status=rs3.getString("status");
				}
				rs3.close();

				crsFlag=false;

				if(accCode.indexOf(acode)!= -1)
				{
					crsFlag=true;
				}
				if(crsFlag==false)
				{
					rs4=stmt4.executeQuery("select course_id from coursewareinfo_det where (student_id='"+user+"' and school_id='"+schoolid+"') or (student_id='"+schoolid+"_"+user+"')");
									
					while(rs4.next())
					{
						aCode="-S:"+rs4.getString("course_id")+":ALL-";
						int index = accCode.indexOf(aCode); 
						if(index!=-1)
						{
							crsFlag=true;
						}
					}
				}
				if(crsFlag==false)
				{
%>
					<SCRIPT LANGUAGE="JavaScript">
					<!--
						redirect('<%=user%>','<%=schoolid%>');
					//-->
					</SCRIPT>
<%
				}
			}
			if(utype.equals("teacher"))
			{
				rs2=stmt2.executeQuery("select class_id from teachprofile where username='"+user+"' and schoolid='"+schoolid+"'");
				if(rs2.next())
					grade=rs2.getString(1);
				temp=rs2.getString(1);
				acode="-T:"+temp+":ALL-";
			
				rs3=stmt3.executeQuery("select * from forum_master where school_id='"+schoolid+"' and forum_id='"+forumid+"' and access_code like '%"+acode+"%'");
				if(!rs3.next())
				{
%>
					<SCRIPT LANGUAGE="JavaScript">
					<!--
						redirect('<%=user%>','<%=schoolid%>');
					//-->
					</SCRIPT>
<%
				}
			}
		}
	}
	catch(Exception ex)
	{
		ExceptionsFile.postException("ShowTopics.jsp","operations on database","Exception",ex.getMessage());
		out.println(ex+" its first");
		try
		{
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("ShowTopics.jsp","closing statement,result and connection objects","Exception",e.getMessage());
		}
	}
%>
<center>
<table  align=center border="0" cellPadding="0" cellSpacing="0" width="100%">
	<tr>
		<td bgColor="#d0c0a0" align=center>
			<font face="Arial" size="2" color="#000000"><b>
			<a href="/LBCOM/studentAdmin/ShowDirTopics.jsp?emailid=<%=user%>&schoolid=<%=schoolid%>" style="color: #000000;text-decoration:none">Forums</a></b></font></td>
<%
	if(status.equals("1"))
	{
%>		
		<td bgColor="#d0c0a0" align=center>
			<font color="#000000" size="2" face="Arial, Arial, Helvetica, sans-serif"> 
			<b><a href="PostNewTopic.jsp?sid=<%=sId%>&fid=<%=forumid%>&fname=<%=dir%>" style="color: #000000;text-decoration:none">
			Post New Topic</a></b></font></td>
<%
	}
	else
	{
%>
		<td bgColor="#d0c0a0" align=center>
			<font color="#000000" size="2" face="Arial, Arial, Helvetica, sans-serif"> 
			<b><a href="#"  onclick="return cantPostTopic();" style="color: #000000;text-decoration:none">
			Post New Topic</a></b></font></td>
<%
	}	
%>
<%
	if(status.equals("1"))
	{
%>
		<td bgColor="#d0c0a0" align=center>
			<font face="Arial" size="2" color="#000000"><b>
			<a href="/LBCOM/studentAdmin/PostSug.jsp?sid=<%=sId%>&fid=<%=forumid%>&fname=<%=dir%>" style="color: #000000;text-decoration:none">
			Post Suggestions</a></b></font></td>
<%
	}
	else
	{
%>
		<td bgColor="#d0c0a0" align=center>
			<font face="Arial" size="2" color="#000000"><b>
			<a href="#" onclick="return cantPostSuggestion();" style="color: #000000;text-decoration:none">
			Post Suggestions</a></b></font></td>

<%
	}	
%>
	</tr>
	<tr>
		<td colspan=3 align="center"> 
			<font face="Arial" size="2" color="#660033">&nbsp;</font>
		</td>
  </tr>
  <tr> 
		<td bgColor="#e08040" align=center width="35%">
			<font color=black face="Arial" size="2"><b>Forum: <%=dir%></b></font></td>
		<td bgColor="#e08040" align=center width="35%">
			<font color=black face="Arial" size="2"><b>School: <%=sId%></b></font></td>
		<td bgColor="#e08040" align="right" width="30%">
			<a href="/LBCOM/studentAdmin/ShowDirTopics.jsp?emailid=<%=user%>&schoolid=<%=schoolid%>" style="COLOR: #000080; TEXT-DECORATION: none"><b>
			<font face="Arial" color=black size="2">Back</font></b></a></td>
  </tr>
</table>

<table align=center border="0" cellPadding="0" cellSpacing="1" width="100%">
    <tr>
		<td bgColor="#d0c0a0" align=left width="25%">
			<font color="#000000" face="Arial" size="2"><b>&nbsp;Topic</b></font></td>
		<td bgColor="#d0c0a0" align=center width="25%">
			<font color="#000000" face="Arial" size="2"><b>Posted by</b></font></td>
		<td bgColor="#d0c0a0" align="center" width="25%">
			<font color="#000000" face="Arial" size="2"><b>Replies</b></font></td>
		<td bgColor="#d0c0a0" align=center width="25%">
			<font color="#000000" face="Arial" size="2"><b>Posted on</b></font></td>
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
          stmt=con.createStatement(); 
          rs=stmt.executeQuery("select * from forum_post_topic_reply where forum_id='"+forumid+"' and school_id='"+sId+"' and trans_type='1'");
          while (rs.next())
          {
			user1=rs.getString(3);
			topic=rs.getString(5);
			temp=check4Opostrophe(topic);
			topic1=topic;
			maxdate=rs.getString(7);
            replycount="0";
			flag=true;
            String query1="select count(*) from forum_post_topic_reply where forum_id='"+forumid+"' and topic='"+temp+"' and trans_type='2' and school_id='"+sId+"'";
			
			rs1=stmt1.executeQuery(query1);         
			
			if(rs1.next())
			{				
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
				<font size="2" color="#000000" face="Arial">&nbsp;
				<a href="/LBCOM/studentAdmin/ShowReply.jsp?sid=<%=sId%>&fid=<%=forumid%>&user=<%=user1%>&dir=<%=dir%>&topic=<%=topic%>&amp;postdate=<%=maxdate%>" style="COLOR: #000000; TEXT-DECORATION: none"><%=topic1%></a></font></td>
			<td bgColor="#E2E2E2" align=center width="25%">
				<font color="#000000" size="2" face="Arial"><%=user1%></font></td>
			<td bgColor="#E2E2E2" align="center" width="25%">
				<font color="#000000" size="2" face="Arial"><%= replycount %></font></td>
			<td bgColor="#E2E2E2" align=center width="25%">
				<font color="#000000" size="2" face="Arial"><%= posteddate %></font></td>
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
			if(rs!=null)
				rs.close();
			if(rs1!=null)
		        rs1.close();
			if(stmt1!=null)
		        stmt1.close();
			if(stmt!=null)
		        stmt.close();
			if(con!=null && !con.isClosed())
		        con.close();
        }catch(Exception e){
			ExceptionsFile.postException("ShowTopics.jsp","closing statement,result and connection objects","Exception",e.getMessage());
			System.out.println("Connection close failed in studentAdmin/ShowTopics.jsp");
		}

    }
%>
	<tr>
		<td bgColor="#e08040" colspan=4 align=left>&nbsp;</td>
	</tr>
</table>
</center>
</body>
</html>

