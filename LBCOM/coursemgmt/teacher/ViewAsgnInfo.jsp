<%@ page import="java.sql.*,utility.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
Connection con=null;
Statement st=null,st1=null;
ResultSet rs=null,rs1=null;
String classId="",courseId="",workId="",schoolId="",sessId="",maxAttempts="",markScheme="",attachFile="";
String topicd="",subtopicd="",topic_desc="",subtopic_desc="",teacherId="",to_date="";
%>
<%
	try
	{
		session=request.getSession();
		sessId=(String)session.getAttribute("sessid");
		if(sessId==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}

		schoolId=(String)session.getAttribute("schoolid");
		classId=(String)session.getAttribute("classid");
		courseId=(String)session.getAttribute("courseid");
		teacherId = (String)session.getAttribute("emailid");
		workId=request.getParameter("workid");
				
		con=con1.getConnection();
		st=con.createStatement();

		rs=st.executeQuery("select last_date from coursewareinfo where course_id='"+courseId+"' and school_id='"+schoolId+"' and teacher_id='"+teacherId+"'");
		if(rs.next())
			to_date=rs.getString("last_date");
		rs.close();

		rs=st.executeQuery("select * from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id='"+workId+"'");
		if(rs.next())
		{
			maxAttempts=rs.getString("max_attempts");
			if(maxAttempts.equals("-1"))
				maxAttempts="No Limit";
			markScheme=rs.getString("mark_scheme");
			if(markScheme.equals("0"))
				markScheme="Best Submission";
			else if(markScheme.equals("1"))
				markScheme="Latest Submission";
			else
				markScheme="Average Submission";
			attachFile=rs.getString("attachments");
			if(attachFile.equals("null") || attachFile==null)
				attachFile="";
			
			topicd=rs.getString("topic");
			if(!topicd.equals(null))
			{
				
				st1=con.createStatement();
				rs1=st1.executeQuery("select topic_des from topic_master where course_id='"+courseId+"' and topic_id='"+topicd+"'");
				if(rs1.next())
					topic_desc=rs1.getString("topic_des");
			}
			rs1.close();
			
			subtopicd=rs.getString("subtopic");
			if(!subtopicd.equals(null))
			{
				
				st1=con.createStatement();
				rs1=st1.executeQuery("select subtopic_des from subtopic_master where course_id='"+courseId+"' and subtopic_id='"+subtopicd+"'");
				if(rs1.next())
					subtopic_desc=rs1.getString("subtopic_des");
			}
			rs1.close();
%>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title></title>
</head>
<body>
<center>
<table border="0" cellspacing="1" width="60%" id="AutoNumber1" height="368">
  <tr>
    <td width="54%" colspan="2" bgcolor="#808080" height="28"><b>
    <font face="Verdana" size="2" color="#FFFFFF">&nbsp;Assignment Information :</font></b></td>
  </tr>
  <tr>
    <td width="21%" height="19">&nbsp;</td>
    <td width="33%" height="19">&nbsp;</td>
  </tr>
  <tr>
    <td width="21%" bgcolor="#C0C0C0" height="19" align="right">
		<font face="Verdana" size="2">&nbsp;Assignment Name :&nbsp;</font></td>
    <td width="33%" bgcolor="#F2F2F2" height="19">
		<font face="Verdana" size="2">&nbsp;<%=rs.getString("doc_name")%></font></td>
  </tr>
  <tr>
    <td width="21%" bgcolor="#C0C0C0" height="19" align="right">
		<font face="Verdana" size="2">&nbsp;Category :</font></td>
    <td width="33%" bgcolor="#F2F2F2" height="19">
		<font face="Verdana" size="2">&nbsp;<%=rs.getString("category_id")%></font></td>
  </tr>
  <tr>
    <td width="21%" bgcolor="#C0C0C0" height="19" align="right">
		<font face="Verdana" size="2">&nbsp;Topic :</font></td>
    <td width="33%" bgcolor="#F2F2F2" height="19">
		<font face="Verdana" size="2">&nbsp;<%=topic_desc%></font></td>
  </tr>
  <tr>
    <td width="21%" bgcolor="#C0C0C0" height="19" align="right">
		<font face="Verdana" size="2">&nbsp;Subtopic :</font></td>
    <td width="33%" bgcolor="#F2F2F2" height="19">
		<font face="Verdana" size="2">&nbsp;<%=subtopic_desc%></font></td>
  </tr>
  <tr>
    <td width="21%" bgcolor="#C0C0C0" height="19" align="right">
		<font face="Verdana" size="2">&nbsp;Max. Points :</font></td>
    <td width="33%" bgcolor="#F2F2F2" height="19">
		<font face="Verdana" size="2">&nbsp;<%=rs.getString("marks_total")%></font></td>
  </tr>
  <tr>
    <td width="21%" bgcolor="#C0C0C0" height="19" align="right">
		<font face="Verdana" size="2">&nbsp;No. of Attempts :</font></td>
    <td width="33%" bgcolor="#F2F2F2" height="19">
		<font face="Verdana" size="2">&nbsp;<%=maxAttempts%></font></td>
  </tr>
  <tr>
    <td width="21%" bgcolor="#C0C0C0" height="19" align="right">
		<font face="Verdana" size="2">&nbsp;Marking Scheme :</font></td>
    <td width="33%" bgcolor="#F2F2F2" height="19">
		<font face="Verdana" size="2">&nbsp;<%=markScheme%></font></td>
  </tr>
  <tr>
    <td width="21%" bgcolor="#C0C0C0" height="19" align="right">
		<font face="Verdana" size="2">&nbsp;Start Date :</font></td>
    <td width="33%" bgcolor="#F2F2F2" height="19">
		<font face="Verdana" size="2">&nbsp;<%=rs.getString("from_date")%></font></td>
  </tr>
  <tr>
    <td width="21%" bgcolor="#C0C0C0" height="19" align="right">
		<font face="Verdana" size="2">&nbsp;Due Date :</font></td>
    <td width="33%" bgcolor="#F2F2F2" height="19">
		<font face="Verdana" size="2">&nbsp;<%=to_date%></font></td>
  </tr>
  <tr>
    <td width="21%" bgcolor="#C0C0C0" height="19" align="right">
		<font face="Verdana" size="2">&nbsp;Attachments :</font></td>
    <td width="33%" bgcolor="#F2F2F2" height="19">
		<font face="Verdana" size="2">&nbsp;<%=attachFile.substring(attachFile.indexOf('_')+1,attachFile.length())%></font></td>
  </tr>
  <tr>
    <td width="21%" bgcolor="#C0C0C0" height="19" align="right"><font face="Verdana" size="2">&nbsp;Instructions 
    :</font></td>
    <td width="33%" bgcolor="#F2F2F2" height="19"><font face="Verdana" size="2">&nbsp;<%=rs.getString("instructions")%></font></td>
  </tr>
  <tr>
    <td width="21%" height="19">&nbsp;</td>
    <td width="33%" height="19">&nbsp;</td>
  </tr>
  <tr>
    <td width="54%" colspan="2" bgcolor="#808080" height="26" align="center">
		<a href="#" onclick="javascript:window.close(-1);"><font face="Verdana" size="2" color="#FFFFFF"><b>CLOSE</b></font></a>
	</td>
  </tr>
</table>
</center>
</body>
</html>

<%
		}
	}
	catch(Exception e)
	{
		System.out.println("Exception in ViewAsgnInfo.jsp is..."+e);
	}
	finally
{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("ViewAsgnInfo.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}

    }
	
%>