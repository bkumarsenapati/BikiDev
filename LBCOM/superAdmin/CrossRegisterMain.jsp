<%@page import="java.io.*,java.sql.*"%>
<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%
String schoolId="",schoolIds="";
ResultSet  rs=null,rs1=null;
Connection con=null;
Statement st=null,st1=null;  
boolean flag=false;

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv='Pragma' content='no-cache'>
<meta http-equiv='Cache-Control' content='no-cache'> 
<title></title>

<script language="javascript">
function selectOption()
{
	var win=window.document.registerForm;
	var option=win.selectoption.value;
	var destSchTD=document.getElementById("destschtd");
	if(option=="register")
	{
		destSchTD.style.visibility = "visible";
		win.srcschool.value="none";
		win.destschool.value="none";
		parent.bottom.location.href="about:blank";
	}
	else
	{
		destSchTD.style.visibility = "hidden";
		win.srcschool.value="none";
		parent.bottom.location.href="about:blank";
	}
}

function startListing()
{
	var win=window.document.registerForm;
	var school=win.srcschool.value;
	var option=win.selectoption.value;
	
	if(option=="register")
	{
		if(school=="none")
		{
			alert("Please select the school from which you want to cross register");
			parent.bottom.location.href="about:blank";
			return false;
		}
		parent.bottom.location.href="CrossRegisterUsersList.jsp?school="+school+"&utype=student&totalrecords=&start=0";
	}
	else
	{
		if(school=="none")
		{
			alert("Please select the school name");
			parent.bottom.location.href="about:blank";
			return false;
		}
		parent.bottom.location.href="CrossRegisteredList.jsp?school="+school+"&utype=student&totalrecords=&start=0";
	}
}

function crossRegister()
{
	var win=window.document.registerForm;
	var school1=win.srcschool.value;
	var school2=win.destschool.value;
	if(school1=="none")
	{
		alert("Please select the school from which you want to cross register");
		parent.bottom.location.href="about:blank";
	}
	else if(school2=="none")
		alert("Please select the school into which you want to cross register");

	else
	{
		var selid = new Array();
		var bottomwin=parent.bottom.document;
		with(bottomwin.crossRegister) 
		{
			for(var i=0,j=0; i < elements.length; i++) 
			{
				if(elements[i].type == 'checkbox' && elements[i].name == 'selids' &&elements[i].checked==true)
				{
					selid[j]=elements[i].value;
					j++;
				}
		    }
		}
		if(j>0)
		{
			if(confirm("Are you sure you want to cross register the selected student(s) to the selected school?"))
			{
				parent.bottom.location.href="/LBCOM/superAdmin/CrossRegister.jsp?srcschool="+school1+"&destschool="+school2+"&mode=crossregister&selids="+selid;
				return false;
			}
			else
				return false;
		}
		else
		{
			alert("Please select the student(s) to be cross registered");
	        return false;
		}
	}
}

</script>
</head>

<body topmargin=4 leftmargin=4>
<form name="registerForm" id="registerForm" onsubmit="return startListing()">

<%
	try
	{
		con=db.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		rs=st.executeQuery("select schoolid from school_profile");
		rs1=st1.executeQuery("select schoolid from school_profile");
%>
<br>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="100%" colspan="2"><b>
			<font face="Verdana" size="2" color="#008080">Here, you can cross register students from one school to another school.</font></b>
		</td>
	</tr>
	<tr>
		<td width="50%">&nbsp;</td>
		<td width="50%">&nbsp;</td>
	</tr>
</table>

<table bgcolor="#E8CFBF" border='0' width='100%' cellspacing='0'>
	<tr>
		<td height="20" align="left" width="40%">&nbsp;
			<select id="selectoption" name="selectoption" onchange="selectOption()">
				<option value="register" selected>Cross register</option>
				<option value="list">List cross registered</option>
			</select>

			<b><font face="Verdana" size="2">students from</font>
			<select id="srcschool" name="srcschool" onchange="startListing()">
				<option value="none" selected>select a school</option>
<%		
		while (rs.next())
		{
%>
				<option value='<%=rs.getString("schoolid")%>'><%=rs.getString("schoolid")%></option>
<%
		}
%>
			</select>
		</td>
		<td id="destschtd" align="left">
			<b><font face="Verdana" size="2">to the school</font> 
			<select id="destschool" name="destschool">
				<option value="none" selected>select a school</option>
<%		
		while (rs1.next())
		{
%>
				<option value='<%=rs1.getString("schoolid")%>'><%=rs1.getString("schoolid")%></option>
<%
		}
%>
			</select>
		
			<input type="button" value="GO" name="search" onclick="crossRegister()">
       </td>
	<tr bgcolor='#EFEFF7' bordercolor='#EFEFF7'>
<%
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("CrossRegisterMain.jsp","operations on database","Exception",e.getMessage());
    }
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("CrossRegisterMain.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
%>

</form>
</body>
</html>