<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,common.*" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
    
	String schoolId="",classId="",courseId="",studentId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",assgnContent="";
	String cat="",assgnName="",workId="",attachFile="",teacherId="",categoryName="",tableName="",catText="";
	int totMarks=0,assgNo=0;
	try
	{
		con=con1.getConnection();
		st=con.createStatement();
		courseId=request.getParameter("courseid");
		unitId=request.getParameter("unitid");
		lessonId=request.getParameter("lessonid");
		assgNo=Integer.parseInt(request.getParameter("assgnno"));
			
		
		if(courseId.equals("DC008")||courseId.equals("DC015")||courseId.equals("DC032")||courseId.equals("DC016")||courseId.equals("DC026")||courseId.equals("DC049")||courseId.equals("DC030")||courseId.equals("DC018")||courseId.equals("DC031")||courseId.equals("DC047")||courseId.equals("DC055")||courseId.equals("DC056")||courseId.equals("DC023")||courseId.equals("DC036")|courseId.equals("DC060")||courseId.equals("DC036")||courseId.equals("DC057")||courseId.equals("DC046")||courseId.equals("DC042")||courseId.equals("DC058")||courseId.equals("DC024")||courseId.equals("DC019"))
		{
			tableName="lbcms_dev_assgn_social_larts_content_master";
					
		}
		else if(courseId.equals("DC048")||courseId.equals("DC005")||courseId.equals("DC043")||courseId.equals("DC044")||courseId.equals("DC051")||courseId.equals("DC037")||courseId.equals("DC080")||courseId.equals("DC050")||courseId.equals("DC020")||courseId.equals("DC017")||courseId.equals("DC059"))
		{
			tableName="lbcms_dev_assgn_science_content_master";
					
		}
		else
		{
			tableName="lbcms_dev_assgn_math_content_master";
			
		}
		
		System.out.println("select * from "+tableName+" where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and assgn_no="+assgNo+"");
		
		rs=st.executeQuery("select * from "+tableName+" where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and slno="+assgNo+"");
		if(rs.next())
		{
			courseName=rs.getString("course_name");
			lessonName=rs.getString("lesson_name");
			totMarks=Integer.parseInt(rs.getString("marks_total"));
			assgnName=rs.getString("assgn_name");
			cat=rs.getString("category_id");
			if(cat.equals("WR"))
			{
				catText="Writing Assignment";
				cat="WA";
			}
			else if(cat.equals("RA"))
				catText="Reading Assignment";
			else if(cat.equals("HW"))
				catText="Home Work";
			else if(cat.equals("PW"))
				catText="Project Work";

			assgnContent = new String(rs.getBytes("assgn_content"), "UTF-8");
			assgnContent=assgnContent.replaceAll("&Acirc;","");
			assgnContent=assgnContent.replaceAll("Â","");
			assgnContent=assgnContent.replaceAll("http://oh.learnbeyond.net/LBCOM/","http://oh.learnbeyond.net:8080/LBCOM/");
			attachFile=rs.getString("assgn_attachments");
			if(attachFile==null)
				attachFile="";
			
		}
		
		

%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>ASSIGNMENT INFO</title>
<script language="JavaScript" type="text/javascript" src="wysiwyg/assgnwysiwyg.js"></script>

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
      <td width="58%" height="19" bgcolor="#EBEBD6"><font face="Verdana" size="2">&nbsp;<%=catText%></font></td>
    </tr>
    <tr>
      <td width="15%" height="19" bgcolor="#D9D9B3">
      <font face="Verdana" size="2">&nbsp;Maximum Points</font></td>
      <td width="58%" height="19" bgcolor="#EBEBD6"><font face="Verdana" size="2">&nbsp;<%=totMarks%></font></td>
    </tr>
    <tr>
      <td width="73%" colspan="2" height="1" bgcolor="#EBEBD6" align="center">
      &nbsp;</td>
    </tr>
    <tr>
      <td width="73%" colspan="2" height="385" bgcolor="#EBEBEB" align="left" valign="top">&nbsp;<%=assgnContent%>
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
	catch(Exception e)
	{
		System.out.println("The exception1 in AssignmentView.jsp is....."+e);
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
				System.out.println("The exception2 in AssignmentView.jsp is....."+se.getMessage());
			}
	}
%>
</body>
<SCRIPT LANGUAGE="JavaScript">
function showattachments(attachfile,cat)
{
	var x=window.open("/LBCOM/lbcms/CB_Assignment/<%=courseName%>/"+cat+"/"+attachfile,"Documentassgn","width=750,height=600,scrollbars");
}
</script>

</html>
