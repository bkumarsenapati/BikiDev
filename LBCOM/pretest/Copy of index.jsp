<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<html>
<head>
<title></title>
</head>
<body>
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String questionCount="",questionId="",questionBody="";
	int i=0;

	try
	{
		con=con1.getConnection();
		st=con.createStatement();

		String id = UUID.randomUUID().toString();  
		//System.out.println(id);  

		rs=st.executeQuery("select count(*) from pretest where course_id='DC023'");
		if(rs.next())
			questionCount=rs.getString(1);

		rs=st.executeQuery("select * from pretest where course_id='DC023' ORDER BY question_id");
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>PRETEST</title>
</head>

<body>
<form method="POST" action="--WEBBOT-SELF--">
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
  <tr>
    <td width="25%"><font face="Verdana" size="2">&nbsp;<font color="#934900"><b>PRETEST</b></font></font></td>
    <td width="25%" align="center">&nbsp;<%=System.currentTimeMillis()%></td>
    <td width="25%" align="center">&nbsp;UUID id is...<%=id%></td>
    <td width="25%" align="center">&nbsp;</td>
  </tr>
  <tr>
    <td width="25%" align="center">&nbsp;</td>
    <td width="25%" align="center">&nbsp;</td>
    <td width="25%" align="center">&nbsp;</td>
    <td width="25%" align="center">&nbsp;</td>
  </tr>
</table>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
  <tr>
    <td width="24%"><font color="#934900"><font face="Verdana" size="1">&lt;&lt; </font><font face="Verdana" size="2">Prev</font></font></td>
    <td width="49%">
    <p align="center"><font face="Verdana" size="2" color="#934900">1 - <%=questionCount%> Questions of <%=questionCount%></font></td>
    <td width="18%" align="center">
		<a href="CreateQuestion.jsp" style="text-decoration: none">
		<font face="Verdana" size="1">ADD QUESTION</font></a>&nbsp;&nbsp;&nbsp;
		<font face="Verdana" size="1"><a href="QuestionMapping.jsp" style="text-decoration: none">MAP</a></font>
	</td>
    <td width="9%">
    <p align="right"><font color="#934900"><font face="Verdana" size="2">Next </font><font face="Verdana" size="1">&gt;&gt;</font></font></td>
  </tr>
</table>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
  <tr>
    <td width="2%" align="center" bgcolor="#934900">&nbsp;</td>
    <td width="2%" align="center" bgcolor="#934900">&nbsp;</td>
    <td width="2%" align="center" bgcolor="#934900">&nbsp;</td>
    <td width="2%" align="center" bgcolor="#934900">
    <font face="Verdana" size="1" color="#FFFFFF">D</font></td>
    <td width="2%" align="center" bgcolor="#934900">
    <font face="Verdana" size="1" color="#FFFFFF">I</font></td>
    <td width="60%" bgcolor="#934900"><b>
    <font face="Verdana" size="2" color="#FFFFFF">&nbsp;Title of the Question</font></b></td>
    <td width="17%" align="center" bgcolor="#934900"><b>
    <font face="Verdana" size="2" color="#FFFFFF">Question Type</font></b></td>
  </tr>

<%
		while(rs.next())
		{
			questionId=rs.getString("question_id");
			i++;
			questionBody=rs.getString("question_body");
			if(questionBody.length() > 50)
				questionBody=questionBody.substring(0,80)+".......";
%>

  <tr>
    <td width="2%" align="center"><font face="Verdana" size="1"><b><input type="checkbox" name="C1" value="ON"></b></font></td>
    <td width="2%" align="center"><font face="Verdana" size="1"><%=i%></font></td>
    <td width="2%" align="center"><font size="1" face="Verdana">E</font></td>
    <td width="2%" align="center"><font size="1" face="Verdana">D</font></td>
    <td width="2%" align="center"><font size="1" face="Verdana">I</font></td>
    <td width="60%"><font face="Verdana" size="2">&nbsp;<%=questionBody%></font></td>
    <td width="17%" align="center"><font face="Verdana" size="2"><%=rs.getString("question_type")%></font></td>
  </tr>
<%
		}	  
		if(Integer.parseInt(questionCount) == 0)
		{
%>
  <tr>
    <td width="100%" colspan="7">
		<font face="Verdana" size="1">There are no questions in the pretest.</font>
	</td>
  </tr>
<%
		}
	}
  	catch(SQLException se)
	{
		System.out.println("Error in index.jsp : pretest : SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("Error:  in index.jsp : pretest -" + e.getMessage());
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			System.out.println("Error:  in finally of index.jsp : pretest -"+se.getMessage());
		}
	}
%>
 
</table>
</form>
</body>
</html>