<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="dbCon" class="sqlbean.DbBean" scope="page" />
<% 
	Connection con =null;
	Statement stmt=null;
    ResultSet rs=null;
	String courseId="",courseName="",teacherid="",schoolid="",classId="",categoryId="",schoolId="",className="",mode="",disableMsg="";
	int i=0;
	String schema="";
	int haveFlag = 0;
	float[] mins = new float[30];
	String[] grades=new String[30];
%>

<% 
    schoolId=(String)session.getAttribute("schoolid");
	courseId=request.getParameter("courseid");
	courseName=request.getParameter("coursename");
	classId=request.getParameter("classid");
	className=request.getParameter("classname");
	mode=request.getParameter("mode");
	schema=request.getParameter("schema");
		
	try
		{
			
			con=dbCon.getConnection();
			stmt=con.createStatement();
			String scaleValue="";
			
		// Grading scale code is used to know whether the scale is 10 scale or 100 scale.
		
		if(schema.equals("Main"))
		{
			
			rs=stmt.executeQuery("select grading_scale from coursewareinfo where school_id='"+schoolId+"' and class_id='"+classId+"' and course_id='"+courseId+"'");
			if(rs.next())
			{
				scaleValue=rs.getString("grading_scale");
			}
			rs.close();
			
		}
		else
			scaleValue="100scale";

		// Grading scale code ends here.
%>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0"><meta name="author" content="hotschools.net">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK HREF="../images/style.css" TYPE="text/css" REL="stylesheet">  
<title></title>

<script type="text/javascript">
var rowcount=0;
var scaleValue="<%=scaleValue%>";

function addRow(rownum)
{
	rownum=rowcount;
	var x=document.getElementById('gradesTable').insertRow(rownum+1)
	var a=x.insertCell(0)
	var b=x.insertCell(1)
	var c=x.insertCell(2)
	var d=x.insertCell(3)
	var e=x.insertCell(4)
	a.innerHTML="<TD bgcolor='#AEAEAE' width='19'><A onclick='return delRow(this);' href='javascript://'><img height='21' TITLE='Delete Row' src='/LBCOM/coursemgmt/images/del.gif' width='19' border=0></A></TD>"
	b.innerHTML="<TD bgcolor='#AEAEAE' width='169' height='21'><p align='center'><INPUT id='grade' size=23 name='gradenames'></p></td>"
	c.innerHTML="<td width='103'><p align='center'><INPUT id='ddd' size=10 name='gradecodes'></td>"
	d.innerHTML="<td width='97'><p align='center'><INPUT id='ddd' maxLength=4 size=10 name='minimum'></td>"
	e.innerHTML="<td width='289'><p align='center'><INPUT id='ddd' size=50 name='descriptions'></td>"

	rowcount++;
	document.getElementById("no_of_records").value=rowcount;
}

function delRow(btn) 
{
	var tab = document.getElementById('gradesTable');
	var r = btn.parentNode;
	while (r.nodeName != "TR")
	{
		r = r.parentNode;
	}
	if (confirm("Are you sure that you want to delete the grade?"))
	{
		try   
		{
			tab.deleteRow(r.rowIndex);
		}
		catch(e)
		{
			tab.deleteRow(-1); // for firefox; reqd to delete last row
		}
		rowcount--;
		document.getElementById("no_of_records").value=rowcount;
	}
}

function deleteRow(rownum)
{
	if(confirm("Are you sure you want to delete the grade?")==true)
	{
		document.getElementById('gradesTable').deleteRow(rownum);
		rowcount--;
		document.getElementById("no_of_records").value=rowcount;
	}
	else
		return;
}

function goHome()
{
	parent.main.location.href="CoursesList.jsp";
}

function clearfileds()
{
	window.document.defgrades.reset();
	return false;
}

function checkNumber(keyCode)
{
	if(keyCode>=48 && keyCode<=57)
		return true;
	else
		if(keyCode==8 || keyCode==13)
		  return true;
	   else
	   {
		alert("Enter Only Numbers");
		return false;
	   }
}

function checkAll()
{
	var totrecords=document.getElementById("no_of_records").value;
	var frm=window.document.Grading
	var num="0123456789."
	var scale=document.getElementById("scale");
	var mintxt;
	var gcodes;
	
	gcodes=document.getElementsByName("gradecodes");
	for(i=0;i<gcodes.length;i++)
	{
		if(gcodes[i].value=="")
		{
			alert("Please enter Grade Code.");
			gcodes[i].select();
			i=100;
			return false;
		}
	}

	if(scale.checked==true)
	{
		mintxt=document.getElementsByName("minimum");
		
		for(i=0;i<mintxt.length;i++)
		{
			if(mintxt[i].type!="hidden")
			{
				if(mintxt[i].value=="")
			    {
					alert("Please enter proper values");
					mintxt[i].select();
					i=100;
					return false;
				}
				if(parseFloat(mintxt[i].value) >= 10 || parseFloat(mintxt[i].value) < 0)
				{
					if(parseFloat(mintxt[i].value) >= 10)
						alert("Select a value which is less than 10.");
					else
						alert("Please enter proper values.");
					mintxt[i].select();
					i=100;
					return false;
				}

				if((num.indexOf((mintxt[i].value).charAt(0)))==-1||(num.indexOf((mintxt[i].value).charAt(1)))==-1||
				   (num.indexOf((mintxt[i].value).charAt(2)))==-1||(num.indexOf((mintxt[i].value).charAt(3)))==-1)
			    {
					alert("Please enter numbers only");
					mintxt[i].select();
					i =100;
					return false;
				} 
			
				if(i+1 < totrecords)
				{
					if(parseFloat(mintxt[i].value) <= parseFloat(mintxt[i+1].value))
					{
						alert("This value should be greater than the below value.");
						mintxt[i].select();
						i=100;
						return false;
					}
				}
			}
		}
		
		if(mintxt[totrecords-1].value!=0.0)
		{
			if(confirm("The last grade will be set to 'Failed'. OK?")==true)
			{
				document.getElementById("last_record").value="yes";
			}
			else
				return;
		}
	}
	else
	{
		mintxt=document.getElementsByName("minimum")
		
		for(i=0;i<mintxt.length;i++)
	    {
			if(mintxt[i].type!="hidden")
			{
				if(mintxt[i].value=="")
				{
					alert("Please enter proper values");
					mintxt[i].select();
					i=100;
					return false;
				}
				if(parseFloat(mintxt[i].value) >= 100 || parseFloat(mintxt[i].value) < 0)
				{
					if(parseInt(mintxt[i].value) >= 100)
						alert("Select a value which is less than 100.");
					else
						alert("Please enter proper values.");
					mintxt[i].select();
					i=100;
					return false;
				}

				if((num.indexOf((mintxt[i].value).charAt(0)))==-1||(num.indexOf((mintxt[i].value).charAt(1)))==-1||
				   (num.indexOf((mintxt[i].value).charAt(2)))==-1||(num.indexOf((mintxt[i].value).charAt(3)))==-1)
			    {
					alert("Please enter numbers only");
					mintxt[i].select();
					i =100;
					return false;
				} 
			
				if(i+1 < totrecords)
				{
					if(parseFloat(mintxt[i].value) <= parseFloat(mintxt[i+1].value))
					{
						alert("This value should be greater than the below value.");
						mintxt[i].select();
						i=100;
						return false;
					}
				}
			}
		}

		if(mintxt[totrecords-1].value!=0)
		{
			if(confirm("The last grade will be set to 'Failed'. OK?")==true)
			{
				document.getElementById("last_record").value="yes";
			}
			else
				return;
		}
	}

document.getElementById("defgrades").submit()
}

function checkScale(scale)
{
	var scaleVal=scale;
	if((scaleValue==100 && scaleVal==100) || (scaleValue==10 && scaleVal==10))
		return;
	var n = document.getElementsByName("minimum");
	var min=0.0;
	if(scaleVal==10)
	{
		for(var i=0;i<n.length;i++)
		{
			min=n[i].value;
			min=min/10;
			n[i].value=min;
		}
	}
	else
	{
		for(var i=0;i<n.length;i++)
		{
			min=n[i].value;
			min=min*10;
			n[i].value=min;
		}
	}
	scaleValue=scaleVal;
}
</script>

</head>


<!--<form method="POST" name="defgrades" action="/servlet/coursemgmt.AddGrades?courseid=<%=courseId %>">-->
<form method="POST" name="defgrades" id="defgrades" action="/LBCOM/coursemgmt.EditCourseGrades?courseid=<%=courseId%>&classid=<%=classId%>">
  <table border="0" width="100%" cellspacing="1">
    <tr>
      <td width="100%" valign="middle" align="left" bgcolor="#E8ECF4"><font color="#800080"><!-- <a href="CoursesList.jsp">Courses</a> &gt;&gt; <a href="DropBox.jsp?coursename=<%=courseName%>&classid=<%=classId%>&courseid=<%=courseId %>&classname=<%=className%>"> --><%= courseName %><!-- </a> --> &gt;&gt;</font> Grading Schema</td>
    </tr>
  </table>
</table>
</center>

	<p align="center"><b><font face="Verdana"><span style="font-size:14pt;">Grading Schema  - <%=schema%></span></font></b></p>
	<p align="center">
<%
if(mode.equals("edit"))
{
%> 
<table border="0" cellspacing="1" width="750" bgcolor="#A8B8D1" height="34">
  <tr>
    <td width="350" align="left" height="34" bgcolor="#A8B8D1">
		<FONT face=Helvetica,Arial size=-1>
          <b>
		  <a href="ViewEditCourseGrades.jsp?coursename=<%=courseName%>&classid=<%=classId%>&courseid=<%=courseId%>&classname=<%=className%>&mode=<%=mode%>&schema=Main">&nbsp;Default</a>
          <a href="ViewEditCourseGrades.jsp?coursename=<%=courseName%>&classid=<%=classId%>&courseid=<%=courseId%>&classname=<%=className%>&mode=<%=mode%>&schema=Template1">1</a>&nbsp;
          <a href="ViewEditCourseGrades.jsp?coursename=<%=courseName%>&classid=<%=classId%>&courseid=<%=courseId%>&classname=<%=className%>&mode=<%=mode%>&schema=Template2">2</a>&nbsp;
          <a href="ViewEditCourseGrades.jsp?coursename=<%=courseName%>&classid=<%=classId%>&courseid=<%=courseId%>&classname=<%=className%>&mode=<%=mode%>&schema=Template3">3</a>&nbsp;
          <a href="ViewEditCourseGrades.jsp?coursename=<%=courseName%>&classid=<%=classId%>&courseid=<%=courseId%>&classname=<%=className%>&mode=<%=mode%>&schema=Template4">4</a>&nbsp;
          <a href="ViewEditCourseGrades.jsp?coursename=<%=courseName%>&classid=<%=classId%>&courseid=<%=courseId%>&classname=<%=className%>&mode=<%=mode%>&schema=Template5">5</a></b></FONT>&nbsp;</TD>

<%
		if(scaleValue.equals("10scale"))
		{
%>
	<td width="400" height="34" align="right" bgcolor="#A8B8D1">
		<input type="radio" name="scale" id="scale" value="10" onclick="checkScale(this.value)" checked>
			<b><font face="Verdana" size="2">10 Scale</font></b>&nbsp;&nbsp;&nbsp; &nbsp; 
		<input type="radio" name="scale" id="scale" value="100" onclick="checkScale(this.value)">
			<b><font face="Verdana" size="2">100 Scale&nbsp;&nbsp;&nbsp;</font></b></td>
<%
		}
		else
		{
%>
	<td width="400" height="34" align="right" bgcolor="#A8B8D1">
		<input type="radio" name="scale" id="scale" value="10" onclick="checkScale(this.value)">
			<b><font face="Verdana" size="2">10 Scale</font></b>&nbsp;&nbsp;&nbsp; &nbsp; 
		<input type="radio" name="scale" id="scale" value="100" onclick="checkScale(this.value)" checked>
			<b><font face="Verdana" size="2">100 Scale&nbsp;&nbsp;&nbsp; </font></b></td>
<%
		}	
%>
       
</tr>
<TR>
	<TD width="763" height="1" bgcolor="#FFFFFF" colspan="6">
		<img border="0" src="images/spacer.gif" width="1" height="1"></TD>
</tr>
</table>
<%
}
%> 
<TABLE cellSpacing=1 width=750 bgColor=#AEAEAE id="gradesTable" border=0 height="54">
<TBODY>
<TR>
<%
if(mode.equals("edit"))
{
%> 
		<TD width="19" height="28" bgcolor="#A8B8D1">&nbsp;</TD>
<%
}
%>
		<TD width="169" height="28" bgcolor="#A8B8D1">
          <p align="center" class="style1">
          <FONT face=Helvetica,Arial size=-1>&nbsp;<B>Grade Name</B></FONT></TD>
      <TD width="103" bgcolor="#A8B8D1" height="28">
        <p align="center" class="style1">
          <FONT face=Helvetica,Arial size=-1>&nbsp;<B>Grade Code</B></FONT></TD>
      <TD width="97" bgcolor="#A8B8D1" height="28">
        <p align="center" class="style1">
          <FONT face=Helvetica,Arial size=-1><B>Minimum</B></FONT></TD>
      <TD width="289" bgcolor="#A8B8D1" height="28">
        <p align="center" class="style1">
          <FONT face=Helvetica,Arial size=-1><B>&nbsp;Description</B></FONT></TD>
    </TR>
<%
			i=0;		
			if(mode.equals("view"))
				disableMsg="disabled";
			
			if(schema.equals("Main"))
			{
				rs=stmt.executeQuery("select * from course_grades where courseid= '"+courseId+"' and classid='"+classId+"' and schoolid='"+schoolId+"' order by maximum desc");
			}
			else
			{
				rs=stmt.executeQuery("select * from grading_schemas where schema_name='"+schema+"' order by minimum desc");
			}
			while(rs.next())
			{
				mins[i]=rs.getFloat("minimum");
				grades[i]=rs.getString("grade_code");
%>
      <TR bgcolor="#E0E0E0">
<%
if(mode.equals("edit"))
{
%>    <TD bgcolor="#AEAEAE" width="19" height="21"><A onclick="return delRow(this);" href="javascript://">
		<img height="21" TITLE="Delete Row" src="/LBCOM/coursemgmt/images/del.gif" width="19" border=0></A></TD>
<%
}
%>   
		
		<TD bgcolor="#AEAEAE" width="169" height="21">
          <p align="center">
        <INPUT id="grade" size="24" name="gradenames" value="<%=rs.getString("grade_name")%>" <%=disableMsg%> ></TD>
	    <TD width="103" bgcolor="#AEAEAE" height="21">
	      <p align="center">
          <INPUT id="min" maxLength=7 size=10 name="gradecodes" value="<%=grades[i]%>" <%=disableMsg%>></TD>
	    <TD width="97" bgcolor="#AEAEAE" height="21">
	      <p align="center">
          <INPUT id="max" maxLength=4 size=10 name="minimum" value="<%=mins[i]%>" <%=disableMsg%>></TD>
		<TD bgcolor="#AEAEAE" width="289" height="21">
	      <p align="center">
        <INPUT id="two" size="50" name="descriptions" value="<%=rs.getString("description")%>" <%=disableMsg%>></TD>
	  </TR>
<%
			i++;
	}
%>
    </TBODY>
  </TABLE>
  <table width="750" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td bgcolor="#A8B8D1">&nbsp;</td>
    </tr>
<%
			if(mode.equals("edit"))
			{
%>

	<tr>
      <td align="center" bgcolor="#A8B8D1"><b><font face="Verdana"><span style="font-size:10pt;">
	  <input type="button" onclick="return checkAll()" value="Submit">&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="reset" value="Reset" name="B2">&nbsp;&nbsp;&nbsp;
		<input type="button" value="Add Row" name="arow" onclick="addRow(<%=i%>)">
     </td>
    </tr>
	<tr>
      <td align="center" bgcolor="#A8B8D1">&nbsp;</td>
   </tr>
	</table>
<%
			}
			else
			{
%>
	<tr>
      <td align="center" bgcolor="#A8B8D1">
		<input type="button" value="     OK     " name="view" onclick="goHome()">
	  </td>
   </tr>
   <tr>
      <td align="center" bgcolor="#A8B8D1">&nbsp;</td>
   </tr>
	</table>
  <table width="750" border="0" cellpadding="0" cellspacing="0">
	<tr>
	  <td align="left">
	  <font face="Verdana">
	  <span style="font-size:8pt;">You don't have the privilege to modify the 'Grading Schema'.</span></font></td>
   </tr>
	</table>
<%
			}	
%>
	

<%
	}
	catch(SQLException se)
	{
		ExceptionsFile.postException("CourseGrades.jsp","Operations on gradedefinitions table ","SQLException",se.getMessage());
		out.println("Exception is.."+se.getMessage());
	}		

	catch(Exception e)
	{
		ExceptionsFile.postException("CourseGrades.jsp","Operations on gradedefinitions table ","Exception",e.getMessage());
		out.println("Exception is.."+e.getMessage());
	}
	finally
	{
		try
		{
			if(stmt!=null)
				stmt.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("ViewEditCourseGrades.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
    }		
%>
	<tr>
    <td width="192" bgcolor="#40A0E0" style="border-top-width:2; border-left-width:2; border-top-color:rgb(64,160,224); border-left-color:rgb(64,160,224); border-top-style:solid; border-left-style:solid;" colspan="2">
    </td>
	<td width="202" bgcolor="#40A0E0" style="border-top-width:2; border-top-color:rgb(64,160,224); border-top-style:solid;">
    </td>
    <td width="206" bgcolor="#40A0E0" style="border-top-width:2; border-right-width:2; border-top-color:rgb(64,160,224); border-right-color:rgb(64,160,224); border-top-style:solid; border-right-style:solid;">
    </td>
    </tr>	
    </table>

<!--  
	<p align="center">
	<input type="image" src="../images/submit.gif" width="89" height="34" value="submit" onClick="return checkall()">
	<input type="image" src="../images/submit.gif" width="89" height="34" value="submit">
	<input type=image src="../images/reset.gif" onClick="return clearfileds();"></p>
-->
<INPUT type="hidden" id="no_of_records" name="no_of_records" value=<%=i%>> 
<INPUT type="hidden" id="last_record" name="last_record" value="">
<br>
<br>
</form>
<SCRIPT LANGUAGE="JavaScript">
<!--
rowcount=<%=i%>;
//-->
</SCRIPT>
</html>