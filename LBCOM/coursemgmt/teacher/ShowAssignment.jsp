<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,common.*" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
    
	String schoolId="",classId="",courseId="",studentId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",assgnContent="";
	String cat="",assgnName="",workId="",attachFile="",teacherId="",categoryName="",maxattempts="";
	float totMarks=0.0f;
	int assgNo=0;
	try
	{
		con=con1.getConnection();
		st=con.createStatement();
		teacherId = (String)session.getAttribute("emailid");
		schoolId=(String)session.getAttribute("schoolid");
		courseId=(String)session.getAttribute("courseid");
		classId=(String)session.getAttribute("classid");
		//studentId=(String)session.getAttribute("emailid");
		workId=request.getParameter("workid");
			
		rs=st.executeQuery("select * from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id='"+workId+"'");
		if(rs.next())
		{
			
			assgnName=rs.getString("doc_name");
			cat=rs.getString("category_id");
			if(cat.equals("WR"))
				cat="WA";
			if(cat.equals("WA"))
				categoryName="Writing Assignment";
			else if(cat.equals("RA"))
				categoryName="Reading Assignment";
			else if(cat.equals("HW"))
				categoryName="Home Work";
			else if(cat.equals("PW"))
				categoryName="Project Work";

			assgnContent=rs.getString("asgncontent");
			assgnContent=assgnContent.replaceAll("&Acirc;","");
			assgnContent=assgnContent.replaceAll("Â","");
			assgnContent=assgnContent.replaceAll("http://oh.learnbeyond.net/LBCOM/","http://oh.learnbeyond.net:8080/LBCOM/");
			attachFile=rs.getString("attachments");
			totMarks=Float.parseFloat(rs.getString("marks_total"));
			maxattempts=rs.getString("max_attempts");
		}


%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>ASSIGNMENT INFO</title>
<script language="JavaScript" type="text/javascript" src="wysiwyg/assgnwysiwyg.js"></script>
<SCRIPT LANGUAGE="JavaScript">
function showattachments(subfile,cat)
{
	window.open("<%=(String)session.getAttribute("schoolpath")%><%=schoolId%>/<%=teacherId%>/coursemgmt/<%=courseId%>/"+cat+"/"+subfile,"Document","width=750,height=600,scrollbars");

}
</script>


</head>
<body>
<form>
<div align="center">
  <center>
  <table border="0" cellspacing="0" width="80%" bordercolorlight="#838341" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0">
  <tr>
<td bgcolor="#546878" colspan="3">
<%
if(attachFile.equals("") || attachFile==null || attachFile.equals("null"))
	{
		
%>		<font face="Verdana" size="2" color="#FFFFFF">There is no attachment for this assignment.</font>
<%		
	}
	else
	{				
%>
		<a href="javascript:showattachments('<%=attachFile%>','<%=cat%>');"><font face="Verdana" size="2" color="#FFFFFF"><b>Attachment Preview</b></font>
<%		
	}
%>
</td>

</tr>
    <tr>
      <td width="72%" bgcolor="#36361B" height="25"><b>
      <font face="Verdana" size="2" color="#FFFFFF">&nbsp;ASSIGNMENT VIEW</font></b></td>
      <td width="4%" bgcolor="#36361B" height="25" align="center">
      <a href="#save">
      <img border="0" src="images/save-icon.jpg" width="20" height="21"></a></td>
      <td width="4%" bgcolor="#36361B" height="25" align="center">
      <p align="center"><a href="#print">
      <img border="0" src="images/print-icon.jpg" width="20" height="21"></a></td>
    </tr>
    </table>
    <table border="0" cellspacing="1" width="80%" bordercolorlight="#838341" height="460">
    <tr>
      <td width="15%" height="19" bgcolor="#D9D9B3">
      <font face="Verdana" size="2">&nbsp;Assignment Name</font></td>
      <td width="58%" height="19" bgcolor="#EBEBD6">
		<font face="Verdana" size="2">&nbsp;<%=assgnName%></font>
	  </td>
    </tr>
    <tr>
      <td width="15%" height="19" bgcolor="#D9D9B3">
      <font face="Verdana" size="2">&nbsp;Category</font></td>
      <td width="58%" height="19" bgcolor="#EBEBD6"><font face="Verdana" size="2">&nbsp;<%=categoryName%></font></td>
    </tr>
    <tr>
      <td width="15%" height="19" bgcolor="#D9D9B3">
      <font face="Verdana" size="2">&nbsp;Maximum Points</font></td>
      <td width="58%" height="19" bgcolor="#EBEBD6"><font face="Verdana" size="2">&nbsp;<%=totMarks%></font></td>
    </tr>
	<tr>
      <td width="15%" height="19" bgcolor="#D9D9B3">
      <font face="Verdana" size="2">&nbsp;Maximum Attempts</font></td>
      <td width="58%" height="19" bgcolor="#EBEBD6"><font face="Verdana" size="2">&nbsp;<%=maxattempts%></font></td>
    </tr>
    <tr>
      <td width="73%" colspan="2" height="1" bgcolor="#EBEBD6" align="center">
      &nbsp;</td>
    </tr>
    <tr>
      <td width="73%" colspan="2" height="385" bgcolor="#EBEBEB">&nbsp;<%=assgnContent%>
	</td>
    </tr>
    <tr>
      <td width="73%" colspan="2" height="24" bgcolor="#36361B">
      <p align="center">
			<b>
			<a href="javascript:self.close();">
            <font color="#FFFFFF" face="Verdana" size="2">CLOSE</font></a></b></td>
    </tr>
    
  </table>
  </center>
</div>
      </form>
<%
}
	catch(SQLException se)
	{
		System.out.println("The exception1 in showassignments.jsp is....."+se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in showassignments.jsp is....."+e);
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
			ExceptionsFile.postException("ShowAssignment.jsp","closing the statement objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
%>
</body>
</html>