
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
Statement stmt=null,stmt1=null,stmt2=null;
ResultSet rs=null,rs1=null;
String dir="",forumid="";
String schoolid="",emailid="";
String topic="",topic1="",message1="",reply1="";
String posteddate=" ";
String posteduser="";
String userid="",temp="";
String one="",two="",three="";
String crtby="",topiccount="",ruser1="",replydate1="",desc="",rdate="",sno="",utype="",replycount="";


%>
<%  
forumid = request.getParameter("fid");
dir = request.getParameter("dir");
schoolid = request.getParameter("sid");

schoolid=(String)session.getAttribute("schoolid");
emailid = (String)session.getAttribute("emailid");
topic=request.getParameter("topic");
posteduser=request.getParameter("user");
userid = emailid;
posteddate=request.getParameter("postdate");

	crtby=request.getParameter("crtby");
	utype=request.getParameter("utype");
	topiccount=request.getParameter("topiccount");
	replycount=request.getParameter("replycount");
	ruser1=request.getParameter("ruser");
	replydate1=request.getParameter("replydate");
	desc=request.getParameter("desc");
	sno = request.getParameter("sno");


try
{
		con = con1.getConnection();
 }
 catch(Exception ex) {
	 ExceptionsFile.postException("ShowReply.jsp","creating connection object","Exception",ex.getMessage());
	 out.println(ex+" its first");
 }


try
{
	stmt=con.createStatement();
	stmt1=con.createStatement();
	//String query1="update forum_master set nov=nov+1 where forum_id='"+forumid+"'  and school_id='"+schoolid+"'";
	//int s=stmt.executeUpdate(query1);

	String query2="update forum_post_topic_reply set nov=nov+1 where forum_id='"+forumid+"'  and school_id='"+schoolid+"' and topic='"+topic+"'";
	int s1=stmt1.executeUpdate(query2);
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

	response.sendRedirect("ShowReply.jsp?sno="+sno+"&sid="+schoolid+"&fid="+forumid+"&user="+posteduser+"&dir="+dir+"&topic="+topic+"&postdate="+posteddate+"&crtby="+crtby+"&utype="+utype+"&desc="+desc+"&topiccount="+topiccount+"&replycount="+replycount+"&ruser="+ruser1+"&replydate="+replydate1);
%>

