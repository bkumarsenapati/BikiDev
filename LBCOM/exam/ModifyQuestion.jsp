<HTML>
<%@ page import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
    Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String qId=null,qType=null,qBody=null,schoolId=null,classId=null,courseId=null,pathname=null,topicid=null,subtopicid=null;
	
%>
<%
		
	try
	{
		schoolId = request.getParameter("schoolid");
		classId = request.getParameter("classid");
		courseId = request.getParameter("courseid");
		qType = request.getParameter("q_type");
		qId = request.getParameter("q_id");

		con=con1.getConnection();
		st=con.createStatement();
	
		rs=st.executeQuery("select * from "+schoolId+"_"+classId+"_"+courseId+"_quesbody where q_type='"+qType+"'&q_id='"+qId+"'");
		if(rs.next())
		{
			qBody=rs.getString("q_body");
			System.out.println("qBody is..."+qBody);
			
		}
	
		
	}
	catch(Exception e)
	{
		System.out.println("Exception iin ModifyQuestion.jsp is..."+e);
		ExceptionsFile.postException("ModifyQuestion.jsp","Operations on database","Exception",e.getMessage());
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();			//finally close the statement object
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("ModifyQuestion.jsp","closing connection object","SQLException",se.getMessage());
			System.out.println("Exception in TakeAssignment.jsp is..."+se.getMessage());
		}
	}
%>

<head><title></title>
</head>
<SCRIPT LANGUAGE="JavaScript" src="../teacher/validationscripts.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" src="/LBCOM/validationscripts.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
var flag;
  

</SCRIPT>

<BODY topmargin="3" leftmargin="3" bgcolor="#EBF3FB">
<form name="sub" method="post" action="http://192.168.0.7:8080/LBCOM/qeditor/q_fill_blanks.jsp?qid=<%=qId%>&qtype=<%=qType%>&schoolid=<%=schoolId%>&classid=<%=classId%>&courseid=<%=courseId%>&topicid=<%=topicid%>&subtopicid=<%=subtopicid%>&pathname=<%=pathname%>">


<hr>
<center>
<table border="0" cellpadding="0" cellspacing="0" bordercolor="#111111" width="70%">
  <tr>
    <td width="100%" height="28" bgcolor="#C0C0C0"><b>
    <font face="Verdana" size="2" color="#003399">&nbsp;Submit Question</font></b></td>
  </tr>
  <tr>
    <td width="100%" height="12">&nbsp;</td>
  </tr>
  
</table>

<br>

<table border="1" cellspacing="1" width="70%">
  <tr>
    <td width="40%" height="11" align="right"><font face="Verdana" size="2">Enter Points :</font></td>
    <td width="60%" height="30">
		<input type="text" name="qbody" size="150">
		<font face="verdana" size="1" color="brown"></font>
  </tr>
  
  <tr>
    <td width="40%" height="19">&nbsp;</td>
    <td width="60%" height="19">&nbsp;</td>
  </tr>
  <tr>
	<td width="100%" colspan="2" align="center">
		<input type="submit" value="PROCEED">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="reset" value="CANCEL">
	</td>
  </tr>
</table>
</center>
</form>
</BODY>
</HTML>
