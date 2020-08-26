<%@  page language="java"  import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
%>
<%
	/*
	session=request.getSession(true);
	String s=(String)session.getAttribute("sessid");
	if(s==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	*/
	try
	{
		con=con1.getConnection();
		st=con.createStatement();
		rs=st.executeQuery("select schoolid,schoolname,password from school_profile");

%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title></title>
<script>
function goSchool()
{
	var win=window.document.SchoolSelection;
	var xvar= document.getElementById("schools");
	var schoolid=xvar.options[xvar.selectedIndex].text;
	var pwd=xvar.options[xvar.selectedIndex].value;
	if(!(pwd=="none"))
	{
		window.open("/LBCOM/ValidateUser?schoolid="+schoolid+"&userid=admin&mode=admin&password="+pwd,"win");
	}
	else
		alert("Please select any school");
}

</script>
</head>
<body>
<form name="SchoolSelection"  method="post" >
<p>&nbsp;</p>
<table border="0" cellpadding="0" cellspacing="0" width="100%" height="125">
  <tr>
    <td width="100%" colspan="2" height="106"><b>
    <font face="Verdana" size="2" color="#800000">
    From here, you can login to any particular school directly.</font></b></td>
  </tr>
  <tr>
    <td width="54%" height="19">
    <p align="right"><b><font face="Verdana" size="2" color="#0000FF">Select School ID you want to login :</font></b></td>
    <td width="46%" height="19">  &nbsp;&nbsp;

	<select name="schools" id="schools" onchange="javascript:goSchool();">
	<option value="none" selected>Select School ID</option>
	
<%		
		while (rs.next())
		{
%>
			<option value='<%=rs.getString("password")%>'><%=rs.getString("schoolid")%></option>
<%
		}
%>
	</select>


	</td>
  </tr>
</table>
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
</body>

</html>