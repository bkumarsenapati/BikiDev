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
		
		System.out.println("------------*****************--------------");
		System.out.println("gradeid is ..."+gradeId);
		if(gradeId == null)
			gradeId="uall";
		

		String standardId=request.getParameter("standardid");
		System.out.println("standardId is ..."+standardId);

		if(standardId == null)
			standardId="lall";
		
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();

		rs=st.executeQuery("select distinct grade from lbcms_dev_cc_standards where standard_type='common'");
%>

<SCRIPT LANGUAGE="JavaScript">
<!--

function goUnit(cId)
{
	
	var unitId=document.firstpage.unitid.value;
	window.location="StandardsMapping.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&gradeid="+unitId+"";
	
}


function goValidate(cId)
{	
	var obj=document.setmarking;
	var unitId=document.firstpage.unitid.value;
	var lessonId=document.firstpage.lessonid.value;
	
	
	
	if(unitId=="uall")
	{
		alert("Please select Grade");
		window.document.firstpage.unitid.focus();
		return false;
		
	}
	else if(lessonId=="lall")
	{
		alert("Please select Standard");
		window.document.firstpage.lessonid.focus();
		return false;
		
	}
	else
	{		
		var unitId=document.firstpage.unitid.value;
	window.location="StandardsMapping.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&gradeid="+unitId+"&standardid="+lessonId+"";		
		
		return false;
	}
	
}
var studentids=new Array();
function validate()
{
	var obj=document.firstpage;
	var flag=false;
	var stdCount=0;

	for(i=0;i<obj.elements.length;i++)
	{
		if (obj.elements[i].type=="checkbox" && obj.elements[i].name=="strandid" && obj.elements[i].checked==true)
		{
			studentids[i]=obj.elements[i].value;
			alert(obj.elements[i].value);
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

<table border="0" cellpadding="0" cellspacing="0" width="100%" background="images/CourseHome_01.gif">

<tr>
<td>
<b>Grade:</b>&nbsp;
<select name="unitid" style="width: 246px" onChange ="goUnit(this.value); return false;">
<option value="uall">Select</option>
<%
	con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		

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
	<b>Standard:</b>&nbsp;
	<select name="lessonid" style="width: 246px" selected onchange="goValidate();">
	
	<option value="lall">Select</option>
	<%
		System.out.println("select * from lbcms_dev_cc_standards where standard_type='common' and grade='"+gradeId+"'");

		rs1=st1.executeQuery("select distinct strand_name from lbcms_dev_cc_standards where standard_type='common' and grade='"+gradeId+"'");
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
	
			document.firstpage.lessonid.value="<%=standardId%>";	
		</script> 

	</td>
	</tr>
	
	</table>
		


	<%
	
		if(gradeId.equals("uall") || standardId.equals("lall"))
		{
%>
		<table>
			<tr>
				<td width="100%" colspan="4">
					<font face="Arial" size="2"><center><strong>Please select a Standards</strong></center></font>
				</td>
			</tr>
			</table>

<%	
		}
		else
		{
			%>
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<%

			rs2=st2.executeQuery("select * from lbcms_dev_cc_standards where standard_type='common' and grade='"+gradeId+"' and strand_name='"+standardId+"'");
			while(rs2.next())
			{
%>
<br>
			<tr>
				<td width="5%" colspan="4"><input type="checkbox" name="strandid" value="<%=rs2.getString("standard_code")%>">
				</td>
				<td width="5%" colspan="4" align="center"><%=rs2.getString("standard_id")%></td>
				<td width="10%" colspan="4" align="center"><%=rs2.getString("standard_code")%></td>
				<td width="70%" colspan="4"><%=rs2.getString("standard_desc")%></td>
				</td>
			</tr>
<%	

			}			

		}
%>
<tr>
	<td colspan=8 align="left"><input type="button" value="Submit" onClick="return validate('<%=courseId%>');"></td>
</tr>
</table>

<input type="hidden" name="courseid" value="<%=courseId%>">

	<%
		System.out.println("gradeId..."+gradeId+"...standardId..."+standardId);
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
			if(con!=null && !con.isClosed())
				con.close();
			
		}
		catch(SQLException se){
			ExceptionsFile.postException("Mainlessonmap.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
		}
		%>
		