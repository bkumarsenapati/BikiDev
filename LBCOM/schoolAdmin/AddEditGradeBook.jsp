<jsp:useBean id="db" class="sqlbean.DbBean" scope="session" />
<jsp:setProperty name="db" property="*" />
<%@page import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>

<%	
	float[] mins = new float[30];
	String[] grades=new String[30];
	int i=0;
	String schoolId="",classId="",mode="",dispName="",schema="",scaleValue="",gTag="";
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
%>
<%
	schoolId = request.getParameter("schoolid");
	classId = request.getParameter("classid");
	mode=request.getParameter("mode");
	schema=request.getParameter("schema");	// Schema tells whether grades are taken frm database or templates.(Main means database)
%>

<HTML>
<HEAD>
<TITLE>Add Edit Grades</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">

<script type="text/javascript">
var rowcount=0;
var scaleValue="<%=scaleValue%>";
function addRow(rownum)
{
	rownum=rowcount;
	//alert("rownum is..."+rownum);
	//alert("rowcount is..."+rowcount);
	var x=document.getElementById('gradesTable').insertRow(rownum+2)
	var a=x.insertCell(0)
	var b=x.insertCell(1)
	var c=x.insertCell(2)
	var d=x.insertCell(3)
	var e=x.insertCell(4)
	a.innerHTML="<TD width='20' height='21'><A onclick='return delRow(this);' href='javascript://'><img height='21' TITLE='Delete Row' src='images/del.gif' width='18' border=0></A></TD>"
	b.innerHTML="<TD width='200' height='21'><p align='center'><INPUT id='gradenames' size='29' name='gradenames'></p></td>"
	c.innerHTML="<td width='125' height='21'><p align='center'><INPUT id='code' maxLength=7 size=10 name='gradecodes'></td>"
	d.innerHTML="<td width='120' height='21'><p align='center'><INPUT id='min' maxLength=4 size=10 name='minimum'></td>"
	e.innerHTML="<td width='285' height='21'><p align='center'><INPUT id='description' size='53' name='descriptions'></td>"

	rowcount++;
	//alert("rowcount after adding is..."+rowcount);
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

function deleteMyRow(rownum)
{
	if(confirm("Are you sure you want to delete the grade?")==true)
	{
		//alert("rownum is..."+rownum);
		document.getElementById('gradesTable').deleteRow(rownum);
		rowcount--;
		//alert("rowcount after deleting is..."+rowcount);
		document.getElementById("no_of_records").value=rowcount;
	}
	else
		return;
}

function formSubmit()
{
	if (document.getElementById("allow").checked)
		document.getElementById("editTag").value="allow";
	else
		document.getElementById("editTag").value="allownot";
	document.getElementById("Grading").submit()
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
			var min1=min+"";
			if(min1.indexOf(".")==-1)
				n[i].value=min1+".00";
			else if(min1.length==3)
				n[i].value=min1+"0";
			else
				n[i].value=min1;
		}
	}
	else
	{
		for(var i=0;i<n.length;i++)
		{
			min=n[i].value;
			min=min*10;
			var min1=min+"";
			if(min1.indexOf(".")==-1)
				n[i].value=min1+".0";
			else if(min1.length==3)
				n[i].value=min1+"0";
			else
				n[i].value=min1;

		}
	}
	scaleValue=scaleVal;
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

	if (document.getElementById("allow").checked)
		document.getElementById("editTag").value="allow";
	else
		document.getElementById("editTag").value="allownot";

document.getElementById("Grading").submit()
}

