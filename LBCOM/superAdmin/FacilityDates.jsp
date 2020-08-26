<%@  page language="java"  import="java.sql.*,coursemgmt.ExceptionsFile,java.util.StringTokenizer" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%!
	String month[]={"MMM","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
%>

<%
	String facilityName=request.getParameter("fname");
	String facilityId=request.getParameter("fid");
	String totalStudents=request.getParameter("count");
	String startDate=request.getParameter("startdate");
	String endDate=request.getParameter("enddate");

	String yyyy="0000";
    int mm=0;
	int dd=0;

	StringTokenizer stk=new StringTokenizer(endDate,"-");
		 
		if(stk.hasMoreTokens())
		{
			yyyy=stk.nextToken();
			mm=Integer.parseInt(stk.nextToken());
			dd=Integer.parseInt(stk.nextToken());
		}
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>New Page 1</title>
<script>

function editYears()
{
	var dt=new Date();
	var year;
	year=dt.getFullYear()-4;
	for(var i=1;i<=14;i++)
	{
		year=year+1;
		window.document.facilitydates.yyyy.options[i]=new Option(year,year);
	}
}
</script>

</head>

<body bgcolor="#FAF4F1">
<form name="facilitydates" method="POST" action="UpdateFacilityDates.jsp?fid=<%=facilityId%>">

<p>&nbsp;</p>
<p>&nbsp;</p>

<div align="center">
  <center>
  <table border="0" cellspacing="1" width="60%">
    <tr>
      <td width="38%" height="27" bgcolor="#C28256">
      <font face="Verdana" size="2">&nbsp;</font><b><font face="Verdana" size="2">Facility 
      Start &amp; End Dates</font></b></td>
      <td width="62%" height="27" bgcolor="#C28256">
      <p align="right">
      <font face="Verdana" size="2">&nbsp;</font><b><a href="FacilityHome.jsp" style="text-decoration: none"><font color="#FFFFFF" face="Verdana" size="1">&lt;&lt;</font><font color="#FFFFFF" face="Verdana" size="2">Back</font></a></b></td>
    </tr>
    <tr>
      <td width="38%" height="19" bgcolor="#DDB9A2">
      <font face="Verdana" size="2">&nbsp;Name of the Facility</font></td>
      <td width="62%" height="19" bgcolor="#EEDDD2">
                  
          <font face="Verdana" size="2"><%=facilityName%></font></td>
    </tr>
    <tr>
      <td width="38%" height="19" bgcolor="#DDB9A2">
      <font face="Verdana" size="2">&nbsp;Facility ID</font></td>
		<td width="62%" height="19" bgcolor="#EEDDD2">
			<font face="Verdana" size="2"><%=facilityId%></font>
		</td>
    </tr>
		<tr>
			<td width="38%" height="19" bgcolor="#DDB9A2">
				&nbsp;<font face="Verdana" size="2">Start Date</font></td>
			<td width="62%" height="19" bgcolor="#EEDDD2">
				<font face="Verdana" size="2"><%=startDate%></font>
			</td>
    </tr>
		<tr>
			<td width="38%" height="19" bgcolor="#DDB9A2">
				<font face="Verdana" size="2">&nbsp;End Date</font></td>
			<td width="62%" height="19" bgcolor="#EEDDD2">
				<select id="dd_id" name="dd">
					<option value='0'>DD</option>
<% 
						for (int i=1;i<=31;i++)
						{
							if(dd==i)
							{
								out.println("<option selected value='"+i+"'>"+i+"</option>");
							}
							else
							{
								out.println("<option value='"+i+"'>"+i+"</option>");
							}
						}
%>
				</select>
				<select id='mm_id' name='mm'>
<%
					for(int i=0;i<=12;i++)
					{
						if(mm==i)
						{
							out.println("<option selected value='"+i+"'>"+month[i]+"</option>");
						}
						else
						{
							out.println("<option value='"+i+"'>"+month[i]+"</option>");
						}
					}
%>
				</select>
				<select id='yyyy_id' name='yyyy'>
					<option value="0000">YYYY</option>
				</select>
			</td>
    </tr>
    </table>
  </center>
</div>
<div align="center">
  <center>
  <table border="0" cellspacing="1" width="60%">
    <tr>
      <td width="100%" height="19" bgcolor="#C28256">
      <p align="center"><input type="submit" value="Submit" name="B1">&nbsp;&nbsp;
      <input type="reset" value="Reset" name="B2"></td>
    </tr>
  </table>
  </center>
</div>
</form>
</body>
<script language="javascript">
editYears();
function init()
{
	document.facilitydates.yyyy.value="<%=yyyy%>";
}
init();
</script>
</html>