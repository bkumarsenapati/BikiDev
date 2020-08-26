<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,common.*" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
    
	String courseId="",courseName="",assgnContent="",cat="",assgnName="",workId="";
	String schoolId="",classId="",studentId="";
	int totMarks=0,assgNo=0,submitCount=0;

	try
	{
		session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		con=con1.getConnection();
		st=con.createStatement();
		schoolId=(String)session.getAttribute("schoolid");
		courseId=(String)session.getAttribute("courseid");
		classId=(String)session.getAttribute("classid");
		studentId=(String)session.getAttribute("emailid");
		//workId=request.getParameter("workid");

		rs=st.executeQuery("select * from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and submit_count="+submitCount+"");
		
		if(rs.next())
		{
			assgnContent=rs.getString("answerscript");
		}


%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>ASSIGNMENT INFO</title>
<script language="JavaScript" type="text/javascript" src="wysiwyg/assgnwysiwyg.js"></script> 

</head>
<body>
<form>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<div align="center">
  <center>
  
  </center>
</div>
<div align="center">
  <center>
  <table border="0" cellspacing="1" width="80%" id="AutoNumber1" height="524">
    <tr>
      <td width="73%" bgcolor="#FFFFFF" height="25" colspan="2">
      <hr color="#C0C0C0" size="1"></td>
    </tr>
    <tr>
      <td width="28%" bgcolor="#7C7C7C" height="25"><b>
      <font face="Verdana" size="2" color="#FFFFFF">&nbsp;WORK FILE</font><font face="Verdana" size="2" color="#000080">
      </font></b></td>
      <td width="45%" bgcolor="#7C7C7C" height="25">
      <p align="right"><b><font face="Verdana" size="1" color="#FFFFFF">
      <a href="javascript:self.close();"><font color="#FFFFFF"></font></a>&nbsp; </font></b></td>
    </tr>
   <tr>
      <td width="73%" colspan="2" height="28" bgcolor="#C0C0C0" align="center">
      <p align="left"><font face="Verdana" size="2">&nbsp;Assignment:</font></td>
    </tr>
    <tr>
      <td width="73%" colspan="2" height="388" bgcolor="#EBEBEB">&nbsp;<%=assgnContent%>
	</td>
    </tr>
    <tr>
      <td width="73%" colspan="2" height="27" bgcolor="#C0C0C0">&nbsp;</td>
    </tr>
    <tr>
      <td width="73%" colspan="2" height="27" bgcolor="#7C7C7C">
      <p align="center">
			<a href="javascript:self.close();"><font color="#FFFFFF">CLOSE</font></a></td>
    </tr>
    
  </table>
  </center>
</div>
&nbsp;</p>
      </form>
      <p>&nbsp;
<%
	}
	catch(SQLException se)
	{
		System.out.println("The exception1 in AssignmentResult.jsp is....."+se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in AssignmentResult.jsp is....."+e);
	}
	finally{
	try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
	}catch(SQLException se){
			ExceptionsFile.postException("AssignmentResult.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("The exception2222222 in AssignmentResult.jsp is....."+se.getMessage());
	}

}
%>
</body>

</html>