</script>
</head>
<META http-equiv=Pragma content=no-cache>
<BODY bgColor=white topMargin=5 leftMargin=10>
<form id="Grading" method="POST" name="Grading" action="admindefinegrades.jsp?mode=<%=mode%>">
<%
    try
	{
		
		con=db.getConnection();
		st=con.createStatement();

		// Grading scale code is used to know whether the scale is 10 scale or 100 scale.
		
		if(schema.equals("Main"))
		{
			rs=st.executeQuery("select grades_tag, grading_scale from class_master where class_id='"+classId+"' and school_id='"+schoolId+"'");
			if(rs.next())
			{
				gTag=rs.getString("grades_tag");
				scaleValue=rs.getString("grading_scale");
			}
			rs.close();
		}
		else
			scaleValue="100scale";

		// Grading scale code ends here.

		// GRading schema code. If schema name 'main' means that the grades are already entered into db, and it fetches from there.
		// Otherwise, it fetches grades from grading_schema table based on the template name.

		if(schema.equals("Main"))
		{
			rs=st.executeQuery("select * from class_grades where schoolid='"+schoolId+"' and classid='"+classId+"' order by maximum desc ");
		}
		else
		{
			rs=st.executeQuery("select * from grading_schemas where schema_name='"+schema+"' order by maximum desc");
		}

		// Here ends the Grading code.
%>

<p align="center">
<font face="Verdana"><span style="font-size:14pt; font-weight:700"><br>Grading Schema Editor</span></font></p>
<p align="center">
<table border="0" cellspacing="1" width="750" bgcolor="#EEE0A1" bordercolor="#FFFFFF" height="40">
  <tr>
<%
		if(gTag.equals("1"))
		{
	
%>
    <td width="290" height="21">
		<input type="checkbox" name="allow" id="allow" value="ON" checked><font face="Verdana" size="2">Allow teachers to edit the Grade Book.</font></td>

<%
		}
		else
		{
%>
	<td width="290" height="21">
		<input type="checkbox" name="allow" id="allow" value="ON"><font face="Verdana" size="2">Allow teachers to edit the Grade Book.</font></td>
<%
		}	
%>
<%
		if(scaleValue.equals("10scale"))
		{
%>
	<td width="225" height="21" align="center">
    <p align="center">&nbsp;&nbsp;
	<input type="radio" id="scale" name="scale" value="10" onclick="checkScale(this.value)" checked>
		<b><font face="Verdana" size="2">10 Scale</font></b>&nbsp;&nbsp;&nbsp; &nbsp; 
	<input type="radio" name="scale" value="100" onclick="checkScale(this.value)">
		<b><font face="Verdana" size="2">100 Scale</font></b></td>
<%
		}
		else
		{
%>
	<td width="225" height="21" align="center">
    <p align="center">&nbsp;&nbsp;
	<input type="radio"id="scale" name="scale" value="10" onclick="checkScale(this.value)">
		<b><font face="Verdana" size="2">10 Scale</font></b>&nbsp;&nbsp;&nbsp; &nbsp; 
	<input type="radio" name="scale" value="100" onclick="checkScale(this.value)" checked>
		<b><font face="Verdana" size="2">100 Scale</font></b></td>
<%
		}	
%>
	
	<td width="200" height="21">
		<FONT face=Helvetica,Arial size=-1>
          <p align="right"><b>&nbsp;
		  <a href="AddEditGradeBook.jsp?schoolid=<%=schoolId%>&classid=<%=classId%>&mode=<%=mode%>&schema=Main">
          Default</a>&nbsp;
          <a href="AddEditGradeBook.jsp?schoolid=<%=schoolId%>&classid=<%=classId%>&mode=<%=mode%>&schema=Template1">
          1</a>&nbsp;
          <a href="AddEditGradeBook.jsp?schoolid=<%=schoolId%>&classid=<%=classId%>&mode=<%=mode%>&schema=Template2">
          2</a>&nbsp;
          <a href="AddEditGradeBook.jsp?schoolid=<%=schoolId%>&classid=<%=classId%>&mode=<%=mode%>&schema=Template3">
          3</a>&nbsp;
          <a href="AddEditGradeBook.jsp?schoolid=<%=schoolId%>&classid=<%=classId%>&mode=<%=mode%>&schema=Template4">
          4</a>&nbsp;
          <a href="AddEditGradeBook.jsp?schoolid=<%=schoolId%>&classid=<%=classId%>&mode=<%=mode%>&schema=Template5">
          5</a>&nbsp;&nbsp;&nbsp; </b></FONT></td>
  </tr>
</table>
  
  <TABLE cellSpacing=1 width=750 align="center" id="gradesTable" border=0 bordercolor="#EEE0A1">
    <TBODY>
      <tr>
        <TD width="750" height="1" bgcolor="#FFFFFF" colspan="6">
        <img border="0" src="images/spacer.gif" width="1" height="1"></TD>
      </tr>
      <TR bgcolor="#EEE0A1">
        <TD width="19" height="28">&nbsp;</TD>
        <TD width="200" height="28">
          <p align="center">
             <FONT face=Verdana size=-1><B>Grade Name</B></FONT></TD>
        <TD width="125" height="28">
		  <p align="center">
             <FONT face=Verdana size=-1><B>Grade Code</B></FONT></TD>
        <TD width="120" height="28">
          <p align="center">
             <FONT face=Verdana size=-1><B>Minimum</B></FONT></TD>
	    <TD width="285" height="28">
          <p align="center">
             <FONT face=Verdana size=-1><B>Description</B></FONT></TD>
    </TR>
  <%
	while(rs.next())
	{
		mins[i]=rs.getFloat("minimum");
  		grades[i]=rs.getString("grade_code");
%>
      <TR>
        <TD width="20" height="21"><A onclick="return delRow(this);" href="javascript://">
		<img height="21" TITLE="Delete Row" src="images/del.gif" width="18" border=0></A></TD>
        <TD width="200" height="21">
          <p align="center">
        <INPUT id="grade" size="29" name="gradenames" value="<%=rs.getString("grade_name")%>" ></TD>
	    <TD width="125" height="21">
	      <p align="center">
          <INPUT id="code" maxLength=7 size=10 name="gradecodes" value="<%=grades[i]%>"></TD>
	    <TD width="120" height="21">
	      <p align="center">
          <INPUT id="min" maxLength=4 size=10 name="minimum" value="<%=mins[i]%>"></TD>
		<TD width="285" height="21">
	      <p align="center">
        <INPUT id="description" size=53 name="descriptions" value="<%=rs.getString("description")%>"></TD>
	  </TR>
<%
			i++;
	}
%>
	  <tr>
        <TD width="715" height="1" bgcolor="#FFFFFF" colspan="6">
        <img border="0" src="images/spacer.gif" width="1" height="1"></TD>
      </tr>
    </TBODY>
  </TABLE>

  <table width="750" height="40" border="0" cellpadding="0" cellspacing="0">
   	<tr>
      <td align="center" bgcolor="#EEE0A1"><b><font face="Verdana"><span style="font-size:10pt;">
	    <input type="button" onclick="return checkAll()" value="Submit">&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="reset" value="Reset" name="B2">&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" value="Add Row" name="arow" onclick="addRow(<%=i%>)">
      <font face="Verdana" size="-1">&nbsp;&nbsp;&nbsp; </font>
	</td>
    </tr>
 </table>

<p align="center">&nbsp;</p>
<INPUT type="hidden" id="no_of_records" name="no_of_records" value=<%=i%>> 
<INPUT type="hidden" id="editTag" name="editTag" value=""> 
<input type="hidden" name="classid" value=<%=classId%>>
<INPUT type="hidden" id="last_record" name="last_record" value=""> 

</FORM>
</FONT>
<%
	}
	catch(Exception e) 
	{
		ExceptionsFile.postException("AddEditGradeBook.jsp","operations on database and reading parameters","Exception",e.getMessage());
		System.out.println("Error in AddEditGradeBook is "+e);
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("AddEditClass.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
%>
</BODY>
<SCRIPT LANGUAGE="JavaScript">
<!--
rowcount=<%=i%>;
//-->
</SCRIPT>
</HTML>