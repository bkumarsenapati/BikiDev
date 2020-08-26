<%@page import="java.io.*,java.sql.*"%>
<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%
String schoolId="",schoolIds="";
ResultSet  rs=null;
Connection con=null;
Statement st=null;  
boolean flag=false;
String userType=request.getParameter("user");
String bgclr="";

if(userType.equals("admin"))
	bgclr="#EDE1BA";
else if(userType.equals("teacher"))
	bgclr="#D6DDE9";
else
	bgclr="#E1DED5";
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
function startSearch()
{
	var num="0123456789"
	var win=window.document.searchForm;
	var school=win.school.value;
	var utype=win.utype.value;
	var userdet=win.userdet.value;
	var like=win.like.value;
	var partinfo=win.partinfo.value;

	if(utype=='none')
	{
		alert("Select user type.");
		win.utype.focus();
		return false;
	}

	if(userdet !='none')
	{
		if(userdet == "phone")
		{
			for(var i=0;i<partinfo.length;i++)
			{
				if((num.indexOf((partinfo).charAt(i)))==-1)
				{
					alert("Please enter numbers only");
					win.partinfo.select();
					i=100;
					return false;
				}
			}
		}
			
		if(like == "none")
		{
			alert('Select search type.');
			win.like.focus();
			return false;
		}
		else
		{
			if(partinfo == "")
			{
				alert("Enter the search word.");
				win.partinfo.focus();
				return false;
			}
			else
			{
parent.sec.location.href="SearchUser.jsp?school="+school+"&user=<%=userType%>&utype="+utype+"&userdet="+userdet+"&like="+like+"&partinfo="+partinfo+"&totalrecords=&start=0";
return false;
			}
		}
	}
	else
	{
		if((like != "none") || (partinfo != ""))
		{
			alert('Select whose phrase.');
			win.userdet.focus();
			return false;
		}
		else
		{
parent.sec.location.href="SearchUser.jsp?school="+school+"&user=<%=userType%>&utype="+utype+"&userdet="+userdet+"&like="+like+"&partinfo="+partinfo+"&totalrecords=&start=0";
return false;
		}
	}
}
</script>
</head>
<body topmargin=4 leftmargin=4>
<form name="searchForm" id="searchForm" onsubmit="return startSearch()">
<%
	session=request.getSession();
	flag=false;
	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	schoolId=(String)session.getAttribute("schoolid");
	try
	{
		con=db.getConnection();
		st=con.createStatement();

		rs=st.executeQuery("select schoolid from school_profile");
%>
<table border='0' width='912' cellspacing='0' bordercolordark='#DDEEFF'>
	<tr width='337' bgcolor='#EFEFF7' bordercolor='#EFEFF7'>
		<td align=right width="1053" bgcolor="<%=bgclr%>">
        <p align="left">
		<b><font face="Verdana" size="2">&nbsp;Search in&nbsp;&nbsp; </font>
        <font face="Verdana">
		
		<select id="school" name="school">
			<option value="myschool" selected>my school</option>
			<option value="all">all schools</option>
<%		
		while (rs.next())
		{
%>
			<option value='<%=rs.getString("schoolid")%>'><%=rs.getString("schoolid")%></option>
<%
		}
%>
		</select>
		
		<font size="2">&nbsp;&nbsp; for&nbsp;&nbsp; </font>
		
		<select id='utype' name='utype'>
			<!-- <option value='allusers' selected>all users</option>  -->
			<option value='none' selected>user type</option>
			<option value='admin'>school</option>
			<option value='teacher'>teacher</option>
			<option value='student'>student</option>
		</select>
		<font size="2">&nbsp;&nbsp; whose&nbsp;&nbsp; </font>
				
		<select id="userdet" name="userdet">
			<option value="none" selected>----</option> 
			<option value="fname">first name</option>
			<option value="lname">last name</option>
            <option value="userid">userid</option>
            <option value="emailid">emailid</option>
            <option value="phone">phone number</option>
		</select>
		
		<!-- <font size="2">&nbsp;&nbsp;is&nbsp;</font> -->
        
		<select id="like" name="like">
			<option value="none" selected>----</option>
			<option value="like">is like</option>
			<option value="exactly">is exactly</option>
            <option value="startwith">starts with</option>
            <option value="endwith">ends with</option>
		</select>
		
		<font size="2">&nbsp;&nbsp;</font> 
		
		<input type="text" name="partinfo" id="partinfo" size="20">&nbsp;&nbsp;&nbsp;&nbsp;</b></font>

		<input type="button" value="GO" name="search" onclick="startSearch()"></p>
       
        </td>
		<tr width='337' bgcolor='#EFEFF7' bordercolor='#EFEFF7'>
<%
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("SearchMain.jsp","operations on database","Exception",e.getMessage());
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
			ExceptionsFile.postException("SearchMain.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
%>

</form>
</body>
</html>