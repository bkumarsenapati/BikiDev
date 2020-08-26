<html>

<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<title></title>
</head>

<body>
<%@  page language="java"  import="java.sql.*,java.util.*,java.lang.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%!
	String month[]={" ","Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Nov","Dec"};
%>
<%
String forumid="",forumname="",schoolid="",emailid="",suguser="",message="";
Connection con=null;
ResultSet rs=null;
Statement st=null;
boolean flag=false;
java.util.Date date=null;

%>
<%
String sessid=(String)session.getAttribute("sessid");
if(sessid==null){
	out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
	return;
}
forumid = request.getParameter("fid");
forumname = request.getParameter("fname");
emailid = (String)session.getAttribute("emailid");
schoolid =(String)session.getAttribute("schoolid");
%>
<table border="0" cellPadding="0" cellSpacing="0" width="100%" align=center>
    <tr>
      <td align="middle" width="35%" bgColor="#a8b8d0"><font face="Arial" color="#000000" size="2"><b><a style="COLOR: #000000; TEXT-DECORATION: none" href="ShowDirTopics.jsp?emailid=<%=emailid%>&amp;schoolid=<%=schoolid%>">Forums</a></b></font></td>
      <td align="middle" width="30%" bgColor="#a8b8d0"><b><font face="Arial" color="#000000" size="2"><a style="COLOR: #000000; TEXT-DECORATION: none" href="PostNewTopic.jsp?fid=<%=forumid%>&amp;fname=<%=forumname%>">Post
        New Topic</a></font></b></td>
      <td align="middle" width="35%" bgColor="#a8b8d0"><b><font face="Arial" color="#000080" size="2" align="right"><a style="COLOR: #000080; TEXT-DECORATION: none" href="ShowDirTopics.jsp?emailid=<%=emailid%>&amp;schoolid=<%=schoolid%>"><font face="Arial, Arial, Helvetica, sans-serif" color="#000000">Back</font></a></font></b></td>
    </tr>
    <tr>
      <td align="middle" width="35%" bgColor="#40a0e0"><b><font face="Arial" color="#000000" size="2">Forum:&nbsp;</font><font face="Arial" color="#800080" size="2"><%=forumname%></font></b></td>
      <td align="middle" width="30%" bgColor="#40a0e0"><b><font face="Arial" color="#000000" size="2">School:&nbsp;</font><font face="Arial" color="#800080" size="2"><%=schoolid%></font></b></td>
      <td align="middle" width="35%" bgColor="#40a0e0">&nbsp;</td>
    </tr>

</table>

<table borderColor="#ffffff" cellSpacing="0" cellPadding="0" width="100%" align="center" border="1">
<%
try{
	con = con1.getConnection();
	st = con.createStatement();
	rs = st.executeQuery("select user_id,message,trans_date from forum_post_topic_reply where school_id='"+schoolid+"' and forum_id='"+forumid+"' and trans_type='3'");
	while(rs.next()){
		suguser = rs.getString(1);
		message = rs.getString(2);
		date = rs.getDate(3);
		flag=true;
		int yy=date.getYear()+1900;
		int mn=date.getMonth()+1;
		int dd=date.getDate();
%>

    <tr>
      <td vAlign="center" align="middle" width="25%" bgColor="#40a0e0"><b><font face="Arial" color="#000000" size="2">Suggested by</font></b></td>
      <td vAlign="center" width="75%" bgColor="#40a0e0"><b><font face="Arial" color="#000000" size="2">Suggestion</font></b></td>
    </tr>
    <tr>
      <td vAlign="center" align="middle" width="25%" bgColor="#a8b8d0"><b><font face="Arial" size="2"><%=suguser%></font></b></td>
      <td width="588" bgColor="#a8b8d0"><font face="Arial"><font face="Arial, Arial" color="#800080" size="1">Suggested
        on:&nbsp;<%=month[mn]+"&nbsp;"+dd+","+yy%>&nbsp;&nbsp;</font>
        <hr>
        <font face="Arial" size="2"><%=message%></font></font></td>
    </tr>
<%
	}
	if(flag==false)
		out.println("<tr><td align=\"center\" width=\"100%\" bgColor=\"#40a0e0\"><b><font face=\"Arial\" color=\"#000000\" size=\"2\"><-- No Suggestions Available --></font></b></td></tr>");
}
catch(Exception e){
	ExceptionsFile.postException("ShowSuggestions.jsp","operations on database","Exception",e.getMessage());
	out.println("Exception occured is "+e);
}
finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("ShowSuggestion.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
		

   }



%>

</table>

</body>

</html>
