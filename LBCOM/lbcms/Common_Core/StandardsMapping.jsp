<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile,exam.FindGrade" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page"/>

<%
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",developerId="";
	String gradeId="",subjName="";
	boolean sflag=false;
	ResultSet  rs=null,rs1=null,rs2=null;
	Connection con=null;
	Statement st=null,st1=null,st2=null;

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
		subjName=request.getParameter("subjid");
		if(subjName == null)
			subjName="sall";
				
		if(gradeId == null)
			gradeId="uall";
		
		String standardId=request.getParameter("standardid");

		if(standardId == null)
			standardId="lall";
				
%>

<SCRIPT LANGUAGE="JavaScript">

function goSub(sId)
{
	
	var subjId=document.frm.subjid.value;
	window.location="StandardsMapping.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&subjid="+subjId+"";
	
}
function goUnit(cId)
{
	
	var subjId=document.frm.subjid.value;
	var unitId=document.frm.unitid.value;
	window.location="StandardsMapping.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&gradeid="+unitId+"&subjid="+subjId+"";
	
}


function goValidate(cId)
{	
	var subjId=document.frm.subjid.value;
	var unitId=document.frm.unitid.value;
	var lessonId=document.frm.lessonid.value;
	
	if(unitId=="uall")
	{
		alert("Please select Grade");
		window.document.frm.unitid.focus();
		return false;
		
	}
	else if(lessonId=="lall")
	{
		alert("Please select Standard");
		window.document.frm.lessonid.focus();
		return false;
		
	}
	else
	{		
		var unitId=document.frm.unitid.value;
	window.location="StandardsMapping.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&subjid="+subjId+"&gradeid="+unitId+"&standardid="+lessonId+"";		
		
		return false;
	}
	
}
var studentids=new Array();
function validate()
{
	var obj=document.frm;
	var flag=false;
	var stdCount=0;

	for(i=0;i<obj.elements.length;i++)
	{
		if (obj.elements[i].type=="checkbox" && obj.elements[i].name=="strandid" && obj.elements[i].checked==true)
		{
			studentids[i]=obj.elements[i].value;
			stdCount=stdCount+1;
		}
	}
	if(stdCount < 1)
	{
		alert("You have to select atleast one Standard!!!");
		return false;
	}
	else
	{
		window.location.href="SaveStandards.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>&standardids="+studentids;
		return false;
	}
	
}
</SCRIPT>
<link href="../styles/teachcss.css" rel="stylesheet" type="text/css" />

<form name="frm" method="post" action="">
<table>
			<tr>
				<td width="100%" colspan="4">
					<font face="Arial" size="2"><center><strong>Please select Standards</strong></center></font>
				</td>
			</tr>
			</table><br/>

<div align="center" style="margin-top:40px;">
<table border="0" cellpadding="0" cellspacing="0" width="90%" background="images/CourseHome_01.gif">

<tr>
<td>

<!--   Subject    Start here   -->

<b>Subject:</b>&nbsp;
<select name="subjid" style="width: 146px" onChange ="goSub(this.value); return false;">
<option value="sall">Select</option>
<%
		con=con1.getConnection();
		st=con.createStatement();
		rs=st.executeQuery("select distinct subject from lbcms_dev_cc_standards where standard_type='common'");
		while(rs.next())
		{
			String sName = rs.getString("subject");
			
		%>
				<option value="<%= sName %>"><% out.println(sName); %></option>
	<%
			
		}
	
	rs.close();
	st.close();
	
	%>
	</select>
	
	<!-- Upto here -->

<b>Grade:</b>&nbsp;
<select name="unitid" style="width: 100px" onChange ="goUnit(this.value); return false;">
<option value="uall">Select</option>
<%
	
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		rs=st.executeQuery("select distinct grade from lbcms_dev_cc_standards where standard_type='common' and subject='"+subjName+"' order by grade");

	while(rs.next())
	{
		String uName = rs.getString("grade");
		String uId   = rs.getString("grade");
		if(gradeId.equals(uId))
		{
%>
			<option value="<%= uId %>" selected><% out.println(uName); %></option>
<%
		}
		else
		{
%>
			<option value="<%= uId %>"><% out.println(uName); %></option>
<%
		}
	}
	rs.close();
	st.close();
	
	%>
	</select>
<%
	if(!unitId.equals(""))
	{

%>
	&nbsp;&nbsp;<b>Standard:</b>&nbsp;
	<select name="lessonid" style="width: 346px" selected onChange="goValidate();">
	
	<option value="lall">Select</option>
	<%
		
		rs1=st1.executeQuery("select distinct strand_name from lbcms_dev_cc_standards where standard_type='common' and grade='"+gradeId+"' and subject='"+subjName+"'");
	while(rs1.next())
	{
		String lName = rs1.getString("strand_name");
		
		if(standardId.equals(lName))
		{
	%>
	<option value="<%= lName %>" checked><% out.println(lName); %></option>
	<%
	}
	else
		{
	%>
	<option value="<%= lName %>"><% out.println(lName); %></option>
	<%
	}
	}
	rs1.close();
	st1.close();

	
	%>
	</select>
	<script>
	
			document.frm.subjid.value="<%= subjName %>";
			document.frm.lessonid.value="<%=standardId%>";	
		</script> 
	</td>
	</tr>
	
	</table>
		


	<%
	
		if(gradeId.equals("uall") || standardId.equals("lall"))
		{
%>
<br/><br/>
		

<%	
		}
		else
		{
			%>
			<table border="0" cellpadding="0" cellspacing="0" width="90%"  class="whiteBgClass">
			<tr><td width="5%" colspan="4" valign="top">&nbsp;</td></tr>
			<tr><td width="5%" colspan="4" valign="top">&nbsp;</td><td width="5%" colspan="4" align="center"><font color="#8A0808"><b>Standard</b></font></td><td width="10%" colspan="4" align="center"><font color="#8A0808"><b>Standard Id</b></font></td><td width="50%" colspan="4" align="center"><font color="#8A0808"><b>Standard Description</b></font></td></tr>
			<%

			rs2=st2.executeQuery("select * from lbcms_dev_cc_standards where standard_type='common' and grade='"+gradeId+"' and strand_name='"+standardId+"' order by grade");
			while(rs2.next())
			{
%>
			<tr><td width="5%" colspan="4" valign="top">&nbsp;</td></tr>
			<tr>
			
				<td width="8%" colspan="4" valign="top">
					<input type="checkbox" name="strandid" value="<%=rs2.getString("standard_code")%>">
				</td>
				<td width="10%" colspan="4" align="center" valign="top">
					<%=rs2.getString("standard_id")%>
				</td>
				<td width="10%" colspan="4" align="center" valign="top">
					<%=rs2.getString("standard_code")%>
				</td>
				<td width="50%" colspan="4" valign="top">
					<p align="justify"><font size="3" ><%=rs2.getString("standard_desc")%></font></p>
				</td>
				
			</tr>
			<tr><td width="5%" colspan="4" valign="top">&nbsp;</td></tr>
			
			
<%	

			}			

		}
%>
</table>
<table>
<tr>
	<td colspan=4 align="right" ><input class="button" type="button" value="Submit" align="absmiddle" onClick="return validate('<%=courseId%>');"></td>
</tr>
</table>

<input type="hidden" name="courseid" value="<%=courseId%>">

	<%
		
		}
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
			if(con!=null && !con.isClosed())
				con.close();
			
		}
		catch(SQLException se){
			ExceptionsFile.postException("Mainlessonmap.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
		}
		%>
		
</div>
		 </form>