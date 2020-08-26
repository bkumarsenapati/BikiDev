<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,common.*" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
    
	String schoolId="",courseId="",studentId="",attachments="",questionId="",qBody="",ansStr="",id="";

	try
	{
		con=con1.getConnection();
		st=con.createStatement();

		schoolId=(String)session.getAttribute("schoolid");
		
		courseId=request.getParameter("courseid");
		studentId=request.getParameter("studentid");
		questionId=request.getParameter("questionid");
			
		rs=st.executeQuery("select answer_text from pretest_attachments where school_id='"+schoolId+"' and course_id='"+courseId+"' and student_id='"+studentId+"' and question_id='"+questionId+"'");
		
		if(rs.next())
		{
			attachments=rs.getString("answer_text");
			attachments=attachments.replaceAll("&#39;","\'");
			attachments=attachments.replaceAll("&#34;","\"");
		}
		if(attachments ==null || attachments .equals("null"))
		{
			attachments ="";
		}

		rs=st.executeQuery("select question_body from pretest where school_id='"+schoolId+"' and course_id='"+courseId+"' and question_id='"+questionId+"'");
		if(rs.next())
		{
			qBody=rs.getString("question_body");
			qBody=qBody.replaceAll("&#39;","\'");
			qBody=qBody.replaceAll("&#34;","\"");
		}

		ansStr=questionId+"_seq ANSWER IS:::";

		//StringTokenizer asgnTokens=new StringTokenizer(attachments,"&&&&&");

		//while(asgnTokens.hasMoreTokens())
		//{
			//id=asgnTokens.nextToken();
		//	out.println("id is..."+id);

			//if(ansStr.indexOf(id)!=-1)
			//{
			//	break;
			//}
		//	out.println("<br>");
		//}
	//	out.println(ansStr);
		
		if(qBody.indexOf(ansStr)!=-1)
			ansStr="yes";		
	//	out.println(ansStr); 
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Pretest Answer View</title>
<script language="JavaScript" type="text/javascript" src="wysiwyg/assgnwysiwyg.js"></script>
<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>
</head>
<body>
<div align="center">
<table border="1" cellspacing="1" width="80%" bordercolorlight="#838341" height="460">
<tr>
	<td width="100%" bgcolor="#36361B" height="25">
		<b><font face="Verdana" size="2" color="#FFFFFF">&nbsp;Short or Essay Question</font></b>
	</td>
</tr>
<tr>
	<td width="100%" bgcolor="red"><font face="Verdana" size="2" color="white">&nbsp;<%=qBody%></font></td>
</tr>
<tr>
	<td width="100%" height="1" bgcolor="#EBEBD6" align="center">&nbsp;</td>
</tr>
<tr>
	<td width="100%" height="385" bgcolor="#EBEBEB" valign="top">&nbsp;<%=attachments%></td>
</tr>
<tr>
	<td width="100%" height="24" bgcolor="#36361B" align="center">
		<a href="javascript:self.close();"><font color="#FFFFFF" face="Verdana" size="2"><b>CLOSE</b></font></a>
	</td>
</tr>
</table>
</div>

<%
}
	catch(SQLException se)
	{
		System.out.println("The exception1 in ViewSEQAnswer.jsp is....."+se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in ViewSEQAnswer.jsp is....."+e);
	}	

	finally{
		try{
			if(st!=null)
				st.close();
			if(rs!=null)
				rs.close();
			if(con!=null && !con.isClosed())
				con.close();
			}
			catch(SQLException se){
			ExceptionsFile.postException("ViewSEQAnswer.jsp","closing the statement objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
%>
</body>
</html>