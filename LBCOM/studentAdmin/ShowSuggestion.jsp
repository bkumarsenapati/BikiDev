<html>

<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<title></title>
</head>

<body>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%@  page language="java"  import="java.sql.*,java.util.*,java.lang.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%!
	String month[]={" ","Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Nov","Dec"};
%>
<% 
String forumid=null,forumname=null,schoolid=null,emailid=null,suguser=null,message=null;
Connection con=null;
ResultSet rs=null;
Statement st=null;
boolean flag=false;
java.util.Date date=null;

%>
<%
forumid = request.getParameter("fid");
forumname = request.getParameter("fname");
emailid = (String)session.getAttribute("emailid");
schoolid =(String)session.getAttribute("schoolid");
%>
<table border="0" cellPadding="0" cellSpacing="0" width="100%" align=center>
    <tr>
      <td align="middle" width="35%" bgColor="#d0c0a0"><font face="Arial" color="#000000" size="2"><b><a style="COLOR: #000000; TEXT-DECORATION: none" href="/LBCOM/studentAdmin/ShowDirTopics.jsp?emailid=<%=emailid%>&amp;schoolid=<%=schoolid%>">Bulletin
        Boards</a></b></font></td>
      <td align="middle" width="30%" bgColor="#d0c0a0"><b><font face="Arial" color="#000000" size="2"><a style="COLOR: #000000; TEXT-DECORATION: none" href="/LBCOM/studentAdmin/PostNewTopic.jsp?fid=<%=forumid%>&amp;fname=<%=forumname%>">Post
        New Topic</a></font></b></td>
      <td align="middle" width="35%" bgColor="#d0c0a0"><b><font face="Arial" color="#000080" size="2" align="right"><a style="COLOR: #000080; TEXT-DECORATION: none" href="/LBCOM/studentAdmin/ShowDirTopics.jsp?emailid=<%=emailid%>&amp;schoolid=<%=schoolid%>"><font face="Arial, Arial, Helvetica, sans-serif" color="#000000">Back</font></a></font></b></td>
    </tr>
    <tr>
      <td align="middle" width="35%" bgColor="#e08040"><b><font face="Arial" color="#000000" size="2">Forum:&nbsp;</font><font face="Arial" color="#800080" size="2"><%=forumname%></font></b></td>
      <td align="middle" width="30%" bgColor="#e08040"><b><font face="Arial" color="#000000" size="2">School:&nbsp;</font><font face="Arial" color="#800080" size="2"><%=schoolid%></font></b></td>
      <td align="middle" width="35%" bgColor="#e08040">&nbsp;</td>
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
      <td vAlign="center" align="middle" width="25%" bgColor="#e08040"><b><font face="Arial" color="#000000" size="2">Suggested by</font></b></td>
      <td vAlign="center" width="75%" bgColor="#e08040"><b><font face="Arial" color="#000000" size="2">Suggestion</font></b></td>
    </tr>
    <tr>
      <td vAlign="center" align="middle" width="25%" bgColor="#d0c0a0"><b><font face="Arial" size="2"><%=suguser%></font></b></td>
      <td width="588" bgColor="#d0c0a0"><font face="Arial"><font face="Arial, Arial" color="#800080" size="1">Suggested
        on:&nbsp;<%=month[mn]+"&nbsp;"+dd+","+yy%>&nbsp;&nbsp;</font>
        <hr>
        <font face="Arial" size="2"><%=message%></font></font></td>
    </tr>
<%
	}
	if(flag==false)
		out.println("<tr><td width='100%' bgcolor='#e7e7e7' align='center'><font face=\"Arial\" color=\"#000000\" size=\"2\"><b><-- No Suggestions Available --></td></tr><tr><td align=\"center\" width=\"100%\" bgColor=\"#e08040\">&nbsp;</font></b></td></tr>");
}
catch(Exception ex){
	ExceptionsFile.postException("ShowSuggestion.jsp","operations on database","Exception",ex.getMessage());
	out.println("Exception occured is "+ex);
}finally{
			try{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed()){
				   con.close();
				}

			}catch(Exception e){
				ExceptionsFile.postException("studnetReg.jsp","Closing the  connection object ","Exception",e.getMessage());
			}
		}
%>

</table>

</body>

</html>
