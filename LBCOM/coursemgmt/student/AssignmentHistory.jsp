<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,common.*" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null,rs1=null;
	Statement st=null,st1=null;
    
	String courseId="",courseName="",assgnContent="",cat="",assgnName="",workId="";
	String schoolId="",classId="",studentId="",docName="",temp="",date="",attachFile="",categoryId="";
	int totMarks=0,assgNo=0,submitCount=0,maxAttempts=0;

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
		st1=con.createStatement();
		schoolId=(String)session.getAttribute("schoolid");
		courseId=(String)session.getAttribute("courseid");
		classId=(String)session.getAttribute("classid");
		studentId=(String)session.getAttribute("emailid");
		workId=request.getParameter("workid");
		
		submitCount=Integer.parseInt(request.getParameter("submit_count"));
		rs1=st1.executeQuery("select * from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id='"+workId+"'");
		if(rs1.next())
		{
			maxAttempts=rs1.getInt("max_attempts");
			if(maxAttempts!=-1)
				temp=Integer.toString(maxAttempts);
			else
				temp="No Limit";
			docName=rs1.getString("doc_name");
			categoryId=rs1.getString("category_id");
		}

		rs=st.executeQuery("select * from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and submit_count="+submitCount+" and student_id='"+studentId+"'");
		if(rs.next())
		{
			assgnContent=rs.getString("answerscript");
			assgnContent=assgnContent.replaceAll("<A href","<A target =\"_blank\" href");
			date=rs.getString("eval_date");
			if(date==null)
				date="0000-00-00";
			if(date.equals("0000-00-00"))
				date="Not Evaluated";
			attachFile=rs.getString("stuattachments");
			
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
<script language="javascript">

	function showattachments(subfile,cat)
	{
		alert(subfile);
		window.open("<%=(String)session.getAttribute("schoolpath")%><%=schoolId%>/<%=studentId%>/coursemgmt/<%=courseId%>/"+cat+"/"+subfile,"Document","width=750,height=600,scrollbars");

	}
</script>
</head>
<body>
<form>
<table border="1" cellpadding="0" cellspacing="0" width="100%" bordercolor="#FFFFFF">
  <center>
  <tr>
	
	<td bgcolor="#546878" height="19">
		<font color="#FFFFFF" face="Verdana" size="2"><b>&nbsp;Submission No.:<%=submitCount%>/<%=temp%>&nbsp;</b></font>
	</td>
	<!-- <td bgcolor="#546878" height="19" align="center">
		<a href="javascript:window.print();">
			<font face="verdana" color="#FFFFFF" align="left" size="2"><b>Print</b></font>
		</a>
		
	</td> -->

	<td bgcolor="#546878" height="19" align="right">
		&nbsp;<a href="javascript:history.back();">
			<font face="verdana" color="#FFFFFF" align="right" size="2"><b>BACK TO SUBMISSION HISTORY</b></font>
		</a></td>

</tr>
<table border="1" cellpadding="0" cellspacing="0" width="100%" bordercolor="#FFFFFF">
<tr>
	
  	<td width="20%" bgColor="#dbd9d5" align="center" height="16">
		<font face="Verdana" color="#000080" size="2">&nbsp;<b>Submission Date</b></font>
	</td>
    <td width="20%" bgColor="#dbd9d5" align="center" height="16">
		<font face="Verdana" color="#000080" size="2"><b>Evaluation Date</b></font>
	</td>
    <td width="10%" bgColor="#dbd9d5" align="center" height="16">
		<font face="Verdana" color="#000080" size="2"><b>Points</b></font>
	</td>
   
</tr>
<tr>
	<td width="33%" bgcolor="#7D8C98" align="center" height="21">
		<font color="#FFFFFF" face="Verdana" size="2">&nbsp;<%=rs.getString("submitted_date")%></font>
	</td>
	<td bgColor="#7D8C98" align="center" height="16">
		<font face="Verdana" color="#FFFFFF" size="2">&nbsp;<%=date%></font>
	</td>
	<td width="33%" bgcolor="#7D8C98" align="center" height="21">
		<font face="verdana" color="#FFFFFF" size="2"><b>&nbsp;<%=rs.getString("marks_secured")%>/<%=rs1.getFloat("marks_total")%></b></b></font>
	</td>
</tr>
</table>
  <table border="0" cellspacing="1" width="80%" id="AutoNumber1" height="524">
    <tr>
      <td width="73%" bgcolor="#FFFFFF" height="10" colspan="2">
      <hr color="#C0C0C0" size="1">
<%
	if(attachFile.equals("") || attachFile==null || attachFile.equals("null"))
	{
		
%>		<font face="Verdana" size="2" color="#546878">There is no attachment for this assignment.</font>
<%		
	}
	else
	{				
%>
		<a href="javascript:showattachments('<%=attachFile.replaceAll("&#39;","&#92;&#39;")%>','<%=categoryId%>');"><font face="Verdana" size="2" color="#546878"><b>Attached file for this assignment</b></font>
<%		
	}
%>  
	  </td>
    </tr>
    
   <tr>
      <td width="73%" colspan="2" height="28" bgcolor="#546878" align="center">
      <p align="center"><font face="Verdana" color="#FFFFFF" size="2">&nbsp;<%=docName%></font></td>
    </tr>
    <tr>
      <td width="73%" colspan="2" height="388" bgcolor="#EBEBEB">&nbsp;<%=assgnContent%>
	</td>
    </tr>
    <tr>
      <td width="73%" colspan="2" height="27" bgcolor="#C0C0C0">&nbsp;</td>
    </tr>
    <tr>
      <td width="73%" colspan="2" height="27" bgcolor="#546878" align="center">
      <a href="javascript:history.back();"><font color="#FFFFFF">BACK TO SUBMISSION HISTORY</font></a></td>
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
		System.out.println("The exception2 in AssignmentHistory.jsp is....."+se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in AssignmentHistory.jsp is....."+e);
	}
	finally{
	try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
	}catch(SQLException se){
			ExceptionsFile.postException("AssignmentHistory.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("The exception2 in AssignmentHistory.jsp is....."+se.getMessage());
	}

}
%>
</body>

</html>