<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,common.*" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
    
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",assgnContent="",developerId="";
	String cat="",assgnName="",attachFile="",catText="",tableName="";
	int totMarks=0,assgNo=0,maxattempts=0;
	try
	{
		String courseDevPath=application.getInitParameter("lbcms_dev_path");
		con=con1.getConnection();
		st=con.createStatement();
		courseId=request.getParameter("course_id");
		unitId=request.getParameter("unit_id");
		lessonId=request.getParameter("lesson_id");
		assgNo=Integer.parseInt(request.getParameter("assgn_no"));
		
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

		rs=st.executeQuery("select * from "+tableName+" where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and assgn_no="+assgNo+"");
		if(rs.next())
		{
			courseName=rs.getString("course_name");
			lessonName=rs.getString("lesson_name");
			totMarks=Integer.parseInt(rs.getString("marks_total"));
			maxattempts=Integer.parseInt(rs.getString("maxattempts"));
			assgnName=rs.getString("assgn_name");
			cat=rs.getString("category_id");
			if(cat.equals("WA"))
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

			assgnContent=rs.getString("assgn_content");
			assgnContent=assgnContent.replaceAll("&Acirc;","");
			assgnContent=assgnContent.replaceAll("Â","");
			attachFile=rs.getString("assgn_attachments");
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
<SCRIPT LANGUAGE="JavaScript">
<!--
function showFile(attachfile,cat)
{
	var x=window.open("/LBCOM/lbcms/CB_Assignment/<%=courseName%>/"+cat+"/"+attachfile,"Document","width=750,height=600,scrollbars");
	
	return false;
}
</SCRIPT>
</head>
<body>
<form>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<div align="center">
  <center>
  <table border="0" cellspacing="0" width="80%" id="AutoNumber2" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0">
    <tr>
      <td width="100%" bgcolor="#F1F8FA" colspan="2">
      <img border="0" src="images/hscoursebuilder.gif" width="194" height="70"></td>
    </tr>
    <tr>
      <td width="100%" colspan="2"><hr color="#C0C0C0" size="1"></td>
    </tr>
    <tr>
      <td width="50%"><font face="Verdana" size="2" color="#000080"><b>Course :
      </b></font><font face="Verdana" size="2" color="#800000"><%=courseName%></font></td>
      <td width="50%">
      <p align="right"><font face="Verdana" size="2" color="#000080"><b>&nbsp;Lesson 
      : </b></font><font face="Verdana" size="2" color="#800000"><%=lessonName%></font></td>
    </tr>
  </table>
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
      <font face="Verdana" size="2" color="#FFFFFF">&nbsp;ASSIGNMENT VIEW</font><font face="Verdana" size="2" color="#000080">
      </font></b></td>
<%
		if(attachFile==null || attachFile.equals("null") || attachFile.equals(""))
		{
%>			<td width="45%" bgcolor="#7C7C7C" height="25">
				<p align="right"><b><font face="Verdana" size="1" color="#FFFFFF"><b>No attachments are available</b></font>
			</td>
<%		}
		else
		{
%>
		  <td width="45%" bgcolor="#7C7C7C" height="25">
		  <p align="right"><b><font face="Verdana" size="1" color="#FFFFFF"><a href="javascript://" onclick="return showFile('<%=attachFile%>','<%=cat%>');"><b>Work File</b></a></font>
		  </td>
<%		}

%>
	</tr>
    <tr>
      <td width="12%" height="22" bgcolor="#C0C0C0">
      <font face="Verdana" size="2">&nbsp;Assignment Name</font></td>
      <td width="61%" height="22" bgcolor="#EBEBEB">&nbsp;<%=assgnName%></td>
    </tr>
    <tr>
      <td width="12%" height="22" bgcolor="#C0C0C0">
      <font face="Verdana" size="2">&nbsp;Category</font></td>
      <td width="61%" height="22" bgcolor="#EBEBEB">&nbsp;<%=catText%></td>
    </tr>
    <tr>
      <td width="12%" height="22" bgcolor="#C0C0C0">
      <font face="Verdana" size="2">&nbsp;Maximum Points</font></td>
      <td width="61%" height="22" bgcolor="#EBEBEB">&nbsp;<%=totMarks%></td>
    </tr>
	<tr>
      <td width="12%" height="22" bgcolor="#C0C0C0">
      <font face="Verdana" size="2">&nbsp;Maximum Attempts</font></td>
      <td width="61%" height="22" bgcolor="#EBEBEB">&nbsp;<%=maxattempts%></td>
    </tr>
    <tr>
      <td width="73%" colspan="2" height="28" bgcolor="#C0C0C0" align="center">
      <p align="left"><font face="Verdana" size="2">&nbsp;Assignment:</font></td>
    </tr>
    <tr>
      <td width="73%" colspan="2" height="388" bgcolor="#EBEBEB" align="left" valign="top">&nbsp;<%=assgnContent%>
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
    <tr>
      <td width="73%" colspan="2" height="27" bgcolor="#C0C0C0">
      <p align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Do you want to edit this assignment "&nbsp;<b><%=assgnName%></b>&nbsp;":
			<a href="EditAssignmentBuilder.jsp?course_id=<%=courseId%>&unit_id=<%=unitId%>&lesson_id=<%=lessonId%>&assgn_no=<%=assgNo%>"><font color="#FFFFFF">EDIT</font></a></td>
    </tr>
  </table>
  </center>
</div>
&nbsp;</p>
      </form>
      <p>&nbsp;
<%
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in AssignmentPreview.jsp is....."+e);
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
				System.out.println("The exception2 in AssignmentPreview.jsp is....."+se.getMessage());
			}
	}
%>
</body>

</html>