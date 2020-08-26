<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<html>
<head><title></title>
<script language="javascript" src="../validationscripts.js"></script>
<script language = javascript>
function Validate(){
if((document.PostNewTopic.topic.value=="") || (document.PostNewTopic.message.value=="") || (document.PostNewTopic.dir.value=="noval")){
alert("Please dont Leave any field Blank!");return false;}  replacequotes(); return true;}</script>
</head>
<body bgColor="#FFFFFF" topmargin="0" leftmargin="0">
<%@  page language="java"  import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<%  String user="";
     Connection con=null;
     ResultSet rs=null,rs1=null;
     Statement st=null;
     String dir="",type=" ",mode="",topic="",schoolid="",emailid="",forumid="",message="";
	 String sno="",main="";
%>
<% 
	try{
		con = con1.getConnection();
		st=con.createStatement();
		forumid=request.getParameter("fid");
		schoolid=(String)session.getAttribute("schoolid");
		emailid = (String)session.getAttribute("adminid");
		topic=request.getParameter("tid");
		message=request.getParameter("message");
		mode=request.getParameter("mode");
		main=request.getParameter("main");
		if(main==null||main.equals(""))
			main="no";
		else
			main=main;

		if(mode==null||mode.equals(""))
		{
			mode="";
		}
		else
		{
			mode=mode;
			sno=request.getParameter("sno");
		}
		user = emailid;
		dir = request.getParameter("fname");
		if(dir==null||dir.equals(""))
			dir="select";
		else
			dir=dir;
	}
    catch(Exception ex){
		ExceptionsFile.postException("PostNewTopic.jsp","reading parameters","Exception",ex.getMessage());
		out.println(ex+" its first");
	}
%>
<!--<form action="../teacherAdmin/AcceptTopic.jsp?emailid=<%=emailid%>&schoolid=<%=schoolid%>&dir=<%= dir %>" method="post" name="PostNewTopic" onsubmit="return Validate();">-->
<form name="newtopicform" action="/LBCOM/forums.SaveForum?sno=<%=sno%>&sid=<%=schoolid%>&fid=<%=forumid%>&fname=<%=dir%>&type=1&mode=<%=mode%>&main=<%=main%>" method="post" name="PostNewTopic" onsubmit="return Validate();">
<table align=center border="0" cellPadding="0" cellSpacing="0" width="100%">
    <tr>
      <td bgColor="#F0E0A0" align=left width="100%"><font color="#000000" face="Arial" size="2"><a href="ShowDirTopics.jsp?emailid=<%= user %>&schoolid=<%= schoolid %>" style="COLOR: #000000; TEXT-DECORATION: none"><b>Forums&nbsp;</b></a></font></td>
 <!--    <td bgColor="#F0E0A0" align=right width="25%"><font color="#000000" face="Arial" size="2"><a href="../teacherAdmin/ShowTopics.jsp?emailid=<%=user%>&schoolid=<%=schoolid%>&dir=<%= dir %>" style="COLOR: #000000; TEXT-DECORATION: none"><b>Back</b></a></font></td>-->
    </tr>
  </table>
  <table align=center border="0" cellPadding="0" cellSpacing="0" width="100%">
    <tr> 
      <td bgColor="#FFFFFF" vAlign="top" width="20%"><font color="#800000" face="Arial" size="2"><b>Note</b></font></td>
      <td bgColor="#FFFFFF" vAlign="top" width="80%"><font color="#800000" face="Arial" size="2"> 
        <!--<li>Would you like to reply or add your comments?</li>-->
        <li>Authorized users can post a reply to this topic.</li>
        <li>All comments are monitored for appropriateness.</li>
        </font></td>
    </tr>
<!--    <tr> 
      <td bgColor="#F0E0A0">&nbsp;</td>
      <td bgColor="#F0E0A0">&nbsp;</td>
    </tr>-->
    <tr> 
      <td bgColor="#F0E0A0"><b><font color="#000000" face="Arial" size="2">User 
        Name:</font></b></td>
      <td bgColor="#F0E0A0"><font color="#000000" face="Arial" size="2"><b><%= emailid %></b></font></td>
    </tr>
    <tr> 
      <td bgColor="#F0E0A0" noWrap><b><font color="#000000" face="Arial" size="2">Forum:</font></b></td>
	  <td bgColor="#F0E0A0">
	  <select id="forumname" name="forumname">
	  <option value="none" selected>Select forum category</option>
 <%
  try
  {
	  System.out.println("select * from forum_master where school_id='"+schoolid+"' and status='1' order by forum_id");
	 
      rs=st.executeQuery("select * from forum_master where school_id='"+schoolid+"' and status='1' order by forum_id");
	  while(rs.next())
	  {
		   out.println("<option value='"+rs.getString("forum_id")+"'>"+rs.getString("forum_name")+"</option>");
		
	  }
  }
  catch(Exception e)
  {
		ExceptionsFile.postException("PostNewTopic.jsp","operations on resultset","Exception",e.getMessage());
		System.out.println("Exception in EditAssignemt.jsp 2 is..."+e);
  }
  finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("PostNewTopic.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("Exception in PostNewTopic.jsppp iss..."+se.getMessage());
		}

    }
	  %>
	  </select>
		
	  <!-- <td bgColor="#F0E0A0"> 
	       <b><font color="#000000" face="Arial" size="2"><%=dir%></font></b> -->
      </td>
    </tr>
    <tr> 
      <td bgColor="#F0E0A0" noWrap><b><font color="#000000" face="Arial" size="2">Topic:</font></b></td>
      <td bgColor="#F0E0A0">
	  <%
	  if(mode.equals("edit"))
	  {
	  %>
        <input maxLength="85" name="topic" size="53"  oncontextmenu="return false" value="<%=topic%>">
		<%
	  }
	  else
	  {
	  %>
	   <input maxLength="85" name="topic" size="53"  oncontextmenu="return false">
	   <%
	  }
	   %>
      </td>
    </tr>
    <tr> 
      <td bgColor="#F0E0A0" noWrap vAlign="top"><b><font color="#000000" face="Arial" size="2">Message:</font></b> 
      <td bgColor="#F0E0A0"> 
        <textarea cols="45" name="message" rows="10" wrap="VIRTUAL"></textarea>
      </td>
    </tr>
    <tr> 
      <td bgColor="#F0E0A0">&nbsp;</td>
      <td bgColor="#F0E0A0">&nbsp;</td>
    </tr>
    <tr> 
      <td bgColor="#F0E0A0">
        <div align="right">
          &nbsp;
        </div>
      </td>
      <td bgColor="#F0E0A0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="submit" value="Submit"><input type="reset" value="Clear"></td>
    </tr>
   	<tr> 
      <td bgColor="#F0B850" colspan=2 vAlign="top">&nbsp;</td>
    </tr>
  </table>
  <input type='hidden' name="forumname" value="<%=forumid%>">
  </form>
</body>
</html>
