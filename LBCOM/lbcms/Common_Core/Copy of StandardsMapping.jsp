<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile,exam.FindGrade" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page"/>

<%
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",developerId="";
	String gradeId="";
	boolean sflag=false;
	ResultSet  rs=null,rs1=null,rs2=null,rs3=null,rs4=null;
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null;

	try
	{
		session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}   
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		developerId=request.getParameter("userid");
		unitId=request.getParameter("unitid");
		unitName=request.getParameter("unitname");
		lessonId=request.getParameter("lessonid");
		lessonName=request.getParameter("lessonname");
		gradeId=request.getParameter("gradeid");
		System.out.println("gradeid is ..."+gradeId);
		if(gradeId==null);
		{
			gradeId="common";
		}
		System.out.println("*****************-----------------");
		System.out.println("gradeid is ..."+gradeId);

		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();

		
		
		rs=st.executeQuery("select * from lbcms_dev_common_core_larts_standards where standard_type='common'");	
%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>SummaryByMarking</title>
<SCRIPT LANGUAGE="JavaScript">
<!--
function goCourse()
{
	var gradeId=document.catsummary.gradelist.value;
	alert(gradeId);
	window.location="StandardsMapping.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&gradeid="+gradeId+"";

}
function goMP()
{
	var courseId=document.catsummary.gradelist.value;
	window.location="StandardsMapping.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>";
}
//-->
</SCRIPT>
</head>

<body>
<form name="catsummary" method="POST" action="--WEBBOT-SELF--"><BR>

<div align="center">
  <center>
<table border="0" cellspacing="0" width="95%" id="AutoNumber1" bgcolor="#429EDF" height="26" style="border-collapse: collapse" bordercolor="#111111" cellpadding="5">
  <tr bgcolor="#429EDF">
    <td width="30%" height="23" colspan="2" bgcolor="#96C8ED">
		<select id="gradelist" style="width:200px" name="gradelist" onchange="goCourse(); return false;">
			<option value="selectgrade" selected>Select Grade</option>
<%
	                
              while(rs.next())
				{

				  sflag=true;
				  
					out.println("<option value='"+rs.getString("grade")+"'>"+rs.getString("grade")+"</option>");
				}
				rs.close();
				st.close();
				System.out.println("In the subject..."+gradeId);
%>
		</select>
		<script>
			document.catsummary.gradelist.value="<%=gradeId%>";	
		</script>
	</td>
  
	
</tr>
</table>
<%
	
	}
		catch(SQLException se)
		{
			System.out.println("Error: SQL -" + se.getMessage());
		}
		catch(Exception e)
		{
			System.out.println("Error:  -" + e.getMessage());
		}
		finally
		{
			try
			{
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(st2!=null)
					st2.close();
				if(st3!=null)
					st3.close();
			
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se){
				ExceptionsFile.postException("SummaryByMarking.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				System.out.println(se.getMessage());
		}

    }
%>
  </center>
</div>

<hr color="#429EDF" width="100%" size="1">
<%
if(sflag=false)
{
	System.out.println("sflag..."+sflag);
	%>
		<table>
			<tr>
					<td width="20%" height="18">
					<p align="left"><font face="Verdana" size="2" color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;There are no assignments available.</font></td></tr>
		</table>
		<%
}%>
		
		</form>
</body>
</html>